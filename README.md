# Google Drive API

## Описание

Этот проект позволяет выгружать информацию о файлах из Google Drive с помощью Google Drive API, обрабатывать эти данные и загружать их в базу данных Google BigQuery. Далее, для анализа выгруженных данных используются SQL-скрипты.

## Основные функции

- **Выгрузка информации о файлах**: Использует Google Drive API для получения данных о файлах.
- **Обработка данных**: Выполняет предварительную обработку данных перед загрузкой в базу данных.
- **Загрузка в BigQuery**: Загружает обработанные данные в Google BigQuery.
- **Анализ данных**: SQL-скрипты для анализа загруженных данных и подготовки их для использования в BI-системах.

## Установка и настройка

1. **Клонирование репозитория**:
    ```bash
    git clone https://github.com/username/GoogleDriveAPIProject.git
    cd GoogleDriveAPIProject
    ```

2. **Создание и активация виртуального окружения (опционально)**:
    ```bash
    python3 -m venv venv
    source venv/bin/activate  # Для Windows: venv\Scripts\activate
    ```

3. **Установка зависимостей**:
    ```bash
    pip install -r requirements.txt
    ```

4. **Настройка Google Drive API**:
    - Создайте проект в [Google Cloud Console](https://console.cloud.google.com/).
    - Активируйте Google Drive API.
    - Создайте OAuth 2.0 Client ID и скачайте файл `credentials.json`.
    - Сохраните файл `credentials.json` в корневом каталоге проекта.

5. **Настройка Google BigQuery**:
    - Активируйте BigQuery API в вашем проекте Google Cloud.
    - Настройте аутентификацию и предоставьте необходимые разрешения для загрузки данных.

6. **Настройка переменных окружения**:
    - Создайте файл `.env` в корневом каталоге проекта и добавьте в него необходимые переменные (например, путь к файлу `credentials.json` и параметры подключения к BigQuery).

## Примеры использования

1. **Выгрузка данных из Google Drive**:
    ```bash
    python drive_data_extractor.py
    ```

2. **Загрузка данных в BigQuery**:
    ```bash
    python bigquery_loader.py
    ```

3. **Анализ данных с помощью SQL**:
    - Откройте файл `data_analysis.sql` в вашем SQL-редакторе.
    - Выполните запросы для анализа данных.

## Зависимости

- Python 3.8 или выше
- `google-api-python-client`
- `google-auth-httplib2`
- `google-auth-oauthlib`
- `google-cloud-bigquery`
- Другие зависимости перечислены в файле `requirements.txt`.

