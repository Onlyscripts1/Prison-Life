-- This script is made by feariosz0 in discord, beta v1.0.3

local noclipbool = false
local infstambool = false
local autorebool = false
local autogbool = false
local infjumpbool = false
local antisitconn;

local loopkill = false

local whitelisted = {
	"vole7vin",
	"RONALDO_32720",
}

local function gets(service)
    return game:GetService(service)
end

local players = gets('Players')
local storage = gets('ReplicatedStorage')
local chat = gets('Chat')
local team = gets('Teams')
local gui = gets('StarterGui')
local run = gets('RunService')
local input = gets('UserInputService')

local function notify(title, text, duration)
    pcall(function()
        gui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5
        })
    end)
end

local localp = players.LocalPlayer
local cam = workspace.CurrentCamera

local function getpl()
    for _, v in pairs(players:GetPlayers()) do
        return v
    end
end

local function getch()
    if localp.Character then
        return localp.Character
    else
        repeat
            task.wait(0.1)
        until localp.Character
        return localp.Character
    end
end

local function gethm()
    local ch = getch()
    if ch:FindFirstChildOfClass('Humanoid') then
        return ch:FindFirstChildOfClass('Humanoid')
    else
        repeat
            task.wait()
        until ch:FindFirstChildOfClass('Humanoid')
        return ch:FindFirstChildOfClass('Humanoid')
    end
end

local function gethp()
    local ch = getch()
    if ch:FindFirstChild('HumanoidRootPart') then
        return ch:FindFirstChild('HumanoidRootPart')
    else
        repeat
            task.wait()
        until ch:FindFirstChild('HumanoidRootPart')
        return ch:FindFirstChild('HumanoidRootPart')
    end
end

do -- limit for kick/kill
    local p = Instance.new('Part')
    p.Name = 'HeightLimit'
    p.Size = Vector3.new(10000000, 10, 10000000)
    p.Position = Vector3.new(929, 180, 2397)
    p.Anchored = true
    p.Transparency = 1
    p.CanCollide = true
    p.Parent = workspace
    
    run.Heartbeat:Connect(function()
        if gethp().Position.Y < -50 then
            gethp().CFrame = CFrame.new(913, 100, 2385)
        end
    end)
end

local function noclip()
    if storage:FindFirstChild('Scripts') and storage:FindFirstChild('Scripts'):FindFirstChild('ClientItemHandler') then
        storage.Scripts.CharacterCollision:Destroy()
    end
    if not noclipbool then
        noclipbool = true
    end
    while noclipbool do
        local ch = getch()
        for _, v in pairs(ch:GetChildren()) do
            if v:IsA('BasePart') then
                v.CanCollide = false
            end
        end
        task.wait()
    end
end

local function unnoclip()
    noclipbool = false
    local ch = getch()
    ch.Head.CanCollide = true
    ch.Torso.CanCollide = true
end

local function infstam()
    infstambool = true
    while infstam do
        local ch = getch()
        if ch:FindFirstChild('AntiJump') then
            ch.AntiJump.Disabled = true
        end
        task.wait()
    end
end

local function crim()
    local hp = gethp()
    local og = hp.CFrame
    local ogcam = cam.CFrame
    local cf = CFrame.new(-975, 108, 2071)
    
    hp.CFrame = cf
    repeat task.wait(0.1) until localp.Team.Name == 'Criminals'
    hp.CFrame = og
    cam.CFrame = ogcam
end

local function autore()
    if not autorebool then
        autorebool = true
    end
    while autorebool do
        local hm = gethm()
        if hm and hm.Health == 0 then
            local ch = getch()
            local hp = gethp()
            local og = hp.CFrame
            local ogcam = cam.CFrame
            localp.CharacterAdded:Wait()
            task.wait()
            local newhp = gethp()
            if ch:FindFirstChild('ForceField') and localp.Team.Name == 'Criminals' then
                repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
            end
            newhp.CFrame = og
            cam.CFrame = ogcam
        end
        task.wait()
    end
end

local function helper()
    local hm = gethm()
    local anim = Instance.new('Animation')
    anim.AnimationId = 'rbxassetid://180426354'
    anim.Name = 'HelperAnim'
    anim.Parent = hm
    local track = hm:LoadAnimation(anim)
    track:Play()
end

