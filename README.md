Color LEDs like Philips Hue, Osram Lightify or LIFX are a nice upgrade to home lighting but are quite costly and (despite of LIFX) are somehow inflexible in terms of customizing. As an interesting alternative for DIYers Italian company Souliss is currently offering a nice RGBW LED called LYT8266 (another alternative that I have not yet tested is WifiPixels).

My idea was to connect the LED to a smart flush-mounted controller to turn it on and off, to dimm the brightness, and to adjust the colors. Since there is no such controller, I had to construct one on my own.
 
Piece 1 - The LED

Out-of-the box the LYT8266 isn't doing anything and has to be flashed with an appropriate firmware, e.g. this one here to come into operation. After trying the Souliss firmware, I decided to flash NodeMCU onto the bulb since I'm not familiar to the Arduino environment and since I wanted to have a possibility to program it via Lua scripts. NodeMCU works for the LYT8266 since there is an ESP-03, that controls the GPIOs, soldered onto it .
