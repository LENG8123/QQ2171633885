local ULlib = loadstring(game:HttpGet("https://github.com/AURORA666Script/ui/raw/main/kinghub.txt"))()

local lib = loadstring(game:HttpGet("https://github.com/AURORA666Script/ui/raw/main/vapeui.txt"))()
local OpenUI = Instance.new("ScreenGui")
local TextButton = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner") 
local UIColor = Instance.new("UIGradient")
OpenUI.Name = "OpenUI" 
OpenUI.Parent = game.CoreGui 
OpenUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
TextButton.Parent = OpenUI 
TextButton.BackgroundColor3 = Color3.fromRGB(5, 6, 7)
TextButton.BackgroundTransparency = 0.5
TextButton.Position = UDim2.new(0.0235790554, 0, 0.466334164, 0) 
TextButton.Size = UDim2.new(0, 50, 0, 50)
TextButton.Text = ""
TextButton.Draggable = true
TextLabel.Parent = TextButton
TextLabel.BackgroundColor3 = Color3.fromRGB(5, 6, 7)
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 0, 0, 0)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Font = Enum.Font.GothamSemibold
TextLabel.Text = "冷脚本"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14
TextLabel.TextXAlignment = Enum.TextXAlignment.Center
TextLabel.TextYAlignment = Enum.TextYAlignment.Center
UICorner.CornerRadius = UDim.new(1, 0) 
UICorner.Parent = TextButton
UIColor.Rotation = 45
UIColor.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
}
UIColor.Parent = TextLabel
TextButton.MouseButton1Click:Connect(function() 
  if uihide == false then
	uihide = true
	game.CoreGui.ui.Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)
else
	uihide = false
	game.CoreGui.ui.Main:TweenSize(UDim2.new(0, 560, 0, 319),"Out","Quad",0.4,true)
		end 
		
end)

uihide = false

local win = ULlib:Window("冷脚本 | 压力",Color3.fromRGB(204, 0, 0), Enum.KeyCode.RightControl)

local tab = win:Tab("主要功能")
local tab2 = win:Tab("自动躲")
local tab3 = win:Tab("ESP")

tab:Button("自动互动", "Hello!", function()
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local INTERACT_PROMPT_TAG = "InteractPromptTag"

for _, descendant in ipairs(workspace:GetDescendants()) do
    if descendant:IsA("ProximityPrompt") then
        CollectionService:AddTag(descendant, INTERACT_PROMPT_TAG)
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        CollectionService:AddTag(descendant, INTERACT_PROMPT_TAG)
    end
end)

local function shouldTriggerPrompt(prompt)
    local parent = prompt.Parent
    local parentName = parent and parent.Name
    local grandParent = parent and parent.Parent
    local grandParentName = grandParent and grandParent.Name
    local greatGrandParent = grandParent and grandParent.Parent
    local greatGrandParentName = greatGrandParent and greatGrandParent.Name

    if parentName == "MonsterLocker" or parentName == "Door" or parentName == "HighLight" then
        return false
    end
    if grandParentName == "EncounterGenerator" or grandParentName == "Generator" or grandParentName == "RotShop" then
        return false
    end
    if greatGrandParentName == "puzzle" or greatGrandParentName == "Shop" or greatGrandParentName == "ShopSpawn" or greatGrandParentName == "TricksterDoor" then
        return false
    end

    return parentName ~= "Locker"
end

local function triggerPrompt(prompt)
    if shouldTriggerPrompt(prompt) then
        fireproximityprompt(prompt)
    end
end

local function getDistance(prompt)
    local player = Players.LocalPlayer
    local character = player and player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if rootPart and prompt.Parent and prompt.Parent:IsA("BasePart") then
        return (rootPart.Position - prompt.Parent.Position).Magnitude
    end
    return math.huge
end

local function mainLoop()
    local taggedPrompts = CollectionService:GetTagged(INTERACT_PROMPT_TAG)
    local prompts = {}

    for _, prompt in ipairs(taggedPrompts) do
        local distance = getDistance(prompt)
        if distance ~= math.huge then
            table.insert(prompts, {prompt = prompt, distance = distance})
        end
    end

    table.sort(prompts, function(a, b) return a.distance < b.distance end)

    for _, promptData in ipairs(prompts) do
        coroutine.wrap(triggerPrompt)(promptData.prompt)
    end
end

local lastUpdate = 0
local updateInterval = 1/10

RunService.Heartbeat:Connect(function(deltaTime)
    lastUpdate = lastUpdate + deltaTime
    if lastUpdate >= updateInterval then
        lastUpdate = lastUpdate - updateInterval
        mainLoop()
    end
end)
end)

tab:Button("装备100个门卡", "注意手上！", function()

local function performTask()
local args = {
    [1] = "NormalKeyCard"
}

game:GetService("ReplicatedStorage").Events.Equip:FireServer(unpack(args))
end

local function executeTasksInFrame(numTasks)
    for i = 1, numTasks do
        performTask()
    end
end

executeTasksInFrame(100)
end)

tab:Button("删除和触发而免疫", "Hello!", function()
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local objectsToDelete = {
    "EyefestationSpawn",
    "DesiredLocation",
    "Steam1",
    "Steam2",
    "Steam3",
    "Pandemonium",
    "Electricity",
    "BlockPart",
    "Steam",
    "Smoke"
}

local function deleteObject(obj)
    if obj and table.find(objectsToDelete, obj.Name) then
        RunService.Heartbeat:Wait()
        obj:Destroy()
    end
    
    if obj:IsA("RemoteEvent") and obj.Parent and obj.Parent.Name == "MainSearchlight" then
        RunService.Heartbeat:Wait()
        obj:Destroy()
    end
end

local function triggerRemoveParts(obj)
    if obj.Name == "RemoveParts" and obj.Parent and obj.Parent.Name == "Trickster" then
        obj:FireServer()
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    deleteObject(descendant)
    triggerRemoveParts(descendant)
end)

for _, obj in ipairs(workspace:GetDescendants()) do
    deleteObject(obj)
    triggerRemoveParts(obj)
end
end)