local function ak47()
    local hp = gethp()
    local hm = gethm()
    local cf = CFrame.new(-932, 94, 2039)
    local og = hp.CFrame
    local ogcam = cam.CFrame
    local Event = storage.Remotes.InteractWithItem

    while task.wait() do
        gethp().CFrame = CFrame.new(-929, 97, 2056)
        helper()
        task.wait(0.1)
        hp.CFrame = cf
        hm:ChangeState(Enum.HumanoidStateType.Jumping)
        Event:InvokeServer(
            workspace.Prison_ITEMS.giver["AK-47"]["Meshes/AK47_7"]
        )
        if localp.Backpack:FindFirstChild('AK-47') then
            for _, track in pairs(hm:GetPlayingAnimationTracks()) do
                track:Stop()
            end
            hp.CFrame = og
            cam.CFrame = ogcam
            break
        end
    end
end

local function shotgun()
    local hp = gethp()
    local hm = gethm()
    local cf = CFrame.new(-939, 94, 2040)
    local og = hp.CFrame
    local ogcam = cam.CFrame
    local Event = storage.Remotes.InteractWithItem

    while task.wait() do
        gethp().CFrame = CFrame.new(-929, 97, 2056)
        helper()
        task.wait(0.1)
        hp.CFrame = cf
        hm:ChangeState(Enum.HumanoidStateType.Jumping)
        Event:InvokeServer(
            workspace.Prison_ITEMS.giver:GetChildren()[4]["Meshes/r870_2"]
        )
        if localp.Backpack:FindFirstChild('Remington 870') then
            for _, track in pairs(hm:GetPlayingAnimationTracks()) do
                track:Stop()
            end
            hp.CFrame = og
            cam.CFrame = ogcam
            break
        end
    end
end

