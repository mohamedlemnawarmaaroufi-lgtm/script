
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- دالة التحريك السلس (Tween)
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- ==================== GHOST PROTOCOL - ULTIMATE STEALTH ====================
local Ghost = {Active = true, GhostMode = false}
local function GR(len) local c = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"; local s = ""; for i = 1, len do s = s .. c:sub(math.random(1, #c), math.random(1, #c)) end; return s end
function Ghost:DeepObfuscate(gui) pcall(function() gui.Name = "RobloxGui"; for _, obj in ipairs(gui:GetDescendants()) do pcall(function() if obj:IsA("Frame") then obj.Name = GR(math.random(8, 16)) end; if obj:IsA("TextLabel") then obj.Name = GR(math.random(6, 14)) end; if obj:IsA("TextButton") then obj.Name = GR(math.random(7, 15)) end; if obj:IsA("ScrollingFrame") then obj.Name = GR(math.random(5, 12)) end; if obj:IsA("ImageLabel") then obj.Name = GR(math.random(6, 13)) end; if obj:IsA("TextBox") then obj.Name = GR(math.random(5, 10)) end end) end end) end
function Ghost:CoreGuiMask(gui) pcall(function() gui.Parent = CoreGui; if CoreGui:FindFirstChild("RobloxGui") then local r = CoreGui.RobloxGui; local f = Instance.new("Frame", r); f.Size = UDim2.new(0, 0, 0, 0); f.Name = GR(10); f.Visible = false end end) end
function Ghost:KillTimeBombScanners() coroutine.wrap(function() while self.Active do pcall(function() for _, v in ipairs(game:GetDescendants()) do if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then local src = pcall(function() return v.Source end) and v.Source or ""; local ls = src:lower(); if ls:match("timebomb") or ls:match("anticheat") or ls:match("detection") or ls:match("scanner") or ls:match("exploit") or ls:match("hack") or ls:match("cheat") or ls:match("kick") or ls:match("ban") then v.Enabled = false; v.Disabled = true; pcall(function() v:Destroy() end) end end; if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then local n = v.Name:lower(); if n:match("detect") or n:match("ban") or n:match("kick") or n:match("scan") then pcall(function() v:Destroy() end) end end end; for _, v in ipairs(Workspace:GetDescendants()) do if v:IsA("Script") or v:IsA("LocalScript") then local src = pcall(function() return v.Source end) and v.Source or ""; if src:lower():match("bomb") or src:lower():match("detect") then v.Enabled = false end end end end); task.wait(math.random(3, 7)) end end)() end
function Ghost:NetworkMask() coroutine.wrap(function() while self.Active do pcall(function() local f = Instance.new("RemoteEvent"); f.Name = GR(12); task.wait(0.1); f:Destroy() end); task.wait(math.random(5, 12)) end end)() end
function Ghost:AntiKickShield() LocalPlayer.OnKicked:Connect(function(msg) pcall(function() task.wait(0.5); game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end) end) end
function Ghost:PlayerGuiShield() coroutine.wrap(function() while self.Active do pcall(function() local pg = LocalPlayer:FindFirstChild("PlayerGui"); if pg then for _, v in ipairs(pg:GetChildren()) do if v:IsA("ScreenGui") and v.Name ~= "RobloxGui" then pcall(function() v.Enabled = true end) end end end end); task.wait(math.random(2, 5)) end end)() end
function Ghost:AntiTeleportDetect() coroutine.wrap(function() while self.Active do pcall(function() if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then local h = LocalPlayer.Character.Humanoid; if h.WalkSpeed > 16 and h.WalkSpeed < 30 then end end end); task.wait(math.random(10, 20)) end end)() end

-- ==================== WHITELIST ====================
function checkWhitelist()
    local whitelist = {"M3YA9_01","versionya","31_adem3mkk","31_adem3mkk5","AaayamYou_5637","31_adem3mkk8","31_adem3mkk0","RRJR4DR4DREU","Michaeltuuholoaki","31_adem3mkkZ","Stormnex20","uycm8","alsqaadm69","Hdhygdjf","3mkra101","A_4044456","marroum90","fatmah27816","zxczxc11122211","1043d7","klyhd7","be_humble62"}
    for _,n in pairs(whitelist) do if LocalPlayer.Name:lower()==n:lower() then return true end end
    return false
end
if not checkWhitelist() then LocalPlayer:Kick("غير مصرح لك!") return end

-- ==================== SYSTEM ====================
local autoMode = "Classic"
local isTracking = false
local targetNumber = 5
local KEEP_DISTANCE = 3.5
local wallDistance = 2.5
local wallHopEnabled = true
local debounceJump = true
local flickEnabled = false
local flickPower = 45
local flickDir = 1
local isFlicking = false
local flickPulseActive = true
local stretchEnabled = false
local stretchConn
local fpsEnabled = false
local escapeMode = false
local escConn
local escapeStep = 0
local hadTool = false
local lastAvatarUser = nil
local cam = Workspace.CurrentCamera

local function hasTool(plr)local c=plr and plr.Character;if not c then return false end;for _,v in ipairs(c:GetChildren())do if v:IsA("Tool")then return true end end;return false end
local function getClosest()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then return nil,999 end
    local mp=LocalPlayer.Character.HumanoidRootPart.Position;local cp,cd=nil,999
    for _,p in ipairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then local d=(p.Character.HumanoidRootPart.Position-mp).Magnitude;if d<cd then cd=d;cp=p end end end
    return cp,cd
end
local function getNum(plr)
    if not plr or not plr.Character then return nil end
    for _,t in pairs(plr.Character:GetChildren())do if t:IsA("Tool")then for _,ch in pairs(t:GetDescendants())do if ch:IsA("BillboardGui")then for _,gc in pairs(ch:GetDescendants())do if gc:IsA("TextLabel")and gc.Text~=""then local n=tonumber(gc.Text);if n then return n end end end end;if ch:IsA("Highlight")then local n=tonumber(ch.Name);if n then return n end end end;local n=tonumber(t.Name);if n then return n end end end
    return nil
end

