---- Code Area ----
trash_useless   = false
webhook_enable  = true
warp_interval   = 5000
trash_webhook   = true
detonator       = 5524
---------------------- Trash list --------------------------
trash = {
    -- items list u want to trash if trash_useless = true
}

bot = getBot()

function SplitString(str,special)
    local rows = {}
    delimiter = special
    for row in str:gmatch("[^"..delimiter.."]+") do
        table.insert(rows, row)
    end
    return rows
end

function GetTimeZoneOffset()
    local offset_str = os.date("%z")
    local sign = offset_str:sub(1, 1)
    local hours = tonumber(offset_str:sub(2, 3))
    local minutes = tonumber(offset_str:sub(4, 5))
    local offset_seconds = (hours * 3600) + (minutes * 60)
    if sign == "-" then
        offset_seconds = -offset_seconds
    end
    return offset_seconds
end

function GetIndoTime()
    local current_time_utc = os.time(os.date("!*t"))
    local timeZoneOffset = GetTimeZoneOffset()
    local local_time = current_time_utc + timeZoneOffset
    indonesianDate = os.date("%B %d, %Y", local_time)
    indonesianTime = os.date("%H:%M", local_time)
    return {date = indonesianDate, time = indonesianTime}
end

function GonWebhook(desc)
    wh = Webhook.new(WebhookUrl)
    wh.username = "YourKing AUTO Fishing"
    wh.avatar_url = "https://www.kaorinusantara.or.id/wp-content/uploads/2018/11/film-kakegurui-2019-visual-F.jpg"
    wh.embed1.use = true
    wh.embed1.title = "AUTO FISHING by YourKing"
    wh.embed1.description = desc
    wh:send()
end

function getposx()

    return getBot():getWorld():getLocal().posx
end

function getposy()

    return getBot():getWorld():getLocal().posy
end


--- function take rod ----
function getrod(bot, index)

    if not take_rod then return end

    if not bot:isInWorld() then
        sleep(500)
        bot:warp(WorldSRod[index])
        sleep(warp_interval)
    end

    if bot:getInventory():getItemCount(RodItem) > 0 or bot:getInventory():getItemCount(RodItem) > 0 then 
        return     
    end

    if getBot():getWorld().name ~= WorldSRod[index]:match("(.+)|"):upper() then
        sleep(500)
        bot:warp(WorldSRod[index])
        sleep(warp_interval)
    end

    if getBot():getWorld():getTile(math.floor(getposx()/32), math.floor(getposy()/32)).fg == 6 then
        sleep(500)
        bot:warp(WorldSRod[index])
        sleep(warp_interval)
    end

    while getBot():getInventory():getItemCount(RodItem) == 0 do
        for _, obj in pairs(getBot():getWorld():getObjects()) do
            if obj.id == RodItem then
                getBot().collect_range = 2
                getBot().auto_collect = true
                getBot():findPath(math.floor(obj.x/32), math.floor(obj.y/32))
                sleep(5000)

                while getBot():getInventory():getItemCount(RodItem) == 0 do sleep(1000) end
            end
        end
    end

    if getBot():getInventory():getItemCount(RodItem) > 1 then
        getBot().auto_collect = false
        sleep(4000)
        bot:drop(RodItem, getBot():getInventory():getItemCount(RodItem) - 1)
        sleep(4000)
        bot:wear(RodItem)
        sleep(3000)
    end
end

---Function Scan Bait---
function floatScan()
    local count = 0
    ida = Baits
    for _,obj in pairs(bot:getWorld():getObjects()) do
        if obj.id == ida then
            count = count + obj.count
        end
    end
    return count
end

---Function Scan Bait---
function floatScan2()
    local count = 0
    idb = detonator
    for _,obj in pairs(bot:getWorld():getObjects()) do
        if obj.id == idb then
            count = count + obj.count
        end
    end
    return count
end

--- Function take bait ---
take_bait = true