tab:Button("免疫", "触发进柜子的远程事件而免疫大部分怪物搭配那个删除和触发的而免疫Z-367", function()
for _, room in pairs(workspace.Rooms:GetChildren()) do
    room.Locker.Folder.Enter:InvokeServer()
end
end)

tab:Toggle("自动互动2","Toggle",false,function(Value)
        Jump = Value
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local INTERACT_PROMPT_TAG = "InteractPromptTag"
local TRIGGER_INTERVAL = 0.1
local PROCESS_TIME_BUDGET = 0.005

local prompts = {}
local promptQueue = {}
local lastTriggerTime = {}
local excludedParents = {
    MonsterLocker = true, Door = true, HighLight = true, Locker = true,
    EncounterGenerator = true, Generator = true, RotShop = true,
    puzzle = true, Shop = true, ShopSpawn = true, TricksterDoor = true,
    LockerUnderwater = true
}

local function isValidPrompt(prompt)
    local parent = prompt.Parent
    if not parent then return false end
    if excludedParents[parent.Name] then return false end
    local grandParent = parent.Parent
    if grandParent and excludedParents[grandParent.Name] then return false end
    local greatGrandParent = grandParent and grandParent.Parent
    if greatGrandParent and excludedParents[greatGrandParent.Name] then return false end
    return true
end

local function addPrompt(prompt)
    if prompt:IsA("ProximityPrompt") and isValidPrompt(prompt) then
        prompts[prompt] = true
        CollectionService:AddTag(prompt, INTERACT_PROMPT_TAG)
        table.insert(promptQueue, prompt)
    end
end

local function removePrompt(prompt)
    prompts[prompt] = nil
    lastTriggerTime[prompt] = nil
    for i, queuedPrompt in ipairs(promptQueue) do
        if queuedPrompt == prompt then
            table.remove(promptQueue, i)
            break
        end
    end
end

for _, descendant in ipairs(workspace:GetDescendants()) do
    addPrompt(descendant)
end

workspace.DescendantAdded:Connect(addPrompt)
workspace.DescendantRemoving:Connect(removePrompt)

local function processPrompts()
    local startTime = tick()
    local promptsProcessed = 0
    
    while tick() - startTime < PROCESS_TIME_BUDGET and #promptQueue > 0 do
        local prompt = table.remove(promptQueue, 1)
        local currentTime = tick()
        
        if prompts[prompt] and (not lastTriggerTime[prompt] or currentTime - lastTriggerTime[prompt] >= TRIGGER_INTERVAL) then
            task.spawn(function()
                pcall(fireproximityprompt, prompt)
            end)
            lastTriggerTime[prompt] = currentTime
            promptsProcessed = promptsProcessed + 1
        end
        
        table.insert(promptQueue, prompt)
    end
    
    return promptsProcessed
end

RunService.Heartbeat:Connect(function()
    processPrompts()
end)
end)

tab:Button("自动修电箱", "Hello!", function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function monitorGenerators(generatorName)
    for _, room in pairs(workspace.Rooms:GetChildren()) do
        local interactables = room:FindFirstChild("Interactables")
        
        if interactables then
            for _, generator in pairs(interactables:GetChildren()) do
                if generator.Name == generatorName and generator:FindFirstChild("Fixed") and generator:FindFirstChild("RemoteFunction") and generator:FindFirstChild("RemoteEvent") then
                    local proximityPrompt = generator.ProxyPart:FindFirstChild("ProximityPrompt")
                    
                    generator.RemoteFunction:InvokeServer()

                    spawn(function()
                        while true do
                            local distance = (character.PrimaryPart.Position - generator.ProxyPart.Position).Magnitude

                            if distance <= proximityPrompt.MaxActivationDistance and generator.Fixed.Value < 100 then
                                local args = {
                                    [1] = true
                                }
                                generator.RemoteEvent:FireServer(unpack(args))
                            end

                            wait(0)
                        end
                    end)
                end
            end
        end
    end
end

monitorGenerators("Generator")
monitorGenerators("EncounterGenerator")

workspace.Rooms.ChildAdded:Connect(function()
    monitorGenerators("Generator")
    monitorGenerators("EncounterGenerator")
end)
end)

tab:Toggle("怪物通知","Toggle",false,function(Value)
        Jump = Value
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local DeathFolder = ReplicatedStorage:WaitForChild("DeathFolder")
local monsterNames = {}

for _, folder in ipairs(DeathFolder:GetChildren()) do
    if folder:IsA("Folder") then
        table.insert(monsterNames, folder.Name)
    end
end

local function createNotification(player, message)
    local playerGui = player:WaitForChild("PlayerGui")
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "MonsterNotification"
    notificationGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 50)
    frame.Position = UDim2.new(1, 20, 1, -70)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = notificationGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 1, -10)
    textLabel.Position = UDim2.new(0, 5, 0, 5)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Text = message
    textLabel.Parent = frame

    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, -220, 1, -70)})
    tweenIn:Play()

    task.delay(2, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, 1, -70)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notificationGui:Destroy()
        end)
    end)
end

local function notifyAllPlayers(message)
    for _, player in ipairs(Players:GetPlayers()) do
        createNotification(player, message)
    end
end

game.Workspace.ChildAdded:Connect(function(child)
    if table.find(monsterNames, child.Name) then
        notifyAllPlayers(child.Name .. " 快看！78出现了！")
        
        child.AncestryChanged:Connect(function(_, parent)
            if not parent then
                notifyAllPlayers(child.Name .. " 消失")
            end
        end)
    end
end)
end)

tab:Button("获得魔法书", "需要足够的钱购买", function()
local args = {
    [1] = {
        ["Items"] = {
            ["Book"] = 1
        },
        ["Batteries"] = 0
    }
}

game:GetService("ReplicatedStorage").Events.PreRoundShop:FireServer(unpack(args))
end)