local function autog()
    if not autogbool then
        autogbool = true
    end
    while autogbool do
        if not localp:FindFirstChildOfClass('Backpack') then
            task.wait(0.5)
        end
        if localp.Team.Name == 'Neutral' then
            repeat task.wait(0.1) until localp.Team.Name ~= 'Neutral'
            task.wait(0.5)
        end
        local hm = gethm()
        local og = gethp().CFrame
        local ogcam = cam.CFrame

        local function hasgun(name)
            local ch = localp.Character
            return localp.Backpack:FindFirstChild(name) or (ch and ch:FindFirstChild(name))
        end

        if not hasgun('AK-47') then
            local Event = storage.Remotes.InteractWithItem
            gethp().CFrame = CFrame.new(-929, 97, 2056)
            helper()
            task.wait(0.1)
            gethp().CFrame = CFrame.new(-932, 94, 2039)
            hm:ChangeState(Enum.HumanoidStateType.Jumping)

            while not hasgun('AK-47') do
                gethp().CFrame = CFrame.new(-932, 94, 2039)
                Event:InvokeServer(
                    workspace.Prison_ITEMS.giver["AK-47"]["Meshes/AK47_7"]
                )
                task.wait()
            end

            for _, track in pairs(gethm():GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        if not hasgun('Remington 870') then
            local Event = storage.Remotes.InteractWithItem
            gethp().CFrame = CFrame.new(-929, 97, 2056)
            helper()
            task.wait(0.1)
            gethp().CFrame = CFrame.new(-939, 94, 2040)
            hm:ChangeState(Enum.HumanoidStateType.Jumping)

            while not hasgun('Remington 870') do
                gethp().CFrame = CFrame.new(-939, 94, 2040)
                Event:InvokeServer(
                    workspace.Prison_ITEMS.giver:GetChildren()[4]["Meshes/r870_2"]
                )
                task.wait()
            end

            for _, track in pairs(gethm():GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        gethp().CFrame = og
        cam.CFrame = ogcam
        task.wait(0.5)
    end
end

local function base()
    local hp = gethp()
    local cf = CFrame.new(-929, 97, 2056)
    hp.CFrame = cf
end

local function yard()
    local ch = getch()
    if ch:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    local hp = gethp()
    local cf = CFrame.new(799, 98, 2469)
    hp.CFrame = cf
end

local function prison()
    local ch = getch()
    if ch:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    local hp = gethp()
    local cf = CFrame.new(913, 100, 2385)
    hp.CFrame = cf
end

local function cafeteria()
    local ch = getch()
    if ch:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    local hp = gethp()
    local cf = CFrame.new(906, 100, 2298)
    hp.CFrame = cf
end

local function tower()
    local ch = getch()
    if ch:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    local hp = gethp()
    local cf = CFrame.new(822, 125, 2588)
    hp.CFrame = cf
end

local function rdoors()
    for _, v in pairs(workspace.Doors:GetChildren()) do
        v:Destroy()
    end
end

local function findpl(arg)
    arg = arg:lower()
    local found

    for _, p in pairs(players:GetPlayers()) do
        if p ~= localp then
            local name = p.Name:lower()
            local display = p.DisplayName:lower()

            if name:sub(1, #arg) == arg or display:sub(1, #arg) == arg then
                if found and found ~= p then
                    return nil, 'Multiple Players Match "' .. arg .. '"'
                end
                found = p
            end
        end
    end
    
    if found then
        if whitelisted[found] then
            notify('Info', 'This Player Is Whitelisted', 5)
            return
        end
    end

    return found, found and nil or 'Player "' .. arg .. '" Not Found'
end

local function arrest(arg)
    local player, err = findpl(arg)

    if not player then
        notify('Arrest', err, 5)
        return
    end

    local ch = player.Character
    local target = ch and ch:FindFirstChild('HumanoidRootPart')

    if not target then
        notify('Arrest', 'Target Character Not Found', 5)
        return
    end

    local event = storage.Remotes.ArrestPlayer
    local hp = gethp()
    local ch1 = getch()
    
    if ch:FindFirstChild('ForceField') then
        notify('Arrest', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    
    local og = hp.CFrame
    
    if not ch1:FindFirstChild('Handcuffs') then
        if not localp.Backpack:FindFirstChild('Handcuffs') then
            notify('Must Be In Guards Team!')
            return
        end
        localp.Backpack.Handcuffs.Parent = ch1
    end

    for i = 1, 15 do
        if not target.Parent or not ch.Parent then
            break
        end

        hp.CFrame = target.CFrame
        event:InvokeServer(player, 1)
    end
    
    hp.CFrame = og
end

local function kill(arg)
    local player, err = findpl(arg)
    if not player then
        notify('Kill', err, 5)
        return
    end
    
    local ch = player.Character
    local target = ch:FindFirstChild('HumanoidRootPart')
    if not target then
        notify('Kill', 'Target Character Not Found', 5)
        return
    end
    
    if ch:FindFirstChild('ForceField') then
        notify('Kill', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    
    local ch1 = getch()
    
    if ch1:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch1:FindFirstChild('ForceField')
    end
    
    local hp = gethp()
    local hm = gethm()
    local og = hp.CFrame
    
    local hm = gethm()
    local anim = Instance.new('Animation')
    anim.AnimationId = 'rbxassetid://279229192'
    anim.Name = 'HelperAnim'
    anim.Parent = hm
    local track = hm:LoadAnimation(anim)
    track:Play()
    
    local Event = storage.meleeEvent
    repeat
        if hm.Health == 0 then
            task.wait(players.RespawnTime)
            kill(arg)
        end
        cam.CameraSubject = ch.Humanoid
        hp.CFrame = target.CFrame * CFrame.new(0, -3, 0)
        Event:FireServer(
            player,
            1,
            1
        )
        task.wait()
    until ch.Humanoid.Health == 0
    for _, trac in pairs(gethm():GetPlayingAnimationTracks()) do
        trac:Stop()
    end
    hp.CFrame = og
    cam.CameraSubject = gethm()
end

local infjumpconn;

local function infjump()
    if not infjumpbool then
        infjumpbool = true
    end

    if infjumpconn then
        infjumpconn:Disconnect()
        infjumpconn = nil
    end
    
    infjumpconn = input.JumpRequest:Connect(function()
        if not infjumpbool then return end
        local hm = gethm()
        if hm and hm.Health > 0 then
            hm:ChangeState(Enum.HumanoidStateType.Jumping)
        else
            infjumpbool = false
        end
    end)
end

local function car()
    local ch = getch()
    local hp = gethp()
    local hm = gethm()
    local og = hp.CFrame
    local cf = CFrame.new(624, 98, 2495)
    local Event = storage.Remotes.InteractWithItem

    for _, v in pairs(workspace.CarContainer:GetChildren()) do
        if v.Name == "Squads" then
            v:Destroy()
        end
    end

    hp.CFrame = cf
    task.wait(0.2)

    Event:InvokeServer(
        workspace.Prison_ITEMS.buttons:GetChildren()[4]["Car Spawner"]
    )

    local cars = workspace.CarContainer
    local carModel = cars:WaitForChild("Squad")
    local body = carModel:WaitForChild("Body")

    task.wait(0.5)

    local seat = carModel:FindFirstChildWhichIsA("VehicleSeat", true) or carModel:FindFirstChildWhichIsA("Seat", true)

    if seat then
        hp.CFrame = seat.CFrame * CFrame.new(0,0,-2)
        task.wait(0.5)
    else
        notify("Car", "No seat found", 5)
        task.wait(1)
        return
    end

    local parts = {}

    for _, v in pairs(body:GetDescendants()) do
        if v:IsA("BasePart") then
            table.insert(parts, v)
        end
    end

    if #parts == 0 then
        notify("Car", "No car parts found", 5)
        hp.CFrame = og
        return
    end

    for _, v in pairs(parts) do
        if v ~= hp then
            v.CFrame = og * CFrame.new(0, 5, 0)
        end
    end
    
    task.wait(0.1)
    
    for _, v in pairs(carModel.Wheels:GetChildren()) do
        v.CFrame = body.Main.CFrame
    end

    task.wait(0.2)
    hp.CFrame = og
    
    for i = 1, 50 do
        seat:Sit(hm)
        task.wait()
    end
end

local function kickhelper(hum)
    return hum.SeatPart:IsA('VehicleSeat')
end

local function antisit(bool)
    if not bool then
        antisitconn:Disconnect()
    end
    
    local hm = gethm()
    
    antisitconn = run.Heartbeat:Connect(function()
        if hm and hm.Sit then
            hm.Sit = false
            hm:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end)
end

local function kick(arg)
    local player, err = findpl(arg)

    if not player then
        notify('Kick', err, 5)
        return
    end
    
    local ch1 = player.Character
    local hm1 = ch1.Humanoid
    
    local bool = kickhelper(hm1)
    
    if not bool then
        notify('Kick', 'Player Is Not In A Car', 5)
        return
    end
    
    local ch = getch()
    local hp = gethp()
    local hp1 = ch1.HumanoidRootPart
    local og = hp.CFrame
    local og1 = hp.Velocity
    hp.Velocity = Vector3.new(0,10000,0)
    task.wait()
    antisit(true)
    for i = 1,50 do
        hp.CFrame = hp1.CFrame * CFrame.new(1,-1,1)
        task.wait()
    end
    task.wait()
    hp.CFrame = og
    hp.Velocity = og1
    antisit(false)
end

local function goto(arg)
    local player, err = findpl(arg)

    if not player then
        notify('Teleport', err, 5)
        return
    end
    
    if not player.Character then
        notify('Teleport', 'Character Not Found', 5)
        return
    end
    
    if not player.Character:FindFirstChild('HumanoidRootPart') then
        notify('Teleport', 'HumanoidRootPart Not Found', 5)
        return
    end
    
    local ch = getch()
    local hp = gethp()
    
    local ch1 = player.Character
    local hp1 = ch1.HumanoidRootPart
    
    hp.CFrame = hp1.CFrame
end

local function hammer()
    if not workspace:FindFirstChild('Hammer') then
        notify('Hammer', 'Please Wait For It To Spawn', 5)
        repeat
            task.wait(0.1)
        until workspace:FindFirstChild('Hammer')
    end
    
    local item = workspace:FindFirstChild('Hammer').ITEMPICKUP
    local cf = item.CFrame
    local Event = storage.Remotes.GiverPressed
    
    local hp = gethp()
    local og = hp.CFrame
    
    local pack = localp.Backpack
    
    while true do
        hp.CFrame = cf
        Event:FireServer(workspace.Hammer)
        if pack:FindFirstChild('Hammer') then
            break
        end
        task.wait()
    end
    
    hp.CFrame = og
end

local function knife()
    if not workspace:FindFirstChild('Crude Knife') then
        notify('Crude Knife', 'Please Wait For It To Spawn', 5)
        repeat
            task.wait(0.1)
        until workspace:FindFirstChild('Crude Knife')
    end
    
    local item = workspace:FindFirstChild('Crude Knife').ITEMPICKUP
    local cf = item.CFrame
    local Event = storage.Remotes.GiverPressed
    
    local hp = gethp()
    local og = hp.CFrame
    
    local pack = localp.Backpack
    
    while true do
        hp.CFrame = cf
        Event:FireServer(workspace['Crude Knife'])
        if pack:FindFirstChild('Crude Knife') then
            break
        end
        task.wait()
    end
    
    hp.CFrame = og
end

local function loopk(arg)
    while loopkill do
        local player, err = findpl(arg)
        if not player then
            notify('Kill', err, 5)
            return
        end
        
        if not player.Character then
            repeat task.wait(0.1) until player.Character
        end
        
        if not player.Character:FindFirstChild('HumanoidRootPart') then
            repeat task.wait(0.1) until target
        end
        
        if not player.Character.Humanoid then
            repeat task.wait(0.1) until player.Character:FindFirstChildOfClass('Humanoid')
        end
        
        local og = gethp().CFrame
        
        local anim = Instance.new('Animation')
        anim.AnimationId = 'rbxassetid://279229192'
        anim.Name = 'HelperAnim'
        anim.Parent = gethm()
        local track = gethm():LoadAnimation(anim)
        track:Play()
        
        local Event = storage.meleeEvent
        repeat
            if gethm().Health == 0 then
                task.wait(players.RespawnTime)
            end
            if not player.Character.Humanoid then
                repeat task.wait(0.1) until player.Character:FindFirstChildOfClass('Humanoid')
            end
            cam.CameraSubject = player.Character.Humanoid
            gethp().CFrame = player.Character:WaitForChild('HumanoidRootPart').CFrame * CFrame.new(0, -3, 0)
            Event:FireServer(
                player,
                1,
                1
            )
            task.wait()
        until player.Character:WaitForChild('Humanoid').Health == 0
        for _, trac in pairs(gethm():GetPlayingAnimationTracks()) do
            trac:Stop()
        end
        gethp().CFrame = og
        cam.CameraSubject = gethm()
    end
end

local function getb()
    local bomb = workspace.Prison_ITEMS.giver["C4 Explosive"].Explosive
    local og = gethp().CFrame
    local args = {workspace:WaitForChild("Prison_ITEMS"):WaitForChild("giver"):WaitForChild("C4 Explosive"):WaitForChild("Handle")}
    repeat
        gethp().CFrame = bomb.CFrame * CFrame.new(0,0,5) * CFrame.Angles(math.rad(90),0,0)
        storage:WaitForChild("Remotes"):WaitForChild("InteractWithItem"):InvokeServer(unpack(args))
        task.wait(0.1)
    until localp.Backpack:FindFirstChild('C4 Explosive')
    task.wait(0.1)
    gethp().CFrame = og
end

local function getf()
    local fal = workspace.Prison_ITEMS.giver.FAL.Handle
    local og = gethp().CFrame
    local Event = storage.Remotes.InteractWithItem
    
    repeat
        gethp().CFrame = fal.CFrame * CFrame.new(0,0,5) * CFrame.Angles(math.rad(90),0,0)
        Event:InvokeServer(workspace.Prison_ITEMS.giver.FAL.Union)
        task.wait(0.1)
    until localp.Backpack:FindFirstChild('FAL')
    task.wait(0.1)
    gethp().CFrame = og
end

local function armory()
    local ch = getch()
    if ch:FindFirstChild('ForceField') then
        notify('Teleport', 'Please Wait For ForceField To Expire', 5)
        repeat task.wait(0.1) until not ch:FindFirstChild('ForceField')
    end
    local hp = gethp()
    local cf = CFrame.new(829, 100, 2244)
    hp.CFrame = cf
end

local esp = {}
local espbool = false
local espconn
local espadded = {}

local function espcolor(plr)
    return plr.Team and plr.Team.TeamColor.Color or plr.TeamColor.Color
end

local function removeesp(plr)
    local d = esp[plr]
    if d then
        if d.highlight then d.highlight:Destroy() end
        if d.billboard then d.billboard:Destroy() end
        esp[plr] = nil
    end
end

local function createesp(plr)
    removeesp(plr)

    if not espbool or plr == localp then return end

    local ch = plr.Character
    if not ch then return end

    local hm = ch:FindFirstChildOfClass("Humanoid")
    local head = ch:FindFirstChild("Head")
    if not hm or not head then return end

    local color = espcolor(plr)

    local hl = Instance.new("Highlight")
    hl.Name = "PlayerESP"
    hl.Adornee = ch
    hl.FillColor = color
    hl.OutlineColor = color
    hl.FillTransparency = 0.45
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = gui

    local bb = Instance.new("BillboardGui")
    bb.Name = "PlayerESPInfo"
    bb.Adornee = head
    bb.Size = UDim2.fromOffset(200, 76)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 2500
    bb.Parent = plr.Character

    local txt = Instance.new("TextLabel")
    txt.Name = "Info"
    txt.Size = UDim2.fromScale(1, 1)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.GothamBold
    txt.TextSize = 13
    txt.TextColor3 = color
    txt.TextStrokeColor3 = Color3.new(0, 0, 0)
    txt.TextStrokeTransparency = 0.15
    txt.TextWrapped = true
    txt.Parent = bb

    esp[plr] = {
        highlight = hl,
        billboard = bb,
        text = txt,
        character = ch
    }
end

local function updateesp()
    if not espbool then return end

    local ch = localp.Character
    local root = ch and ch:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for plr, d in pairs(esp) do
        local target = plr.Character
        local tr = target and target:FindFirstChild("HumanoidRootPart")
        local hm = target and target:FindFirstChildOfClass("Humanoid")
        local head = target and target:FindFirstChild("Head")

        if not target or target ~= d.character or not tr or not hm or not head then
            createesp(plr)
        else
            local color = espcolor(plr)
            local dist = math.floor((root.Position - tr.Position).Magnitude)
            local hp = math.max(0, math.floor(hm.Health))
            local maxhp = math.floor(hm.MaxHealth)
            local teamname = plr.Team and plr.Team.Name or "Neutral"

            d.highlight.FillColor = color
            d.highlight.OutlineColor = color
            d.billboard.Adornee = head
            d.text.TextColor3 = color
            d.text.Text = string.format(
                "%s Health: %d",
                plr.DisplayName,
                hp
            )
        end
    end
end

local function setupesp(plr)
    if plr == localp or espadded[plr] then return end
    espadded[plr] = true

    plr.CharacterAdded:Connect(function()
        if espbool then
            task.wait(0.5)
            createesp(plr)
        end
    end)

    plr.CharacterRemoving:Connect(function()
        removeesp(plr)
    end)

    if espbool and plr.Character then
        createesp(plr)
    end
end

local function espstart()
    if espbool then return end
    espbool = true

    for _, plr in ipairs(players:GetPlayers()) do
        setupesp(plr)
        createesp(plr)
    end

    espconn = run.Heartbeat:Connect(updateesp)
end

local function espstop()
    espbool = false

    if espconn then
        espconn:Disconnect()
        espconn = nil
    end

    for plr in pairs(esp) do
        removeesp(plr)
    end
end

players.PlayerAdded:Connect(function(plr)
    setupesp(plr)
    if espbool then
        createesp(plr)
    end
end)

players.PlayerRemoving:Connect(function(plr)
    removeesp(plr)
    espadded[plr] = nil
end)

local prefix = ";"
local cmds = {
	"cmds",
	"goto <player name> / to <player name>",
	"noclip / unnoclip / clip",
	"infstamina / infstam",
	"criminal / crim",
	"autorespawn / autore / unautore",
	"ak47",
    "remington / rem",
    "autoguns / unautoguns",
    "hammer",
    "knife",
    "bomb (mafia gamepass or else u get bugged)",
    "fal (mafia gamepass or else u get bugged)",
	"base",
    "yard",
    "prison",
    "cafeteria / caf",
    "tower",
    "armory",
	"removedoors / rdoors",
	"arrest <player name> (shortcut names supported)",
	"infjump / uninfjump",
	"kick <player name> (broken) (shortcut names supported)",
	"bring <player name> (soon maybe)",
	"kill <player name> (shortcut names supported)",
	"loopkill <player name> (shortcut names supported)",
	"unloopkill <player name> (shortcut names supported)",
	"car (must not be in prison)",
	"walkspeed <number> / speed <number>",
	"jumppower <number> / jumpp <number>",
	"esp",
    "unesp",
}

local gui=Instance.new("ScreenGui")
gui.Name="CommandBar"
gui.ResetOnSpawn=false
gui.Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local btn=Instance.new("TextButton")
btn.Name="MenuButton"
btn.Size=UDim2.new(0,58,0,48)
btn.Position=UDim2.new(0.112,0,1,-84)
btn.BackgroundColor3=Color3.fromRGB(95,95,95)
btn.BackgroundTransparency=0.08
btn.Text=""
btn.AutoButtonColor=true
btn.Parent=gui

btn.BackgroundColor3 = Color3.new(1, 1, 1)
btn.BackgroundTransparency = 0

local bg1 = Instance.new("UIGradient")
bg1.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 75, 75))
})
bg1.Rotation = 0
bg1.Parent = btn

local bc=Instance.new("UICorner")
bc.CornerRadius=UDim.new(0,10)
bc.Parent=btn

local bs=Instance.new("UIStroke")
bs.Color=Color3.fromRGB(45,45,45)
bs.Thickness=2
bs.Parent=btn

local logo=Instance.new("ImageLabel")
logo.Name="TermuxLogo"
logo.Size=UDim2.new(0,36,0,36)
logo.Position=UDim2.new(0.5,-18,0.5,-18)
logo.BackgroundTransparency=1
logo.Image = "rbxassetid://131890774532975"
logo.ScaleType=Enum.ScaleType.Fit
logo.Parent=btn

local bar=Instance.new("TextBox")
bar.Name="CommandInput"
bar.Size=UDim2.new(0.6,0,0,48)
bar.Position=UDim2.new(0.112,70,1,-84)
bar.BackgroundColor3=Color3.fromRGB(105,105,105)
bar.BackgroundTransparency=0.05
bar.Text=""
bar.PlaceholderText="Command bar"
bar.PlaceholderColor3=Color3.fromRGB(205,205,205)
bar.TextColor3=Color3.fromRGB(255,255,255)
bar.TextSize=19
bar.Font=Enum.Font.Gotham
bar.ClearTextOnFocus=false
bar.TextXAlignment=Enum.TextXAlignment.Center
bar.Parent=gui

bar.BackgroundColor3 = Color3.new(1, 1, 1)
bar.BackgroundTransparency = 0

local bg2 = Instance.new("UIGradient")
bg2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 75, 75)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(235, 235, 235))
})
bg2.Rotation = 0
bg2.Parent = bar

