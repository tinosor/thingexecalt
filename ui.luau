--// Cache

local getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, lower, gsub, match = getgenv, getnamecallmethod, hookmetamethod, hookfunction, newcclosure, checkcaller, string.lower, string.gsub, string.match

--// Loaded check

if getgenv().ED_AntiKick then
	return
end

--// Variables

local cloneref = cloneref or function(...) 
	return ...
end

local clonefunction = clonefunction or function(...)
	return ...
end

local Players, LocalPlayer, StarterGui = cloneref(game:GetService("Players")), cloneref(game:GetService("Players").LocalPlayer), cloneref(game:GetService("StarterGui"))

local SetCore = clonefunction(StarterGui.SetCore)
--local GetDebugId = clonefunction(game.GetDebugId)
local FindFirstChild = clonefunction(game.FindFirstChild)

local CompareInstances = (CompareInstances and function(Instance1, Instance2)
		if typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance" then
			return CompareInstances(Instance1, Instance2)
		end
	end)
or
function(Instance1, Instance2)
	return (typeof(Instance1) == "Instance" and typeof(Instance2) == "Instance")-- and GetDebugId(Instance1) == GetDebugId(Instance2)
end

local CanCastToSTDString = function(...)
	return pcall(FindFirstChild, game, ...)
end

--// Global Variables

getgenv().ED_AntiKick = {
	Enabled = true, -- Set to false if you want to disable the Anti-Kick.
	SendNotifications = false, -- Set to true if you want to get notified for every event.
	CheckCaller = true -- Set to true if you want to disable kicking by other user executed scripts.
}

--// Main

local OldNamecall; OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
	local self, message = ...
	local method = getnamecallmethod()
	
	if ((getgenv().ED_AntiKick.CheckCaller and not checkcaller()) or true) and CompareInstances(self, LocalPlayer) and gsub(method, "^%l", string.upper) == "Kick" and ED_AntiKick.Enabled then
		if CanCastToSTDString(message) then
			if getgenv().ED_AntiKick.SendNotifications then
				SetCore(StarterGui, "SendNotification", {
					Title = "Exunys Developer - Anti-Kick",
					Text = "Successfully intercepted an attempted kick.",
					Icon = "rbxassetid://6238540373",
					Duration = 2
				})
			end

			return
		end
	end

	return OldNamecall(...)
end))

local OldFunction; OldFunction = hookfunction(LocalPlayer.Kick, function(...)
	local self, Message = ...

	if ((ED_AntiKick.CheckCaller and not checkcaller()) or true) and CompareInstances(self, LocalPlayer) and ED_AntiKick.Enabled then
		if CanCastToSTDString(Message) then
			if ED_AntiKick.SendNotifications then
				SetCore(StarterGui, "SendNotification", {
					Title = "Exunys Developer - Anti-Kick",
					Text = "Successfully intercepted an attempted kick.",
					Icon = "rbxassetid://6238540373",
					Duration = 2
				})
			end

			return
		end
	end
end)

if getgenv().ED_AntiKick.SendNotifications then
	StarterGui:SetCore("SendNotification", {
		Title = "Exunys Developer - Anti-Kick",
		Text = "Anti-Kick script loaded!",
		Icon = "rbxassetid://6238537240",
		Duration = 3
	})
end

-- ========================================
-- SERVICES & INITIALIZATION
if not game:IsLoaded() then game.Loaded:Wait() end
-- ========================================
local udaxi = udaxi or function(hhexd) return hhexd end
local vxrcs = {
    Players = udaxi(game:GetService("Players")),
    TweenService = udaxi(game:GetService("TweenService")),
    UserInputService = udaxi(game:GetService("UserInputService")),
    RunService = udaxi(game:GetService("RunService")),
    CoreGui = udaxi(game:GetService("CoreGui"))
}

-- ========================================
-- CONFIGURATION
-- ========================================

local nbacg = {
    MaxKeyLength = 44,
    AnimationSpeed = 0.4,
}
local hqtar;

-- ========================================
-- COLOR SCHEME
-- ========================================

local gwuwr = {
    Background = Color3.fromRGB(18, 18, 22),
    Surface = Color3.fromRGB(25, 25, 30),
    Primary = Color3.fromRGB(45, 45, 50),
    Secondary = Color3.fromRGB(35, 35, 40),
    Border = Color3.fromRGB(40, 40, 45),
    TextPrimary = Color3.fromRGB(220, 220, 225),
    TextSecondary = Color3.fromRGB(140, 140, 150),
    Success = Color3.fromRGB(25, 135, 84),
    Error = Color3.fromRGB(180, 50, 50),
    Warning = Color3.fromRGB(200, 120, 30),
    Discord = Color3.fromRGB(60, 70, 180),
    GetKey = Color3.fromRGB(40, 140, 100),
    HoverPrimary = Color3.fromRGB(55, 55, 60),
    HoverGetKey = Color3.fromRGB(30, 120, 80),
    NeonWhite = Color3.fromRGB(255, 255, 255),
}

-- ========================================
-- STATE MANAGEMENT
-- ========================================

