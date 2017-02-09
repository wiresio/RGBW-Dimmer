-- turn on the bulb
gpio.mode(8, gpio.OUTPUT)
pwm.setduty(7, 0)
pwm.setduty(6, 0)
pwm.setduty(5, 0)
gpio.write(8, gpio.HIGH)

-- connect to switch
wifi.setmode(wifi.STATION)
wifi.sta.config("lyt8266","!felizchaparron")
tmr.alarm(1,1000,1,function() 
    if wifi.sta.getip()~=nil then  
        tmr.stop(1)
		dofile("main.lc")
    end 
end)
