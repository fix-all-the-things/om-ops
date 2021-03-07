from selenium.webdriver import Firefox
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

options = Options()
options.add_argument('--headless')
driver = Firefox(options=options)
driver.set_window_size(1920, 1080)

driver.implicitly_wait(30)
wait = WebDriverWait(driver, timeout=30)

driver.get('http://localhost')
print("Waiting Cityvizor in title")
wait.until(EC.title_contains("Cityvizor"))
driver.get_screenshot_as_file("./pics/landing.png")

driver.get('http://localhost/praha12')
print("Waiting Praha 12 in title")
# No profile with data?
time.sleep(10)
print(driver.title)
# wait.until(EC.title_contains("Praha 12"))
driver.get_screenshot_as_file("./pics/profile.png")

el = driver.find_element_by_css_selector('#content div.row div')
wait.until(EC.visibility_of(el))
el.click()
driver.get_screenshot_as_file("./pics/detail.png")
