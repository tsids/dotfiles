import time
from pynput.mouse import Listener, Controller

# Limit mouse click frequency to 100ms
CLICK_LIMIT_MS = 0.1

mouse = Controller()
last_click_time = 0

def on_click(x, y, button, pressed):
    global last_click_time

    current_time = time.time()
    if pressed and current_time - last_click_time >= CLICK_LIMIT_MS:
        last_click_time = current_time
        mouse.click(button)

# Start the mouse listener
with Listener(on_click=on_click) as listener:
    listener.join()