local nhosi = {
    IsLoading = false,
    Particles = {},
    Animations = {},
    IsDestroyed = false,
    MousePosition = {X = 0, Y = 0},
    FocusStates = {
        InputFocused = false,
        ButtonHovered = {},
        AnimationsActive = true
    }
}

zayzf = {}

-- ========================================
-- LUARMOR API (forced script id, no GameId logic)
-- ========================================
local wnkie = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
wnkie.script_id = "ee0370f9fe7ec9ecf443edca7b98d745" -- <- always load this

local gykdc = {
    KEY_EXPIRED = "Key Expired! Please renew your key.",
    KEY_BANNED = "Your key has been blacklisted. Contact support for details.",
    KEY_HWID_LOCKED = "Key linked to a different HWID. Please reset it using our bot.",
    KEY_INCORRECT = "Key is incorrect or has been deleted.",
    KEY_INVALID = "The provided key is in an invalid format.",
    SCRIPT_ID_INCORRECT = "The provided script ID does not exist or was deleted.",
    SCRIPT_ID_INVALID = "The script ID is in an invalid format.",
    INVALID_EXECUTOR = "HWID header contains invalid data. Executor might not be supported.",
    SECURITY_ERROR = "Security error detected. Cloudflare validation failed.",
    TIME_ERROR = "Client time is invalid. Ensure your system clock is correct.",
    UNKNOWN_ERROR = "Unknown server error. Please contact support."
}

-- ========================================
-- KEY WRAPPER / SCRUBBER
-- ========================================
local function qpgys(bfngm, func)
    local env = (getgenv and getgenv()) or _G
    local prev = rawget(env, "script_key")
    rawset(env, "script_key", bfngm)
    local ok, err = pcall(func)
    if prev ~= nil then
        rawset(env, "script_key", prev)
    else
        rawset(env, "script_key", nil)
    end
    return ok, err
end

local function dvazk(delFile, fname)
    local env = (getgenv and getgenv()) or _G
    pcall(function()
        rawset(env, "script_key", nil)
        env.script_key = nil
    end)
    if shared then
        pcall(function()
            shared.script_key = nil
            for k, _ in pairs(shared) do
                if type(k) == "string" and k:lower():find("luarmor") then
                    shared[k] = nil
                end
            end
        end)
    end
    if delFile and fname and isfile and delfile then
        pcall(function()
            if isfile(fname) then delfile(fname) end
        end)
    end
end

local function mdllt(izbxo)
	if typeof(izbxo) == "string" and delfile and isfile and isfile(izbxo) then
		pcall(delfile, izbxo)
	end
end

function rdmcr(jutls, gwcbv)
    -- removed GameId mapping; using forced api.script_id set above

    local hyjch = jutls:gsub("%s", "")

    if hyjch ~= jutls then
        dmiou("Spaces detected in the key. Verifying the key without spaces...", false, false)
    end

    local ixrfm = wnkie.check_key(hyjch)

    if ixrfm.code == "KEY_VALID" then
        pcall(function()
            if isfile and readfile and writefile then
                if isfile(gwcbv) then
                    local opvpu = readfile(gwcbv)
                    if opvpu ~= hyjch then
                        if delfile then
                            delfile(gwcbv)
                        end
                        writefile(gwcbv, hyjch)
                    end
                else
                    writefile(gwcbv, hyjch)
                end
            end
        end)

        if ixrfm.data then
            local zbqaz = ixrfm.data.auth_expire
            local mvwus = ixrfm.data.total_executions or 0

            if mvwus > 0 then
                if zbqaz == -1 or zbqaz == 0 then
                    dmiou("🔓 Key Status: Lifetime Access", false, true)
                else
                    local lzvwd = zbqaz - os.time()
                    if lzvwd > 0 then
                        local hednd = string.format(
                            "%02d:%02d:%02d",
                            math.floor(lzvwd / 3600),
                            math.floor((lzvwd % 3600) / 60),
                            lzvwd % 60
                        )
                        dmiou("⏳ Time Left: " .. hednd, false, true)
                    end
                end
            end

            task.wait(1.5)

            dmiou("Total executions: " .. mvwus, false, false)
        end

        -- DO NOT leak globally; return cleaned key
        return true, hyjch
    end
    
    if ixrfm and gykdc[ixrfm.code] then
        mdllt(gwcbv) 
        dmiou(gykdc[ixrfm.code], false, false)
        if table.find({"INVALID_EXECUTOR","SECURITY_ERROR","UNKNOWN_ERROR"}, ixrfm.code) then
            task.wait(1)
            pcall(function()
                vxrcs.Players.LocalPlayer:Kick(gykdc[ixrfm.code])
            end)
        end
        return nil
    end

    dmiou(
        "Key check failed: " ..
        (ixrfm.message or "no message") ..
        " Code: " .. ixrfm.code,
        true,
        false
    )
end


-- ========================================
-- UI CREATION FUNCTIONS
-- ========================================

