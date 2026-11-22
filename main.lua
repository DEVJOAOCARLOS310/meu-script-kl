local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

local state = {
	autoFarmLevel = false,
	prioritizeMiniBoss = true,
	autoQuest = false,
	autoFish = false,
	autoMaterial = false,
	autoRaid = false,
	farmSeaKing = false,
	farmHydra = false,
	farmAllBosses = false,
	hopSeaKing = false,
	hopHydra = false,
	hopThirdSeaBoss = false,
	autoPvpHunt = false,
	hopPvpTarget = false,
	hopClanFlag = false,
	autoWeaponV2 = false,
	autoRaceV2 = false,
	autoRaceV3 = false,
	autoStyleGale = false,
	autoStyleTrickster = false,
	bringFruit = false,
	autoStoreFruit = false,
	autoTradeFruitKey = false,
}

local progressionTable = {
	{ min = 0,    max = 9,    sea = 1, island = "Starter Island",    mob = "Soldier",          bosses = {} },
	{ min = 10,   max = 49,   sea = 1, island = "Starter Island",    mob = "Clown Pirate",     bosses = { { lvl = 30, names = { "Tashi" } }, { lvl = 20, names = { "Smoky" } } } },
	{ min = 50,   max = 99,   sea = 1, island = "Pirate Island",     mob = "Clown Swordsman",  bosses = { { lvl = 75, names = { "The Clown", "Captain Clown" } } } },
	{ min = 100,  max = 179,  sea = 1, island = "Soldier Island",    mob = "Soldier",          bosses = { { lvl = 145, names = { "The Barbaric" } }, { lvl = 120, names = { "The Captain" } } } },
	{ min = 180,  max = 249,  sea = 1, island = "Shark Island",      mob = "Fighter Fishman",  bosses = { { lvl = 230, names = { "Shark Man" } }, { lvl = 200, names = { "Karate Fishman" } } } },
	{ min = 250,  max = 399,  sea = 1, island = "Chef Ship",         mob = "Pirate",           bosses = { { lvl = 350, names = { "Dory" } }, { lvl = 300, names = { "Dark Leg" } } } },
	{ min = 400,  max = 524,  sea = 1, island = "Snow Island",       mob = "Snow Soldier",     bosses = { { lvl = 500, names = { "Little Dear" } }, { lvl = 450, names = { "King of Snow" } } } },
	{ min = 525,  max = 649,  sea = 1, island = "Sand Kingdom",      mob = "Desert Thief",     bosses = { { lvl = 625, names = { "Bomb Man" } }, { lvl = 525, names = { "Candle Man" } } } },
	{ min = 650,  max = 799,  sea = 1, island = "Sand Kingdom",      mob = "Sand Bandit",      bosses = { { lvl = 725, names = { "King of Sand" } } } },
	{ min = 800,  max = 924,  sea = 1, island = "Sky Island",        mob = "Sky Soldier",      bosses = { { lvl = 900, names = { "Rumble Man" } }, { lvl = 850, names = { "Ball Man" } } } },
	{ min = 925,  max = 999,  sea = 1, island = "Sky Island",        mob = "Guard",            bosses = { { lvl = 900, names = { "Rumble Man" } } } },
	{ min = 1000, max = 1049, sea = 1, island = "Bubble Island",     mob = "Bounty Hunter",    bosses = {} },
	{ min = 1050, max = 1249, sea = 1, island = "Bubble Island",     mob = "Slave",            bosses = { { lvl = 1150, names = { "Pasta" } }, { lvl = 1100, names = { "Leader" } } } },
	{ min = 1250, max = 1374, sea = 1, island = "Lobby Island",      mob = "Marine",           bosses = { { lvl = 1325, names = { "Giraffe" } }, { lvl = 1250, names = { "Wolf" } } } },
	{ min = 1375, max = 1499, sea = 1, island = "Lobby Island",      mob = "Agent",            bosses = { { lvl = 1400, names = { "Leo" } } } },
	{ min = 1500, max = 1624, sea = 1, island = "Zombie Island",     mob = "Zombie",           bosses = {} },
	{ min = 1625, max = 1749, sea = 1, island = "Zombie Island",     mob = "Elite Zombie",     bosses = { { lvl = 1650, names = { "Shadow Master" } } } },
	{ min = 1750, max = 1874, sea = 1, island = "War Island",        mob = "Marine Soldier",   bosses = { { lvl = 1850, names = { "True Karate Fishman" } } } },
	{ min = 1875, max = 1999, sea = 1, island = "War Island",        mob = "Vice Admiral",     bosses = { { lvl = 1925, names = { "Quake Woman" } } } },
	{ min = 2000, max = 2124, sea = 1, island = "Fishland",          mob = "Fishman Soldier",  bosses = {} },
	{ min = 2125, max = 2249, sea = 1, island = "Fishland",          mob = "Seasoned Fishman", bosses = { { lvl = 2150, names = { "Fishman Lord", "Shark Man V2" } } } },
	{ min = 2250, max = 2299, sea = 2, island = "Floresco",          mob = "Bandit",           bosses = {} },
	{ min = 2300, max = 2399, sea = 2, island = "Floresco",          mob = "Trainee",          bosses = { { lvl = 2350, names = { "Joey" } } } },
	{ min = 2400, max = 2474, sea = 2, island = "Floresco",          mob = "Samurai",          bosses = { { lvl = 2450, names = { "Flame User" } } } },
	{ min = 2475, max = 2549, sea = 2, island = "Floresco",          mob = "Assassin",         bosses = { { lvl = 2475, names = { "Oden", "Kawamatsu", "Denjiro", "Ashura", "Kinemon", "Kiku", "Izou" } } } },
	{ min = 2550, max = 2649, sea = 2, island = "Skull Island",      mob = "Pirate",           bosses = {} },
	{ min = 2650, max = 2749, sea = 2, island = "Skull Island",      mob = "Brute",            bosses = { { lvl = 2700, names = { "Lord of Saber", "Elite Skeleton" } } } },
	{ min = 2750, max = 2874, sea = 2, island = "Dead Tundra",       mob = "Snow Bandit",      bosses = {} },
	{ min = 2875, max = 2999, sea = 2, island = "Dead Tundra",       mob = "Yeti",             bosses = { { lvl = 2950, names = { "Mammoth", "Ice King", "Pharaoh" } } } },
	{ min = 3000, max = 3099, sea = 2, island = "Loaf Island",       mob = "Biscuit Soldier",  bosses = { { lvl = 3050, names = { "Biscuit Man", "Lord of Saber", "Elite Skeleton" } } } },
	{ min = 3100, max = 3174, sea = 2, island = "Loaf Island",       mob = "Chess Soldier",    bosses = { { lvl = 3125, names = { "Dough Master" } } } },
	{ min = 3175, max = 3274, sea = 2, island = "Shred Endangering", mob = "Hazmat Guard",     bosses = { { lvl = 3175, names = { "Pharaoh", "Biscuit Man" } } } },
	{ min = 3275, max = 3374, sea = 2, island = "Shred Endangering", mob = "Scientist",        bosses = { { lvl = 3350, names = { "Gas Man", "Smoke Admiral", "Crimson Demon" } } } },
	{ min = 3375, max = 3474, sea = 2, island = "Pirate Skull Island", mob = "Beast Pirate",   bosses = { { lvl = 3425, names = { "Jack" } } } },
	{ min = 3475, max = 3599, sea = 2, island = "Pirate Skull Island", mob = "Headliner",      bosses = { { lvl = 3525, names = { "Queen" } } } },
	{ min = 3600, max = 3699, sea = 2, island = "Soldier Headquarters", mob = "HQ Marine",     bosses = {} },
	{ min = 3700, max = 3799, sea = 2, island = "Soldier Headquarters", mob = "Captain",       bosses = { { lvl = 3750, names = { "Fleet Admiral", "Magma Admiral" } } } },
	{ min = 3800, max = 3849, sea = 2, island = "Fiore",             mob = "Fiore Guard",      bosses = { { lvl = 3825, names = { "Pica" } } } },
	{ min = 3850, max = 3924, sea = 2, island = "Fiore",             mob = "Captain",          bosses = { { lvl = 3875, names = { "Diamante" } } } },
	{ min = 3925, max = 3999, sea = 2, island = "Fiore",             mob = "Gladiator",        bosses = { { lvl = 3975, names = { "String Man" } }, { lvl = 3925, names = { "Trebol" } } } },
	{ min = 4000, max = 4099, sea = 3, island = "The Unearthly",     mob = "Jungle Ape",       bosses = {} },
	{ min = 4100, max = 4199, sea = 3, island = "The Unearthly",     mob = "Bushido Ape",      bosses = { { lvl = 4150, names = { "Bushido Ape" } } } },
	{ min = 4200, max = 4299, sea = 3, island = "The Unearthly",     mob = "Cyborg Gorilla",   bosses = { { lvl = 4250, names = { "Cyborg Gorilla Boss", "Cyborg Gorilla" } } } },
	{ min = 4300, max = 4349, sea = 3, island = "The Shallow",       mob = "Deep Sea Dweller", bosses = {} },
	{ min = 4350, max = 4399, sea = 3, island = "The Shallow",       mob = "Trench Warrior",   bosses = { { lvl = 4375, names = { "Trench Captain", "Deep Sea Lord" } } } },
	{ min = 4400, max = 4474, sea = 3, island = "Drakenhold Fortress", mob = "Dragon Guard",   bosses = {} },
	{ min = 4475, max = 4549, sea = 3, island = "Drakenhold Fortress", mob = "Draken Knight",  bosses = { { lvl = 4500, names = { "Draken Knight Captain" } } } },
	{ min = 4550, max = 4674, sea = 3, island = "Forgotten Coliseum", mob = "Ocean Gladiator", bosses = {} },
	{ min = 4675, max = 4799, sea = 3, island = "Forgotten Coliseum", mob = "Coliseum Fighter", bosses = { { lvl = 4750, names = { "Coliseum Champion", "Gladiator Boss" } } } },
	{ min = 4800, max = 4874, sea = 3, island = "Land of Detention", mob = "Warden Guard",     bosses = {} },
	{ min = 4875, max = 5450, sea = 3, island = "Land of Detention", mob = "Jailer",           bosses = { { lvl = 4950, names = { "Chief Warden", "Luma" } } } },
}

