wifi.setmode(wifi.STATION)
wifi.sta.config("lyt8266","!felizchaparron")
tmr.alarm(1,1000, 1, function() 
    if wifi.sta.getip()~=nil then  
        tmr.stop(1)
		dofile("main.lc")
     end 
end)