local function startAuto()
    isTracking = true
    local conn = RunService.Heartbeat:Connect(function()
        if not isTracking then conn:Disconnect() return end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid")then return end
        local h = LocalPlayer.Character.Humanoid;local t,d = getClosest()
        if not t or not t.Character or not t.Character:FindFirstChild("HumanoidRootPart")then return end
        local mn = getNum(LocalPlayer);local tn = getNum(t);local chase = false
        if autoMode=="Classic"then if hasTool(LocalPlayer)or hasTool(t)then if mn and mn<=targetNumber then chase=true end;if tn and tn<=targetNumber then chase=true end;if not hasTool(LocalPlayer)and hasTool(t)then chase=true end end
        elseif autoMode=="Pro"then if hasTool(LocalPlayer)and mn and mn<=targetNumber then chase=true end end
        if chase then h.WalkSpeed = 21
            if d<=KEEP_DISTANCE then local dir=(LocalPlayer.Character.HumanoidRootPart.Position-t.Character.HumanoidRootPart.Position).Unit;h:MoveTo(t.Character.HumanoidRootPart.Position+dir*KEEP_DISTANCE)
            else h:MoveTo(t.Character.HumanoidRootPart.Position)end end
    end)
end
local function stopAuto()
    isTracking = false; escapeMode = false
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("M3YA9_01")then LocalPlayer.Character.Humanoid.WalkSpeed=16 end
end

local function doStrongFlick()
    if isFlicking then return end
    isFlicking = true
    local strongAngle = math.rad(flickPower)
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then isFlicking = false; return end
    if not hasTool(LocalPlayer) then isFlicking = false; return end
    local baseY = math.atan2(root.CFrame.LookVector.X,root.CFrame.LookVector.Z)
    local baseCamCF = cam.CFrame
    root.CFrame = CFrame.new(root.Position)*CFrame.fromEulerAnglesYXZ(0,baseY-strongAngle,0)
    cam.CFrame = baseCamCF * CFrame.Angles(0, -strongAngle, 0)
    task.wait(0.008)
    root.CFrame = CFrame.new(root.Position)*CFrame.fromEulerAnglesYXZ(0,baseY+strongAngle,0)
    cam.CFrame = baseCamCF * CFrame.Angles(0, strongAngle, 0)
    task.wait(0.008)
    root.CFrame = CFrame.new(root.Position)*CFrame.fromEulerAnglesYXZ(0,baseY,0)
    cam.CFrame = baseCamCF
    task.wait(0.008)
    flickDir = flickDir * -1
    task.wait(0.2)
    isFlicking = false
end

RunService.Heartbeat:Connect(function()
    if not flickEnabled then return end
    if not flickPulseActive then return end
    if not hasTool(LocalPlayer) then return end
    local _, d = getClosest()
    if d > KEEP_DISTANCE then return end
    if isFlicking then return end
    task.spawn(doStrongFlick)
end)

task.spawn(function()
    while true do
        if flickEnabled then flickPulseActive = true; task.wait(1); flickPulseActive = false; task.wait(1)
        else task.wait(0.5) end
    end
end)

coroutine.wrap(function()
    while true do
        if isTracking and escapeMode then
            local htn = hasTool(LocalPlayer)
            if not hadTool and htn and not escConn then
                escapeStep = 1
                escConn = RunService.Heartbeat:Connect(function()
                    if escapeStep == 1 then
                        local c = LocalPlayer.Character
                        if not c then return end
                        local r = c:FindFirstChild("HumanoidRootPart")
                        local h = c:FindFirstChildOfClass("M3YA9_01")
                        if not r or not h then return end
                        local t, d = getClosest()
                        if t then h.WalkSpeed = 30; local dir = (r.Position - t.Character.HumanoidRootPart.Position).Unit; h:MoveTo(r.Position + dir * 10) end
                        task.wait(0.5); escapeStep = 2
                    elseif escapeStep == 2 then
                        local c = LocalPlayer.Character
                        if not c then return end
                        local r = c:FindFirstChild("HumanoidRootPart")
                        local h = c:FindFirstChildOfClass("M3YA9_01")
                        if not r or not h then return end
                        local t, d = getClosest()
                        if t then h.WalkSpeed = 21; h:MoveTo(t.Character.HumanoidRootPart.Position) end
                    end
                end)
            end
            if hadTool and not htn then escapeStep = 2 end
            hadTool = htn
        else hadTool = false; escapeStep = 0; if escConn then escConn:Disconnect(); escConn = nil end end
        task.wait(0.2)
    end
end)()

local function updateStretch()
    if stretchConn then stretchConn:Disconnect();stretchConn=nil end
    if not stretchEnabled then return end
    stretchConn = RunService.RenderStepped:Connect(function()cam.CFrame=cam.CFrame*CFrame.new(0,0,0,1,0,0,0,0.75,0,0,0,1)end)
end
local function applyFPS()
    if not fpsEnabled then return end
    Lighting.Ambient=Color3.fromRGB(255,255,255);Lighting.OutdoorAmbient=Color3.fromRGB(255,255,255);Lighting.GlobalShadows=false
    pcall(function()settings().Rendering.QualityLevel=Enum.QualityLevel.Level01 end)
    local function h(o)if o:IsA("BasePart")then o.Material=Enum.Material.SmoothPlastic;o.Reflectance=0 end end
    Workspace.DescendantAdded:Connect(h);for _,v in pairs(Workspace:GetDescendants())do h(v)end
end

local rP = RaycastParams.new();rP.FilterType=Enum.RaycastFilterType.Blacklist
local function getWall()
    local c=LocalPlayer.Character;if not c then return nil end;local r=c:FindFirstChild("HumanoidRootPart");if not r then return nil end
    rP.FilterDescendantsInstances={c};local dirs={r.CFrame.LookVector,-r.CFrame.LookVector,r.CFrame.RightVector,-r.CFrame.RightVector}
    local h,md=nil,wallDistance+1;for _,d in pairs(dirs)do local ry=Workspace:Raycast(r.Position,d*wallDistance,rP)
    if ry and ry.Instance and ry.Distance<md then md=ry.Distance;h=ry end end;return h end
UserInputService.JumpRequest:Connect(function()
    if not wallHopEnabled or not debounceJump then return end
    local c=LocalPlayer.Character;local h=c and c:FindFirstChildOfClass("Humanoid");local r=c and c:FindFirstChild("HumanoidRootPart")
    if not(h and r)then return end;local w=getWall()
    if w then debounceJump=false;local wn=w.Normal;local hwn=Vector3.new(wn.X,0,wn.Z).Unit
    if hwn.Magnitude<0.1 then hwn=(r.CFrame.LookVector*Vector3.new(1,0,1)).Unit end
    local b=hwn;local cl=Workspace.CurrentCamera.CFrame.LookVector;local hcl=Vector3.new(cl.X,0,cl.Z).Unit
    local ma=math.rad(40);local dt=math.clamp(b:Dot(hcl),-1,1);local ab=math.acos(dt);local cr=b:Cross(hcl);local rs=math.sign(cr.Y)
    if rs==0 then ab=0 end;local aa=math.min(ab,ma);local ar=CFrame.Angles(0,aa*rs,0);local it=ar*b
    r.CFrame=CFrame.lookAt(r.Position,r.Position+it);RunService.Heartbeat:Wait()
    h:ChangeState(Enum.HumanoidStateType.Jumping);h.JumpPower=100
    r.CFrame=CFrame.lookAt(r.Position,r.Position-b);task.wait(0.15);debounceJump=true end
end)