local guiParent = player:WaitForChild("PlayerGui")
if guiParent:FindFirstChild("KL_MinimalSquare") then
	guiParent.KL_MinimalSquare:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KL_MinimalSquare"
screenGui.ResetOnSpawn = false
screenGui.Parent = guiParent

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 275)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -137)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(70, 70, 82)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 26)
topBar.BackgroundColor3 = Color3.fromRGB(26, 26, 32)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -34, 1, 0)
titleLabel.Position = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "KL // MINIMAL"
titleLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
titleLabel.Font = Enum.Font.Code
titleLabel.TextSize = 12
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 26, 1, 0)
minBtn.Position = UDim2.new(1, -26, 0, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
minBtn.BorderSizePixel = 0
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(235, 235, 245)
minBtn.Font = Enum.Font.Code
minBtn.TextSize = 14
minBtn.Parent = topBar

local tabNames = { "FARM", "BOSS/SEA", "PVP/HOP", "UPGRADE", "FRUTA/TP" }
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 24)
tabBar.Position = UDim2.new(0, 0, 0, 26)
tabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Parent = tabBar

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -12, 1, -60)
contentArea.Position = UDim2.new(0, 6, 0, 54)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

local pages, tabButtons = {}, {}

for _, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1 / #tabNames, 0, 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	btn.BorderSizePixel = 1
	btn.BorderColor3 = Color3.fromRGB(52, 52, 62)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(165, 165, 180)
	btn.Font = Enum.Font.Code
	btn.TextSize = 11
	btn.Parent = tabBar

	local page = Instance.new("ScrollingFrame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false
	page.Parent = contentArea

	local list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0, 4)
	list.Parent = page

	pages[name] = page
	tabButtons[name] = btn

	btn.MouseButton1Click:Connect(function()
		for k, p in pairs(pages) do p.Visible = (k == name) end
		for k, b in pairs(tabButtons) do
			b.BackgroundColor3 = (k == name) and Color3.fromRGB(44, 44, 54) or Color3.fromRGB(22, 22, 28)
			b.TextColor3 = (k == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(165, 165, 180)
		end
	end)
end

pages["FARM"].Visible = true
tabButtons["FARM"].BackgroundColor3 = Color3.fromRGB(44, 44, 54)
tabButtons["FARM"].TextColor3 = Color3.fromRGB(255, 255, 255)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	tabBar.Visible = not minimized
	contentArea.Visible = not minimized
	mainFrame.Size = minimized and UDim2.new(0, 380, 0, 26) or UDim2.new(0, 380, 0, 275)
	minBtn.Text = minimized and "+" or "-"
end)