local function hbzkm()
    local hqtar = Instance.new("ScreenGui")
    hqtar.Name = "KeySystemGUI"
    hqtar.ResetOnSpawn = false
    hqtar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    hqtar.IgnoreGuiInset = true
    hqtar.DisplayOrder = 100
    hqtar.Enabled = false

    if get_hidden_gui or gethui then
        local nnrjy = get_hidden_gui or gethui
        hqtar.Parent = nnrjy()
    elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
        syn.protect_gui(hqtar)
        hqtar.Parent = vxrcs.CoreGui
    elseif vxrcs.CoreGui:FindFirstChild("RobloxGui") then
        hqtar.Parent = vxrcs.CoreGui.RobloxGui
    else
        hqtar.Parent = vxrcs.CoreGui
    end

    pcall(function() if LuarmorGot_System then LuarmorGot_System:Destroy() end end)
    getgenv().LuarmorGot_System = hqtar

    zayzf.ScreenGui = hqtar
    return hqtar
end

local function jgzvw(xlgsi)
    local cgcws = Instance.new("Frame")
    cgcws.Name = "Backdrop"
    cgcws.Size = UDim2.new(1, 0, 1, 0)
    cgcws.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    cgcws.BackgroundTransparency = 0.1
    cgcws.BorderSizePixel = 0
    cgcws.ZIndex = 100
    cgcws.Parent = xlgsi

    zayzf.Backdrop = cgcws
    return cgcws
end

local function nflzo(xmtjl)
    local vktbf = Instance.new("Frame")
    vktbf.Name = "MainContainer"
    vktbf.Size = UDim2.new(0, 420, 0, 450)
    vktbf.Position = UDim2.new(0.5, 0, 0.5, 0)
    vktbf.AnchorPoint = Vector2.new(0.5, 0.5)
    vktbf.BackgroundColor3 = gwuwr.Background
    vktbf.BorderSizePixel = 0
    vktbf.ZIndex = 110
    vktbf.Selectable = false
    vktbf.Parent = xmtjl

    local ogoqx = Instance.new("UICorner")
    ogoqx.CornerRadius = UDim.new(0, 10)
    ogoqx.Parent = vktbf

    local syymp = Instance.new("UIStroke")
    syymp.Color = gwuwr.Border
    syymp.Thickness = 1
    syymp.Transparency = 0.3
    syymp.Parent = vktbf

    local evvyu = Instance.new("UIScale")
    evvyu.Parent = vktbf
    evvyu.Scale = 0.8

    zayzf.Container = vktbf
    return vktbf
end

local function vjdbl(bzsho)
    local csrjd = Instance.new("Frame")
    csrjd.Name = "AnimatedBorder"
    csrjd.Size = UDim2.new(1, 6, 1, 6)
    csrjd.Position = UDim2.new(0, -3, 0, -3)
    csrjd.BackgroundTransparency = 1
    csrjd.ZIndex = 109
    csrjd.Selectable = false
    csrjd.Parent = bzsho

    local cmewl = Instance.new("UICorner")
    cmewl.CornerRadius = UDim.new(0, 23)
    cmewl.Parent = csrjd

    local gkphf = Instance.new("UIStroke")
    gkphf.Color = Color3.fromRGB(171, 0, 255)
    gkphf.Thickness = 2
    gkphf.Transparency = 0.3
    gkphf.Parent = csrjd

    local jhckr = Instance.new("UIGradient")
    jhckr.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 255))
    }
    jhckr.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(0.2, 0.1),
        NumberSequenceKeypoint.new(0.8, 0.1),
        NumberSequenceKeypoint.new(1, 0.9)
    }
    jhckr.Parent = gkphf

    zayzf.AnimatedBorder = {Frame = csrjd, Gradient = jhckr, Stroke = gkphf}
    return csrjd
end

-- ========================================
-- HEADER SECTION
-- ========================================

local function rkxwi(zgoyy)
    local rqvmy = Instance.new("Frame")
    rqvmy.Name = "Header"
    rqvmy.Size = UDim2.new(1, 0, 0, 100)
    rqvmy.BackgroundTransparency = 1
    rqvmy.ZIndex = 11
    rqvmy.Selectable = false
    rqvmy.Parent = zgoyy

    local jvkwg = Instance.new("Frame")
    jvkwg.Size = UDim2.new(0, 56, 0, 56)
    jvkwg.Position = UDim2.new(0.5, -28, 0, 24)
    jvkwg.BackgroundColor3 = gwuwr.Primary
    jvkwg.BorderSizePixel = 0
    jvkwg.ZIndex = 12
    jvkwg.Selectable = false
    jvkwg.Parent = rqvmy

    local wfjlr = Instance.new("UICorner")
    wfjlr.CornerRadius = UDim.new(0, 14)
    wfjlr.Parent = jvkwg

    local cypkt = Instance.new("Frame")
    cypkt.Size = UDim2.new(1, 12, 1, 12)
    cypkt.Position = UDim2.new(0, -6, 0, -6)
    cypkt.BackgroundTransparency = 1
    cypkt.ZIndex = 11
    cypkt.Selectable = false
    cypkt.Parent = jvkwg

    local vmhut = Instance.new("UICorner")
    vmhut.CornerRadius = UDim.new(0, 20)
    vmhut.Parent = cypkt

    local ubttr = Instance.new("UIStroke")
    ubttr.Color = gwuwr.NeonWhite
    ubttr.Thickness = 3
    ubttr.Transparency = 0.2
    ubttr.Parent = cypkt

    local lsidb = Instance.new("UIGradient")
    lsidb.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(114, 137, 218)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(88, 101, 242)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(114, 137, 218))
    }
    lsidb.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.2, 0.05),
        NumberSequenceKeypoint.new(0.8, 0.05),
        NumberSequenceKeypoint.new(1, 0.8)
    }
    lsidb.Parent = ubttr

    local wwqzi = Instance.new("ImageLabel")
    wwqzi.Size = UDim2.new(1, 0, 1, 0)
    wwqzi.Position = UDim2.new(0, 0, 0, 0)
    wwqzi.BackgroundTransparency = 1
    wwqzi.Image = "rbxassetid://83378893125739"
    wwqzi.ImageColor3 = gwuwr.NeonWhite
    wwqzi.ImageTransparency = 0.1
    wwqzi.ScaleType = Enum.ScaleType.Fit
    wwqzi.ZIndex = 13
    wwqzi.Parent = jvkwg

    local tgjxo = Instance.new("UICorner")
    tgjxo.CornerRadius = UDim.new(0, 14)
    tgjxo.Parent = wwqzi

    zayzf.Header = {Container = rqvmy, IconGlow = lsidb, IconStroke = ubttr}
    return rqvmy
