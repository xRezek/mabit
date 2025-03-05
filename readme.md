# Introduction

The documentation describes a machine performance monitoring system that consists of several modules:

- **Backend:** Python scripts responsible for collecting, aggregating, and saving data to a MySQL database.
- **Frontend:** JavaScript scripts responsible for data visualization using the Plotly library.
- **PHP Modules:** Files responsible for handling application logic, database connection configuration, and generating the user interface.

# System Requirements

## Backend

- Python 3.x
- Libraries: `python-dotenv`, `schedule`, `paho-mqtt`, `pymysql`
- MySQL database server

## Frontend

- Web browser with JavaScript support
- Library `Plotly.js version 2.35.2`
- Library `Bootstrap version 5.3.3`

## PHP

- Web server with PHP support version 8.2.12 (e.g., Apache)

# Description of Project Modules and Files

## Python Files

### `dailyDataInsert.py`

The `dailyDataInsert.py` script is responsible for:

- Loading environment variables from the `.env` file using the `python-dotenv` library.
- Establishing a connection to the MySQL database.
- Executing an SQL query that aggregates data from the `products` and `machine_status` tables. Indicators such as:
    - **Quality** – the ratio of products with status 1 to the total number of products.
    - **Availability** – the ratio of machine operating time to total time.
    - **Performance** – the average scaling factor value.
- Inserting aggregated data into the `daily_data` table.
- Automatically running the task daily at 23:00 using the `schedule` library.

### `dataCollector.py`

The `dataCollector.py` script is responsible for:

- Connecting to the MQTT broker (e.g., `broker.emqx.io`) and subscribing to the `ZONE_01/#` topic.
- Receiving MQTT messages, parsing the transmitted JSON, and validating the format.
- Inserting data into the MySQL database using the `pymysql` library. Operations include:
    - Inserting alarms into the `alarms` table.
    - Inserting events into the `events` table.
    - Inserting product information into the `products` table.
    - Inserting machine status into the `machine_status` table.
    - Adding a new record to the `machines` table if the machine does not exist in the database.
- Handling errors related to incorrect JSON format and database connection errors.

## JavaScript Files

### `index.js`

The `index.js` file is responsible for data visualization on the website using the Plotly library. Main functions include:

- **createIndicator:** Creates a gauge chart displaying OEE, quality, availability, and performance values. The indicator color depends on the value range. It takes 3 arguments: id, value, and title, where id is the id of the div where the chart will be drawn, value is the displayed value, and title is the displayed indicator title.
- **createOeeLineChart:** Generates a line chart showing changes in OEE and quality indicators over time. It takes 4 arguments: id, where the chart will be located, xData for X-axis values (in this case, individual days), and oeeData and qualityData for Y-axis values (OEE and quality indicator values).
- **createPieChart:** Creates a pie chart illustrating the status of products (e.g., Good, Bad, Canceled). The function takes 4 arguments: id, where the chart will be located, goodProducts for the number of good products, badProducts for the number of bad products, and canceledProducts for the number of canceled products.

## PHP Files

The project includes several PHP files that serve configuration, application logic, and interface generation roles.

### `controller.php`

The `controller.php` file contains the main application logic. It can handle HTTP requests, process data, and direct the flow of information between the frontend and backend.

### `dbconfig.php`

The `dbconfig.php` file contains the database connection configuration, including settings such as:

- Database host
- Username
- Password
- Database name

This file is used by other PHP scripts to establish a connection to the database.

### `offcanvas.php`

The `offcanvas.php` file is responsible for generating user interface elements, such as off-canvas menus or side panels. It can be used for navigation or displaying additional options in the application.

### `index.php`

The `index.php` file is the main entry point for the web application. Its tasks include:

- Initializing the session and configuring the environment.
- Combining view parts and application modules, including attaching appropriate CSS and JavaScript scripts.
- Rendering dynamic page content, fetching data from the database or other sources, and presenting it to the user.

### `sqlQueries.php`

The `sqlQueries.php` file contains definitions of SQL queries used by the application. Its main tasks include:

- Storing SQL query templates used for retrieving, inserting, updating, or deleting data in the database.
- Allowing easy modification of queries in one place, contributing to better code maintenance.
- Integrating with PHP modules that execute these queries to ensure consistency and centralization of data access logic.

# Installation and Configuration

## Backend

1. Install the required libraries:

    ```bash
    pip install python-dotenv schedule paho-mqtt pymysql
    ```

2. Create a `.env` file with the database connection configuration:

    ```bash
    DB_HOST=database_server_address
    DB_USER=username
    DB_PASSWORD=password
    DB_DATABASE=database_name
    DB_PORT=3306
    ```

3. Run the scripts:

    - `dailyDataInsert.py` – aggregation and data insertion daily at 23:00.
    - `dataCollector.py` – receiving MQTT messages and saving data to the database.

## Frontend

1. Include the `index.js` file in the HTML page.

    ```html
    <script src="index.js" defer></script>
    ```

2. Ensure the page contains HTML elements with appropriate attributes (e.g., `data-json`) from which data for the charts is retrieved.

3. Load the Plotly library and the necessary Bootstrap script:

    ```html
    <script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    ```

4. In the head section, include the Bootstrap CSS:

    ```html
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    ```

## PHP

1. Ensure that the `controller.php`, `dbconfig.php`, `offcanvas.php`, `index.php`, and `sqlQueries.php` files are placed in the appropriate project directories.

2. Configure the web server to correctly interpret PHP files.

3. Review the `dbconfig.php` file and update the database settings as needed.

# Summary

The machine performance monitoring system integrates several technologies:

- Python scripts (`dailyDataInsert.py` and `dataCollector.py`) are responsible for collecting, processing, and saving data to the database.
- The JavaScript script (`index.js`) processes data from the database and generates interactive charts using the Plotly library.
- PHP components (`controller.php`, `dbconfig.php`, `offcanvas.php`, `index.php`, and `sqlQueries.php`) support application logic, database connection configuration, and user interface generation.

Thanks to this integration, it is possible to continuously monitor key indicators (such as OEE, quality, availability, and performance), allowing for quick responses and data-driven decision-making.
