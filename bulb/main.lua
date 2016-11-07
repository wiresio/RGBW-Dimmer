vr = 0
vg = 0
vb = 0
vw = 0
pwm.setup(7, 500, 512) -- red
pwm.setup(6, 500, 512) -- green
pwm.setup(5, 500, 512) -- blue
pwm.setup(4, 500, 512) -- white
gpio.mode(8, gpio.OUTPUT) -- enable
pwm.start(7)
pwm.start(6)
pwm.start(5)
pwm.start(4)
function led(r, g, b)
    pwm.setduty(7, r)
    pwm.setduty(6, g)
    pwm.setduty(5, b)
end
function rgb(payload, opts)
    vr, vg, vb = payload:match("([^,]+),([^,]+),([^,]+)")
    led(vr, vg, vb)
    return
end
function white(payload, opts)
	pwm.setduty(4, payload)
    return
end
function switch(payload, opts)
	if payload == "Off" then
		gpio.write(8, gpio.LOW)
	else
		gpio.write(8, gpio.HIGH)
	end
	return
end
led(vr, vg, vb)
gpio.write(8, gpio.HIGH)
-- COAP server
cs=coap.Server()
cs:listen(5683)
cs:func(coap.PUT, "rgb")
cs:func(coap.PUT, "white")
cs:func(coap.PUT, "switch")