function getbait(bot, index)

    bot.auto_collect = false

    if not take_bait then return end

    if not bot:isInWorld() then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    if bot:getInventory():getItemCount(Baits) > 0 or bot:getInventory():getItemCount(Baits) > 0 then 
        return     
    end

    if getBot():getWorld().name ~= WorldSBait[index]:match("(.+)|"):upper() then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    if getBot():getWorld():getTile(math.floor(getposx()/32), math.floor(getposy()/32)).fg == 6 then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    local Baits_count = 0
    for id, count in pairs(getBot():getWorld().growscan:getObjects()) do
        if id == Baits then Baits_count = count end
    end

    if Baits_count < 1 then
        GonWebhook(":warning: **| 0 BAITS SIR |** :warning:"..
        "\n==================================================="..
        "\n<:growbot:1133362502667866132> **| Bot Information |** <:growbot:1133362502667866132>"..
        "\n<:birth_certificate:1011929949076193291> BOT NAME :" ..getBot().name..
        "\n<:globe:1011929997679796254> | World : "..getBot():getWorld().name..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| FLOATING STORAGE INFORMATION |** <:pickaxe:1011931845065183313>"..
        "\n<:jar2:1112272439540449402> BAITS | "..floatScan()..
        "\n==================================================="..
        "\n<:lucifer:1106878943186931712> **| RDP Information |** <:lucifer:1106878943186931712>"..
        "\n:calendar: | Date  : "..GetIndoTime().date..
        "\n<:growtopia_clock:1011929976628596746> | Time  : "..GetIndoTime().time..
        "\n==================================================="..
        "\n**KINGTOPIA DISCORD**"..
        "\n**JOIN HERE : https://discord.gg/4ejU9KDuUA**"..
        "\n**BUY SC FROM RESELLER? REPORT To Owner : <@443422981104992258>**"..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| Auto FISHING By YOURKING |** <:pickaxe:1011931845065183313>"..
        "\n===================================================".."")
        sleep(1000)
        GonWebhook("Bot : "..getBot().name.." offline sir cz your storage 0 bait"..
        "\n:warning: ALSO DONT FORGET TO STOP SCRIPT IF YOU WANT TO CONTINUE SIR".."")
        sleep(1000)        
        bot.auto_reconnect = false
        bot:disconnect()
        stop_program = true
        return
    end

    for _, obj in pairs(bot:getWorld():getObjects()) do

        if obj.id == Baits then
            last_obj = obj
        end
    end

    if last_obj.id == Baits then
        sleep(500)
        bot:findPath(math.floor(last_obj.x/32) +1,math.floor(last_obj.y/32))
        sleep(2000)
        bot:collect(4, 500)
        sleep(2000)
        bot:moveRight()
        sleep(1000)
        bot:moveLeft()
        sleep(1000)
        bot:say("Yourking cakeup beut dah!")
        sleep(1000)
        GonWebhook(":warning: **| INFO STORAGE BAITS SIR |** :warning:"..
        "\n==================================================="..
        "\n<:growbot:1133362502667866132> **| Bot Information |** <:growbot:1133362502667866132>"..
        "\n<:birth_certificate:1011929949076193291> BOT NAME :" ..getBot().name..
        "\n<:globe:1011929997679796254> | World : "..getBot():getWorld().name..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| FLOATING STORAGE INFORMATION |** <:pickaxe:1011931845065183313>"..
        "\n<:jar2:1112272439540449402> BAITS | "..floatScan()..
        "\n==================================================="..
        "\n<:lucifer:1106878943186931712> **| RDP Information |** <:lucifer:1106878943186931712>"..
        "\n:calendar: | Date  : "..GetIndoTime().date..
        "\n<:growtopia_clock:1011929976628596746> | Time  : "..GetIndoTime().time..
        "\n==================================================="..
        "\n**KINGTOPIA DISCORD**"..
        "\n**JOIN HERE : https://discord.gg/4ejU9KDuUA**"..
        "\n**BUY SC FROM RESELLER? REPORT To Owner : <@443422981104992258>**"..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| Auto FISHING By YOURKING |** <:pickaxe:1011931845065183313>"..
        "\n===================================================".."")
        sleep(1000)
    end

    local Baits_count = 0
    for id, count in pairs(getBot():getWorld().growscan:getObjects()) do
        if id == Baits then Baits_count = count end
    end    

