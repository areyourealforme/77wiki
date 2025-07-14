local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local DarkFrame = Instance.new("Frame")
DarkFrame.Size = UDim2.new(1, 0, 1, 0)
DarkFrame.Position = UDim2.new(0, 0, 0, 0)
DarkFrame.BackgroundColor3 = Color3.new(0, 0, 0)
DarkFrame.BackgroundTransparency = 1
DarkFrame.Parent = ScreenGui

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(0, 300, 0, 300)
LogoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://130680533178823"
LogoImage.ImageTransparency = 1
LogoImage.Parent = ScreenGui

local FadeInTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)
local FadeOutTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)

local BlurInTween = TweenService:Create(Blur, FadeInTweenInfo, { Size = 500 })
local FrameFadeInTween = TweenService:Create(DarkFrame, FadeInTweenInfo, { BackgroundTransparency = 0.15 })
local ImageFadeInTween = TweenService:Create(LogoImage, FadeInTweenInfo, { ImageTransparency = 0 })

local BlurOutTween = TweenService:Create(Blur, FadeOutTweenInfo, { Size = 0 })
local FrameFadeOutTween = TweenService:Create(DarkFrame, FadeOutTweenInfo, { BackgroundTransparency = 1 })
local ImageFadeOutTween = TweenService:Create(LogoImage, FadeOutTweenInfo, { ImageTransparency = 1 })

BlurInTween:Play()
FrameFadeInTween:Play()
ImageFadeInTween:Play()

ImageFadeInTween.Completed:Connect(function()
	task.delay(3.2, function()
		BlurOutTween:Play()
		FrameFadeOutTween:Play()
		ImageFadeOutTween:Play()
	end)
end)

ImageFadeOutTween.Completed:Connect(function()
	ScreenGui:Destroy()
	Blur:Destroy()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/kullanici/script/main.lua"))()
end)
