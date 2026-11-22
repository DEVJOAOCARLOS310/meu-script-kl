local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

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
	{ min = 0,    max = 9,    sea = 1, island = "Starter Island",       questNpc = "Quest", mob = "Soldier",          goalCount = 4, bosses = {} },
	{ min = 10,   max = 19,   sea = 1, island = "Starter Island",       questNpc = "Quest", mob = "Clown Pirate",     goalCount = 5, bosses = {} },
	{ min = 20,   max = 29,   sea = 1, island = "Starter Island",       questNpc = "Quest", mob = "Clown Pirate",     goalCount = 5, bosses = { { lvl = 20, names = { "Smoky" } } } },
	{ min = 30,   max = 49,   sea = 1, island = "Starter Island",       questNpc = "Quest", mob = "Clown Pirate",     goalCount = 5, bosses = { { lvl = 30, names = { "Tashi" } }, { lvl = 20, names = { "Smoky" } } } },
	{ min = 50,   max = 74,   sea = 1, island = "Pirate Island",        questNpc = "Quest", mob = "Clown Swordsman",  goalCount = 6, bosses = {} },
	{ min = 75,   max = 99,   sea = 1, island = "Pirate Island",        questNpc = "Quest", mob = "Clown Swordsman",  goalCount = 6, bosses = { { lvl = 75, names = { "The Clown", "Captain Clown" } } } },
	{ min = 100,  max = 119,  sea = 1, island = "Soldier Island",       questNpc = "Quest", mob = "Soldier",          goalCount = 4, bosses = {} },
	{ min = 120,  max = 144,  sea = 1, island = "Soldier Island",       questNpc = "Quest", mob = "Soldier",          goalCount = 4, bosses = { { lvl = 120, names = { "The Captain" } } } },
	{ min = 145,  max = 179,  sea = 1, island = "Soldier Island",       questNpc = "Quest", mob = "Soldier",          goalCount = 4, bosses = { { lvl = 145, names = { "The Barbaric" } }, { lvl = 120, names = { "The Captain" } } } },
	{ min = 180,  max = 199,  sea = 1, island = "Shark Island",         questNpc = "Quest", mob = "Fighter Fishman",  goalCount = 4, bosses = {} },
	{ min = 200,  max = 229,  sea = 1, island = "Shark Island",         questNpc = "Quest", mob = "Fighter Fishman",  goalCount = 4, bosses = { { lvl = 200, names = { "Karate Fishman" } } } },
	{ min = 230,  max = 249,  sea = 1, island = "Shark Island",         questNpc = "Quest", mob = "Fighter Fishman",  goalCount = 4, bosses = { { lvl = 230, names = { "Shark Man" } }, { lvl = 200, names = { "Karate Fishman" } } } },
	{ min = 250,  max = 299,  sea = 1, island = "Chef Ship",            questNpc = "Quest", mob = "Pirate",           goalCount = 4, bosses = {} },
	{ min = 300,  max = 349,  sea = 1, island = "Chef Ship",            questNpc = "Quest", mob = "Pirate",           goalCount = 4, bosses = { { lvl = 300, names = { "Dark Leg" } } } },
	{ min = 350,  max = 399,  sea = 1, island = "Chef Ship",            questNpc = "Quest", mob = "Pirate",           goalCount = 4, bosses = { { lvl = 350, names = { "Dory" } }, { lvl = 300, names = { "Dark Leg" } } } },
	{ min = 400,  max = 449,  sea = 1, island = "Snow Island",          questNpc = "Quest", mob = "Snow Soldier",     goalCount = 4, bosses = {} },
	{ min = 450,  max = 499,  sea = 1, island = "Snow Island",          questNpc = "Quest", mob = "Snow Soldier",     goalCount = 4, bosses = { { lvl = 450, names = { "King of Snow" } } } },
	{ min = 500,  max = 524,  sea = 1, island = "Snow Island",          questNpc = "Quest", mob = "Snow Soldier",     goalCount = 4, bosses = { { lvl = 500, names = { "Little Dear" } }, { lvl = 450, names = { "King of Snow" } } } },
	{ min = 525,  max = 624,  sea = 1, island = "Sand Kingdom",         questNpc = "Quest", mob = "Desert Thief",     goalCount = 4, bosses = { { lvl = 525, names = { "Candle Man" } } } },
	{ min = 625,  max = 649,  sea = 1, island = "Sand Kingdom",         questNpc = "Quest", mob = "Desert Thief",     goalCount = 4, bosses = { { lvl = 625, names = { "Bomb Man" } }, { lvl = 525, names = { "Candle Man" } } } },
	{ min = 650,  max = 724,  sea = 1, island = "Sand Kingdom",         questNpc = "Quest", mob = "Sand Bandit",      goalCount = 4, bosses = {} },
	{ min = 725,  max = 799,  sea = 1, island = "Sand Kingdom",         questNpc = "Quest", mob = "Sand Bandit",      goalCount = 4, bosses = { { lvl = 725, names = { "King of Sand" } } } },
	{ min = 800,  max = 849,  sea = 1, island = "Sky Island",           questNpc = "Quest", mob = "Sky Soldier",      goalCount = 4, bosses = {} },
	{ min = 850,  max = 899,  sea = 1, island = "Sky Island",           questNpc = "Quest", mob = "Sky Soldier",      goalCount = 4, bosses = { { lvl = 850, names = { "Ball Man" } } } },
	{ min = 900,  max = 924,  sea = 1, island = "Sky Island",           questNpc = "Quest", mob = "Sky Soldier",      goalCount = 4, bosses = { { lvl = 900, names = { "Rumble Man" } }, { lvl = 850, names = { "Ball Man" } } } },
	{ min = 925,  max = 999,  sea = 1, island = "Sky Island",           questNpc = "Quest", mob = "Guard",            goalCount = 4, bosses = { { lvl = 900, names = { "Rumble Man" } } } },
	{ min = 1000, max = 1049, sea = 1, island = "Bubble Island",        questNpc = "Quest", mob = "Bounty Hunter",    goalCount = 4, bosses = {} },
	{ min = 1050, max = 1099, sea = 1, island = "Bubble Island",        questNpc = "Quest", mob = "Slave",            goalCount = 4, bosses = {} },
	{ min = 1100, max = 1149, sea = 1, island = "Bubble Island",        questNpc = "Quest", mob = "Slave",            goalCount = 4, bosses = { { lvl = 1100, names = { "Leader" } } } },
	{ min = 1150, max = 1249, sea = 1, island = "Bubble Island",        questNpc = "Quest", mob = "Slave",            goalCount = 4, bosses = { { lvl = 1150, names = { "Pasta" } }, { lvl = 1100, names = { "Leader" } } } },
	{ min = 1250, max = 1324, sea = 1, island = "Lobby Island",         questNpc = "Quest", mob = "Marine",           goalCount = 4, bosses = { { lvl = 1250, names = { "Wolf" } } } },
	{ min = 1325, max = 1374, sea = 1, island = "Lobby Island",         questNpc = "Quest", mob = "Marine",           goalCount = 4, bosses = { { lvl = 1325, names = { "Giraffe" } }, { lvl = 1250, names = { "Wolf" } } } },
	{ min = 1375, max = 1399, sea = 1, island = "Lobby Island",         questNpc = "Quest", mob = "Agent",            goalCount = 4, bosses = {} },
	{ min = 1400, max = 1499, sea = 1, island = "Lobby Island",         questNpc = "Quest", mob = "Agent",            goalCount = 4, bosses = { { lvl = 1400, names = { "Leo" } } } },
	{ min = 1500, max = 1624, sea = 1, island = "Zombie Island",        questNpc = "Quest", mob = "Zombie",           goalCount = 4, bosses = {} },
	{ min = 1625, max = 1649, sea = 1, island = "Zombie Island",        questNpc = "Quest", mob = "Elite Zombie",     goalCount = 4, bosses = {} },
	{ min = 1650, max = 1749, sea = 1, island = "Zombie Island",        questNpc = "Quest", mob = "Elite Zombie",     goalCount = 4, bosses = { { lvl = 1650, names = { "Shadow Master" } } } },
	{ min = 1700, max = 1849, sea = 1, island = "War Island",           questNpc = "Quest", mob = "New World Pirate", goalCount = 4, bosses = {} },
	{ min = 1850, max = 1924, sea = 1, island = "War Island",           questNpc = "Quest", mob = "Marine Soldier",   goalCount = 4, bosses = { { lvl = 1850, names = { "True Karate Fishman" } } } },
	{ min = 1925, max = 1999, sea = 1, island = "War Island",           questNpc = "Quest", mob = "Vice Admiral",     goalCount = 4, bosses = { { lvl = 1925, names = { "Quake Woman" } } } },
	{ min = 2000, max = 2124, sea = 1, island = "Fishland",             questNpc = "Quest", mob = "Fishman Soldier",  goalCount = 4, bosses = {} },
	{ min = 2125, max = 2149, sea = 1, island = "Fishland",             questNpc = "Quest", mob = "Seasoned Fishman", goalCount = 4, bosses = {} },
	{ min = 2150, max = 2249, sea = 1, island = "Fishland",             questNpc = "Quest", mob = "Seasoned Fishman", goalCount = 4, bosses = { { lvl = 2150, names = { "Fishman Lord", "Shark Man V2" } } } },
	{ min = 2250, max = 2299, sea = 2, island = "Floresco",             questNpc = "Quest", mob = "Bandit",           goalCount = 4, bosses = {} },
	{ min = 2300, max = 2399, sea = 2, island = "Floresco",             questNpc = "Quest", mob = "Trainee",          goalCount = 4, bosses = { { lvl = 2350, names = { "Joey" } } } },
	{ min = 2400, max = 2474, sea = 2, island = "Floresco",             questNpc = "Quest", mob = "Samurai",          goalCount = 4, bosses = { { lvl = 2450, names = { "Flame User" } } } },
	{ min = 2475, max = 2549, sea = 2, island = "Floresco",             questNpc = "Quest", mob = "Assassin",         goalCount = 4, bosses = { { lvl = 2475, names = { "Oden", "Kawamatsu", "Denjiro", "Ashura", "Kinemon", "Kiku", "Izou" } } } },
	{ min = 2550, max = 2649, sea = 2, island = "Skull Island",         questNpc = "Quest", mob = "Pirate",           goalCount = 4, bosses = {} },
	{ min = 2650, max = 2749, sea = 2, island = "Skull Island",         questNpc = "Quest", mob = "Brute",            goalCount = 4, bosses = { { lvl = 2700, names = { "Lord of Saber", "Elite Skeleton" } } } },
	{ min = 2750, max = 2874, sea = 2, island = "Dead Tundra",          questNpc = "Quest", mob = "Snow Bandit",      goalCount = 4, bosses = {} },
	{ min = 2875, max = 2999, sea = 2, island = "Dead Tundra",          questNpc = "Quest", mob = "Yeti",             goalCount = 4, bosses = { { lvl = 2950, names = { "Mammoth", "Ice King", "Pharaoh" } } } },
	{ min = 3000, max = 3099, sea = 2, island = "Loaf Island",          questNpc = "Quest", mob = "Biscuit Soldier",  goalCount = 4, bosses = { { lvl = 3050, names = { "Biscuit Man", "Lord of Saber", "Elite Skeleton" } } } },
	{ min = 3100, max = 3174, sea = 2, island = "Loaf Island",          questNpc = "Quest", mob = "Chess Soldier",    goalCount = 4, bosses = { { lvl = 3125, names = { "Dough Master" } } } },
	{ min = 3175, max = 3274, sea = 2, island = "Shred Endangering",    questNpc = "Quest", mob = "Hazmat Guard",     goalCount = 4, bosses = { { lvl = 3175, names = { "Pharaoh", "Biscuit Man" } } } },
	{ min = 3275, max = 3374, sea = 2, island = "Shred Endangering",    questNpc = "Quest", mob = "Scientist",        goalCount = 4, bosses = { { lvl = 3350, names = { "Gas Man", "Smoke Admiral", "Crimson Demon" } } } },
	{ min = 3375, max = 3474, sea = 2, island = "Pirate Skull Island",  questNpc = "Quest", mob = "Beast Pirate",     goalCount = 4, bosses = { { lvl = 3425, names = { "Jack" } } } },
	{ min = 3475, max = 3599, sea = 2, island = "Pirate Skull Island",  questNpc = "Quest", mob = "Headliner",        goalCount = 4, bosses = { { lvl = 3525, names = { "Queen" } } } },
	{ min = 3600, max = 3699, sea = 2, island = "Soldier Headquarters", questNpc = "Quest", mob = "HQ Marine",        goalCount = 4, bosses = {} },
	{ min = 3700, max = 3799, sea = 2, island = "Soldier Headquarters", questNpc = "Quest", mob = "Captain",          goalCount = 4, bosses = { { lvl = 3750, names = { "Fleet Admiral", "Magma Admiral" } } } },
	{ min = 3800, max = 3849, sea = 2, island = "Fiore",                questNpc = "Quest", mob = "Fiore Guard",      goalCount = 4, bosses = { { lvl = 3825, names = { "Pica" } } } },
	{ min = 3850, max = 3924, sea = 2, island = "Fiore",                questNpc = "Quest", mob = "Captain",          goalCount = 4, bosses = { { lvl = 3875, names = { "Diamante" } } } },
	{ min = 3925, max = 3999, sea = 2, island = "Fiore",                questNpc = "Quest", mob = "Gladiator",        goalCount = 4, bosses = { { lvl = 3975, names = { "String Man" } }, { lvl = 3925, names = { "Trebol" } } } },
	{ min = 4000, max = 4099, sea = 3, island = "The Unearthly",        questNpc = "Quest", mob = "Jungle Ape",       goalCount = 4, bosses = {} },
	{ min = 4100, max = 4199, sea = 3, island = "The Unearthly",        questNpc = "Quest", mob = "Bushido Ape",      goalCount = 4, bosses = { { lvl = 4150, names = { "Bushido Ape" } } } },
	{ min = 4200, max = 4299, sea = 3, island = "The Unearthly",        questNpc = "Quest", mob = "Cyborg Gorilla",   goalCount = 4, bosses = { { lvl = 4250, names = { "Cyborg Gorilla Boss", "Cyborg Gorilla" } } } },
	{ min = 4300, max = 4349, sea = 3, island = "The Shallow",          questNpc = "Quest", mob = "Deep Sea Dweller", goalCount = 4, bosses = {} },
	{ min = 4350, max = 4399, sea = 3, island = "The Shallow",          questNpc = "Quest", mob = "Trench Warrior",   goalCount = 4, bosses = { { lvl = 4375, names = { "Trench Captain", "Deep Sea Lord" } } } },
	{ min = 4400, max = 4474, sea = 3, island = "Drakenhold Fortress",  questNpc = "Quest", mob = "Dragon Guard",     goalCount = 4, bosses = {} },
	{ min = 4475, max = 4549, sea = 3, island = "Drakenhold Fortress",  questNpc = "Quest", mob = "Draken Knight",    goalCount = 4, bosses = { { lvl = 4500, names = { "Draken Knight Captain" } } } },
	{ min = 4550, max = 4674, sea = 3, island = "Forgotten Coliseum",   questNpc = "Quest", mob = "Ocean Gladiator",  goalCount = 4, bosses = {} },
	{ min = 4675, max = 4799, sea = 3, island = "Forgotten Coliseum",   questNpc = "Quest", mob = "Coliseum Fighter", goalCount = 4, bosses = { { lvl = 4750, names = { "Coliseum Champion", "Gladiator Boss" } } } },
	{ min = 4800, max = 4874, sea = 3, island = "Land of Detention",    questNpc = "Quest", mob = "Warden Guard",     goalCount = 4, bosses = {} },
	{ min = 4875, max = 5450, sea = 3, island = "Land of Detention",    questNpc = "Quest", mob = "Jailer",           goalCount = 4, bosses = { { lvl = 4950, names = { "Chief Warden", "Luma" } } } },
}

local guiParent = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui", 10)
if not guiParent then return end

if guiParent:FindFirstChild("KL_MinimalSquare") then
	pcall(function()
		guiParent.KL_MinimalSquare:Destroy()
	end)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KL_MinimalSquare"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
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
addCheck("FARM", "Auto Quest (NPC Quest)", "autoQuest")
addCheck("FARM", "Auto Pesca (Fishing)", "autoFish")
addCheck("FARM", "Farm Todos os Materiais", "autoMaterial")
addCheck("FARM", "Auto Raid", "autoRaid")

addCheck("BOSS/SEA", "Farm Sea King", "farmSeaKing")
addCheck("BOSS/SEA", "Farm Hydra", "farmHydra")
addCheck("BOSS/SEA", "Farm Bosses Gerais", "farmAllBosses")
addCheck("BOSS/SEA", "Hop Sea King (1h/4h/5h)", "hopSeaKing")
addCheck("BOSS/SEA", "Hop Hydra (3h/6h)", "hopHydra")
addCheck("BOSS/SEA", "Hop
