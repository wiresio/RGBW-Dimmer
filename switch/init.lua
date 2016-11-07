wifi.setmode(wifi.SOFTAP)
maccfg =
{
    ssid="lyt8266",
    pwd="!felizchaparron"
}
wifi.ap.config(maccfg)
ifcfg =
{
    ip="192.168.179.1",
    netmask="255.255.255.0",
    gateway="192.168.179.1"
}
wifi.ap.setip(ifcfg)
dofile("main.lc")