local function applyAvatar(u)
    task.spawn(function()
        local c=LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();local h=c:WaitForChild("Humanoid",10)
        if not h then return end;local tp=nil
        for _,p in ipairs(Players:GetPlayers())do if p.Name:lower()==u:lower()then tp=p;break end end
        local desc;if tp and tp.Character then local th=tp.Character:FindFirstChildOfClass("Humanoid");if th then desc=th:GetAppliedDescription()end end
        if not desc then local ok,id=pcall(Players.GetUserIdFromNameAsync,Players,u)
        if not ok then return end;local ok2,d=pcall(Players.GetHumanoidDescriptionFromUserId,Players,id)
        if not ok2 then return end;desc=d end
        for _,ch in ipairs(c:GetChildren())do if ch:IsA("Accessory")or ch:IsA("Hat")or ch:IsA("BodyColors")or ch:IsA("CharacterMesh")or ch:IsA("Shirt")or ch:IsA("Pants")or ch:IsA("ShirtGraphic")then ch:Destroy()end end
        pcall(function()h:ApplyDescription(desc)end)
    end)
end
LocalPlayer.CharacterAdded:Connect(function(char) if lastAvatarUser then char:WaitForChild("Humanoid",10); task.wait(0.65); applyAvatar(lastAvatarUser) end end)

-- ==================== INTRO - شاشة كاملة ====================
local introGui = Instance.new("ScreenGui",CoreGui)
introGui.Name = "HM_Intro"
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.DisplayOrder = 999999

local function tw(obj,props,t,style,dir)
    local tween = TweenService:Create(obj,TweenInfo.new(t or 0.5,style or Enum.EasingStyle.Quart,dir or Enum.EasingDirection.Out),props)
    tween:Play();return tween
end

local Bg = Instance.new("Frame",introGui)
Bg.Size = UDim2.new(1,0,1,0);Bg.Position = UDim2.new(0,0,0,0)
Bg.BackgroundColor3 = Color3.fromRGB(0,0,0);Bg.BackgroundTransparency = 0
Bg.BorderSizePixel = 0;Bg.ZIndex = 1;Bg.ClipsDescendants = true

local corners = {{0,4,0,4,false,false},{1,-44,0,4,true,false},{0,4,1,-6,false,true},{1,-44,1,-6,true,true}}
for _,c in ipairs(corners)do
    local h = Instance.new("Frame",Bg);h.Size=UDim2.new(0,40,0,2);h.Position=UDim2.new(c[1],c[2],c[3],c[4])
    h.BackgroundColor3=Color3.fromRGB(170,0,0);h.BackgroundTransparency=0.25;h.BorderSizePixel=0;h.ZIndex=2
    local v = Instance.new("Frame",Bg);v.Size=UDim2.new(0,2,0,40);v.Position=UDim2.new(c[1],c[2],c[3],c[4]+(c[6]and-38 or 2))
    v.BackgroundColor3=Color3.fromRGB(170,0,0);v.BackgroundTransparency=0.25;v.BorderSizePixel=0;v.ZIndex=2
end

local function thinLine(yScale,yOffset)
    local l=Instance.new("Frame",Bg);l.Size=UDim2.new(1,0,0,1);l.Position=UDim2.new(0,0,yScale,yOffset)
    l.BackgroundColor3=Color3.fromRGB(120,0,0);l.BackgroundTransparency=0.55;l.BorderSizePixel=0;l.ZIndex=2
end
thinLine(0,28);thinLine(1,-29)

local dotPositions={{0.12,0.18},{0.88,0.22},{0.08,0.72},{0.92,0.68},{0.25,0.90},{0.75,0.88},{0.18,0.45},{0.82,0.55},{0.40,0.08},{0.60,0.92}}
for _,d in ipairs(dotPositions)do
    local dot=Instance.new("Frame",Bg);dot.Size=UDim2.new(0,3,0,3);dot.Position=UDim2.new(d[1],-1,d[2],-1)
    dot.BackgroundColor3=Color3.fromRGB(160,0,0);dot.BackgroundTransparency=0.5;dot.BorderSizePixel=0;dot.ZIndex=2
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
end

for i=1,3 do
    local vl=Instance.new("Frame",Bg);vl.Size=UDim2.new(0,1,1,0);vl.Position=UDim2.new(i*0.25,0,0,0)
    vl.BackgroundColor3=Color3.fromRGB(40,0,0);vl.BackgroundTransparency=0.7;vl.BorderSizePixel=0;vl.ZIndex=1
    local hl=Instance.new("Frame",Bg);hl.Size=UDim2.new(1,0,0,1);hl.Position=UDim2.new(0,0,i*0.25,0)
    hl.BackgroundColor3=Color3.fromRGB(40,0,0);hl.BackgroundTransparency=0.7;hl.BorderSizePixel=0;hl.ZIndex=1
end

local RedGlow=Instance.new("ImageLabel",Bg);RedGlow.Size=UDim2.new(0,600,0,600);RedGlow.Position=UDim2.new(0.5,-300,0.5,-300)
RedGlow.BackgroundTransparency=1;RedGlow.Image="rbxasset://textures/ui/Scroll/scroll-middle.png"
RedGlow.ImageColor3=Color3.fromRGB(160,0,0);RedGlow.ImageTransparency=1;RedGlow.ZIndex=2

local HMShadow=Instance.new("TextLabel",Bg);HMShadow.Size=UDim2.new(0,340,0,120);HMShadow.Position=UDim2.new(0.5,-168,0.5,-56)
HMShadow.BackgroundTransparency=1;HMShadow.Text="HM";HMShadow.TextColor3=Color3.fromRGB(120,0,0)
HMShadow.TextTransparency=1;HMShadow.TextSize=92;HMShadow.Font=Enum.Font.GothamBlack;HMShadow.ZIndex=3

