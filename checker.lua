ip = {} -- dont edit

webhookLink = "https://discord.com/api/webhooks/1035557935448866998/KOnWPxOJVDLZsOcKtud679oNze2dz4OEdW2cl7Q9ukBKLxaPEhQ6gQ5enOmyHZpUzbIK" -- Webhook link
messageId = "1035558022438715413" -- Webhook message id
showIp = false -- set false if not showing ip
checkerDelay = 1000 -- Delay between each check
webhookDelay = 300000 -- Delay between each webhook

-- if not showIp 
ip[1] = {{"Varnishing","Backhander"}}
ip[2] = {{"Insolating","Pantascope"}}
ip[3] = {{"Raghuvansa","Disencrese"}}
ip[4] = {{"Cognominal","Gnaphalium"}}
ip[5] = {{"Climatized","Fluidizing"}}
ip[6] = {{"Decangular","Desponsate"}}
ip[7] = {{"Platometer","Dorsimeson"}}
ip[8] = {{"Recolonize","Refracting"}}
ip[9] = {{"Partheniad","Uncurbable"}}
ip[10] = {{"Centistere","Dogmatical"}}

-- if showIp 
ip[1] = {{"botname","botname","botname"},"your ip address"}
ip[2] = {{"botname","botname","botname"},"your ip address"}
ip[3] = {{"botname","botname","botname"},"your ip address"}
ip[4] = {{"botname","botname","botname"},"your ip address"}
ip[5] = {{"botname","botname","botname"},"your ip address"}
ip[6] = {{"botname","botname","botname"},"your ip address"}
ip[7] = {{"botname","botname","botname"},"your ip address"}
ip[8] = {{"botname","botname","botname"},"your ip address"}
ip[9] = {{"botname","botname","botname"},"your ip address"}
ip[10] = {{"botname","botname","botname"},"your ip address"}

function webhook(txt)
    local text = [[
        $webHookUrl = "]]..webhookLink..[[/messages/]]..messageId..[["
        $footerObject = @{
            text = "Auto Refresh every 5 Minutes! | ]]..os.date("!%b %d at %H:%M %p", os.time() + 7 * 60 * 60)..[["
        }
        $fieldArray = @(]]..txt..[[)
        $embedObject = @{
            title = "CHECKER BOT ROTASI"
            footer = $footerObject
            fields = $fieldArray
        }
        $embedArray = @($embedObject)
        $payload = @{
            embeds = $embedArray
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Patch -ContentType 'application/json'
    ]]
    local file = io.popen("powershell -command -", "w")
    file:write(text)
    file:close()
end

while true do
    txt = ""
    for i = 1,#ip do
        str = ""
        for _,bot in pairs(ip[i][1]) do
            if checkUser(bot,checkerDelay) then
                str = str.."<:online:1026204551155556424>"
            else
                str = str.."<:offline:1026204549054214214>"
            end
            str = str.." "..bot:upper().."\n"
        end
        if showIp then
            str = str..":computer: "..ip[i][2].."\n"
        end
        txt = txt..[[@{name = 'RDP - ]]..i..[[';value = ']]..str..[[';inline = 'true'};]]
    end
    webhook(txt)
    sleep(webhookDelay)
end
