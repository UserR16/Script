local repo = 'https://raw.githubusercontent.com/deividcomsono/Obsidian/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = true
Library.NotifySide = "Right"

local Window = Library:CreateWindow({
	Title = "Forsaken",
    Font = Enum.Font.RobotoMono,
	NotifySide = "Right"
})

local Tabs = {
  Main = Window:AddTab("Main"),
  Players = Window:AddTab("Players"),
  Visual = Window:AddTab("Visual")
}

local Generator = Tabs.Main:AddLeftGroupbox("Generator", "boxes")
Generator:AddDropdown('SelectFixMode',{
    Text = "Select Fix Mode",
    Values = {"Fast", "Normal", "Slow"},
    Default = 2,
  	Multi = false,
    Callback = function(v)
_G.SelectFixMode = v or "Normal"
end})
_G.SelectFixMode = "Normal"
Generator:AddToggle("AutoGenerator",{
    Text = "Auto Generator",
    Default = false,
    Callback = function(v)
_G.AutoGenerator = v
while _G.AutoGenerator do
if _G.SelectFixMode == "Fast" and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
wait(1.75)
for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
if v.Name == "Generator" then
v.Remotes.RE:FireServer()
end
end
elseif _G.SelectFixMode == "Normal" and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
wait(3.75)
for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
if v.Name == "Generator" then
v.Remotes.RE:FireServer()
end
end
elseif _G.SelectFixMode == "Slow" and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
wait(5.75)
for _,v in ipairs(workspace["Map"]["Ingame"]["Map"]:GetChildren()) do
if v.Name == "Generator" then
v.Remotes.RE:FireServer()
end
end
end
task.wait()
end
end})

local Other = Tabs.Main:AddRightGroupbox("Other", "boxes")
Other:AddToggle("HidingGeneratorUi",{
    Text = "Hiding Generator Ui",
    Default = false,
    Callback = function(v)
_G.HidingGeneratorUi = v
game:GetService("RunService").RenderStepped:Connect(function()
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI") then
game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PuzzleUI").Enabled = not _G.HidingGeneratorUi
end
end)
end})
Other:AddToggle("HidingSurvivorBar",{
    Text = "Hiding Survivors Bar",
    Default = false,
    Callback = function(v)
_G.HidingSurvivorBar = v
game:GetService("RunService").RenderStepped:Connect(function()
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI"):FindFirstChild("PlayerInfo"):FindFirstChild("CurrentSurvivors") then
game.Players.LocalPlayer.PlayerGui:FindFirstChild("TemporaryUI"):FindFirstChild("PlayerInfo"):FindFirstChild("CurrentSurvivors").Visible = not _G.HidingSurvivorBar
end
end)
end})

local Miscellaneous = Tabs.Main:AddLeftGroupbox("Miscellaneous", "boxes")
game:GetService("RunService").RenderStepped:Connect(function()
if _G.AutoEatPizza and workspace.Map.Ingame:FindFirstChild("Pizza") then
if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth and (workspace.Map:FindFirstChild("Ingame"):FindFirstChild("Pizza").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 then
workspace.Map.Ingame:FindFirstChild("Pizza").Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
end
end
end)
Miscellaneous:AddToggle("AutoEatPizza",{
    Text = "Auto Pizza ( Near Distance )",
    Default = false,
    Callback = function(v)
_G.AutoEatPizza = v
end})

local Players = Tabs.Players:AddLeftGroupbox("Players", "boxes")
StaminaScript = require(game:GetService("ReplicatedStorage").Systems.Character.Game.Sprinting)
game:GetService("RunService").RenderStepped:Connect(function()
StaminaScript.MaxStamina = _G.MaxStamina or 100
StaminaScript.StaminaGain = _G.StaminaGain or 30
StaminaScript.StaminaLoss = _G.StaminaLoss or 10
StaminaScript.SprintSpeed = _G.SprintSpeed or 27.5
end)
Players:AddSlider("MaxStamina",{
    Text = "Max Stamina",
    Default = 100,
    Min = 100,
    Max = 5000,
    Rounding = 0,
    Compact = false,
    Callback = function(v)
_G.MaxStamina = v
end})
Players:AddSlider("StaminaGain",{
    Text = "Stamina Gain",
    Default = 30,
    Min = 30,
    Max = 5000,
    Rounding = 0,
    Compact = false,
    Callback = function(v)
_G.StaminaGain = v
end})
Players:AddSlider("StaminaLoss",{
    Text = "Stamina Loss",
    Default = 10,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Compact = false,
    Callback = function(v)
_G.StaminaLoss = v
end})
Players:AddSlider("SprintSpeed",{
    Text = "Sprint Speed",
    Default = 27.5,
    Min = 27.5,
    Max = 32,
    Rounding = 1,
    Compact = false,
    Callback = function(v)
_G.SprintSpeed = v
end})


local Cheater = Tabs.Players:AddRightGroupbox("Cheater", "boxes")
Cheater:AddToggle("Invisible",{
    Text = "Invisible",
    Default = false,
    Callback = function(v)
_G.Invisible = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.Invisible and game.Players.LocalPlayer.Character.Parent ~= workspace.Players.Spectating then
local Animation = Instance.new("Animation")
Animation.Name = "Invisible_Animation"
Animation.AnimationId = "rbxassetid://75804462760596"
local Load = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Animation)
Load:Play(0,1,1)
Load:AdjustSpeed(0)
else
for i,v in next, game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks() do
if v.Animation.Name == "Invisible_Animation" then
v:Stop()
end
end
end
end)
end})
Cheater:AddToggle("SpamFootstep",{
    Text = "Spam Footstep (FE)",
    Default = false,
    Callback = function(v)
_G.SpamFootstep = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.SpamFootstep then
game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"):WaitForChild("UnreliableRemoteEvent"):FireServer("FootstepPlayed", 9)
end
end)
end})
Cheater:AddDivider()
Cheater:AddToggle("NoSlowness",{
    Text = "No Slowness",
    Default = false,
    Callback = function(v)
_G.NoSlowness = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.NoSlowness and game:GetService("ReplicatedStorage").Modules.StatusEffects:FindFirstChild("Slowness") then
game:GetService("ReplicatedStorage").Modules.StatusEffects:FindFirstChild("Slowness"):Destroy()
end
end)
end})
Cheater:AddToggle("NoBlindness",{
    Text = "No Blindness",
    Default = false,
    Callback = function(v)
_G.NoBlindness = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.NoBlindness and game:GetService("ReplicatedStorage").Modules.StatusEffects:FindFirstChild("Blindness") then
game:GetService("ReplicatedStorage").Modules.StatusEffects:FindFirstChild("Blindness"):Destroy()
end
end)
end})

