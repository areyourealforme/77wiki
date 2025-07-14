local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "r.volt", 
    Footer = "Ink Game v1.0",
    ToggleKeybind = Enum.KeyCode.Delete,
    Icon = 130680533178823,
    Center = true,
    ShowCustomCursor = false,
    AutoShow = true
})

local Tab = Window:AddTab("Main", "house")

local RedLightGreenLight = Tab:AddLeftGroupbox("Red Light Green Light")

RedLightGreenLight:AddButton({
	Text = "Finish Game",
	Func = function()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr.Character or plr.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")
		local t = workspace:WaitForChild("SQUIDDOLL123"):WaitForChild("Torso1")
		hrp.CFrame = t.CFrame * CFrame.new(0, 0, -5)
	end,
	DoubleClick = false
})

local rs = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local inj

RedLightGreenLight:AddToggle("di", {
	Text = "Disable Injury",
	Default = false,
	Callback = function(v)
		if v then
			inj = rs.RenderStepped:Connect(function()
				local char = plr.Character
				if char then
					local a = char:FindFirstChild("InjuryWalking")
					local b = char:FindFirstChild("WalkingInjury")
					if a then a:Destroy() end
					if b then b:Destroy() end
				end
			end)
		else
			if inj then inj:Disconnect() end
		end
	end
})


local HideAndSeek = Tab:AddLeftGroupbox("Hide And Seek")

local p=game:GetService("Players")
local rs=game:GetService("RunService")

local v=false

HideAndSeek:AddToggle("vh",{Text="Players ESP",Default=false,Callback=function(x)
	v=x
end})

rs.RenderStepped:Connect(function()
	if not v then return end
	for _,pl in pairs(p:GetPlayers()) do
		if pl~=p.LocalPlayer then
			local c=pl.Character
			if c and c:FindFirstChild("HumanoidRootPart") then
				local h=c:FindFirstChild("vest_h")
				if not h then
					local b=c:FindFirstChild("BlueVest")
					local r=c:FindFirstChild("RedVest")
					if b or r then
						local hl=Instance.new("Highlight")
						hl.Name="vest_h"
						hl.FillTransparency=0.6
						if b then
							hl.FillColor=Color3.fromRGB(0,170,255)
							hl.OutlineColor=Color3.fromRGB(0,85,128)
						elseif r then
							hl.FillColor=Color3.fromRGB(255,80,80)
							hl.OutlineColor=Color3.fromRGB(128,30,30)
						end
						hl.Parent=c
						hl.Adornee=c
					end
				end
			end
		end
	end
end)

local rs = game:GetService("RunService")
local espcon

HideAndSeek:AddToggle("dooresp", {
	Text = "Exit Doors ESP",
	Default = false,
	Callback = function(v)
		if v then
			espcon = rs.RenderStepped:Connect(function()
				for i = 1, 3 do
					local folder = workspace:FindFirstChild("HideAndSeekMap")
					if folder then
						local doors = folder:FindFirstChild("NEWFIXEDDOORS")
						if doors then
							local floor = doors:FindFirstChild("Floor"..i)
							if floor then
								local exits = floor:FindFirstChild("EXITDOORS")
								if exits then
									for _, m in pairs(exits:GetChildren()) do
										if m:IsA("Model") and not m:FindFirstChild("esp") then
											local h = Instance.new("Highlight")
											h.Name = "esp"
											h.FillColor = Color3.fromRGB(144, 238, 144)
											h.OutlineColor = Color3.fromRGB(0, 100, 0)
											h.FillTransparency = 0
											h.OutlineTransparency = 0
											h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
											h.Adornee = m
											h.Parent = m
										end
									end
								end
							end
						end
					end
				end
			end)
		else
			if espcon then espcon:Disconnect() end
			for i = 1, 3 do
				local folder = workspace:FindFirstChild("HideAndSeekMap")
				if folder then
					local doors = folder:FindFirstChild("NEWFIXEDDOORS")
					if doors then
						local floor = doors:FindFirstChild("Floor"..i)
						if floor then
							local exits = floor:FindFirstChild("EXITDOORS")
							if exits then
								for _, m in pairs(exits:GetChildren()) do
									if m:IsA("Model") then
										local e = m:FindFirstChild("esp")
										if e then e:Destroy() end
									end
								end
							end
						end
					end
				end
			end
		end
	end
})


local Misc = Tab:AddRightGroupbox("Misc")

local rs = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer
local d

Misc:AddToggle("di", {
	Text = "Disable Stun",
	Default = false,
	Callback = function(v)
		if v then
			d = rs.RenderStepped:Connect(function()
				local char = plr.Character
				if char then
					local a = char:FindFirstChild("Stun")
					local b = char:FindFirstChild("CantRun")
					if a then a:Destroy() end
					if b then b:Destroy() end
				end
			end)
		else
			if d then d:Disconnect() end
		end
	end
})

local p=game:GetService("Players").LocalPlayer
local o

Misc:AddToggle("ps",{Text="Get Phantom Step",Default=false,Callback=function(x) 
	if x then
		o = p:GetAttribute("_EquippedPower")
		p:SetAttribute("_EquippedPower","PHANTOM STEP")
	else
		if o then
			p:SetAttribute("_EquippedPower", o)
		end
	end
end})

local p=game:GetService("Players").LocalPlayer
local dmg
local sprint

Misc:AddToggle("dmgboost",{Text="Maximize Strength",Default=false,Callback=function(x)
	if x then
		dmg = p.Boosts["Damage Boost"].Value
		p.Boosts["Damage Boost"].Value = 5
	else
		if dmg then
			p.Boosts["Damage Boost"].Value = dmg
		end
	end
end})

Misc:AddToggle("sprintboost",{Text="Maximize Sprinting Speed",Default=false,Callback=function(x)
	if x then
		sprint = p.Boosts["Faster Sprint"].Value
		p.Boosts["Faster Sprint"].Value = 5
	else
		if sprint then
			p.Boosts["Faster Sprint"].Value = sprint
		end
	end
end})

local Rebel = Tab:AddRightGroupbox("Rebel")

Rebel:AddButton({
    Text = "Modded MP5",
    Tooltip = "Use this before picking up your gun.",
    Func = function()
        game:GetService("ReplicatedStorage").Weapons.Guns.MP5.MaxBullets.Value = math.huge
        game:GetService("ReplicatedStorage").Weapons.Guns.MP5.FireRateCD.Value = 0
        game:GetService("ReplicatedStorage").Weapons.Guns.MP5.ReloadingSpeed.Value = 0
        game:GetService("ReplicatedStorage").Weapons.Guns.MP5.Spread.Value = math.huge
        game:GetService("ReplicatedStorage").Weapons.Guns.MP5.BulletsPerFire.Value = 20
    end,
    DoubleClick = true
})