local HMLabel=Instance.new("TextLabel",Bg);HMLabel.Size=UDim2.new(0,340,0,120);HMLabel.Position=UDim2.new(0.5,-170,0.5,-58)
HMLabel.BackgroundTransparency=1;HMLabel.Text="HM";HMLabel.TextColor3=Color3.fromRGB(255,255,255)
HMLabel.TextTransparency=1;HMLabel.TextSize=90;HMLabel.Font=Enum.Font.GothamBlack;HMLabel.ZIndex=4

local Line=Instance.new("Frame",Bg);Line.Size=UDim2.new(0,0,0,2);Line.Position=UDim2.new(0.5,0,0.5,56)
Line.AnchorPoint=Vector2.new(0.5,0.5);Line.BackgroundColor3=Color3.fromRGB(200,0,0);Line.BackgroundTransparency=1;Line.BorderSizePixel=0;Line.ZIndex=4

local EyeShadow=Instance.new("Frame",Bg);EyeShadow.Size=UDim2.new(0,230,0,230);EyeShadow.Position=UDim2.new(0.5,0,0.5,0)
EyeShadow.AnchorPoint=Vector2.new(0.5,0.5);EyeShadow.BackgroundColor3=Color3.fromRGB(0,0,0);EyeShadow.BackgroundTransparency=1
EyeShadow.BorderSizePixel=0;EyeShadow.ZIndex=3
Instance.new("UICorner",EyeShadow).CornerRadius=UDim.new(1,0)
local shadowStroke=Instance.new("UIStroke",EyeShadow);shadowStroke.Color=Color3.fromRGB(50,50,50);shadowStroke.Thickness=14;shadowStroke.Transparency=1

local Eye=Instance.new("ImageLabel",Bg);Eye.Size=UDim2.new(0,210,0,210);Eye.Position=UDim2.new(0.5,0,0.5,0)
Eye.AnchorPoint=Vector2.new(0.5,0.5);Eye.BackgroundTransparency=1;Eye.Image="rbxthumb://type=Asset&id=7292869465&w=420&h=420"
Eye.ImageTransparency=1;Eye.ScaleType=Enum.ScaleType.Fit;Eye.ZIndex=4

local TopLid=Instance.new("Frame",Bg);TopLid.Size=UDim2.new(1,0,0,200);TopLid.Position=UDim2.new(0.5,0,0,-210)
TopLid.AnchorPoint=Vector2.new(0.5,1.0);TopLid.BackgroundColor3=Color3.fromRGB(0,0,0);TopLid.BackgroundTransparency=0
TopLid.BorderSizePixel=0;TopLid.ZIndex=6
Instance.new("UICorner",TopLid).CornerRadius=UDim.new(0,22)

local BotLid=Instance.new("Frame",Bg);BotLid.Size=UDim2.new(1,0,0,200);BotLid.Position=UDim2.new(0.5,0,1,210)
BotLid.AnchorPoint=Vector2.new(0.5,0.0);BotLid.BackgroundColor3=Color3.fromRGB(0,0,0);BotLid.BackgroundTransparency=0
BotLid.BorderSizePixel=0;BotLid.ZIndex=6
Instance.new("UICorner",BotLid).CornerRadius=UDim.new(0,22)

local DevLabel=Instance.new("TextLabel",Bg);DevLabel.Size=UDim2.new(0,240,0,26);DevLabel.Position=UDim2.new(0.5,0,0.5,-128)
DevLabel.AnchorPoint=Vector2.new(0.5,0.5);DevLabel.BackgroundTransparency=1;DevLabel.Text="D E V   |   H M"
DevLabel.TextColor3=Color3.fromRGB(210,210,210);DevLabel.TextTransparency=1;DevLabel.TextSize=13;DevLabel.Font=Enum.Font.GothamBold;DevLabel.ZIndex=8

local DevLine=Instance.new("Frame",Bg);DevLine.Size=UDim2.new(0,0,0,1);DevLine.Position=UDim2.new(0.5,0,0.5,-115)
DevLine.AnchorPoint=Vector2.new(0.5,0.5);DevLine.BackgroundColor3=Color3.fromRGB(180,180,180);DevLine.BackgroundTransparency=0.3
DevLine.BorderSizePixel=0;DevLine.ZIndex=8
Instance.new("UICorner",DevLine).CornerRadius=UDim.new(1,0)

local function newSound(id) local s=Instance.new("Sound",introGui);s.SoundId="rbxassetid://"..id;s.Volume=1;return s end
local S0=newSound("100857951036934");local S1=newSound("108120517724039")
local S2=newSound("134103109747331");local S3=newSound("102742504905872")

local Skip=Instance.new("TextButton",introGui);Skip.Size=UDim2.new(0,85,0,28);Skip.Position=UDim2.new(1,-100,1,-42)
Skip.BackgroundColor3=Color3.fromRGB(10,10,10);Skip.BackgroundTransparency=0.4;Skip.Text="SKIP  >"
Skip.TextColor3=Color3.fromRGB(200,200,200);Skip.TextTransparency=1;Skip.TextSize=12;Skip.Font=Enum.Font.GothamBold
Skip.BorderSizePixel=0;Skip.ZIndex=20
Instance.new("UICorner",Skip).CornerRadius=UDim.new(0,6)
local skipStr=Instance.new("UIStroke",Skip);skipStr.Color=Color3.fromRGB(180,0,0);skipStr.Thickness=1;skipStr.Transparency=1

local finished=false;local FADE=0.55

local function endIntro()
    if finished then return end;finished=true
    S0:Stop();S1:Stop();S2:Stop();S3:Stop()
    for _,v in ipairs(introGui:GetDescendants())do pcall(function()
        if v:IsA("TextButton")or v:IsA("TextLabel")then tw(v,{TextTransparency=1,BackgroundTransparency=1},FADE,Enum.EasingStyle.Linear)
        elseif v:IsA("ImageLabel")then tw(v,{ImageTransparency=1,BackgroundTransparency=1},FADE,Enum.EasingStyle.Linear)
        elseif v:IsA("Frame")then tw(v,{BackgroundTransparency=1},FADE,Enum.EasingStyle.Linear)
        elseif v:IsA("UIStroke")then tw(v,{Transparency=1},FADE,Enum.EasingStyle.Linear)end end)end
    task.wait(FADE+0.05);introGui:Destroy();launchMainHub()
end

Skip.MouseButton1Click:Connect(endIntro)