local function addCheck(pageName, labelText, stateKey)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 26)
	btn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
	btn.BorderSizePixel = 1
	btn.BorderColor3 = Color3.fromRGB(60, 60, 74)
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Font = Enum.Font.Code
	btn.TextSize = 11
	btn.Parent = pages[pageName]

	local function render()
		local active = state[stateKey]
		btn.Text = (active and " [X] " or " [ ] ") .. labelText
		btn.TextColor3 = active and Color3.fromRGB(130, 255, 160) or Color3.fromRGB(220, 220, 230)
		btn.BorderColor3 = active and Color3.fromRGB(85, 195, 115) or Color3.fromRGB(60, 60, 74)
	end

	render()
	btn.MouseButton1Click:Connect(function()
		state[stateKey] = not state[stateKey]
		render()
	end)
end

addCheck("FARM", "Auto Farm Level (Mobs + Boss)", "autoFarmLevel")
addCheck("FARM", "Priorizar Mini-Boss Vivo", "prioritizeMiniBoss")
addCheck("FARM", "Auto Quest", "autoQuest")
addCheck("FARM", "Auto Pesca (Fishing)", "autoFish")
addCheck("FARM", "Farm Todos os Materiais", "autoMaterial")
addCheck("FARM", "Auto Raid", "autoRaid")