bar.TextColor3 = Color3.fromRGB(255, 255, 255)
bar.PlaceholderColor3 = Color3.fromRGB(230, 230, 230)

local cr=Instance.new("UICorner")
cr.CornerRadius=UDim.new(0,10)
cr.Parent=bar

local st=Instance.new("UIStroke")
st.Color=Color3.fromRGB(45,45,45)
st.Thickness=2
st.Parent=bar

local menu = Instance.new("Frame")
menu.Name = "CommandsMenu"
menu.Size = UDim2.new(0.78, 0, 0.62, 0)
menu.Position = UDim2.new(0.11, 0, 0.19, 0)
menu.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Parent = gui

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = menu

local ms = Instance.new("UIStroke")
ms.Color = Color3.fromRGB(75, 75, 75)
ms.Thickness = 2
ms.Parent = menu

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -55, 0, 45)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Commands"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = menu

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 38, 0, 35)
close.Position = UDim2.new(1, -45, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = menu

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 8)
cc.Parent = close

local list = Instance.new("ScrollingFrame")
list.Name = "CommandList"
list.Size = UDim2.new(1, -20, 1, -58)
list.Position = UDim2.new(0, 10, 0, 50)
list.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.Parent = menu

local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(0, 8)
lc.Parent = list

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 8)
pad.PaddingLeft = UDim.new(0, 8)
pad.PaddingRight = UDim.new(0, 8)
pad.Parent = list