task.spawn(function()
    S0:Play()
    task.wait(0.4);tw(Skip,{TextTransparency=0.3},1.0);tw(skipStr,{Transparency=0.3},1.0)
    task.wait(0.1)
    tw(HMLabel,{TextTransparency=0},1.4,Enum.EasingStyle.Quart);tw(HMShadow,{TextTransparency=0.3},1.4,Enum.EasingStyle.Quart)
    tw(Line,{Size=UDim2.new(0,110,0,2),BackgroundTransparency=0.2},0.9,Enum.EasingStyle.Quart);tw(RedGlow,{ImageTransparency=0.92},2.0)
    task.wait(2.8);if finished then return end
    tw(HMLabel,{TextTransparency=1},0.9,Enum.EasingStyle.Quart);tw(HMShadow,{TextTransparency=1},0.9)
    tw(Line,{Size=UDim2.new(0,0,0,2),BackgroundTransparency=1},0.6,Enum.EasingStyle.Quart)
    task.wait(0.7);if finished then return end
    TopLid.Position=UDim2.new(0.5,0,0.5,0);BotLid.Position=UDim2.new(0.5,0,0.5,0);Eye.ImageTransparency=0
    if finished then return end;S1:Play()
    task.spawn(function()local rot=0;while not finished do rot=rot+360;tw(Eye,{Rotation=rot},3.5,Enum.EasingStyle.Linear);task.wait(3.5)end end)
    tw(TopLid,{Position=UDim2.new(0.5,0,0.5,-112)},1.8,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
    tw(BotLid,{Position=UDim2.new(0.5,0,0.5,112)},1.8,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
    tw(EyeShadow,{BackgroundTransparency=0.72},2.0,Enum.EasingStyle.Quart);tw(shadowStroke,{Transparency=0.50},2.0,Enum.EasingStyle.Quart)
    task.wait(1.4);if finished then return end
    tw(DevLabel,{TextTransparency=0.08},1.0,Enum.EasingStyle.Quart);tw(DevLine,{Size=UDim2.new(0,130,0,1)},0.9,Enum.EasingStyle.Quart)
    tw(RedGlow,{ImageTransparency=0.88},1.8)
    task.wait(0.4);if finished then return end
    S2:Play();task.wait(0.15);if finished then return end;S3:Play()
    task.wait(3.5);if finished then return end;endIntro()
end)

-- ==================== HM UI ====================
function launchMainHub()
    local C = {
        bg    = Color3.fromRGB(8,  0,  0), panel = Color3.fromRGB(14, 2,  2), card  = Color3.fromRGB(20, 5,  5),
        blood = Color3.fromRGB(140, 0,  0), red   = Color3.fromRGB(200, 15, 15), glow  = Color3.fromRGB(255, 40, 40),
        white = Color3.new(1, 1, 1), muted = Color3.fromRGB(180, 120, 120), dim   = Color3.fromRGB(60,  20, 20),
    }

    if CoreGui:FindFirstChild("HM_UI") then CoreGui:FindFirstChild("HM_UI"):Destroy() end

    local Screen = Instance.new("ScreenGui", CoreGui)
    Screen.Name = "HM_UI"; Screen.ResetOnSpawn = false; Screen.DisplayOrder = 9999

    local Win = Instance.new("Frame", Screen)
    Win.Size = UDim2.new(0, 420, 0, 400); Win.Position = UDim2.new(0.5, -210, 0.5, -200)
    Win.BackgroundColor3 = C.bg; Win.BackgroundTransparency = 1; Win.BorderSizePixel = 0; Win.ClipsDescendants = true
    Instance.new("UICorner", Win).CornerRadius = UDim.new(0, 14)

    local BG = Instance.new("ImageLabel", Win)
    BG.Size = UDim2.new(1, 0, 1, 0); BG.BackgroundTransparency = 1
    BG.Image = "rbxthumb://type=Asset&id=103122892052801&w=420&h=420"
    BG.ImageTransparency = 1; BG.ScaleType = Enum.ScaleType.Crop; BG.ZIndex = 1
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0, 14)

    local OV = Instance.new("Frame", Win)
    OV.Size = UDim2.new(1, 0, 1, 0); OV.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OV.BackgroundTransparency = 1; OV.BorderSizePixel = 0; OV.ZIndex = 2
    Instance.new("UICorner", OV).CornerRadius = UDim.new(0, 14)

    local TitleBar = Instance.new("Frame", Win)
    TitleBar.Size = UDim2.new(1, 0, 0, 50); TitleBar.BackgroundColor3 = C.panel
    TitleBar.BackgroundTransparency = 1; TitleBar.BorderSizePixel = 0; TitleBar.ZIndex = 10

    local badge = Instance.new("Frame", TitleBar)
    badge.Size = UDim2.new(0, 40, 0, 32); badge.Position = UDim2.new(0, 12, 0.5, -16)
    badge.BackgroundColor3 = C.blood; badge.BackgroundTransparency = 1; badge.BorderSizePixel = 0; badge.ZIndex = 11
    Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 6)
    local bStr = Instance.new("UIStroke", badge); bStr.Color = C.glow; bStr.Thickness = 1.5; bStr.Transparency = 1
    local badgeTxt = Instance.new("TextLabel", badge)
    badgeTxt.Size = UDim2.new(1, 0, 1, 0); badgeTxt.BackgroundTransparency = 1; badgeTxt.Text = "HM"
    badgeTxt.TextColor3 = C.white; badgeTxt.TextTransparency = 1; badgeTxt.TextSize = 15; badgeTxt.Font = Enum.Font.GothamBlack; badgeTxt.ZIndex = 12

    local titleTxt = Instance.new("TextLabel", TitleBar)
    titleTxt.Size = UDim2.new(0, 200, 1, 0); titleTxt.Position = UDim2.new(0, 60, 0, 0); titleTxt.BackgroundTransparency = 1
    titleTxt.Text = "HM  |  PREMIUM"; titleTxt.TextColor3 = C.white; titleTxt.TextTransparency = 1
    titleTxt.TextSize = 14; titleTxt.Font = Enum.Font.GothamBold; titleTxt.TextXAlignment = Enum.TextXAlignment.Left; titleTxt.ZIndex = 11

    local dot = Instance.new("Frame", TitleBar)
    dot.Size = UDim2.new(0, 7, 0, 7); dot.Position = UDim2.new(0, 238, 0.5, -3)
    dot.BackgroundColor3 = C.glow; dot.BackgroundTransparency = 1; dot.BorderSizePixel = 0; dot.ZIndex = 11
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local minBtn = Instance.new("TextButton", TitleBar)
    minBtn.Size = UDim2.new(0, 26, 0, 26); minBtn.Position = UDim2.new(1, -62, 0.5, -13)
    minBtn.BackgroundColor3 = C.dim; minBtn.BackgroundTransparency = 1; minBtn.Text = "—"
    minBtn.TextColor3 = C.muted; minBtn.TextTransparency = 1; minBtn.TextSize = 12; minBtn.Font = Enum.Font.GothamBold
    minBtn.BorderSizePixel = 0; minBtn.ZIndex = 11
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

    local closeBtn = Instance.new("TextButton", TitleBar)
    closeBtn.Size = UDim2.new(0, 26, 0, 26); closeBtn.Position = UDim2.new(1, -30, 0.5, -13)
    closeBtn.BackgroundColor3 = C.blood; closeBtn.BackgroundTransparency = 1; closeBtn.Text = "x"
    closeBtn.TextColor3 = C.white; closeBtn.TextTransparency = 1; closeBtn.TextSize = 12; closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0; closeBtn.ZIndex = 11
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

    local pingLabel = Instance.new("TextLabel", TitleBar)
    pingLabel.Size = UDim2.new(0, 82, 0, 22); pingLabel.Position = UDim2.new(1, -158, 0.5, -11)
    pingLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10); pingLabel.BackgroundTransparency = 1; pingLabel.BorderSizePixel = 0
    pingLabel.Text = "PING  --"; pingLabel.TextColor3 = C.white; pingLabel.TextSize = 11; pingLabel.Font = Enum.Font.GothamBold
    pingLabel.TextTransparency = 1; pingLabel.ZIndex = 13
    Instance.new("UICorner", pingLabel).CornerRadius = UDim.new(0, 5)

    local divLine = Instance.new("Frame", Win)
    divLine.Size = UDim2.new(1, -24, 0, 1); divLine.Position = UDim2.new(0, 12, 0, 50)
    divLine.BackgroundColor3 = C.blood; divLine.BackgroundTransparency = 1; divLine.BorderSizePixel = 0; divLine.ZIndex = 10

    local Scroll = Instance.new("ScrollingFrame", Win)
    Scroll.Size = UDim2.new(1, -16, 1, -60); Scroll.Position = UDim2.new(0, 8, 0, 56)
    Scroll.BackgroundTransparency = 1; Scroll.BorderSizePixel = 0; Scroll.ScrollBarThickness = 2
    Scroll.ScrollBarImageColor3 = C.blood; Scroll.CanvasSize = UDim2.new(0, 0, 0, 800); Scroll.ZIndex = 12

    local function ripple(parent, z)
        local r = Instance.new("Frame", parent); r.Size = UDim2.new(0, 0, 0, 0); r.Position = UDim2.new(0.5, 0, 0.5, 0)
        r.AnchorPoint = Vector2.new(0.5, 0.5); r.BackgroundColor3 = C.glow; r.BackgroundTransparency = 0.5
        r.BorderSizePixel = 0; r.ZIndex = z or 25
        Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
        tw(r, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 0.4, Enum.EasingStyle.Quad)
        task.delay(0.4, function() r:Destroy() end)
    end

    local function makeSection(y, text)
        local row = Instance.new("Frame", Scroll); row.Size = UDim2.new(1, -8, 0, 22); row.Position = UDim2.new(0, 4, 0, y)
        row.BackgroundTransparency = 1; row.ZIndex = 14
        local line = Instance.new("Frame", row); line.Size = UDim2.new(1, 0, 0, 1); line.Position = UDim2.new(0, 0, 0.5, 0)
        line.BackgroundColor3 = C.blood; line.BackgroundTransparency = 0.5; line.BorderSizePixel = 0; line.ZIndex = 14
        local bg = Instance.new("Frame", row); bg.Position = UDim2.new(0.5, 0, 0, 0); bg.AnchorPoint = Vector2.new(0.5, 0)
        bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0); bg.BackgroundTransparency = 0.1; bg.BorderSizePixel = 0
        bg.AutomaticSize = Enum.AutomaticSize.X; bg.Size = UDim2.new(0, 0, 1, 0); bg.ZIndex = 15
        local lbl = Instance.new("TextLabel", bg); lbl.BackgroundTransparency = 1; lbl.Text = "  " .. text .. "  "
        lbl.TextColor3 = C.glow; lbl.TextSize = 10; lbl.Font = Enum.Font.GothamBold
        lbl.AutomaticSize = Enum.AutomaticSize.X; lbl.Size = UDim2.new(0, 0, 1, 0); lbl.ZIndex = 16
    end

    local function makeToggle(y, icon, label, default, callback)
        local c = Instance.new("Frame", Scroll); c.Size = UDim2.new(1, -8, 0, 42); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.card; c.BackgroundTransparency = 0.4; c.BorderSizePixel = 0; c.ZIndex = 14; c.ClipsDescendants = true
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.dim; cs.Thickness = 1

        local side = Instance.new("Frame", c); side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = default and C.glow or C.dim; side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local il = Instance.new("TextLabel", c); il.Size = UDim2.new(0, 26, 0, 26); il.Position = UDim2.new(0, 10, 0.5, -13)
        il.BackgroundTransparency = 1; il.Text = icon; il.TextSize = 15; il.ZIndex = 15

        local lbl = Instance.new("TextLabel", c); lbl.Size = UDim2.new(1, -105, 1, 0); lbl.Position = UDim2.new(0, 42, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = label; lbl.TextColor3 = C.white; lbl.TextSize = 13; lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15

        local tBg = Instance.new("Frame", c); tBg.Size = UDim2.new(0, 40, 0, 20); tBg.Position = UDim2.new(1, -48, 0.5, -10)
        tBg.BackgroundColor3 = default and C.blood or C.dim; tBg.BackgroundTransparency = default and 0.25 or 0.1
        tBg.BorderSizePixel = 0; tBg.ZIndex = 15
        Instance.new("UICorner", tBg).CornerRadius = UDim.new(1, 0)
        local tStr = Instance.new("UIStroke", tBg); tStr.Color = default and C.glow or C.dim; tStr.Thickness = 1.2

        local circ = Instance.new("Frame", tBg); circ.Size = UDim2.new(0, 14, 0, 14)
        circ.Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        circ.BackgroundColor3 = C.white; circ.BorderSizePixel = 0; circ.ZIndex = 16
        Instance.new("UICorner", circ).CornerRadius = UDim.new(1, 0)

        local val = default or false
        local btn = Instance.new("TextButton", c); btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 17

        btn.MouseButton1Click:Connect(function()
            val = not val; ripple(c, 17)
            tw(tBg, {BackgroundColor3 = val and C.blood or C.dim, BackgroundTransparency = val and 0.25 or 0.1}, 0.2)
            tw(tStr, {Color = val and C.glow or C.dim}, 0.2)
            tw(circ, {Position = val and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)}, 0.2)
            tw(side, {BackgroundColor3 = val and C.glow or C.dim}, 0.2)
            if callback then callback(val) end
        end)
        btn.MouseEnter:Connect(function() tw(c, {BackgroundTransparency = 0.22}, 0.12) end)
        btn.MouseLeave:Connect(function() tw(c, {BackgroundTransparency = 0.4},  0.12) end)
        return {set=function(v)val=v;tw(tBg,{BackgroundColor3=val and C.blood or C.dim,BackgroundTransparency=val and 0.25 or 0.1},0.2);tw(tStr,{Color=val and C.glow or C.dim},0.2);tw(circ,{Position=val and UDim2.new(1,-17,0.5,-7)or UDim2.new(0,3,0.5,-7)},0.2);tw(side,{BackgroundColor3=val and C.glow or C.dim},0.2)end}
    end

    local function makeButton(y, icon, label, cb)
        local c = Instance.new("Frame", Scroll); c.Size = UDim2.new(1, -8, 0, 40); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.blood; c.BackgroundTransparency = 0.6; c.BorderSizePixel = 0; c.ZIndex = 14; c.ClipsDescendants = true
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.glow; cs.Thickness = 1; cs.Transparency = 0.5

        local side = Instance.new("Frame", c); side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = C.glow; side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local lbl = Instance.new("TextLabel", c); lbl.Size = UDim2.new(1, -36, 1, 0); lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1; lbl.Text = icon .. "  " .. label; lbl.TextColor3 = C.white; lbl.TextSize = 13; lbl.Font = Enum.Font.GothamBold
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15

        local arr = Instance.new("TextLabel", c); arr.Size = UDim2.new(0, 22, 1, 0); arr.Position = UDim2.new(1, -24, 0, 0)
        arr.BackgroundTransparency = 1; arr.Text = ">"; arr.TextColor3 = C.glow; arr.TextSize = 20; arr.Font = Enum.Font.GothamBold; arr.ZIndex = 15

        local btn = Instance.new("TextButton", c); btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.ZIndex = 16
        btn.MouseButton1Click:Connect(function()ripple(c,16);tw(c,{BackgroundTransparency=0.35},0.1);task.delay(0.18,function()tw(c,{BackgroundTransparency=0.6},0.2)end);if cb then cb()end end)
        btn.MouseEnter:Connect(function()tw(c,{BackgroundTransparency=0.45},0.12)end)
        btn.MouseLeave:Connect(function()tw(c,{BackgroundTransparency=0.6},0.12)end)
    end

    local function makeSlider(y, icon, label, min, max, default, callback)
        local c = Instance.new("Frame", Scroll); c.Size = UDim2.new(1, -8, 0, 56); c.Position = UDim2.new(0, 4, 0, y)
        c.BackgroundColor3 = C.card; c.BackgroundTransparency = 0.4; c.BorderSizePixel = 0; c.ZIndex = 14
        Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
        local cs = Instance.new("UIStroke", c); cs.Color = C.dim; cs.Thickness = 1

        local side = Instance.new("Frame", c); side.Size = UDim2.new(0, 3, 0.6, 0); side.Position = UDim2.new(0, 0, 0.2, 0)
        side.BackgroundColor3 = C.blood; side.BorderSizePixel = 0; side.ZIndex = 15
        Instance.new("UICorner", side).CornerRadius = UDim.new(1, 0)

        local top = Instance.new("Frame", c); top.Size = UDim2.new(1, -16, 0, 22); top.Position = UDim2.new(0, 12, 0, 6)
        top.BackgroundTransparency = 1; top.ZIndex = 15
        local lbl = Instance.new("TextLabel", top); lbl.Size = UDim2.new(0.75, 0, 1, 0); lbl.BackgroundTransparency = 1
        lbl.Text = icon .. "  " .. label; lbl.TextColor3 = C.white; lbl.TextSize = 12; lbl.Font = Enum.Font.GothamMedium
        lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.ZIndex = 15
        local valLbl = Instance.new("TextLabel", top); valLbl.Size = UDim2.new(0.25, 0, 1, 0); valLbl.Position = UDim2.new(0.75, 0, 0, 0)
        valLbl.BackgroundTransparency = 1; valLbl.Text = tostring(default); valLbl.TextColor3 = C.glow; valLbl.TextSize = 12; valLbl.Font = Enum.Font.GothamBold
        valLbl.TextXAlignment = Enum.TextXAlignment.Right; valLbl.ZIndex = 15

        local track = Instance.new("Frame", c); track.Size = UDim2.new(1, -20, 0, 4); track.Position = UDim2.new(0, 12, 0, 40)
        track.BackgroundColor3 = C.dim; track.BackgroundTransparency = 0.2; track.BorderSizePixel = 0; track.ZIndex = 15
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

        local pct = (default - min) / (max - min)
        local fill = Instance.new("Frame", track); fill.Size = UDim2.new(pct, 0, 1, 0); fill.BackgroundColor3 = C.red
        fill.BackgroundTransparency = 0.2; fill.BorderSizePixel = 0; fill.ZIndex = 16
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local thumb = Instance.new("Frame", track); thumb.Size = UDim2.new(0, 14, 0, 14); thumb.Position = UDim2.new(pct, -7, 0.5, -7)
        thumb.BackgroundColor3 = C.white; thumb.BorderSizePixel = 0; thumb.ZIndex = 17
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
        local tStr = Instance.new("UIStroke", thumb); tStr.Color = C.glow; tStr.Thickness = 1.8

        local dragging = false
        local function updateSlider(rel)
            rel = math.clamp(rel, 0, 1)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            thumb.Position = UDim2.new(rel, -7, 0.5, -7)
            local v = min + (max - min) * rel
            valLbl.Text = tostring(math.floor(v * 10) / 10)
            if callback then callback(v) end
        end

        thumb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
        UserInputService.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
                updateSlider((i.Position.X-track.AbsolutePosition.X)/track.AbsoluteSize.X)
            end
        end)
    end

    local welcome = Instance.new("Frame", Scroll)
    welcome.Size = UDim2.new(1, -8, 0, 60); welcome.Position = UDim2.new(0, 4, 0, 4)
    welcome.BackgroundColor3 = C.blood; welcome.BackgroundTransparency = 0.5; welcome.BorderSizePixel = 0; welcome.ZIndex = 14; welcome.ClipsDescendants = true
    Instance.new("UICorner", welcome).CornerRadius = UDim.new(0, 10)
    local wStr = Instance.new("UIStroke", welcome); wStr.Color = C.glow; wStr.Thickness = 1.2; wStr.Transparency = 0.4

    local wT = Instance.new("TextLabel", welcome)
    wT.Size = UDim2.new(1, -14, 0, 26); wT.Position = UDim2.new(0, 12, 0, 6); wT.BackgroundTransparency = 1
    wT.Text = "  Welcome,  " .. Players.LocalPlayer.Name; wT.TextColor3 = C.white; wT.TextSize = 14; wT.Font = Enum.Font.GothamBold
    wT.TextXAlignment = Enum.TextXAlignment.Left; wT.ZIndex = 15

    local wS = Instance.new("TextLabel", welcome)
    wS.Size = UDim2.new(1, -14, 0, 18); wS.Position = UDim2.new(0, 12, 0, 34); wS.BackgroundTransparency = 1
    wS.Text = "HM  |  PREMIUM EDITION"; wS.TextColor3 = C.glow; wS.TextSize = 11; wS.Font = Enum.Font.GothamMedium
    wS.TextXAlignment = Enum.TextXAlignment.Left; wS.ZIndex = 15

    makeSection(72, "COMBAT")
    local autoToggle = makeToggle(100, "", "Auto", false, function(v) if v then startAuto() else stopAuto() end end)
    local classicBtn = makeButton(148, "", "Classic Mode", function() autoMode = "Classic" end)
    local proBtn = makeButton(194, "", "Pro Mode", function() autoMode = "Pro" end)

    makeSection(242, "SETTINGS")
    makeSlider(270, "", "Max Number", 1, 10, 5, function(v) targetNumber = v end)
    makeSlider(332, "", "Keep Distance", 1, 10, 3.5, function(v) KEEP_DISTANCE = v end)
    makeSlider(394, "", "Wall Distance", 1, 10, 2.5, function(v) wallDistance = v end)
    
    local flickToggle = makeToggle(456, "", "Flick", false, function(v) flickEnabled = v end)
    makeSlider(504, "", "Flick Power", 5, 45, 45, function(v) flickPower = v end)
    
    local stretchToggle = makeToggle(566, "", "Stretch Screen", false, function(v) stretchEnabled = v; if v then updateStretch() else if stretchConn then stretchConn:Disconnect(); stretchConn = nil end end end)
    local fpsToggle = makeToggle(614, "", "FPS Boost", false, function(v) fpsEnabled = v; if v then applyFPS() end end)
    local escapeToggle = makeToggle(662, "", "Escape", true, function(v) escapeMode = v end)

    makeSection(710, "AVATAR CHANGER")
    local avatarInput = Instance.new("TextBox", Scroll)
    avatarInput.Size = UDim2.new(1, -8, 0, 32); avatarInput.Position = UDim2.new(0, 4, 0, 738)
    avatarInput.BackgroundColor3 = C.card; avatarInput.BackgroundTransparency = 0.4; avatarInput.BorderSizePixel = 0
    avatarInput.Text = ""; avatarInput.PlaceholderText = "  Enter Username..."
    avatarInput.TextColor3 = C.white; avatarInput.Font = Enum.Font.GothamMedium; avatarInput.TextSize = 13
    avatarInput.ZIndex = 14
    Instance.new("UICorner", avatarInput).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", avatarInput).Color = C.dim
    
    local avatarApplyBtn = makeButton(776, "", "Apply Avatar", function()
        if avatarInput.Text ~= "" then lastAvatarUser = avatarInput.Text; applyAvatar(avatarInput.Text) end
    end)

    Scroll.CanvasSize = UDim2.new(0, 0, 0, 830)

    local drag, ds, wp = false, nil, nil
    TitleBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; ds = i.Position; wp = Win.Position end end)
    UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - ds; Win.Position = UDim2.new(wp.X.Scale, wp.X.Offset + d.X, wp.Y.Scale, wp.Y.Offset + d.Y) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)

    local mini = false
    minBtn.MouseButton1Click:Connect(function() mini = not mini; tw(Win, {Size = mini and UDim2.new(0, 420, 0, 50) or UDim2.new(0, 420, 0, 400)}, 0.35, Enum.EasingStyle.Back); minBtn.Text = mini and "[ ]" or "—"; if mini then tw(pingLabel, {TextTransparency = 0, BackgroundTransparency = 0.35}, 0.3) else tw(pingLabel, {TextTransparency = 1, BackgroundTransparency = 1}, 0.2) end end)

    task.spawn(function() while Win and Win.Parent do local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000); pingLabel.Text = "PING  " .. ping .. "ms"; task.wait(0.5) end end)

    closeBtn.MouseButton1Click:Connect(function() tw(Win, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In); task.delay(0.3, function() Screen:Destroy() end) end)

    task.spawn(function() while dot and dot.Parent do tw(dot, {BackgroundTransparency = 0.8}, 0.8); task.wait(0.8); tw(dot, {BackgroundTransparency = 0}, 0.8); task.wait(0.8) end end)

    Win.Size = UDim2.new(0, 420, 0, 400)
    tw(Win, {BackgroundTransparency = 0.05}, 0.5, Enum.EasingStyle.Quart); tw(BG, {ImageTransparency = 0.3}, 0.6); tw(OV, {BackgroundTransparency = 0.72}, 0.6)
    task.wait(0.3)
    tw(TitleBar, {BackgroundTransparency = 0.3}, 0.4); tw(badge, {BackgroundTransparency = 0.3}, 0.4); tw(bStr, {Transparency = 0.3}, 0.4)
    tw(badgeTxt, {TextTransparency = 0}, 0.4); tw(titleTxt, {TextTransparency = 0}, 0.4); tw(dot, {BackgroundTransparency = 0}, 0.4)
    tw(minBtn, {BackgroundTransparency = 0.3, TextTransparency = 0}, 0.4)
    tw(closeBtn, {BackgroundTransparency = 0.3, TextTransparency = 0}, 0.4)
    task.wait(0.25); tw(divLine, {BackgroundTransparency = 0.4}, 0.4)

    btitleTxt.Text = "Mohamed Prumuim"



end

-- ==================== ACTIVATE PROTECTION ====================
Ghost:KillTimeBombScanners()
Ghost:NetworkMask()
Ghost:AntiKickShield()
Ghost:PlayerGuiShield()
Ghost:AntiTeleportDetect()

badge

titleTxt.Text = "Mohamed Prumuim"