end

-- Func take deto --

function getdeto(bot, index)

    bot.auto_collect = false

    if not Auto_Deto then return end

    if not bot:isInWorld() then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    if bot:getInventory():getItemCount(detonator) > 0 or bot:getInventory():getItemCount(detonator) > 0 then 
        return     
    end

    if getBot():getWorld().name ~= WorldSBait[index]:match("(.+)|"):upper() then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    if getBot():getWorld():getTile(math.floor(getposx()/32), math.floor(getposy()/32)).fg == 6 then
        sleep(500)
        bot:warp(WorldSBait[index])
        sleep(warp_interval)
    end

    local detonator_count = 0
    for id, count in pairs(getBot():getWorld().growscan:getObjects()) do
        if id == detonator then detonator_count = count end
    end

    if detonator_count < 1 then
        GonWebhook(":warning: **| 0 DETO SIR |** :warning:"..
        "\n==================================================="..
        "\n<:growbot:1133362502667866132> **| Bot Information |** <:growbot:1133362502667866132>"..
        "\n<:birth_certificate:1011929949076193291> BOT NAME :" ..getBot().name..
        "\n<:globe:1011929997679796254> | World : "..getBot():getWorld().name..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| FLOATING STORAGE INFORMATION |** <:pickaxe:1011931845065183313>"..
        "\n<:jar2:1112272439540449402> DETONAROR | "..floatScan2()..
        "\n==================================================="..
        "\n<:lucifer:1106878943186931712> **| RDP Information |** <:lucifer:1106878943186931712>"..
        "\n:calendar: | Date  : "..GetIndoTime().date..
        "\n<:growtopia_clock:1011929976628596746> | Time  : "..GetIndoTime().time..
        "\n==================================================="..
        "\n**KINGTOPIA DISCORD**"..
        "\n**JOIN HERE : https://discord.gg/4ejU9KDuUA**"..
        "\n**BUY SC FROM RESELLER? REPORT To Owner : <@443422981104992258>**"..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| Auto FISHING By YOURKING |** <:pickaxe:1011931845065183313>"..
        "\n===================================================".."")
        sleep(1000)
        GonWebhook("Bot : "..getBot().name.." offline sir cz your storage 0 Detonator"..
        "\n:warning: ALSO DONT FORGET TO STOP SCRIPT IF YOU WANT TO CONTINUE SIR".."")
        sleep(1000)        
        bot.auto_reconnect = false
        bot:disconnect()
        stop_program = true
        return
    end

    for _, obj in pairs(bot:getWorld():getObjects()) do

        if obj.id == detonator then
            last_obj = obj
        end
    end

    if last_obj.id == detonator then
        sleep(500)
        bot:findPath(math.floor(last_obj.x/32) +1,math.floor(last_obj.y/32))
        sleep(2000)
        bot:collect(4, 500)
        sleep(2000)
        bot:moveRight()
        sleep(1000)
        bot:moveLeft()
        sleep(1000)
        bot:say("Yourking cakeup beut dah!")
        sleep(1000)
        GonWebhook(":warning: **| INFO STORAGE BAITS/DETO SIR |** :warning:"..
        "\n==================================================="..
        "\n<:growbot:1133362502667866132> **| Bot Information |** <:growbot:1133362502667866132>"..
        "\n<:birth_certificate:1011929949076193291> BOT NAME :" ..getBot().name..
        "\n<:globe:1011929997679796254> | World : "..getBot():getWorld().name..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| FLOATING STORAGE INFORMATION |** <:pickaxe:1011931845065183313>"..
        "\n BAITS | "..floatScan()..
        "\n DETONATOR | "..floatScan2()..
        "\n==================================================="..
        "\n<:lucifer:1106878943186931712> **| RDP Information |** <:lucifer:1106878943186931712>"..
        "\n:calendar: | Date  : "..GetIndoTime().date..
        "\n<:growtopia_clock:1011929976628596746> | Time  : "..GetIndoTime().time..
        "\n==================================================="..
        "\n**KINGTOPIA DISCORD**"..
        "\n**JOIN HERE : https://discord.gg/4ejU9KDuUA**"..
        "\n**BUY SC FROM RESELLER? REPORT To Owner : <@443422981104992258>**"..
        "\n==================================================="..
        "\n<:pickaxe:1011931845065183313> **| Auto FISHING By YOURKING |** <:pickaxe:1011931845065183313>"..
        "\n===================================================".."")
        sleep(1000)
    end

    local detonator_count = 0
    for id, count in pairs(getBot():getWorld().growscan:getObjects()) do
        if id == detonator then detonator_count = count end
    end    