for i, command in ipairs(cmds) do
    local item = Instance.new("TextButton")
    item.Name = "Command" .. i
    item.Size = UDim2.new(1, -5, 0, 36)
    item.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
    item.BorderSizePixel = 0
    item.Text = "  " .. command
    item.TextColor3 = Color3.fromRGB(230, 230, 230)
    item.TextSize = 13
    item.Font = Enum.Font.Gotham
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.TextWrapped = true
    item.LayoutOrder = i
    item.Parent = list

    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 6)
    ic.Parent = item

    item.MouseButton1Click:Connect(function()
        local cmd = command:match("^(.-)%s+/") or command
        cmd = cmd:match("^[^%(]+") or cmd
        cmd = cmd:gsub("%s+$", "")

        bar.Text = ";" .. cmd .. " "
        bar:CaptureFocus()
        bar.CursorPosition = #bar.Text + 1
    end)
end

btn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

close.MouseButton1Click:Connect(function()
    menu.Visible = false
end)

local function runcommand(msg, frombar)
    msg = msg:lower():match("^%s*(.-)%s*$")
    
    local pfx = msg:sub(1, 1)
    if not frombar and not (
        pfx == ":" or pfx == ";" or pfx == "!" or
        pfx == "?" or pfx == "/" or pfx == "."
    ) then
        return
    end
 
    if pfx == ":" or pfx == ";" or pfx == "!" or
       pfx == "?" or pfx == "/" or pfx == "." then
        msg = msg:sub(2):match("^%s*(.-)%s*$")
    end

    local cmd, arg = msg:match("^(%S+)%s*(.-)$")
    if not cmd then
        return
    end

    if cmd == "cmds" then
        for i, v in ipairs(cmds) do
            print(i, v)
        end
    elseif cmd == "noclip" then
        task.spawn(noclip)
    elseif cmd == "unnoclip" or cmd == "clip" then
        unnoclip()
    elseif cmd == "infstamina" or cmd == "infstam" then
        task.spawn(infstam)
    elseif cmd == "criminal" or cmd == "crim" then
        crim()
    elseif cmd == "autorespawn" or cmd == "autore" then
        task.spawn(autore)
    elseif cmd == "unautore" then
        autorebool = false
    elseif cmd == "ak47" then
        task.spawn(ak47)
    elseif cmd == "remington" or cmd == "rem" then
        task.spawn(shotgun)
    elseif cmd == "autoguns" then
        task.spawn(autog)
    elseif cmd == "unautoguns" then
        autogbool = false
    elseif cmd == "hammer" then
        task.spawn(hammer)
    elseif cmd == "knife" then
        task.spawn(knife)
    elseif cmd == "bomb" then
        task.spawn(getb)
    elseif cmd == "fal" then
        task.spawn(getf)
    elseif cmd == "base" then
        base()
    elseif cmd == "yard" then
        yard()
    elseif cmd == "prison" then
        prison()
    elseif cmd == "caf" or cmd == "cafeteria" then
        cafeteria()
    elseif cmd == "tower" then
        tower()
    elseif cmd == "armory" then
        armory()
    elseif cmd == "removedoors" or cmd == "rdoors" then
        rdoors()
    elseif cmd == "infjump" then
        infjump()
    elseif cmd == "uninfjump" then
        infjumpbool = false
    elseif cmd == "car" then
        task.spawn(car)
    elseif cmd == "goto" or cmd == "to" then
        if arg ~= "" then
            goto(arg)
        end
    elseif cmd == "esp" then
        espstart()
    elseif cmd == "unesp" then
        espstop()
    elseif cmd == "arrest" and arg ~= "" then
        task.spawn(arrest, arg)
    elseif cmd == "kill" and arg ~= "" then
        task.spawn(kill, arg)
    elseif cmd == "loopkill" and arg ~= "" then
        loopkill = true
        task.spawn(loopk, arg)
    elseif cmd == "unloopkill" then
        loopkill = false
    elseif cmd == "kick" and arg ~= "" then
        task.spawn(kick, arg)
    elseif cmd == "walkspeed" or cmd == "speed" then
        local n = tonumber(arg)
        if n then
            gethm().WalkSpeed = n
        end
    elseif cmd == "jumppower" or cmd == "jumpp" then
        local n = tonumber(arg)
        if n then
            gethm().JumpPower = n
        end
    end
end

localp.Chatted:Connect(function(msg)
    runcommand(msg)
end)

bar.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local msg = bar.Text
        bar.Text = ""
        runcommand(msg, true)
    end
end)

task.spawn(function()
    task.wait(1)
    pcall(function()
        gets("StarterGui"):SetCore("SendNotification", {
            Title = "Info",
            Text  = "Say ;cmds or open up command bar (prefix . : ; ! ? /)",
            Duration = 10
        })
    end)
end)