addCheck("BOSS/SEA", "Farm Sea King", "farmSeaKing")
addCheck("BOSS/SEA", "Farm Hydra", "farmHydra")
addCheck("BOSS/SEA", "Farm Bosses Gerais", "farmAllBosses")
addCheck("BOSS/SEA", "Hop Sea King (1h/4h/5h)", "hopSeaKing")
addCheck("BOSS/SEA", "Hop Hydra (3h/6h)", "hopHydra")
addCheck("BOSS/SEA", "Hop Bosses 3rd Sea", "hopThirdSeaBoss")

addCheck("PVP/HOP", "Auto Combate (PvP Ativo)", "autoPvpHunt")
addCheck("PVP/HOP", "Hop Alvos PvP", "hopPvpTarget")
addCheck("PVP/HOP", "Hop Bandeira de Clas", "hopClanFlag")

addCheck("UPGRADE", "Auto Armas V2", "autoWeaponV2")
addCheck("UPGRADE", "Auto Raca V2", "autoRaceV2")
addCheck("UPGRADE", "Auto Raca V3", "autoRaceV3")
addCheck("UPGRADE", "Auto Estilo: Gale", "autoStyleGale")
addCheck("UPGRADE", "Auto Estilo: Trickster", "autoStyleTrickster")

addCheck("FRUTA/TP", "Bring Fruta Dropada", "bringFruit")
addCheck("FRUTA/TP", "Auto Store Fruta", "autoStoreFruit")
addCheck("FRUTA/TP", "Auto Trocar Fruta por Key", "autoTradeFruitKey")

local function getPlayerLevel()
	local stats = player:FindFirstChild("PlayerStats") or player:FindFirstChild("leaderstats")
	if stats then
		local lvl = stats:FindFirstChild("lvl") or stats:FindFirstChild("Level") or stats:FindFirstChild("Lvl")
		if lvl and tonumber(lvl.Value) then
			return tonumber(lvl.Value)
		end
	end
	return 1
end

local function getProgressionEntry(lvl)
	for _, entry in ipairs(progressionTable) do
		if lvl >= entry.min and lvl <= entry.max then
			return entry
		end
	end
	return progressionTable[#progressionTable]
end

local function findAliveByNames(nameList)
	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return nil end

	local containers = {
		workspace:FindFirstChild("Monster"),
		workspace:FindFirstChild("Enemies"),
		workspace,
	}

	local bestRoot, bestName = nil, nil
	local shortest = math.huge

	for _, container in ipairs(containers) do
		if container then
			for _, obj in ipairs(container:GetDescendants()) do
				if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
					local hum = obj:FindFirstChildOfClass("Humanoid")
					if hum and hum.Health > 0 then
						local lowerObj = obj.Name:lower()
						for _, targetName in ipairs(nameList) do
							if lowerObj:find(targetName:lower(), 1, true) then
								local d = (obj.HumanoidRootPart.Position - root.Position).Magnitude
								if d < shortest then
									shortest = d
									bestRoot = obj.HumanoidRootPart
									bestName = obj.Name
								end
							end
						end
					end
				end
			end
		end
		if bestRoot then break end
	end

	return bestRoot, bestName
end

local function selectBestTarget()
	local lvl = getPlayerLevel()
	local entry = getProgressionEntry(lvl)

	if state.prioritizeMiniBoss and entry.bosses then
		for _, bossInfo in ipairs(entry.bosses) do
			if lvl >= bossInfo.lvl then
				local bRoot, bName = findAliveByNames(bossInfo.names)
				if bRoot then
					return bRoot, bName, entry.island
				end
			end
		end
	end

	local mRoot, mName = findAliveByNames({ entry.mob })
	return mRoot, mName or entry.mob, entry.island
end

local function equipFishingRod()
	local char = player.Character
	local backpack = player:FindFirstChild("Backpack")
	if not char or not backpack then return nil end

	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower():find("rod") then return tool end
	end
	for _, tool in ipairs(backpack:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:lower():find("rod") then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then hum:EquipTool(tool) end
			return tool
		end
	end
	return nil
end

task.spawn(function()
	while task.wait(0.25) do
		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not root then continue end

		if state.autoFarmLevel then
			local targetRoot, targetName = selectBestTarget()
			titleLabel.Text = "KL // ALVO: " .. tostring(targetName)

			if targetRoot then
				root.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 9, 0), targetRoot.Position)
				pcall(function()
					VirtualUser:CaptureController()
					VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end)
			end
		elseif state.autoFish then
			titleLabel.Text = "KL // AUTO PESCA ATIVO"
			local rod = equipFishingRod()
			if rod then
				pcall(function() rod:Activate() end)
			end
		else
			titleLabel.Text = "KL // MINIMAL"
		end
	end
end)

