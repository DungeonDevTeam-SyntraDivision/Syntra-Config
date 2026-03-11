#!/usr/bin/env python3
import time
import urllib.request
import os
import shutil
import tempfile
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import StaleElementReferenceException, TimeoutException

URL = "http://localhost:3000/display"

# Profile setup for Snap
base_dir = os.path.expanduser("~/firefox_automation_profiles")
if not os.path.exists(base_dir):
    os.makedirs(base_dir)
profile_path = tempfile.mkdtemp(dir=base_dir)

# Wait for local server
while True:
    try:
        urllib.request.urlopen("http://localhost:3000", timeout=5)
        break
    except Exception:
        print("Waiting for server...")
        time.sleep(2)

options = Options()
options.binary_location = "/snap/bin/firefox"
options.add_argument("--no-remote")
options.add_argument("--new-instance")
options.add_argument("-profile")
options.add_argument(profile_path)

# GPU Fixes
options.set_preference("layers.acceleration.disabled", True)
options.set_preference("gfx.webrender.all", False)
options.set_preference("media.autoplay.default", 0)
options.set_preference("media.autoplay.enabled.user-gestures-needed", False)

service = Service(executable_path="/usr/local/bin/geckodriver")

driver = None

try:
    print("Launching Firefox...")
    driver = webdriver.Firefox(service=service, options=options)
    driver.maximize_window()
    driver.fullscreen_window()
    
    print(f"Navigating to {URL}...")
    driver.get(URL)

    # Give the page 2 seconds to finish any initial JS re-renders
    time.sleep(2)

    print("Attempting to click 'Enable Audio'...")
    clicked = False
    attempts = 0
    
    # Retry loop for Stale Elements
    while attempts < 5 and not clicked:
        try:
            button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Enable Audio')]"))
            )
            button.click()
            clicked = True
            print("Success: Button clicked.")
        except StaleElementReferenceException:
            print("Element went stale, retrying...")
            attempts += 1
            time.sleep(1)
        except TimeoutException:
            print("Button not found. Is it already clicked or hidden?")
            break

    # KEEP ALIVE LOOP
    # We stay here forever unless a KeyboardInterrupt (Ctrl+C) happens
    while True:
        time.sleep(60)

except KeyboardInterrupt:
    print("\nScript stopped by user.")
except Exception as e:
    print(f"\nAN ERROR OCCURRED: {e}")
    # We do NOT run driver.quit() here so you can see the state of the browser
finally:
    # Only clean up if the driver was never started
    if driver is None:
        shutil.rmtree(profile_path)