state=1
oldpos=0
white=511
red=256
green=0
blue=0
left=0
tmrstarted=0

cc = coap.Client()

rotary.setup(0,5,6,7) -- GPIO 14/12/13

function ky040rot(pos, when)
    if pos > oldpos then left=left+1
    else left=left-1 end
    oldpos = pos
    if tmrstarted==0 then
        tmrstarted=1
        tmr.alarm(1,100,0,function() ky040rotaction() end)
    end
end

function ky040rotaction()
    if left > 0 then
        if state == 1 then
            if white > 0 then white=white-7 end
            cc:put(coap.NON,"coap://192.168.179.2:5683/white",white)
        end
        if state == 2 then
            if     red == 256 and green  < 256 and blue ==   0 then green=green+4
            elseif red  >   0 and green == 256 and blue ==   0 then red=red-4
            elseif red ==   0 and green == 256 and blue  < 256 then blue=blue+4
            elseif red ==   0 and green  >   0 and blue == 256 then green=green-4
            elseif red  < 256 and green ==   0 and blue == 256 then red=red+4
            elseif red == 256 and green ==   0 and blue  >   0 then blue=blue-4 end
            rgb=red..","..green..","..blue
            cc:put(coap.NON,"coap://192.168.179.2:5683/rgb",rgb)
        end
    else
        if state == 1 then
            if white < 511 then white=white+7 end
            cc:put(coap.NON,"coap://192.168.179.2:5683/white",white)
        end
        if state == 2 then
            if     red == 256 and green ==   0 and blue  < 256 then blue=blue+4
            elseif red  >   0 and green ==   0 and blue == 256 then red=red-4
            elseif red ==   0 and green  < 256 and blue == 256 then green=green+4
            elseif red ==   0 and green == 256 and blue  >   0 then blue=blue-4
            elseif red  < 256 and green == 256 and blue ==   0 then red=red+4
            elseif red == 256 and green  >   0 and blue ==   0 then green=green-4 end
            rgb=red..","..green..","..blue
            cc:put(coap.NON,"coap://192.168.179.2:5683/rgb",rgb)
        end
    end
    left=0
    tmrstarted=0
    return
end

function ky040button()
    state = state + 1
    if state == 3 then state = 0 end
    if state == 0 then
        cc:put(coap.NON,"coap://192.168.179.2:5683/switch","Off")
    elseif state == 1 then
        cc:put(coap.NON,"coap://192.168.179.2:5683/switch","On")
        cc:put(coap.NON,"coap://192.168.179.2:5683/white",white)
        cc:put(coap.NON,"coap://192.168.179.2:5683/rgb","0,0,0")
    else
        rgb=red..","..green..","..blue
        cc:put(coap.NON,"coap://192.168.179.2:5683/white",0)
        cc:put(coap.NON,"coap://192.168.179.2:5683/rgb",rgb)
    end
    return
end

rotary.on(0, rotary.ALL, function (type, pos, when) 
    if type == 1 then ky040button()
    elseif type == 8 then ky040rot(pos, when) end
end)
