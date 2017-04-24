 local function config()   

    /*********************************
    CONFIG STARTS HERE
    *********************************/

    // AddPerk simply takes the name of the perk
    // AddUpgrade takes the name you generated using AddPerk, price, description, and function to run on buy

    ezperks_AddPerk("Speed Cola")
    ezperks_AddUpgrade("Speed Cola", 100, "Increase your running speed to 250!", function(ply) ply:SetRunSpeed(250) end)
    ezperks_AddUpgrade("Speed Cola", 200, "Increase your running speed to 260!", function(ply) ply:SetRunSpeed(260) end)
    ezperks_AddUpgrade("Speed Cola", 300, "Increase your running speed to 270!", function(ply) ply:SetRunSpeed(270) end)
    ezperks_AddUpgrade("Speed Cola", 400, "Increase your running speed to 280!", function(ply) ply:SetRunSpeed(280) end)
    ezperks_AddUpgrade("Speed Cola", 500, "Increase your running speed to 290!", function(ply) ply:SetRunSpeed(290) end)

    ezperks_AddPerk("Jumping Pills")
    ezperks_AddUpgrade("Jumping Pills", 100, "Jump at a all new power of 210!", function(ply) ply:SetJumpPower(210) end)
    ezperks_AddUpgrade("Jumping Pills", 200, "Jump at a all new power of 220!", function(ply) ply:SetJumpPower(220) end)
    ezperks_AddUpgrade("Jumping Pills", 300, "Jump at a all new power of 230!", function(ply) ply:SetJumpPower(230) end)
    ezperks_AddUpgrade("Jumping Pills", 400, "Jump at a all new power of 240!", function(ply) ply:SetJumpPower(240) end)
    ezperks_AddUpgrade("Jumping Pills", 500, "Jump at a all new power of 250!", function(ply) ply:SetJumpPower(250) end)

    ezperks_AddPerk("Walking Stick")
    ezperks_AddUpgrade("Walking Stick", 100, "Grandma's walking stick will get you to 170 walk speed!", function(ply) ply:SetWalkSpeed(170) end)
    ezperks_AddUpgrade("Walking Stick", 200, "Grandma's walking stick will get you to 180 walk speed!", function(ply) ply:SetWalkSpeed(180) end)
    ezperks_AddUpgrade("Walking Stick", 300, "Grandma's walking stick will get you to 190 walk speed!", function(ply) ply:SetWalkSpeed(190) end)
    ezperks_AddUpgrade("Walking Stick", 400, "Grandma's walking stick will get you to 200 walk speed!", function(ply) ply:SetWalkSpeed(200) end)
    ezperks_AddUpgrade("Walking Stick", 500, "Grandma's walking stick will get you to 210 walk speed!", function(ply) ply:SetWalkSpeed(210) end)

    ezperks_AddPerk("HealthUp")
    ezperks_AddUpgrade("HealthUp", 100, "Take these pills to increase your spawn / max health to 110!", function(ply) ply:SetMaxHealth(110) ply:SetHealth(110) end)
    ezperks_AddUpgrade("HealthUp", 200, "Take these pills to increase your spawn / max health to 120!", function(ply) ply:SetMaxHealth(120) ply:SetHealth(120) end)
    ezperks_AddUpgrade("HealthUp", 300, "Take these pills to increase your spawn / max health to 130!", function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) end)
    ezperks_AddUpgrade("HealthUp", 400, "Take these pills to increase your spawn / max health to 140!", function(ply) ply:SetMaxHealth(140) ply:SetHealth(140) end)
    ezperks_AddUpgrade("HealthUp", 500, "Take these pills to increase your spawn / max health to 150!", function(ply) ply:SetMaxHealth(150) ply:SetHealth(150) end)

    ezperks_AddPerk("Armorade")
    ezperks_AddUpgrade("Armorade", 100, "Take these pills to spawn with 110 armor!", function(ply) ply:SetArmor(110) end)
    ezperks_AddUpgrade("Armorade", 200, "Take these pills to spawn with 120 armor!", function(ply) ply:SetArmor(120) end)
    ezperks_AddUpgrade("Armorade", 300, "Take these pills to spawn with 130 armor!", function(ply) ply:SetArmor(130) end)
    ezperks_AddUpgrade("Armorade", 400, "Take these pills to spawn with 140 armor!", function(ply) ply:SetArmor(140) end)
    ezperks_AddUpgrade("Armorade", 500, "Take these pills to spawn with 150 armor!", function(ply) ply:SetArmor(150) end)

    -- Add teams to be blacklisted here, ensure they are within speech marks have a seperating comma. Use below as a guide.
    ezperks_JobBlacklist = {"Gun Dealer", "Civil Protection"}

    /*********************************
    CONFIG ENDS HERE
    *********************************/
end

hook.Add("PostGamemodeLoaded", "ezperks_Config", config)