local Camera = Tabs.Visual:AddLeftGroupbox("Camera", "boxes")
Camera:AddSlider("FovValue",{
    Text = "Field Of View",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 1,
    Compact = false,
    Callback = function(v)
_G.FovValue = v
end})
Camera:AddToggle("Fov",{
    Text = "Field Of View",
    Default = false,
    Callback = function(v)
_G.FieldOfView = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.FieldOfView then
workspace.Camera.FieldOfView = _G.FovValue or 70
end
end)
end})
Camera:AddDivider()
Camera:AddToggle("Fullbright",{
    Text = "Fullbright",
    Default = false,
    Callback = function(v)
_G.Fullbright = v
game:GetService("RunService").RenderStepped:Connect(function()
if _G.Fullbright then
game.Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
game.Lighting.Brightness = 1.5
game.Lighting.GlobalShadows = false
else
game.Lighting.OutdoorAmbient = Color3.fromRGB(55,55,55)
game.Lighting.Brightness = 1.5
game.Lighting.GlobalShadows = true
end
end)
end})
Camera:AddToggle("NoFog",{
    Text = "No Fog",
    Default = false,
    Callback = function(v)
_G.NoFog = v
game:GetService("RunService").RenderStepped:Connect(function()
if not game.Lighting:GetAttribute("FogStart") then game.Lighting:SetAttribute("FogStart", game.Lighting.FogStart) end
if not game.Lighting:GetAttribute("FogEnd") then game.Lighting:SetAttribute("FogEnd", game.Lighting.FogEnd) end
game.Lighting.FogStart = _G.NoFog and 0 or game.Lighting:GetAttribute("FogStart")
game.Lighting.FogEnd = _G.NoFog and math.huge or game.Lighting:GetAttribute("FogEnd")
local fog = game.Lighting:FindFirstChildOfClass("Atmosphere")
if fog then
if not fog:GetAttribute("Density") then fog:SetAttribute("Density", fog.Density) end
fog.Density = _G.NoFog and 0 or fog:GetAttribute("Density")
end
end)
end})