tab:Button("速度增加", "Hello!", function()
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local TextButton_2 = Instance.new("TextButton")
local WalkSpeedControl = Instance.new("TextLabel")
local Close = Instance.new("TextButton")
local Label = Instance.new("TextLabel")
local Open = Instance.new("TextButton")
 
--Properties:
 
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
 
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.BorderSizePixel = 3
Frame.Position = UDim2.new(0.382299274, 0, 0.270377755, 0)
Frame.Size = UDim2.new(0, 257, 0, 231)
Frame.Active = true
Frame.Draggable = true
 
TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
TextButton.BorderSizePixel = 3
TextButton.Position = UDim2.new(0.71206224, 0, 0.63203454, 0)
TextButton.Size = UDim2.new(0, 74, 0, 73)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "+"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 14.000
TextButton.TextWrapped = true
 
TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.33073929, 0, 0.29437235, 0)
TextLabel.Size = UDim2.new(0, 87, 0, 70)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "16"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
 
TextButton_2.Parent = Frame
TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TextButton_2.BorderSizePixel = 3
TextButton_2.Position = UDim2.new(0, 0, 0.63203454, 0)
TextButton_2.Size = UDim2.new(0, 74, 0, 73)
TextButton_2.Font = Enum.Font.SourceSans
TextButton_2.Text = "-"
TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton_2.TextScaled = true
TextButton_2.TextSize = 14.000
TextButton_2.TextWrapped = true
 
WalkSpeedControl.Name = "WalkSpeed Control"
WalkSpeedControl.Parent = Frame
WalkSpeedControl.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
WalkSpeedControl.BorderSizePixel = 3
WalkSpeedControl.Position = UDim2.new(0.000976324081, 0, -0.00234955549, 0)
WalkSpeedControl.Size = UDim2.new(0, 257, 0, 59)
WalkSpeedControl.Font = Enum.Font.Highway
WalkSpeedControl.Text = "Walkspeed Control"
WalkSpeedControl.TextColor3 = Color3.fromRGB(0, 0, 0)
WalkSpeedControl.TextScaled = true
WalkSpeedControl.TextSize = 14.000
WalkSpeedControl.TextWrapped = true
 
Close.Name = "Close"
Close.Parent = Frame
Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Close.Position = UDim2.new(1, 0, -0.0259740278, 0)
Close.Size = UDim2.new(0, 63, 0, 69)
Close.Style = Enum.ButtonStyle.RobloxButtonDefault
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.TextScaled = true
Close.TextSize = 14.000
Close.TextWrapped = true
 
Label.Name = "Label"
Label.Parent = Frame
Label.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Label.BorderColor3 = Color3.fromRGB(27, 42, 53)
Label.BorderSizePixel = 3
Label.Position = UDim2.new(0, 0, 0.99999994, 0)
Label.Size = UDim2.new(0, 257, 0, 50)
Label.Font = Enum.Font.Highway
Label.Text = "Made by Roblox Scripter"
Label.TextColor3 = Color3.fromRGB(0, 0, 0)
Label.TextScaled = true
Label.TextSize = 14.000
Label.TextWrapped = true
 
Open.Name = "Open"
Open.Parent = ScreenGui
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.Position = UDim2.new(-0.00074955821, 0, 0.520874739, 0)
Open.Size = UDim2.new(0, 200, 0, 50)
Open.Style = Enum.ButtonStyle.RobloxButton
Open.Font = Enum.Font.SourceSans
Open.Text = "Open"
Open.TextColor3 = Color3.fromRGB(255, 255, 255)
Open.TextScaled = true
Open.TextSize = 14.000
Open.TextWrapped = true
 
-- Scripts:
 
local function QDTZQ_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)
 
	local label = script.Parent.Parent.TextLabel --- defines the number
 
 
	script.Parent.MouseButton1Click:Connect(function() --- when the button is clicked it calls this function
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed +5--- defines the player and addition to walk speed
		label.Text = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed --- tells the text label that displays walk speed to update
	end)
end
coroutine.wrap(QDTZQ_fake_script)()
local function UCADA_fake_script() -- TextButton_2.LocalScript 
	local script = Instance.new('LocalScript', TextButton_2)
 
	local label = script.Parent.Parent.TextLabel --- defines the number
 
 
	script.Parent.MouseButton1Click:Connect(function() --- when the button is clicked it calls this function
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed -5--- defines the player and addition to walk speed
		label.Text = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed --- tells the text label that displays walk speed to update
	end)
end
coroutine.wrap(UCADA_fake_script)()
local function YDSA_fake_script() -- Close.LocalScript 
	local script = Instance.new('LocalScript', Close)
 
	script.Parent.Parent.Visible = false
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Visible =  false
		script.Parent.Parent.Parent.Open.Visible = true
	end)
end
coroutine.wrap(YDSA_fake_script)()
local function ZFFOR_fake_script() -- Open.LocalScript 
	local script = Instance.new('LocalScript', Open)
 
	script.Parent.Visible = true
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Visible = false
		script.Parent.Parent.Frame.Visible = true
	end)
end
coroutine.wrap(ZFFOR_fake_script)()
end)