end

-- ========================================
-- CONTENT SECTION
-- ========================================

local function irgiy(qsars)
    local xwuor = Instance.new("Frame")
    xwuor.Name = "Content"
    xwuor.Size = UDim2.new(1, -64, 0, 440)
    xwuor.Position = UDim2.new(0, 32, 0, 120)
    xwuor.BackgroundTransparency = 1
    xwuor.ZIndex = 11
    xwuor.Selectable = false
    xwuor.Parent = qsars

    local oduzd = Instance.new("TextLabel")
    oduzd.Size = UDim2.new(1, 0, 0, 32)
    oduzd.BackgroundTransparency = 1
    oduzd.Text = "Xenith Android - KeySys"
    oduzd.TextColor3 = gwuwr.TextPrimary
    oduzd.TextSize = 24
    oduzd.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    oduzd.TextXAlignment = Enum.TextXAlignment.Center
    oduzd.ZIndex = 12
    oduzd.Parent = xwuor

    local mveqo = Instance.new("TextLabel")
    mveqo.Size = UDim2.new(1, 0, 0, 40)
    mveqo.Position = UDim2.new(0, 0, 0, 40)
    mveqo.BackgroundTransparency = 1
    mveqo.Text = "Enter your key to continue"
    mveqo.TextColor3 = gwuwr.TextSecondary
    mveqo.TextSize = 16
    mveqo.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    mveqo.TextXAlignment = Enum.TextXAlignment.Center
    mveqo.TextWrapped = true
    mveqo.ZIndex = 12
    mveqo.Parent = xwuor

    zayzf.Content = xwuor
    return xwuor
end

-- ========================================
-- INPUT SECTION
-- ========================================

local function wwdsk(ajxqg)
    local ybnpz = Instance.new("Frame")
    ybnpz.Size = UDim2.new(1, 0, 0, 100)
    ybnpz.Position = UDim2.new(0, 0, 0, 100)
    ybnpz.BackgroundTransparency = 1
    ybnpz.ZIndex = 12
    ybnpz.Selectable = false
    ybnpz.Parent = ajxqg

    local bsblc = Instance.new("Frame")
    bsblc.Size = UDim2.new(1, 0, 0, 52)
    bsblc.BackgroundColor3 = gwuwr.Surface
    bsblc.BorderSizePixel = 0
    bsblc.ZIndex = 13
    bsblc.Selectable = false
    bsblc.Parent = ybnpz

    local wdnsg = Instance.new("UICorner")
    wdnsg.CornerRadius = UDim.new(0, 12)
    wdnsg.Parent = bsblc

    local kqjxa = Instance.new("UIStroke")
    kqjxa.Color = gwuwr.Border
    kqjxa.Thickness = 1
    kqjxa.Transparency = 0.3
    kqjxa.Parent = bsblc

    local yntii = Instance.new("Frame")
    yntii.Size = UDim2.new(1, 8, 1, 8)
    yntii.Position = UDim2.new(0, -4, 0, -4)
    yntii.BackgroundTransparency = 1
    yntii.ZIndex = bsblc.ZIndex - 1
    yntii.Visible = false
    yntii.Selectable = false
    yntii.Parent = bsblc

    local lbgvc = Instance.new("UICorner")
    lbgvc.CornerRadius = UDim.new(0, 16)
    lbgvc.Parent = yntii

    local budtu = Instance.new("UIStroke")
    budtu.Color = gwuwr.NeonWhite
    budtu.Thickness = 2
    budtu.Transparency = 0.3
    budtu.Parent = yntii

    local xixyy = Instance.new("UIGradient")
    xixyy.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 0, 180))
    }
    xixyy.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.85),
        NumberSequenceKeypoint.new(0.2, 0.2),
        NumberSequenceKeypoint.new(0.8, 0.2),
        NumberSequenceKeypoint.new(1, 0.85)
    }
    xixyy.Parent = budtu

    local hqizp = Instance.new("TextBox")
    hqizp.Size = UDim2.new(1, -24, 1, 0)
    hqizp.Position = UDim2.new(0, 12, 0, 0)
    hqizp.BackgroundTransparency = 1
    hqizp.Text = ""
    hqizp.TextTruncate = Enum.TextTruncate.AtEnd
    hqizp.PlaceholderText = "Enter key here"
    hqizp.TextColor3 = gwuwr.TextPrimary
    hqizp.PlaceholderColor3 = gwuwr.TextSecondary
    hqizp.TextSize = 16
    hqizp.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    hqizp.TextXAlignment = Enum.TextXAlignment.Left
    hqizp.ClearTextOnFocus = false
    hqizp.ZIndex = 14
    hqizp.Selectable = true
    hqizp.Parent = bsblc

    local mrrlt = Instance.new("TextLabel")
    mrrlt.Size = UDim2.new(0, 80, 0, 20)
    mrrlt.Position = UDim2.new(1, -85, 0, 60)
    mrrlt.BackgroundTransparency = 1
    mrrlt.Text = "0/" .. nbacg.MaxKeyLength
    mrrlt.TextColor3 = gwuwr.TextSecondary
    mrrlt.TextSize = 12
    mrrlt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    mrrlt.TextXAlignment = Enum.TextXAlignment.Right
    mrrlt.ZIndex = 13
    mrrlt.Parent = ybnpz

    zayzf.Input = {
        Container = bsblc,
        TextBox = hqizp,
        Counter = mrrlt,
        Stroke = kqjxa,
        Glow = {Frame = yntii, Stroke = budtu, Gradient = xixyy}
    }

    return ybnpz
