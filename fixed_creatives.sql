DROP TABLE IF EXISTS `schema.creatives_fixed`;
CREATE TABLE `schema.creatives_fixed` AS

WITH required_fields AS(
  SELECT 
    id as creative_id,
    lower(SPLIT(SPLIT(name, '.')[0], '-')[0]) as creative_name,
    SPLIT(mimeType, '/')[0] as file_type,
    SPLIT(mimeType, '/')[1] as file_format,
    createdTime as created_time,
    webViewLink as link,
    size as size_bytes
  FROM `schema.table_with_creatives`
  WHERE mimeType not like '%folder'
),

workers AS(
  select distinct COALESCE(REPLACE(lower(worker), '_', ''), lower(worker)) as worker 
  from `schema.data_table` 
  where worker is not NULL

  union all

  select 'all' as worker
),

join_designers_buyers AS(
  SELECT 
    creo.*,
    lower(d.color) as color,
    lower(b.worker) as worker_code
  FROM required_fields creo
  LEFT JOIN `schema.colors_dict` d 
    ON creo.creative_name LIKE CONCAT('%\\_', lower(d.color), '\\_%')
  LEFT JOIN workers b
    ON creo.creative_name LIKE CONCAT('%\\_', b.worker, '\\_%')
),

extract_token_offer AS(
  SELECT 
    creo.*,
    CASE 
      WHEN creo.creative_name LIKE CONCAT('%', creo.color, '%') THEN REGEXP_EXTRACT(REPLACE(creo.creative_name, creo.color, '_'), r'_([a-z0-9]{8})_')
      ELSE REGEXP_EXTRACT(creo.creative_name, r'_([a-z0-9]{8})_')
    END AS token,
    o.offer_design as offer
  FROM join_designers_buyers creo 
  LEFT JOIN `schema.offers_dict` o
    ON creo.creative_name LIKE CONCAT('%', lower(o.offer_design), '%')
), 

filter_tokens as(
  select 
    * except(token),
    CASE
      WHEN REGEXP_CONTAINS(token, r'([0-9]{2}x[0-9]{5})') then NULL
      WHEN REGEXP_CONTAINS(token, r'([0-9]{5}x[0-9]{2})') then NULL
      WHEN REGEXP_CONTAINS(token, r'([0-9]{3}x[0-9]{4})') then NULL
      WHEN REGEXP_CONTAINS(token, r'([0-9]{4}x[0-9]{3})') then NULL
      ELSE token
    END AS token
  from extract_token_offer
)

SELECT * FROM filter_tokens