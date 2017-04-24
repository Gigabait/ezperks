surface.CreateFont( "ezperks_Title", {
    font = "Exo Light", 
    size = ScreenScale(12),
    weight = 300,
    antialias = true,
})

surface.CreateFont( "ezperks_Info", {
    font = "Exo Light", 
    size = ScreenScale(10),
    weight = 300,
    antialias = true,
})

surface.CreateFont( "ezperks_PerkTitle", {
    font = "Exo Light", 
    size = ScreenScale(14),
    weight = 300,
    antialias = true,
})

surface.CreateFont( "ezperks_PerkDesc", {
    font = "Exo Light", 
    size = ScreenScale(8),
    weight = 300,
    antialias = true,
})

surface.CreateFont( "ezperks_PerkBar", {
    font = "Exo Light", 
    size = ScreenScale(11),
    weight = 300,
    antialias = true,
})

surface.CreateFont( "ezperks_Close", {
    font = "Exo Bold", 
    size = ScreenScale(11),
    weight = 700,
    antialias = true,
})


local function attemptPurchase(index)
    net.Start("ezperks_handlePurchase")
    net.WriteString(index)
    net.SendToServer()
end

local bg
local cbg

local function confirmUI(k, v, dataTable)
    if IsValid(cbg) then return end

    bg:SetMouseInputEnabled(false)
    bg:SetMouseInputEnabled(false)


    cbg = vgui.Create("DFrame")
    cbg:SetSize(ScrW() * 0.3, ScrH() * 0.25)
    cbg:Center()
    cbg:SetTitle("")
    cbg:MakePopup()
    cbg:ShowCloseButton(false) 
    cbg.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(255, 179, 157))
    end

    local topBar = vgui.Create("DPanel", cbg)
    topBar:SetSize(cbg:GetWide(), cbg:GetTall() * 0.125)
    topBar.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(191, 74, 103))
    end
    
    local titleText = vgui.Create("DLabel", topBar)
    titleText:SetSize(topBar:GetWide(), topBar:GetTall())
    titleText:SetContentAlignment(5)
    titleText:SetFont("ezperks_Title")
    titleText:SetText("Confirmation")

    local info = vgui.Create("DLabel", cbg)
    info:SetSize(topBar:GetWide(), cbg:GetTall() * 0.2)
    info:SetPos(0, cbg:GetTall() * 0.2)
    info:SetTextColor(Color(0, 0, 0))
    info:SetFont("ezperks_Info")
    info:SetText("Are you sure you want to spend $" .. v.upgrades[dataTable[k].data + 1 ].price )
    info:SetContentAlignment(5)

    local yes = vgui.Create("DButton", cbg)
    yes:SetSize(cbg:GetWide() * 0.15, cbg:GetTall() * 0.15)
    yes:SetPos(0, cbg:GetTall() * 0.45)
    yes:SetTextColor(Color(0, 0, 0))
    yes:SetFont("ezperks_Info")
    yes:CenterHorizontal()
    yes:SetText("Yes")
    yes.DoClick = function()
        cbg:Remove()
        bg:Remove()
        net.Start("ezperks_HandlePurchase")
        net.WriteString(k)
        net.SendToServer() 
    end

    yes.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(68, 179, 157))
    end

    local no = vgui.Create("DButton", cbg)
    no:SetSize(cbg:GetWide() * 0.15, cbg:GetTall() * 0.15)
    no:SetPos(0, cbg:GetTall() * 0.625)
    no:CenterHorizontal()
    no:SetTextColor(Color(0, 0, 0))
    no:SetFont("ezperks_Info")
    no:CenterHorizontal()
    no:SetText("No")
    no.DoClick = function()
        cbg:Remove()
        bg:MakePopup()
    end     

    no.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(191, 74, 103))
    end
end