end

-- ========================================
-- BUTTON SECTION
-- ========================================

local function fjpvu(nrznw)
    local glycu = Instance.new("TextButton")
    glycu.Size = UDim2.new(1, 0, 0, 48)
    glycu.Position = UDim2.new(0, 0, 0, 200)
    glycu.BackgroundColor3 = gwuwr.Primary
    glycu.BorderSizePixel = 0
    glycu.Text = "Verify Access Key"
    glycu.TextColor3 = gwuwr.TextPrimary
    glycu.TextSize = 16
    glycu.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    glycu.AutoButtonColor = false
    glycu.ZIndex = 13
    glycu.Selectable = true
    glycu.Parent = nrznw

    local mtdns = Instance.new("UICorner")
    mtdns.CornerRadius = UDim.new(0, 12)
    mtdns.Parent = glycu

    local zovyt = Instance.new("Frame")
    zovyt.Size = UDim2.new(0, 24, 0, 24)
    zovyt.Position = UDim2.new(0.5, -12, 0, 12)
    zovyt.BackgroundTransparency = 1
    zovyt.Visible = false
    zovyt.ZIndex = 14
    zovyt.Selectable = false
    zovyt.Parent = glycu

    local xekyt = Instance.new("Frame")
    xekyt.Size = UDim2.new(1, 0, 1, 0)
    xekyt.BackgroundColor3 = gwuwr.TextPrimary
    xekyt.BorderSizePixel = 0
    xekyt.ZIndex = 15
    xekyt.Selectable = false
    xekyt.Parent = zovyt

    local bndaq = Instance.new("UICorner")
    bndaq.CornerRadius = UDim.new(1, 0)
    bndaq.Parent = xekyt

    local pihfa = Instance.new("UIGradient")
    pihfa.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0.8),
        NumberSequenceKeypoint.new(1, 1)
    }
    pihfa.Parent = xekyt

    local tfdkm = Instance.new("Frame")
    tfdkm.Size = UDim2.new(1, 0, 0, 48)
    tfdkm.Position = UDim2.new(0, 0, 0, 260)
    tfdkm.BackgroundTransparency = 1
    tfdkm.ZIndex = 12
    tfdkm.Selectable = false
    tfdkm.Parent = nrznw

    local pbvwt = Instance.new("TextButton")
    pbvwt.Size = UDim2.new(1, 0, 0, 48)
    pbvwt.BackgroundColor3 = gwuwr.GetKey
    pbvwt.BorderSizePixel = 0
    pbvwt.Text = "Get Key"
    pbvwt.TextColor3 = gwuwr.TextPrimary
    pbvwt.TextSize = 14
    pbvwt.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    pbvwt.AutoButtonColor = false
    pbvwt.ZIndex = 13
    pbvwt.Selectable = true
    pbvwt.Parent = tfdkm

    local vgvgy = Instance.new("UICorner")
    vgvgy.CornerRadius = UDim.new(0, 10)
    vgvgy.Parent = pbvwt

    zayzf.Buttons = {
        Submit = glycu,
        GetKey = pbvwt,
        Loading = {Container = zovyt, Spinner = xekyt}
    }

    return {glycu, pbvwt}
end

-- ========================================
-- STATUS SECTION
-- ========================================

