ezperks_Perks = {}

function ezperks_AddPerk(name)
    ezperks_Perks[name] = {}
    ezperks_Perks[name].upgrades = {}
end

function ezperks_AddUpgrade(name, price, description, buyFunc)
    table.insert(ezperks_Perks[name].upgrades, {name = name, price = price, description = description, buyFunc = buyFunc}) 
end
