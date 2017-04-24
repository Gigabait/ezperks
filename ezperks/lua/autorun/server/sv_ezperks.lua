resource.AddWorkshop("911022861")

util.AddNetworkString("ezperks_HandlePurchase")
util.AddNetworkString("ezperks_OpenUI")
util.AddNetworkString("ezperks_OpenNotifUI")

local function uiPrep(ply)
    local dataTable = {}

    for k, v in pairs(ezperks_Perks) do
        dataTable[k] = {}

        local data = tonumber(ply:GetPData("ezperks_" ..  k, 0))            
        dataTable[k].data = data
        dataTable[k].max =  #v.upgrades
    end

    net.Start("ezperks_OpenUI")
    net.WriteTable(dataTable)
    net.Send(ply)
end

local function handlePurchase(len, ply)
    if table.HasValue(ezperks_JobBlacklist,team.GetName(ply:Team())) then 
        DarkRP.notify(ply, NOTIFY_ERROR, 5, "You cannot use the perks menu as this job!")
        return 
    end

    local index = net.ReadString()

    if ezperks_Perks[index] == nil then return end

    local item = ezperks_Perks[index]
    local itemData = tonumber(ply:GetPData("ezperks_" .. index, 0))

    if itemData != #ezperks_Perks[index].upgrades then


        if !ply:canAfford(item.upgrades[itemData + 1].price) then 
            DarkRP.notify(ply, NOTIFY_ERROR, 5, "You cannot afford to upgrade " .. index)
            uiPrep(ply)
            return 
        end

        ply:addMoney(-item.upgrades[itemData + 1].price) 
        item.upgrades[itemData + 1].buyFunc(ply)

        ply:SetPData("ezperks_" .. index, itemData + 1)
        DarkRP.notify(ply, NOTIFY_GENERIC, 5, "You upgraded " .. index .. " for $" .. item.upgrades[itemData + 1].price)

        uiPrep(ply)
    end
end

net.Receive("ezperks_handlePurchase", handlePurchase)

local function chatCommand(ply, text)
    if table.HasValue(ezperks_JobBlacklist, team.GetName(ply:Team())) then 
        DarkRP.notify(ply, NOTIFY_ERROR, 5, "You cannot use the perks menu as this job!")
        return 
    end

    text = string.lower(text)

    if text == "!perks" or text == "/perks" then 
        uiPrep(ply)
    end
end
hook.Add("PlayerSay", "ezperks_ChatCommand", chatCommand)

local function buyFuncSpawn(ply)
    if table.HasValue(ezperks_JobBlacklist, team.GetName(ply:Team())) then return end

    // Apparently PlayerSpawn get's called too early to set speed and stuff
    timer.Simple(1, function()
        for k, v in pairs(ezperks_Perks) do
            local upgradeLevel = tonumber(ply:GetPData("ezperks_" .. k, 0))
            if upgradeLevel > 0 then v.upgrades[upgradeLevel].buyFunc(ply) end
        end
    end)
end
hook.Add("PlayerSpawn", "ezperks_BuyFuncSpawn", buyFuncSpawn)
hook.Add("OnPlayerChangedTeam", "ezperks_BuyFuncChangeTeam", buyFuncSpawn)