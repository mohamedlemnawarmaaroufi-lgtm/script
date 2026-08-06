if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- دالة التحريك السلس (Tween)
local function tw(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(t or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

-- إنشاء واجهة المستخدم (GUI) أولاً قبل استخدامها
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MOH_Hub_Gui"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Win = Instance.new("Frame")
Win.Name = "Win"
Win.Size = UDim2.new(0, 420, 0, 400)
Win.Position = UDim2.new(0.5, -210, 0.5, -200)
Win.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Win.BorderSizePixel = 0
Win.Parent = ScreenGui

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Win

local minBtn = Instance.new("TextButton")
minBtn.Name = "minBtn"
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -70, 0, 5)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minBtn.Parent = TitleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "closeBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Parent = TitleBar

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "pingLabel"
pingLabel.Size = UDim2.new(1, -20, 0, 30)
pingLabel.Position = UDim2.new(0, 10, 0, 50)
pingLabel.Text = "Ping: calculating..."
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.BackgroundTransparency = 1
pingLabel.Parent = Win

-- نظام سحب النافذة (Dragging)
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Win.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Win.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- أزرار التصغير والإغلاق
local mini = false
minBtn.MouseButton1Click:Connect(function()
    mini = not mini
    minBtn.Text = mini and "[ ]" or "-"
    if mini then
        tw(pingLabel, {TextTransparency = 1}, 0.2)
    else
        tw(pingLabel, {TextTransparency = 0}, 0.2)
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    tw(Win, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    task.delay(0.3, function()
        ScreenGui:Destroy()
    end)
end)

-- عداد البينغ (Ping)
task.spawn(function()
    while Win and Win.Parent do
        pcall(function()
            local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
            pingLabel.Text = "Ping: " .. ping .. " ms"
        end)
        task.wait(1)
    end
end)

print("[MOH] Hub – Ready!")