tab2:Button("Angler自动躲",function()
     local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local brought = "Angler"
local present = nil
local annnwRidd = false
local TP = Vector3.new(10000, 10000, 10000)
local function deliver(Position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
    end
end
local function targetExists()
    return workspace:FindFirstChild(brought) ~= nil
end
RunService.Heartbeat:Connect(function()
    if targetExists() then
        if not annnwRidd then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                present = player.Character.HumanoidRootPart.Position
                annnwRidd = true
            end
        end
        deliver(TP)
    else
        if annnwRidd then
            if present and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                deliver(present)
                present = nil
            end
            annnwRidd = false
        end
    end
end)
end)

tab2:Button("粉色变体自动躲",function()
     local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local brought = "Pinke"
local present = nil
local annnwRidd = false
local TP = Vector3.new(10000, 10000, 10000)
local function deliver(Position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
    end
end
local function targetExists()
    return workspace:FindFirstChild(brought) ~= nil
end
RunService.Heartbeat:Connect(function()
    if targetExists() then
        if not annnwRidd then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                present = player.Character.HumanoidRootPart.Position
                annnwRidd = true
            end
        end
        deliver(TP)
    else
        if annnwRidd then
            if present and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                deliver(present)
                present = nil
            end
            annnwRidd = false
        end
    end
end)
end)

tab2:Button("Z-367自动躲",function()
     local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local brought = "Pandemonium"
local present = nil
local annnwRidd = false
local TP = Vector3.new(10000, 10000, 10000)
local function deliver(Position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
    end
end
local function targetExists()
    return workspace:FindFirstChild(brought) ~= nil
end
RunService.Heartbeat:Connect(function()
    if targetExists() then
        if not annnwRidd then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                present = player.Character.HumanoidRootPart.Position
                annnwRidd = true
            end
        end
        deliver(TP)
    else
        if annnwRidd then
            if present and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                deliver(present)
                present = nil
            end
            annnwRidd = false
        end
    end
end)
end)

tab2:Button("Chainsmoker自动躲",function()
     local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local brought = "Chainsmoker"
local present = nil
local annnwRidd = false
local TP = Vector3.new(10000, 10000, 10000)
local function deliver(Position)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(Position)
    end
end
local function targetExists()
    return workspace:FindFirstChild(brought) ~= nil
end
RunService.Heartbeat:Connect(function()
    if targetExists() then
        if not annnwRidd then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                present = player.Character.HumanoidRootPart.Position
                annnwRidd = true
            end
        end
        deliver(TP)
    else
        if annnwRidd then
            if present and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                deliver(present)
                present = nil
            end
            annnwRidd = false
        end
    end
end)
end)

 tab3:Toggle("KeyCard ESP(钥匙卡ESP)",false,function(state)
        if state then
            _G.keyCardESPInstances = {}
            local esptable = {keyCards = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorNormalKeyCard()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "NormalKeyCard" then
                        createBillboard(instance, "NormalKeyCard", Color3.new(1, 0, 0)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "NormalKeyCard" then
                        createBillboard(instance, "NormalKeyCard", Color3.new(1, 0, 0)) -- Change color as needed
                    end
                end)
            end

            local function monitorInnerKeyCard()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "InnerKeyCard" then
                        createBillboard(instance, "InnerKeyCard", Color3.new(255, 255, 255)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "InnerKeyCard" then
                        createBillboard(instance, "InnerKeyCard", Color3.new(255, 255, 255)) -- Change color as needed
                    end
                end)
            end

            monitorNormalKeyCard()
            monitorInnerKeyCard()
            table.insert(_G.keyCardESPInstances, esptable)
				
        else
            if _G.keyCardESPInstances then
                for _, instance in pairs(_G.keyCardESPInstances) do
                    for _, v in pairs(instance.keyCards) do
                        v.delete()
                    end
                end
                _G.keyCardESPInstances = nil
            end
        end
    end)



tab3:Toggle("Enity Message(实体消息)",false,function(state)
        if state then
            local entityNames = {"怪物名字"}  --这里填写你抓到的会刷新的文件名，记住是文件名字，并且可以无限叠加
            local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))() --Lib1
            local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))() --Lib2

            -- Ensure flags and plr are defined
            local flags = flags or {} --Prevent Error
            local plr = game.Players.LocalPlayer --Prevent Error2

            local function notifyEntitySpawn(entity)
                Notification:Notify(
                    {Title = "提示", Description = entity.Name:gsub("Moving", ""):lower() .. " 出现"},--你不要在这里改了你只需要改上面我标记的
                    {OutlineColor = Color3.fromRGB(80, 80, 80), Time = 5, Type = "image"},
                    {Image = "http://www.roblox.com/asset/?id=96955208633559", ImageColor = Color3.fromRGB(255, 255, 255)}
                )
            end

            local function onChildAdded(child)
                if table.find(entityNames, child.Name) then
                    repeat
                        task.wait()
                    until plr:DistanceFromCharacter(child:GetPivot().Position) < 1000 or not child:IsDescendantOf(workspace)
                    
                    if child:IsDescendantOf(workspace) then
                        notifyEntitySpawn(child)
                    end
                end
            end

            -- Infinite loop to keep the script running and check for hintrush flag
            local running = true
            while running do
                local connection = workspace.ChildAdded:Connect(onChildAdded)
                
                repeat
                    task.wait(1) -- Adjust the wait time as needed
                until not flags.hint or not running
                
                connection:Disconnect()
            end 
        else 
            -- Close message or any other cleanup if needed
            running = false
        end
    end)

tab3:Toggle("Player ESP(玩家ESP)",false,function(state)
        if state then
            _G.aespInstances = {}
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    local aespInstance = esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
                    table.insert(_G.aespInstances, aespInstance)
                end
            end
        else
            if _G.aespInstances then
                for _, aespInstance in pairs(_G.aespInstances) do
                    aespInstance.delete()
                end
                _G.aespInstances = nil
            end
        end
    end)

-- ESP function definition (assuming it already exists)
function esp(what, color, core, name)
    local parts
    if typeof(what) == "Instance" then
        if what:IsA("Model") then
            parts = what:GetChildren()
        elseif what:IsA("BasePart") then
            parts = {what, table.unpack(what:GetChildren())}
        end
    elseif typeof(what) == "table" then
        parts = what
    end

    local bill
    local boxes = {}

    for i, v in pairs(parts) do
        if v:IsA("BasePart") then
            local box = Instance.new("BoxHandleAdornment")
            box.Size = v.Size
            box.AlwaysOnTop = true
            box.ZIndex = 1
            box.AdornCullingMode = Enum.AdornCullingMode.Never
            box.Color3 = color
            box.Transparency = 0.75
            box.Adornee = v
            box.Parent = game.CoreGui

            table.insert(boxes, box)

            task.spawn(function()
                while box do
                    if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                        box.Adornee = nil
                        box.Visible = false
                        box:Destroy()
                    end
                    task.wait()
                end
            end)
        end
    end

    if core and name then
        bill = Instance.new("BillboardGui", game.CoreGui)
        bill.AlwaysOnTop = true
        bill.Size = UDim2.new(0, 100, 0, 50)
        bill.Adornee = core
        bill.MaxDistance = 2000

        local mid = Instance.new("Frame", bill)
        mid.AnchorPoint = Vector2.new(0.5, 0.5)
        mid.BackgroundColor3 = color
        mid.Size = UDim2.new(0, 8, 0, 8)
        mid.Position = UDim2.new(0.5, 0, 0.5, 0)
        Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", mid)

        local txt = Instance.new("TextLabel", bill)
        txt.AnchorPoint = Vector2.new(0.5, 0.5)
        txt.BackgroundTransparency = 1
        txt.BackgroundColor3 = color
        txt.TextColor3 = color
        txt.Size = UDim2.new(1, 0, 0, 20)
        txt.Position = UDim2.new(0.5, 0, 0.7, 0)
        txt.Text = name
        Instance.new("UIStroke", txt)

        task.spawn(function()
            while bill do
                if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                    bill.Enabled = false
                    bill.Adornee = nil
                    bill:Destroy()
                end
                task.wait()
            end
        end)
    end

    local ret = {}

    ret.delete = function()
        for i, v in pairs(boxes) do
            v.Adornee = nil
            v.Visible = false
            v:Destroy()
        end

        if bill then
            bill.Enabled = false
            bill.Adornee = nil
            bill:Destroy()
        end
    end

    return ret