local function yevwp(qhsrn)
    local xffof = Instance.new("Frame")
    xffof.Size = UDim2.new(1, 0, 0, 60)
    xffof.Position = UDim2.new(0, 0, 0, 330)
    xffof.BackgroundTransparency = 1
    xffof.ZIndex = 12
    xffof.Selectable = false
    xffof.Parent = qhsrn

    local psnpn = Instance.new("TextLabel")
    psnpn.Size = UDim2.new(1, 0, 1, 0)
    psnpn.BackgroundTransparency = 1
    psnpn.Text = ""
    psnpn.TextColor3 = gwuwr.Error
    psnpn.TextSize = 14
    psnpn.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    psnpn.TextXAlignment = Enum.TextXAlignment.Center
    psnpn.TextWrapped = true
    psnpn.ZIndex = 13
    psnpn.Parent = xffof

    zayzf.Status = psnpn
    return psnpn
end

-- ========================================
-- VISUAL EFFECTS
-- ========================================

local function pfdin(haren, dmtet, ebtfl)
    local rstww = Instance.new("Frame")
    rstww.Size = UDim2.new(1, 8, 1, 8)
    rstww.Position = UDim2.new(0, -4, 0, -4)
    rstww.BackgroundTransparency = 1
    rstww.ZIndex = haren.ZIndex - 1
    rstww.Visible = false
    rstww.Selectable = false
    rstww.Parent = haren

    local pkbdk = Instance.new("UICorner")
    pkbdk.CornerRadius = UDim.new(0, 14)
    pkbdk.Parent = rstww

    local ztnev = Instance.new("UIStroke")
    ztnev.Color = gwuwr.NeonWhite
    ztnev.Thickness = 2
    ztnev.Transparency = 0.3
    ztnev.Parent = rstww

    local tfttb = Instance.new("UIGradient")
    tfttb.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 220)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 0, 180))
    }
    tfttb.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.85),
        NumberSequenceKeypoint.new(0.2, 0.2),
        NumberSequenceKeypoint.new(0.8, 0.2),
        NumberSequenceKeypoint.new(1, 0.85)
    }
    tfttb.Parent = ztnev

    local jlnfi = nil
    local gfskr = tostring(haren)

    haren.MouseEnter:Connect(function()
        nhosi.FocusStates.ButtonHovered[gfskr] = true
        rstww.Visible = true

        vxrcs.TweenService:Create(haren, TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = dmtet}):Play()

        vxrcs.TweenService:Create(ztnev, TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Transparency = 0.1}):Play()

        if jlnfi then jlnfi:Cancel() end
        jlnfi = vxrcs.TweenService:Create(tfttb,
            TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            {Rotation = 360})
        jlnfi:Play()
    end)

    haren.MouseLeave:Connect(function()
        nhosi.FocusStates.ButtonHovered[gfskr] = false

        vxrcs.TweenService:Create(haren, TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {BackgroundColor3 = ebtfl}):Play()

        vxrcs.TweenService:Create(ztnev, TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {Transparency = 0.8}):Play()

        if jlnfi then
            jlnfi:Cancel()
            tfttb.Rotation = 0
        end

        task.spawn(function()
            task.wait(0.3)
            if rstww and rstww.Parent then
                rstww.Visible = false
            end
        end)
    end)

    return {rstww, ztnev, tfttb}
end

-- ========================================
-- STATUS & FEEDBACK FUNCTIONS
-- ========================================
local fctcv = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua", true))()

local function hmdsh(xbyib, prcpq)
    if fctcv then
        pcall(fctcv.SendNotification, fctcv, xbyib, prcpq, 3)
    else
        warn("Notification: "..xbyib.." - "..prcpq)
    end
end


function dmiou(smhpi, afkmo, xsydq)
    if not zayzf.Status then return end

    zayzf.Status.Text = smhpi
    if not hqtar.Enabled then
        local zhnzf;
        if xsydq then
            zhnzf = "Success"
        elseif afkmo then
            zhnzf = "Error"
        else
            zhnzf = "Warning"
        end

        hmdsh(zhnzf, smhpi)
    else
        if xsydq then
            zayzf.Status.TextColor3 = gwuwr.Success
        elseif afkmo then
            zayzf.Status.TextColor3 = gwuwr.Error
        else
            zayzf.Status.TextColor3 = gwuwr.Warning
        end

        zayzf.Status.TextTransparency = 1
        vxrcs.TweenService:Create(zayzf.Status, TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {TextTransparency = 0}):Play()
    end
end

local function sdcrg()
    if zayzf.Status then
        vxrcs.TweenService:Create(zayzf.Status, TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {TextTransparency = 1}):Play()
    end
end

function qielc(szuzj)
    nhosi.IsLoading = szuzj
    if not zayzf.Buttons then return end

    zayzf.Buttons.Loading.Container.Visible = szuzj
    zayzf.Buttons.Submit.Text = szuzj and "" or "Verify Access Key"

    if szuzj then
        local ypblm = vxrcs.TweenService:Create(zayzf.Buttons.Loading.Spinner,
            TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            {Rotation = 360})
        ypblm:Play()
        nhosi.Animations.SpinTween = ypblm
    else
        if nhosi.Animations.SpinTween then
            nhosi.Animations.SpinTween:Cancel()
            zayzf.Buttons.Loading.Spinner.Rotation = 0
        end
    end