local function ui()
    if IsValid(bg) then return end

    local dataTable = net.ReadTable()

    bg = vgui.Create("DFrame")
    bg:SetSize(ScrW() * 0.35, ScrH() * 0.8)
    bg:Center()
    bg:ShowCloseButton(false)
    bg:SetTitle("")
    bg:MakePopup()

    bg.Paint = function(self, w, h)
        surface.SetDrawColor(Color(59, 60, 61))
        surface.DrawRect(0, 0, w, h * 0.6)

        surface.SetDrawColor(Color(191, 74, 103))
        surface.DrawRect(0, h * 0.6, w, h * 0.4)
    end

    local topBar = vgui.Create("DPanel", bg)
    topBar:SetSize(bg:GetWide(), bg:GetTall() * 0.05)
    topBar.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(191, 74, 103))
    end

    local close = vgui.Create("DButton", bg)
    close:SetSize(bg:GetWide() * 0.1, bg:GetTall() * 0.05)
    close:SetPos(bg:GetWide() * 0.9, 0)
    close:SetTextColor(Color(0, 0, 0))
    close:SetFont("ezperks_Close")
    close:SetText("X")

    close.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(230, 86, 122))
    end

    close.DoClick = function()
        bg:Remove()
    end

    local title = vgui.Create("DLabel", bg)
    title:SetSize(bg:GetWide() * 0.8, bg:GetTall() * 0.05)
    title:CenterHorizontal()
    title:SetContentAlignment(5)
    title:SetFont("ezperks_Title")
    title:SetText("ezPerks Shop")

    local scroll = vgui.Create("DScrollPanel", bg)
    scroll:SetSize(bg:GetWide(), bg:GetTall() * 0.95)
    scroll:SetPos(0, bg:GetTall() * 0.05)

    local sbar = scroll:GetVBar()
    function sbar:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
    end
    function sbar.btnUp:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
    end
    function sbar.btnDown:Paint( w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 200, 100, 0,0 ) )
    end
    function sbar.btnGrip:Paint( w, h )
        draw.RoundedBox(4, w * 0.2, 0, w * 0.6, h, Color(68, 179, 157) )
    end

    local index 
    local yPos = scroll:GetTall() * 0.01

    for k, v in pairs(ezperks_Perks) do
        local perkBox = vgui.Create("DPanel", scroll)
        perkBox:SetSize(scroll:GetWide() * 0.8, scroll:GetTall() * 0.2)
        perkBox:SetPos(scroll:GetWide() * 0.1, yPos) 
        perkBox.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(23, 23, 23, 245))
        end

        local perkTitle = vgui.Create("DLabel", perkBox)
        perkTitle:SetSize(perkBox:GetWide(), perkBox:GetTall() * 0.4)
        perkTitle:SetPos(0, perkBox:GetTall() * 0.1)
        perkTitle:SetFont("ezperks_PerkTitle")
        perkTitle:SetContentAlignment(5)
        perkTitle:SetText(k)
        perkTitle:SizeToContentsY()

        local perkDesc = vgui.Create("DLabel", perkBox)
        perkDesc:SetSize(perkBox:GetWide(), 0)
        perkDesc:SetFont("ezperks_PerkDesc")
        perkDesc:SetContentAlignment(5)
        if dataTable[k].data == dataTable[k].max then
            perkDesc:SetText(v.upgrades[dataTable[k].max].description)
        else
            perkDesc:SetText(v.upgrades[dataTable[k].data + 1].description)
        end
        perkDesc:SizeToContentsY()
        perkDesc:SetPos(0, perkBox:GetTall() * 0.35)

        local perkBar = vgui.Create("DPanel", perkBox)
        perkBar:SetSize(perkBox:GetWide() * 0.6, perkBox:GetTall() * 0.2)
        perkBar:SetPos(0, perkBox:GetTall() * 0.6)
        perkBar:CenterHorizontal()
        perkBar.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255))
            if dataTable[k].data > 0 then
                draw.RoundedBoxEx(4, 0, 0, w / dataTable[k].max * dataTable[k].data, h, Color(68, 179, 157), true, false, true, false)
            end
        end

        local perkUpgrade = vgui.Create("DButton", perkBox)
        perkUpgrade:SetSize(perkBox:GetWide() * 0.05, perkBox:GetTall() * 0.2)
        perkUpgrade:SetPos(perkBox:GetWide() * 0.82, perkBox:GetTall() * 0.6)
        perkUpgrade:SetTextColor(Color(0, 0, 0))
        perkUpgrade:SetFont("ezperks_PerkTitle")
        perkUpgrade:SetText("+")
        perkUpgrade.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(68, 179, 157))
        end

        perkUpgrade.DoClick = function()
            if dataTable[k].data < dataTable[k].max then
                confirmUI(k, v, dataTable)
            end
        end

        local perkBarText = vgui.Create("DLabel", perkBar)
        perkBarText:SetSize(perkBar:GetWide(), perkBar:GetTall())
        perkBarText:SetContentAlignment(5)
        perkBarText:SetTextColor(Color(0, 0, 0))
        perkBarText:SetFont("ezperks_PerkBar")
        perkBarText:SetText(dataTable[k].data .. "/" .. dataTable[k].max)
     
        yPos = yPos + scroll:GetTall() * 0.21
    end
end
net.Receive("ezperks_OpenUI", ui)