end

-- Define Player ESP function
function playerEsp()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character then
            esp(player.Character, Color3.new(255, 255, 255), player.Character:FindFirstChild("HumanoidRootPart"), player.Name)
        end
    end
end

tab3:Toggle("Full Bright(高亮)",false,function(state)
        local Light = game:GetService("Lighting")

        local function dofullbright()
            Light.Ambient = Color3.new(1, 1, 1)
            Light.ColorShift_Bottom = Color3.new(1, 1, 1)
            Light.ColorShift_Top = Color3.new(1, 1, 1)
        end

        local function resetLighting()
            Light.Ambient = Color3.new(0, 0, 0)
            Light.ColorShift_Bottom = Color3.new(0, 0, 0)
            Light.ColorShift_Top = Color3.new(0, 0, 0)
        end

        if state then
            _G.fullBrightEnabled = true
            task.spawn(function()
                while _G.fullBrightEnabled do
                    dofullbright()
                    task.wait(0)  -- 每秒检查一次
                end
            end)
        else
            _G.fullBrightEnabled = false
            resetLighting()
        end
    end)

tab3:Toggle("Entity ESP(实体ESP)",false,function(state)
        if state then
            _G.entityInstances = {}
            local esptable = {entities = {}}
            local flags = {esprush = true}
            local entitynames = {"Angler", "Eyefestation", "Blitz", "Pinkie", "Froger", "Chainsmoker", "Pandemonium", "Body"}

            local function esp(what, color, core, name)
                local parts

                if typeof(what) == "Instance" then
                    if what:IsA("Model") then
                        parts = what:GetChildren()
                    elseif what:IsA("BasePart") then
                        parts = {what, table.unpack(what:GetChildren())}
                    end
                elseif typeof(what) == "table" then
                    parts = what
                end

                local bill
                local boxes = {}

                for _, v in pairs(parts) do
                    if v:IsA("BasePart") then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Size = v.Size
                        box.AlwaysOnTop = true
                        box.ZIndex = 1
                        box.AdornCullingMode = Enum.AdornCullingMode.Never
                        box.Color3 = color
                        box.Transparency = 0.5
                        box.Adornee = v
                        box.Parent = game.CoreGui

                        table.insert(boxes, box)

                        task.spawn(function()
                            while box do
                                if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
                                    box.Adornee = nil
                                    box.Visible = false
                                    box:Destroy()
                                end
                                task.wait()
                            end
                        end)
                    end
                end

                if core and name then
                    bill = Instance.new("BillboardGui", game.CoreGui)
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(0, 100, 0, 50)
                    bill.Adornee = core
                    bill.MaxDistance = 2000

                    local mid = Instance.new("Frame", bill)
                    mid.AnchorPoint = Vector2.new(0.5, 0.5)
                    mid.BackgroundColor3 = color
                    mid.Size = UDim2.new(0, 8, 0, 8)
                    mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                    Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                    Instance.new("UIStroke", mid)

                    local txt = Instance.new("TextLabel", bill)
                    txt.AnchorPoint = Vector2.new(0.5, 0.5)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = color
                    txt.Size = UDim2.new(1, 0, 0, 20)
                    txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                    txt.Text = name
                    Instance.new("UIStroke", txt)

                    task.spawn(function()
                        while bill do
                            if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                                bill.Enabled = false
                                bill.Adornee = nil
                                bill:Destroy()
                            end
                            task.wait()
                        end
                    end)
                end

                local ret = {}

                ret.delete = function()
                    for _, v in pairs(boxes) do
                        v.Adornee = nil
                        v.Visible = false
                        v:Destroy()
                    end

                    if bill then
                        bill.Enabled = false
                        bill.Adornee = nil
                        bill:Destroy()
                    end
                end

                return ret
            end

            local function addEntity(instance)
                for _, name in pairs(entitynames) do
                    if instance:IsA("Model") and instance.Name == name then
                        local espEntity = esp(instance, Color3.fromRGB(255, 0, 0), instance.PrimaryPart, name)
                        table.insert(esptable.entities, espEntity)
                    end
                end
            end

            local function monitorEntities()
                for _, instance in pairs(workspace:GetDescendants()) do
                    addEntity(instance)
                end

                workspace.DescendantAdded:Connect(addEntity)
            end

            monitorEntities()
            table.insert(_G.entityInstances, esptable)
        else
            if _G.entityInstances then
                for _, instance in pairs(_G.entityInstances) do
                    for _, entity in pairs(instance.entities) do
                        entity.delete()
                    end
                end
                _G.entityInstances = nil
            end
        end
    end)

tab3:Toggle("No cilp(穿墙)",false,function(state)
        local player = game.Players.LocalPlayer
        local char = player.Character
        local runService = game:GetService("RunService")
        if state then
            _G.NoClip = runService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        else
            if _G.NoClip then
                _G.NoClip:Disconnect()
                _G.NoClip = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end)
    