end

-- ========================================
-- INPUT HANDLING
-- ========================================

local function srlwu()
    if not zayzf.Input then return end

    local askgm = string.len(zayzf.Input.TextBox.Text)
    zayzf.Input.Counter.Text = askgm .. "/" .. nbacg.MaxKeyLength

    if askgm >= nbacg.MaxKeyLength then
        zayzf.Input.Counter.TextColor3 = gwuwr.Error
    elseif askgm >= nbacg.MaxKeyLength * 0.8 then
        zayzf.Input.Counter.TextColor3 = gwuwr.Warning
    else
        zayzf.Input.Counter.TextColor3 = gwuwr.TextSecondary
    end
end

local function ddxre(ijtgw, kgvui)
    local qpibc = pcall(function()
        if setclipboard then
            setclipboard(ijtgw)
            dmiou(kgvui, false, true)
        else
            dmiou("Link: " .. ijtgw, false, true)
        end
    end)

    if not qpibc then
        dmiou("Link: " .. ijtgw, false, true)
    end
end

-- ========================================
-- EVENT CONNECTIONS
-- ========================================

local function uniba()
    vxrcs.UserInputService.InputChanged:Connect(function(kyeui, fxorw)
        if kyeui.UserInputType == Enum.UserInputType.MouseMovement then
            nhosi.MousePosition.X = kyeui.Position.X
            nhosi.MousePosition.Y = kyeui.Position.Y
        end
    end)

    zayzf.Input.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        local nradc = zayzf.Input.TextBox.Text

        if string.len(nradc) > nbacg.MaxKeyLength then
            zayzf.Input.TextBox.Text = string.sub(nradc, 1, nbacg.MaxKeyLength)
            dmiou("Maximum character limit reached (" .. nbacg.MaxKeyLength .. ")", true)
        end

        srlwu()
        sdcrg()
    end)

    local werbl = nil

    zayzf.Input.TextBox.Focused:Connect(function()
        nhosi.FocusStates.InputFocused = true
        zayzf.Input.Glow.Frame.Visible = true

        vxrcs.TweenService:Create(zayzf.Input.Stroke,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Color = gwuwr.NeonWhite, Transparency = 0.1}):Play()

        vxrcs.TweenService:Create(zayzf.Input.Glow.Stroke,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Transparency = 0.1}):Play()

        if werbl then werbl:Cancel() end
        werbl = vxrcs.TweenService:Create(zayzf.Input.Glow.Gradient,
            TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            {Rotation = 360})
        werbl:Play()
        nhosi.Animations.InputGlowTween = werbl
        sdcrg()
    end)

    zayzf.Input.TextBox.FocusLost:Connect(function()
        nhosi.FocusStates.InputFocused = false

        vxrcs.TweenService:Create(zayzf.Input.Stroke,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
            {Color = gwuwr.Border, Transparency = 0.3}):Play()

        vxrcs.TweenService:Create(zayzf.Input.Glow.Stroke,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad),
            {Transparency = 0.8}):Play()

        if werbl then
            werbl:Cancel()
            zayzf.Input.Glow.Gradient.Rotation = 0
            nhosi.Animations.InputGlowTween = nil
        end

        task.spawn(function()
            task.wait(0.3)
            if zayzf.Input.Glow.Frame and zayzf.Input.Glow.Frame.Parent then
                zayzf.Input.Glow.Frame.Visible = false
            end
        end)
    end)

    zayzf.Buttons.Submit.MouseButton1Click:Connect(function()
        if nhosi.IsLoading then return end

        local jutls = zayzf.Input.TextBox.Text
        if jutls == "" then
            zayzf.Input.TextBox:CaptureFocus()
            return
        end

        qielc(true)
        dmiou("Validating key...", false, false)

        task.wait(2)

        local ok, clean = rdmcr(jutls, "XenithAndroidKey.txt")
        if not ok then
            task.wait(2)
            qielc(false)
            sdcrg()
            return
        end

        task.spawn(function()
            task.wait(2)
            qielc(false)
            dmiou("Key validated successfully!", false, true)
            task.wait(2)
            sdcrg()
            
            -- Load with just-in-time key; then scrub
            qpgys(clean, function()
                wnkie.load_script()
                _G.script_key = nil 
                getgenv().script_key = nil
                print("Cleared")
            end)
            dvazk(false, "XenithAndroidKey.txt")
            pcall(function() if LuarmorGot_System then LuarmorGot_System:Destroy() end end)
        end)
    end)

    zayzf.Buttons.GetKey.MouseButton1Click:Connect(function()
        dmiou("Opening key website...", false, false)
        ddxre("https://ads.luarmor.net/get_key?for=Xenith__Android_Executor-QaQUuCIVwJTL", "Key website link copied to clipboard!")
        task.wait(2.5)
        sdcrg()
    end)
end

