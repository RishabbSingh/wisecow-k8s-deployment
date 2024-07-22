Project: System Health Monitoring
---------------------------------

This project includes two Python scripts that monitor application status and system health. The scripts are designed to run on a server or any system where you need to ensure the application is running smoothly and the system resources are within acceptable thresholds.

### Scripts

#### 1\. `status.py`

This script checks the status of a web application by sending an HTTP GET request to a specified URL and reports if the application is up or down.


```bash
`import requests

def check_application_status(url):
    try:
        response = requests.get(url)
        # Check if the response status code is 200 (OK)
        if response.status_code == 200:
            return "The application is up and running."
        else:
            return f"The application is down. Status code: {response.status_code}"
    except requests.RequestException as e:
        return f"An error occurred: {e}"

if __name__ == "__main__":
    # URL of Google for testing
    url = "https://google.com"
    status = check_application_status(url)
    print(status)`
```
**Usage:**

1.  Ensure you have the `requests` library installed. You can install it using pip:

    ```bash

    `pip install requests`

    ```
2.  Run the script:

    ```bash

    `python status.py`
    ```
    The script will output the status of the application.

#### 2\. `system-monitor.py`

This script monitors system health by checking CPU usage, memory usage, disk usage, and running processes. It logs any issues to a log file and prints alerts to the console.

```bash

`import os
import psutil
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(filename='/var/log/system_health.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Define thresholds
CPU_THRESHOLD = 80  # percent
MEMORY_THRESHOLD = 80  # percent
DISK_THRESHOLD = 90  # percent

def check_cpu_usage():
    cpu_usage = psutil.cpu_percent(interval=1)
    if cpu_usage > CPU_THRESHOLD:
        alert = f"High CPU usage detected: {cpu_usage}%"
        print(alert)
        logging.warning(alert)

def check_memory_usage():
    memory_info = psutil.virtual_memory()
    memory_usage = memory_info.percent
    if memory_usage > MEMORY_THRESHOLD:
        alert = f"High memory usage detected: {memory_usage}%"
        print(alert)
        logging.warning(alert)

def check_disk_usage():
    disk_info = psutil.disk_usage('/')
    disk_usage = disk_info.percent
    if disk_usage > DISK_THRESHOLD:
        alert = f"High disk usage detected: {disk_usage}%"
        print(alert)
        logging.warning(alert)

def check_running_processes():
    # Example of checking for specific processes, modify as needed
    processes_to_check = ['nginx', 'apache2', 'mysql']
    for proc in processes_to_check:
        if any(proc in p.name() for p in psutil.process_iter()):
            alert = f"Process {proc} is running."
            print(alert)
            logging.info(alert)
        else:
            alert = f"Process {proc} is not running."
            print(alert)
            logging.info(alert)

if __name__ == "__main__":
    check_cpu_usage()
    check_memory_usage()
    check_disk_usage()
    check_running_processes()`
```
**Usage:**

1.  Ensure you have the `psutil` library installed. You can install it using pip:

    ```bash

    `pip install psutil`
    ```
2.  Ensure the log directory exists and is writable. If `/var/log/` does not exist or is not writable, modify the logging configuration to use a different directory.

3.  Run the script:

  ```bash
    `python system-monitor.py`
  ```
    The script will print alerts to the console and log them to `/var/log/system_health.log`.
