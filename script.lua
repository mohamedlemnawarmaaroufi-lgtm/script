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

    print("[MOH] Hub — Ready!")
end

-- ==================== ACTIVATE PROTECTION ====================
Ghost:KillTimeBombScanners()
Ghost:NetworkMask()
Ghost:AntiKickShield()
Ghost:PlayerGuiShield()
Ghost:AntiTeleportDetect()

print("[MOH] Hub - LOADED")