-- ========================================
-- ANIMATION LOOPS
-- ========================================
local function srene()
    nhosi.Animations.BorderTween = nil
    nhosi.Animations.IconTween = nil
    nhosi.FocusStates.AnimationsActive = true

    task.spawn(function()
        while not nhosi.IsDestroyed and zayzf.AnimatedBorder and zayzf.AnimatedBorder.Frame.Parent do
            if nhosi.Animations.BorderTween then
                nhosi.Animations.BorderTween:Cancel()
            end

            local bjlzb = zayzf.AnimatedBorder.Gradient.Rotation
            local ypblm = vxrcs.TweenService:Create(zayzf.AnimatedBorder.Gradient,
                TweenInfo.new(4, Enum.EasingStyle.Linear),
                {Rotation = bjlzb + 360})

            nhosi.Animations.BorderTween = ypblm
            ypblm:Play()

            local qpibc = pcall(function()
                ypblm.Completed:Wait()
            end)

            if not qpibc then
                task.wait(4)
            end

            if zayzf.AnimatedBorder and zayzf.AnimatedBorder.Gradient and zayzf.AnimatedBorder.Gradient.Parent then
                zayzf.AnimatedBorder.Gradient.Rotation = zayzf.AnimatedBorder.Gradient.Rotation % 360
            end

            task.wait(0.1)
        end
    end)

    task.spawn(function()
        while not nhosi.IsDestroyed and zayzf.Header and zayzf.Header.IconGlow and zayzf.Header.IconGlow.Parent do
            if nhosi.Animations.IconTween then
                nhosi.Animations.IconTween:Cancel()
            end

            local bjlzb = zayzf.Header.IconGlow.Rotation
            nhosi.Animations.IconTween = vxrcs.TweenService:Create(zayzf.Header.IconGlow,
                TweenInfo.new(3, Enum.EasingStyle.Linear),
                {Rotation = bjlzb + 360})

            nhosi.Animations.IconTween:Play()

            local qpibc = pcall(function()
                nhosi.Animations.IconTween.Completed:Wait()
            end)

            if not qpibc then
                task.wait(3)
            end

            if zayzf.Header and zayzf.Header.IconGlow and zayzf.Header.IconGlow.Parent then
                zayzf.Header.IconGlow.Rotation = zayzf.Header.IconGlow.Rotation % 360
            end

            task.wait(0.1)
        end
    end)
end

-- ========================================
-- ENTRANCE ANIMATION
-- ========================================

local function lgvhv()
    zayzf.Container.Size = UDim2.new(0, 0, 0, 0)
    zayzf.Container.BackgroundTransparency = 1
    zayzf.Backdrop.BackgroundTransparency = 1

    vxrcs.TweenService:Create(zayzf.Backdrop,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad),
        {BackgroundTransparency = 1}):Play()

    task.wait(0.1)

    vxrcs.TweenService:Create(zayzf.Container,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 420, 0, 450), BackgroundTransparency = 0}):Play()

    task.wait(0.5)
end

-- ========================================
-- MAIN INITIALIZATION
-- ========================================

local function dlyrn()
    hqtar = hbzkm()
    local qzbjr = jgzvw(hqtar)
    local wrcly = nflzo(hqtar)
    vjdbl(wrcly)
    rkxwi(wrcly)
    local ijxwl = irgiy(wrcly)
    wwdsk(ijxwl)
    fjpvu(ijxwl)
    yevwp(ijxwl)

    pfdin(zayzf.Buttons.Submit, gwuwr.HoverPrimary, gwuwr.Primary)
    pfdin(zayzf.Buttons.GetKey, gwuwr.HoverGetKey, gwuwr.GetKey)

    srlwu()
    uniba()
    srene()
    lgvhv()
end

-- ========================================
-- START THE GUI
-- ========================================
dlyrn()

task.spawn(function()
    local ok, clean = false, nil
    local pre = script_key  -- if some executor pre-injects it, we support it JIT

    if pre and pre ~= "" then
        dmiou("Found key in script_key variable. Waiting for key system to fully load...", false, false)
        task.wait(0.5)
        ok, clean = rdmcr(pre, "XenithAndroidKey.txt")
    else
        local qpibc, zzfna = pcall(function()
            return readfile and isfile and isfile("XenithAndroidKey.txt") and readfile("XenithAndroidKey.txt")
        end)

        if qpibc and zzfna and zzfna ~= "" then
            dmiou("Found saved key. Waiting for key system to fully load...", false, false)
            task.wait(0.5)
            ok, clean = rdmcr(zzfna, "XenithAndroidKey.txt")
        end
    end

    if not ok and hqtar then
        hqtar.Enabled = true
        task.wait(1.5) 
        sdcrg()
        return
    else
        qpgys(clean, function()
            wnkie.load_script()
            _G.script_key = nil 
            getgenv().script_key = nil
            print("Cleared")
        end)
        dvazk(false, "XenithAndroidKey.txt")
    end

    local env = (getgenv and getgenv()) or _G

    pcall(function()
        -- wipe globals
        _G.script_key = nil 
        getgenv().script_key = nil

        print("Wiped globals")
        if shared then shared.script_key = nil end

        -- nuke the GUI if it exists
        if LuarmorGot_System and LuarmorGot_System.Destroy then
            LuarmorGot_System:Destroy()
        end
    end)
end)
