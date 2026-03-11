#!/usr/bin/env python3
import time
import urllib.request
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import shutil

URL = "http://localhost:3000/display"

# Wait for the page to be available before opening the browser
print("Waiting for localhost:3000 to be ready...")
while True:
    try:
        urllib.request.urlopen("http://localhost:3000", timeout=5)
        break
    except Exception:
        time.sleep(2)
print("Server is up.")

options = Options()
options.binary_location = "/snap/bin/chromium"
options.add_argument("--start-fullscreen")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-infobars")
options.add_argument("--remote-debugging-port=9222")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option("useAutomationExtension", False)

chromedriver_path = shutil.which("chromedriver") or "/snap/chromium/current/usr/lib/chromium-browser/chromedriver"
service = Service(chromedriver_path)
driver = webdriver.Chrome(service=service, options=options)
driver.get(URL)

button = WebDriverWait(driver, 30).until(
    EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Enable Audio')]"))
)
button.click()
print("Button clicked successfully.")

# Keep the script alive so the browser stays open
while True:
    time.sleep(60)