tab3:Toggle("Locker ESP(柜子ESP)",false,function(state)
        if state then
            _G.espToLocker = {}
            local esptable = {lockers = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function addLocker(instance)
                if instance:IsA("Model") and instance.Name == "Locker" then
                    createBillboard(instance, "Locker", Color3.new(250, 250, 250)) -- Change color as needed
                    table.insert(esptable.lockers, instance)
                end
            end

            local function monitorLockers()
                for _, instance in pairs(workspace:GetDescendants()) do
                    addLocker(instance)
                end

                workspace.DescendantAdded:Connect(addLocker)
            end

            monitorLockers()
            table.insert(_G.espToLocker, esptable)
				
        else
            if _G.espToLocker then
                for _, instance in pairs(_G.espToLocker) do
                    for _, locker in pairs(instance.lockers) do
                        if locker and locker:FindFirstChildOfClass("BillboardGui") then
                            locker:FindFirstChildOfClass("BillboardGui"):Destroy()
                        end
                    end
                end
                _G.espToLocker = nil
            end
        end
    end)

tab3:Toggle("NormalDoor ESP(门ESP)",false,function(state)
        if state then
            _G.NormalDoorESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorNormalDoor()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "NormalDoor" then
                        createBillboard(instance, "door(门", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "NormalDoor" then
                        createBillboard(instance, "door(门", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end)
            end

            monitorNormalDoor()
            table.insert(_G.NormalDoorESPInstances, esptable)
				
        else
            if _G.NormalDoorESPInstances then
                for _, instance in pairs(_G.NormalDoorESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.NormalDoorESPInstances = nil
            end
        end
    end)

tab3:Toggle("generator ESP(发电机ESP)",false,function(state)
        if state then
            _G.EncounterGeneratorESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorEncounterGenerator()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "EncounterGenerator" then
                        createBillboard(instance, "EncounterGenerator", Color3.new(50, 10, 25)) -- Change color as neededPipesDoorESPInstances
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "EncounterGenerator" then
                        createBillboard(instance, "EncounterGenerator", Color3.new(50, 10, 25)) -- Change color as needed
                    end
                end)
            end

            monitorEncounterGenerator()
            table.insert(_G.EncounterGeneratorESPInstances, esptable)
				
        else
            if _G.EncounterGeneratorESPInstances then
                for _, instance in pairs(_G.EncounterGeneratorESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.EncounterGeneratorESPInstances = nil
            end
        end
    end)

 tab3:Toggle("locker ESP(储物柜ESP)",false,function(state)
        if state then
            _G.ItemLockerESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorItemLocker()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "ItemLocker" then
                        createBillboard(instance, "Storagecabinet(储物柜", Color3.new(50, 10, 255)) -- Change color as neededPipesDoorESPInstances
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "ItemLocker" then
                        createBillboard(instance, "Storagecabinet(储物柜", Color3.new(50, 10, 255)) -- Change color as needed
                    end
                end)
            end

            monitorItemLocker()
            table.insert(_G.ItemLockerESPInstances, esptable)
				
        else
            if _G.ItemLockerESPInstances then
                for _, instance in pairs(_G.ItemLockerESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.ItemLockerESPInstances = nil
            end
        end
    end)

 tab3:Toggle("Creature of Darkness ESP(章鱼哥ESP)",false,function(state)
        if state then
            _G.BodyESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorBody()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Body" then
                        createBillboard(instance, "Body", Color3.new(50, 100, 25)) -- Change color as neededPipesDoorESPInstances
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Body" then
                        createBillboard(instance, "Body", Color3.new(50, 100, 25)) -- Change color as needed
                    end
                end)
            end

            monitorBody()
            table.insert(_G.BodyESPInstances, esptable)
				
        else
            if _G.BodyESPInstances then
                for _, instance in pairs(_G.BodyESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.BodyESPInstances = nil
            end
        end
    end)

 tab3:Toggle("Fake cabinet ESP(假柜子ESP)",false,function(state)
        if state then
            _G.MonsterLockerESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorMonsterLocker()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "MonsterLocker" then
                        createBillboard(instance, "Fake cabinet(假的柜子", Color3.new(50, 10, 25)) -- Change color as neededPipesDoorESPInstances
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "MonsterLocker" then
                        createBillboard(instance, "Fake cabinet(假的柜子", Color3.new(50, 10, 25)) -- Change color as needed
                    end
                end)
            end

            monitorMonsterLocker()
            table.insert(_G.MonsterLockerESPInstances, esptable)
				
        else
            if _G.MonsterLockerESPInstances then
                for _, instance in pairs(_G.MonsterLockerESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.MonsterLockerESPInstances = nil
            end
        end
    end)

tab3:Toggle("blank door ESP(假门ESP)",false,function(state)
        if state then
            _G.TricksterRoomESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorTricksterRoom()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "TricksterRoom" then
                        createBillboard(instance, "blankdoor(假门", Color3.new(50, 10, 25)) -- Change color as neededPipesDoorESPInstances
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "TricksterRoom" then
                        createBillboard(instance, "blankdoor(假门", Color3.new(50, 10, 25)) -- Change color as needed
                    end
                end)
            end

            monitorTricksterRoom()
            table.insert(_G.TricksterRoomESPInstances, esptable)
				
        else
            if _G.TricksterRoomESPInstances then
                for _, instance in pairs(_G.TricksterRoomESPInstances) do
                    for _, v in pairs(instance.doors) do
                        v.delete()
                    end
                end
                _G.TricksterRoomESPInstances = nil
            end
        end
    end)

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local tpWalkThread
local flyThread
local isFlying = false
local BodyVelocity

local function tpWalk(speed)
    while true do
        task.wait()
        if Humanoid.MoveDirection.Magnitude > 0 then
            -- Move the player in the direction they are facing, including vertical movement
            local moveDirection = Humanoid.MoveDirection * speed

            -- Adjust for swimming: add upward movement if the player is in water
            if Humanoid:GetState() == Enum.HumanoidStateType.Swimming then
                moveDirection = moveDirection + Vector3.new(0, speed, 0)
            end

            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + moveDirection
        end
    end
end

local function flatFly(speed)
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.MaxForce = Vector3.new(1e4, 0, 1e4)
    BodyVelocity.Parent = HumanoidRootPart

    while isFlying do
        task.wait()
        if Humanoid.MoveDirection.Magnitude > 0 then
            -- Move the player in the direction they are facing, but only in the horizontal plane
            local moveDirection = Vector3.new(Humanoid.MoveDirection.X, 0, Humanoid.MoveDirection.Z) * speed
            BodyVelocity.Velocity = moveDirection
        else
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end

    BodyVelocity:Destroy()
end

tab3:Toggle("Flat Fly",false,function(val)
        isFlying = val
        if isFlying then
            -- Start flat flying thread
            flyThread = coroutine.wrap(function()
                flatFly(2)  -- Default flat fly speed
            end)
            flyThread()
        else
            -- Stop flat flying
            if flyThread then
                flyThread = nil
            end
        end
    end)

-- Ensure player and humanoid references are updated if the character respawns
Player.CharacterAdded:Connect(function(character)
    Character = character
    HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
    Humanoid = character:WaitForChild("Humanoid")
end)

local Player = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function updateFOV(fov)
    Camera.FieldOfView = fov
end

tab3:Toggle("Entity Bypass",false,function(state)
        if state then
            local entityNames = {"Angler", "Blitz", "Pinkie", "Froger", "Chainsmoker", "Pandemonium"} -- List of entities to monitor
            local platformHeight = 900 -- Height for the safe platform
            local platformSize = Vector3.new(1000, 1, 1000) -- Size of the platform
            local platform -- Variable to hold the created platform
            local entityTriggerMap = {} -- Map to keep track of which entities triggered the platform
            local playerOriginalPositions = {} -- Table to store original positions of players
            local isMonitoring = true

            -- Function to create or update the safe platform
            local function createSafePlatform()
                if platform then
                    platform:Destroy() -- Remove existing platform if any
                end

                platform = Instance.new("Part")
                platform.Size = platformSize
                platform.Position = Vector3.new(0, platformHeight, 0) -- Center position
                platform.Anchored = true
                platform.Parent = workspace
            end

            -- Function to teleport a player to the safe platform
            local function teleportPlayerToPlatform(player)
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPosition = platform.Position + Vector3.new(0, platform.Size.Y / 2 + 5, 0)
                    playerOriginalPositions[player.UserId] = player.Character.HumanoidRootPart.CFrame -- Store original position
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                end
            end

            -- Function to teleport a player back to their original position
            local function teleportPlayerBack(player)
                if playerOriginalPositions[player.UserId] then
                    player.Character.HumanoidRootPart.CFrame = playerOriginalPositions[player.UserId]
                    playerOriginalPositions[player.UserId] = nil -- Clear the stored position
                end
            end

            -- Function to handle entity detection
            local function onChildAdded(child)
                if table.find(entityNames, child.Name) then
                    -- Create platform and teleport players when entity is detected
                    createSafePlatform()
                    entityTriggerMap[child] = true -- Mark entity as having triggered the platform
                    for _, player in pairs(game.Players:GetPlayers()) do
                        teleportPlayerToPlatform(player)
                    end
                end
            end

            -- Function to handle entity removal
            local function onChildRemoved(child)
                if entityTriggerMap[child] then
                    -- Entity was previously responsible for creating the platform
                    entityTriggerMap[child] = nil -- Remove entity from the map
                    -- Teleport players back to their original positions
                    for _, player in pairs(game.Players:GetPlayers()) do
                        teleportPlayerBack(player)
                    end
                end
            end

            -- Connect the ChildAdded and ChildRemoved events
            local addConnection = workspace.ChildAdded:Connect(onChildAdded)
            local removeConnection = workspace.ChildRemoved:Connect(onChildRemoved)

            -- Loop to keep the script running based on the toggle state
            while isMonitoring do
                task.wait(1) -- Adjust the wait time as needed

                if not state then
                    -- Cleanup if defense is turned off
                    if platform then
                        -- Keep the platform, but ensure players are teleported back
                        for _, player in pairs(game.Players:GetPlayers()) do
                            teleportPlayerBack(player)
                        end
                    end
                    isMonitoring = false
                    addConnection:Disconnect() -- Disconnect the event listener
                    removeConnection:Disconnect() -- Disconnect the event listener
                end
            end 
        else
            -- Cleanup if defense is turned off
            if platform then
                -- Keep the platform, but ensure players are teleported back
                for _, player in pairs(game.Players:GetPlayers()) do
                    teleportPlayerBack(player)
                end
            end
        end
    end)
tab3:Toggle("BigRoomDoor ESP(大门Esp)",false,function(state)
        if state then
            _G.bigRoomDoorESPInstances = {}
            local esptable = {doors = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorBigRoomDoor()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "BigRoomDoor" then
                        createBillboard(instance, "BigRoomDoor", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "BigRoomDoor" then
                        createBillboard(instance, "BigRoomDoor", Color3.new(125, 125, 125)) -- Change color as needed
                    end
                end)
            end

            monitorBigRoomDoor()
            table.insert(_G.bigRoomDoorESPInstances, esptable)
                
        else
            if _G.bigRoomDoorESPInstances then
                for _, instance in pairs(_G.bigRoomDoorESPInstances) do
                    for _, v in pairs(instance.doors) do
                        if v:FindFirstChild("BillboardGui") then
                            v.BillboardGui:Destroy()
                        end
                    end
                end
                _G.bigRoomDoorESPInstances = nil
            end
        end
    end)
 tab3:Toggle("Currency and item esp(钱+物品esp)",false,function(state)
        if state then
            _G.nahInstances = {}
            local esptable = {nah = {}}

            local function createBillboard(instance, name, color)
                local bill = Instance.new("BillboardGui", game.CoreGui)
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 100, 0, 50)
                bill.Adornee = instance
                bill.MaxDistance = 2000

                local mid = Instance.new("Frame", bill)
                mid.AnchorPoint = Vector2.new(0.5, 0.5)
                mid.BackgroundColor3 = color
                mid.Size = UDim2.new(0, 8, 0, 8)
                mid.Position = UDim2.new(0.5, 0, 0.5, 0)
                Instance.new("UICorner", mid).CornerRadius = UDim.new(1, 0)
                Instance.new("UIStroke", mid)

                local txt = Instance.new("TextLabel", bill)
                txt.AnchorPoint = Vector2.new(0.5, 0.5)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = color
                txt.Size = UDim2.new(1, 0, 0, 20)
                txt.Position = UDim2.new(0.5, 0, 0.7, 0)
                txt.Text = name
                Instance.new("UIStroke", txt)

                task.spawn(function()
                    while bill do
                        if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
                            bill.Enabled = false
                            bill.Adornee = nil
                            bill:Destroy()
                        end
                        task.wait()
                    end
                end)
            end

            local function monitorFlashBeacon()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "FlashBeacon" then
                        createBillboard(instance, "FlashBeacon", Color3.new(0, 1, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "FlashBeacon" then
                        createBillboard(instance, "FlashBeacon", Color3.new(0, 1, 0))
                    end
                end)
            end

            local function monitorCodeBreacher()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "CodeBreacher" then
                        createBillboard(instance, "CodeBreacher", Color3.new(0, 0, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "CodeBreacher" then
                        createBillboard(instance, "CodeBreacher", Color3.new(0, 0, 1))
                    end
                end)
            end

            local function monitor25Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "25Currency" then
                        createBillboard(instance, "25Currency", Color3.new(1, 1, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "25Currency" then
                        createBillboard(instance, "25Currency", Color3.new(1, 1, 0))
                    end
                end)
            end

            local function monitor50Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "50Currency" then
                        createBillboard(instance, "50Currency", Color3.new(1, 0.5, 0))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "50Currency" then
                        createBillboard(instance, "50Currency", Color3.new(1, 0.5, 0))
                    end
                end)
            end

            local function monitor15Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "15Currency" then
                        createBillboard(instance, "15Currency", Color3.new(0.5, 0.5, 0.5))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "15Currency" then
                        createBillboard(instance, "15Currency", Color3.new(0.5, 0.5, 0.5))
                    end
                end)
	    end

            local function monitor100Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "100Currency" then
                        createBillboard(instance, "100Currency", Color3.new(1, 0, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "100Currency" then
                        createBillboard(instance, "100Currency", Color3.new(1, 0, 1))
                    end
                end)
            end

            local function monitor200Currency()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "200Currency" then
                        createBillboard(instance, "200Currency", Color3.new(0, 1, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "200Currency" then
                        createBillboard(instance, "200Currency", Color3.new(0, 1, 1))
		    end
                end)
	    end

	    local function monitorFlashlight()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Flashlight" then
                        createBillboard(instance, "Flashlight", Color3.new(25, 25, 25))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Flashlight" then
                        createBillboard(instance, "Flashlight", Color3.new(25, 25, 25))
                    end
                end)
	    end

	    local function monitorA()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Lantern" then
                        createBillboard(instance, "Lantern", Color3.new(99, 99, 99))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Lantern" then
                        createBillboard(instance, "Lantern", Color3.new(99, 99, 99))
                    end
                end)
	    end

	    local function monitorB()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Blacklight" then
                        createBillboard(instance, "Blacklight", Color3.new(5, 1, 1))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Blacklight" then
                        createBillboard(instance, "Blacklight", Color3.new(5, 1, 1))
                    end
                end)
	    end

	    local function monitorC()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Gummylight" then
                        createBillboard(instance, "Gummylight", Color3.new(5, 55, 5))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Gummylight" then
                        createBillboard(instance, "Gummylight", Color3.new(5, 55, 5))
                    end
                end)
	    end

	    local function monitorD()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "DwellerPiece" then
                        createBillboard(instance, "DwellerPiece", Color3.new(50, 10, 25))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "DwellerPiece" then 
                        createBillboard(instance, "DwellerPiece", Color3.new(50, 10, 25))
                    end
                end)
	    end

            local function monitorE()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Medkit" then
                        createBillboard(instance, "Medkit", Color3.new(80, 75, 235))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Medkit" then 
                        createBillboard(instance, "Medkit", Color3.new(80, 75, 235))
                    end
                end)
	    end

            local function monitorF()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "Splorglight" then
                        createBillboard(instance, "Splorglight", Color3.new(50, 100, 55))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "Splorglight" then 
                        createBillboard(instance, "Splorglight", Color3.new(50, 100, 55))
                    end
                end)
	    end

	    local function monitorG()
                for _, instance in pairs(workspace:GetDescendants()) do
                    if instance:IsA("Model") and instance.Name == "WindupLight" then
                        createBillboard(instance, "WindupLight", Color3.new(85, 100, 66))
                    end
                end

                workspace.DescendantAdded:Connect(function(instance)
                    if instance:IsA("Model") and instance.Name == "WindupLight" then 
                        createBillboard(instance, "WindupLight", Color3.new(85, 100, 66))
                    end
                end)
	    end

				
            monitorFlashBeacon()
            monitorCodeBreacher()
            monitor25Currency()
            monitor50Currency()
            monitor15Currency()
            monitor100Currency()
            monitor200Currency()
	    monitorFlashlight()
            monitorA()
            monitorB()
	    monitorC()
	    monitorD()
	    monitorE()
	    monitorF()
	    monitorG()

            table.insert(_G.nahESPInstances, esptable)
                
        else
            if _G.nahInstances then
                for _, instance in pairs(_G.nahESPInstances) do
                    for _, v in pairs(instance.nah) do
                        v.delete()
                    end
                end
                _G.nahInstances = nil
            end
        end
    end)
local autoInteract = false

local function fireAllProximityPrompts()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            local parentModel = descendant:FindFirstAncestorOfClass("Model")
            if parentModel and parentModel.Name ~= "MonsterLocker" and parentModel.Name ~= "Locker" then
                fireproximityprompt(descendant)
            end
        end
    end
end

local function removeSpecificObjects()
    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("Model") and (descendant.Name == "MonsterLocker" or descendant.Name == "Locker" or descendant.Name == "TricksterRoom") then
            descendant:Destroy()
        end
    end
end