end

---------------------------------------------------------------------------------
--start fishing without deto--
function startFishing(bot, index)

    if bot.status ~= 1 then return end

    if bot:getWorld().name ~= WorldAutoFish[index]:upper() then
        sleep(500)
        bot:warp(WorldAutoFish[index])
        sleep(warp_interval)
    end

    if not bot:getWorld():getLocal() then
        sleep(200)
        return
    end

    if bot:getInventory():getItemCount(RodItem) == 0 then
        return
    end

    if bot:getInventory():getItemCount(Baits) == 0 then
        checkInventory(bot, save_index)
        sleep(500)
        getbait(getBot(), save_index)
        sleep(500)
    end

    if bot:getInventory():getItemCount(Baits) > 0 and bot:getInventory():getItemCount(RodItem) > 0 then
        bot:wear(RodItem)
        sleep(1000)
        bot.auto_fish:setRod(RodItem)
        sleep(500)
        bot.auto_fish:setBait(Baits)
        sleep(500)
        checkInventory(bot, save_index)
        sleep(500)
        bot.auto_fish.enabled = true
        sleep(500)
    end

end

-- start fishing using deto --
function startFishingdeto(bot, index)

    if bot.status ~= 1 then return end

    if bot:getWorld().name ~= WorldAutoFish[index]:upper() then
        sleep(500)
        bot:warp(WorldAutoFish[index])
        sleep(warp_interval)
    end

    if not bot:getWorld():getLocal() then
        sleep(200)
        return
    end

    if bot:getInventory():getItemCount(RodItem) == 0 then
        return
    end

    if bot:getInventory():getItemCount(Baits) == 0 then
        checkInventory(bot, save_index)
        sleep(500)
        getbait(getBot(), save_index)
        sleep(500)
    end

    if bot:getInventory():getItemCount(detonator) == 0 then
        checkInventory(bot, save_index)
        sleep(500)
        getdeto(getBot(), save_index)
        sleep(500)
    end

    if bot:getInventory():getItemCount(Baits) > 0 and bot:getInventory():getItemCount(RodItem) > 0 and bot:getInventory():getItemCount(detonator) > 0 then
        bot:wear(RodItem)
        sleep(1000)
        bot.auto_fish:setRod(RodItem)
        sleep(500)
        bot.auto_fish:setBait(Baits)
        sleep(500)
        checkInventory(bot, save_index)
        sleep(500)
        bot.auto_fish.auto_drill = true
        sleep(1000)
        bot.auto_fish.enabled = true
        sleep(500)
    end

end
--- function check inventory ---

