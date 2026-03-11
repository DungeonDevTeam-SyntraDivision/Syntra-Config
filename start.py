#!/usr/bin/env python3
import time
import urllib.request
import os
import shutil
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

URL = "http://localhost:3000/display"

# This creates a profile folder in your home directory so the Snap can access it
PROFILE_DIR = os.path.expanduser("~/.firefox_selenium_profile")
if os.path.exists(PROFILE_DIR):
    shutil.rmtree(PROFILE_DIR)
os.makedirs(PROFILE_DIR)

while True:
    try:
        urllib.request.urlopen("http://localhost:3000", timeout=5)
        break
    except Exception:
        time.sleep(2)

options = Options()
options.binary_location = "/snap/bin/firefox"
options.add_argument("--kiosk")

# Force Firefox to use the directory we just created
options.add_argument("-profile")
options.add_argument(PROFILE_DIR)

options.set_preference("media.autoplay.default", 0)
options.set_preference("media.autoplay.enabled.user-gestures-needed", False)
options.set_preference("dom.webdriver.enabled", False)

service = Service(executable_path="/usr/local/bin/geckodriver")
driver = webdriver.Firefox(service=service, options=options)
driver.get(URL)

try:
    button = WebDriverWait(driver, 30).until(
        EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Enable Audio')]"))
    )
    button.click()
except Exception:
    pass

try:
    while True:
        time.sleep(60)
except KeyboardInterrupt:
    driver.quit()