local ESP = Tabs.Visual:AddRightGroupbox("ESP", "boxes")
--// Create Text \\
local function Text(target, title, color, fontsize, name)
local Billboard = Instance.new("BillboardGui", target)
local TextLabel = Instance.new("TextLabel", Billboard)
local UIStroke = Instance.new("UIStroke", TextLabel)
--// Billboard \\
Billboard.AlwaysOnTop = true
Billboard.Size = UDim2.new(0,400,0,100)
Billboard.Name = name
Billboard.Active = true
--// TextLabel \\
TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
TextLabel.BackgroundTransparency = 1
TextLabel.BackgroundColor3 = Color3.new(0,0,0)
TextLabel.TextColor3 = color
TextLabel.Font = "Roboto"
TextLabel.TextSize = fontsize
TextLabel.TextTransparency = 0
TextLabel.Visible = true
TextLabel.Text = title
TextLabel.Size = UDim2.new(1,0,0,0)
TextLabel.Position = UDim2.new(0.5,0,0.7,-25)
--// UIStroke \\
UIStroke.Thickness = 1
UIStroke.Color = Color3.new()
UIStroke.Transparency = 0
end
--// Create Highlight \\
local function Highlight(target, color, name)
task.wait(0.25)
local Highlight = Instance.new('Highlight', target)
--// Highlight \\
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
Highlight.FillColor = color
Highlight.OutlineColor = color
Highlight.FillTransparency = 1
Highlight.OutlineTransparency =  0.8
Highlight.Name = name
end
--// Disable Text & Highlight \\
local function Disable(name)
for _,v in ipairs(workspace:GetDescendants()) do
if v.Name == name then
v:Destroy()
end
end
end
ESP:AddToggle("KillerESP",{
    Text = "Killer ESP",
    Default = false,
    Callback = function(v)
if v then
for _, v in pairs(workspace.Players.Killers:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Killers" then
Text(v.HumanoidRootPart, v.Name .. "\n" .. v:GetAttribute("SkinNameDisplay"), Color3.new(1), 14, "Killer_ESP")
Highlight(v, Color3.new(1), "Killer_ESP")
end
end
KillerESP = workspace.Players.Killers.ChildAdded:Connect(function(v)
wait(2)
if v:IsA("Model") and v.Parent.Name == "Killers" then
Text(v.HumanoidRootPart, v.Name .. "\n" .. v:GetAttribute("SkinNameDisplay"), Color3.new(1), 14, "Killer_ESP")
Highlight(v, Color3.new(1), "Killer_ESP")
end
end)
else
KillerESP:Disconnect()
Disable("Killer_ESP")
end
end})
ESP:AddToggle("SurvivorESP",{
    Text = "Survivor ESP",
    Default = false,
    Callback = function(v)
if v then
for _, v in ipairs(workspace.Players.Survivors:GetChildren()) do
if v:IsA("Model") and v.Parent.Name == "Survivors" then
Text(v.HumanoidRootPart, v.Name, Color3.new(0,1), 14, "Survivor_ESP")
Highlight(v, Color3.new(0,1), "Survivor_ESP")
end
end
SurvivalESP = workspace.Players.Survivors.ChildAdded:Connect(function(v)
wait(2)
if v:IsA("Model") and v.Parent.Name == "Survivors" then
Text(v.HumanoidRootPart, v.Name, Color3.new(0,1), 14, "Survivor_ESP")
Highlight(v, Color3.new(0,1), "Survivor_ESP")
end
end)
else
SurvivalESP:Disconnect()
Disable("Survivor_ESP")
end
end})
ESP:AddToggle("ItemsESP",{
    Text = "Items ESP",
    Default = false,
    Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "BloxyCola" and not v:FindFirstChild("Items_ESP") then
Text(v, v.Name, Color3.new(1,1), 14, "Items_ESP")
Highlight(v, Color3.new(1,1), "Items_ESP")
elseif v:IsA("Model") and v.Name == "Medkit" and not v:FindFirstChild("Items_ESP") then
Text(v, v.Name, Color3.new(1), 14, "Items_ESP")
Highlight(v, Color3.new(1), "Items_ESP")
end
end
ItemsESP = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v then
if v.Name == "BloxyCola" and not v:FindFirstChild("Items_ESP") then
Text(v, v.Name, Color3.new(1,1), 14, "Items_ESP")
Highlight(v, Color3.new(1,1), "Items_ESP")
elseif v.Name == "Medkit" and not v:FindFirstChild("Items_ESP") then
Text(v, v.Name, Color3.new(1), 14, "Items_ESP")
Highlight(v, Color3.new(1), "Items_ESP")
end
end
end)
else
ItemsESP:Disconnect()
Disable("Items_ESP")
end
end})
ESP:AddToggle("GeneratorESP",{
    Text = "Generator ESP",
    Default = false,
    Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Parent.Name == "Map" and v.Name == "Generator" and not v:FindFirstChild("Generator_ESP") then
Text(v, v.Name, Color3.new(0,0,1), 14, "Generator_ESP")
Highlight(v, Color3.new(0,0,1), "Generator_ESP")
end
end
GeneratorESP = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Parent.Name == "Map" and v.Name == "Generator" and not v:FindFirstChild("Generator_ESP") then
Text(v, v.Name, Color3.new(0,0,1), 14, "Generator_ESP")
Highlight(v, Color3.new(0,0,1), "Generator_ESP")
end
end)
else
GeneratorESP:Disconnect()
Disable("Generator_ESP")
end
end})
ESP:AddToggle("SubspaceTripmineESP",{
    Text = "Subspace Tripmine ESP",
    Default = false,
    Callback = function(v)
if v then
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
Text(v, "Trap", Color3.new(1,0,1), 14, "SubspaceTripmine_ESP")
Highlight(v, Color3.new(1,0,1), "SubspaceTripmine_ESP")
end
end
SubspaceTripmineESP = workspace.Map.Ingame.DescendantAdded:Connect(function(v)
wait(1)
if v:IsA("Model") and v.Name == "SubspaceTripmine" and not v:FindFirstChild("SubspaceTripmine_ESP") then
Text(v, "Trap", Color3.new(1,0,1), 14, "SubspaceTripmine_ESP")
Highlight(v, Color3.new(1,0,1), "SubspaceTripmine_ESP")
end
end)
else
SubspaceTripmineESP:Disconnect()
Disable("SubspaceTripmine_ESP")
end
end})