function checkInventory(bot, index)

    if bot.status ~= 1 then return end

    if trash_useless then
        for _, trash_item in pairs(trash) do
            if bot:getInventory():getItemCount(trash_item) > 0 then
                bot.auto_fish.enabled = false
                if trash_webhook then
                GonWebhook("BOT NAME :  " ..getBot().name.. " Trashed "..getInfo(bot:getInventory():getItem(trash_item).id).name..
                "\n**| RDP Information |**"..
                "\nDate  : "..GetIndoTime().date..
                "\nTime  : "..GetIndoTime().time..
                "\n========================================".."")
                end
                sleep(4000)
                bot:trash(trash_item, bot:getInventory():getItemCount(trash_item))
                sleep(4000)
                getBot():respawn()
                GonWebhook("BOT NAME :  " ..getBot().name.. " Iam Continue fishing sir! "..
                "\n**| RDP Information |**"..
                "\nDate  : "..GetIndoTime().date..
                "\nTime  : "..GetIndoTime().time..
                "\n========================================".."")

            end
        end
    end

    for _, item in pairs(RarePrize) do
        if bot:getInventory():getItemCount(item) > Save_Amount then
            bot.auto_fish.enabled = false
            sleep(500)
            getBot().auto_collect = false
            sleep(500)
            Drop(item, index)
        end
    end
end

function Drop(item, index)


    if getBot():getWorld().name ~= WorldSSave[index]:match("(.+)|"):upper() then
        sleep(500)
        getBot():warp(WorldSSave[index])
        sleep(warp_interval)
    end

    if not getBot():getWorld():getLocal() then
        sleep(200)
        return
    end

    if getBot():getWorld():getTile(math.floor(getposx()/32), math.floor(getposy()/32)).fg == 6 then
        sleep(500)
        getBot():warp(WorldSSave[index])
        sleep(warp_interval)
    end

    sleep(4000)
    GonWebhook("BOT NAME :  " ..getBot().name.. " DROP "..getInfo(bot:getInventory():getItem(item).id).name..
    "\n**| RDP Information |**"..
    "\nDate  : "..GetIndoTime().date..
    "\nTime  : "..GetIndoTime().time..
    "\n========================================".."")
    sleep(400)
    getBot():drop(item, getBot():getInventory():getItemCount(item))
    sleep(4000)
    
    GonWebhook("BOT NAME :  " ..getBot().name.. " DROP REWARD HERE SIR "..getBot():getWorld().name..
    "\n**| RDP Information |**"..
    "\nDate  : "..GetIndoTime().date..
    "\nTime  : "..GetIndoTime().time..
    "\n========================================".."")
    sleep(4000)
    GonWebhook("BOT NAME :  " ..getBot().name.. " Back to fishing world sir! "..
    "\n**| RDP Information |**"..
    "\nDate  : "..GetIndoTime().date..
    "\nTime  : "..GetIndoTime().time..
    "\n========================================".."")

end

function main()

    if script_id == 1 then
        GonWebhook("BOT NAME :  " ..getBot().name.. " START AUTO FISHING SCRIPT "..
        "\n**| RDP Information |**"..
        "\nDate  : "..GetIndoTime().date..
        "\nTime  : "..GetIndoTime().time..
        "\n========================================".."")
    end

    save_indexs = 1

    if script_id % #WorldSRod == 0 then
        save_indexs = #WorldSRod
    else
        save_indexs = script_id % #WorldSRod
    end

    getrod(getBot(), save_indexs)

    save_index = 1

    if script_id % #WorldSBait == 0 then
        save_index = #WorldSBait
    else
        save_index = script_id % #WorldSBait
    end

    while true do

        local bot = getBot()

        index = 1
        if script_id % #WorldAutoFish == 0 then
            index = #WorldAutoFish
        else
            index = script_id % #WorldAutoFish
        end

        save_index = 1
        if script_id % #WorldSSave == 0 then
            save_index = #WorldSSave
        else
            save_index = script_id % #WorldSSave
        end
        
        if Auto_Deto = true then
            startFishingdeto(bot, index)
        else
            startFishing(bot, index)
        end
        sleep(5000)
    end
end

main()
