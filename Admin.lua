-- Made by feariosz0 in discord, beta version v1.0.0

local noclipbool = false
local infstambool = false
local autorebool = false
local autogbool = false
local infjumpbool = false

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

    while task.wait() do
        gethp().CFrame = CFrame.new(-929, 97, 2056)
        helper()
        task.wait(0.1)
        hp.CFrame = cf
        hm:ChangeState(Enum.HumanoidStateType.Jumping)
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

    while task.wait() do
        gethp().CFrame = CFrame.new(-929, 97, 2056)
        helper()
        task.wait(0.1)
        hp.CFrame = cf
        hm:ChangeState(Enum.HumanoidStateType.Jumping)
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
            gethp().CFrame = CFrame.new(-929, 97, 2056)
            helper()
            task.wait(0.1)
            gethp().CFrame = CFrame.new(-932, 94, 2039)
            hm:ChangeState(Enum.HumanoidStateType.Jumping)

            while not hasgun('AK-47') do
                gethp().CFrame = CFrame.new(-932, 94, 2039)
                task.wait()
            end

            for _, track in pairs(gethm():GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end

        if not hasgun('Remington 870') then
            gethp().CFrame = CFrame.new(-929, 97, 2056)
            helper()
            task.wait(0.1)
            gethp().CFrame = CFrame.new(-939, 94, 2040)
            hm:ChangeState(Enum.HumanoidStateType.Jumping)

            while not hasgun('Remington 870') do
                gethp().CFrame = CFrame.new(-939, 94, 2040)
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

    for i = 1, 10 do
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
    local og = hp.CFrame
    
    local Event = storage.meleeEvent
    repeat
        cam.CameraSubject = ch.Humanoid
        hp.CFrame = target.CFrame * CFrame.new(0, -4, 0)
        Event:FireServer(
            player,
            1,
            1
        )
        task.wait()
    until ch.Humanoid.Health == 0
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
        v:Destroy()
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

    local seat = carModel:FindFirstChildWhichIsA("VehicleSeat", true)
        or carModel:FindFirstChildWhichIsA("Seat", true)

    if seat then
        hp.CFrame = seat.CFrame
        task.wait(0.5)

        seat:Sit(hm)
        task.wait(1.5)
    else
        notify("Car", "No seat found; welding anyway", 5)
        task.wait(1)
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
            v.Anchored = false
            v.CanCollide = false

            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hp
            weld.Part1 = v
            weld.Parent = hp
        end
    end

    task.wait(0.2)
    hp.CFrame = og
    hm:ChangeState(Enum.HumanoidStateType.Jumping)
end

local prefix;
local cmds = {
	"cmds",
	"noclip / unnoclip / clip",
	"infstamina / infstam",
	"criminal / crim",
	"autorespawn / autore",
	"ak47 / remington / rem / autoguns",
	"base / yard / prison / cafeteria / caf / tower",
	"removedoors / rdoors",
	"arrest <player name> (shortcut names supported)",
	"infjump / uninfjump",
	"kick <player name> (soon)",
	"bring <player name> (soon)",
	"kill <player name>",
	"car (broken)",
}

localp.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg:find(':') then prefix=':' end
    if msg:find(';') then prefix=';' end
    if msg:find('!') then prefix='!' end
    if msg:find('?') then prefix='?' end
    if msg:find('/') then prefix='/' end
    if msg:find(prefix..'cmds') then
        for i,v in pairs(cmds) do
            print(i,v)
        end
        notify("Commands",
            "Check by typing /console in chat or press F9",
            10
        )
    end
    if msg:find(prefix..'noclip') then
        noclip()
    elseif msg:find(prefix..'unnoclip') then
        unnoclip()
    elseif msg:find(prefix..'clip') then
        unnoclip()
    elseif msg:find(prefix..'infstamina') then
        infstam()
    elseif msg:find(prefix..'infstam') then
        infstam()
    elseif msg:find(prefix..'criminal') then
        crim()
    elseif msg:find(prefix..'crim') then
        crim()
    elseif msg:find(prefix..'autorespawn') then
        autore()
    elseif msg:find(prefix..'autore') then
        autore()
    elseif msg:find(prefix..'ak47') then
        ak47()
    elseif msg:find(prefix..'remington') then
        shotgun()
    elseif msg:find(prefix..'autoguns') then
        autog()
    elseif msg:find(prefix..'rem') then
        shotgun()
    elseif msg:find(prefix..'base') then
        base()
    elseif msg:find(prefix..'yard') then
        yard()
    elseif msg:find(prefix..'prison') then
        prison()
    elseif msg:find(prefix..'caf') then
        cafeteria()
    elseif msg:find(prefix..'cafeteria') then
        cafeteria()
    elseif msg:find(prefix..'tower') then
        tower()
    elseif msg:find(prefix..'removedoors') then
        rdoors()
    elseif msg:find(prefix..'rdoors') then
        rdoors()
    elseif msg:find(prefix..'uninfjump') then
        infjumpbool = false
    elseif msg:find(prefix..'infjump') then
        infjump()
    elseif msg:find(prefix..'car') then
        car()
    end
    local arg = msg:match('^' .. prefix .. 'arrest%s+(.+)$')
    if arg then
        arrest(arg)
    end
    local arg1 = msg:match('^' .. prefix .. 'kill%s+(.+)$')
    if arg1 then
        kill(arg1)
    end
end)

gui:SetCore("SendNotification", {
    Title = "Info",
    Text = "Say ;cmds (prefix : ; ! ? /)",
    Icon = "rbxassetid://123456789",
    Duration = 10
})
