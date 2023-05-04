local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayersService = game:GetService('Players')

local Loader = Instance.new("ScreenGui")
local LoaderFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TitleLabel = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local LoadingLabel = Instance.new("TextLabel")
local SupportedGameLabel = Instance.new("TextLabel")

Loader.Name = "Loader"
Loader.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Loader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

LoaderFrame.Name = "LoaderFrame"
LoaderFrame.Parent = Loader
LoaderFrame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
LoaderFrame.Position = UDim2.new(0.374576271, 0, 0.388316154, 0)
LoaderFrame.Size = UDim2.new(0, 0, 0.223024085, 0)
LoaderFrame.BackgroundTransparency = 1

UICorner.Parent = LoaderFrame

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = LoaderFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1.000
TitleLabel.Size = UDim2.new(1, 0, 0.335562408, 0)
TitleLabel.Font = Enum.Font.Unknown
TitleLabel.Text = "version"
TitleLabel.TextColor3 = Color3.fromRGB(202, 202, 202)
TitleLabel.TextSize = 46.000
TitleLabel.TextTransparency = 1

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(62, 62, 62))}
UIGradient.Rotation = 90
UIGradient.Parent = TitleLabel

LoadingLabel.Name = "LoadingLabel"
LoadingLabel.Parent = LoaderFrame
LoadingLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LoadingLabel.BackgroundTransparency = 1.000
LoadingLabel.Position = UDim2.new(0, 0, 0.789769053, 0)
LoadingLabel.Size = UDim2.new(1, 0, 0.209200025, 0)
LoadingLabel.Font = Enum.Font.Unknown
LoadingLabel.Text = "loading latest script."
LoadingLabel.TextColor3 = Color3.fromRGB(89, 89, 89)
LoadingLabel.TextSize = 14.000
LoadingLabel.TextTransparency = 1

SupportedGameLabel.Name = "SupportedGameLabel"
SupportedGameLabel.Parent = LoaderFrame
SupportedGameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SupportedGameLabel.BackgroundTransparency = 1.000
SupportedGameLabel.Position = UDim2.new(0, 0, 0.350042909, 0)
SupportedGameLabel.Size = UDim2.new(1, 0, 0.286241442, 0)
SupportedGameLabel.Font = Enum.Font.Unknown
SupportedGameLabel.Text = "unsupported game!"
SupportedGameLabel.TextColor3 = Color3.fromRGB(113, 113, 113)
SupportedGameLabel.TextSize = 18.000
SupportedGameLabel.TextTransparency = 1

local gameUnsupported = true

local tweenInfo = TweenInfo.new(0.5)

local animationStage = -1
local stopAllAnimations = false

local function LoadingAnimation()
    while wait(1) do
        if stopAllAnimations then
            break
        end

        if animationStage == 0 then
            LoadingLabel.Text = 'loading latest script..'
        elseif animationStage == 1 then
            LoadingLabel.Text = 'loading latest script...'
        elseif animationStage > 1 then
            LoadingLabel.Text = 'loading latest script.'
            animationStage = -1
        end

        animationStage += 1
    end
end

local function LoadAnimation()
    TweenService:Create(LoaderFrame, tweenInfo, {
        BackgroundTransparency = 0,
        Size = UDim2.new(0.25, 0, 0.223, 0)
    }):Play()
    
    wait(0.5)
    
    TweenService:Create(TitleLabel, tweenInfo, {
        TextTransparency = 0
    }):Play()
    wait(0.25)
    TweenService:Create(SupportedGameLabel, tweenInfo, {
        TextTransparency = 0
    }):Play()
end

local function UnloadAnimation(loading)
    TweenService:Create(LoaderFrame, tweenInfo, {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0.223, 0)
    }):Play()
        
    TweenService:Create(TitleLabel, tweenInfo, {
        TextTransparency = 1
    }):Play()
    TweenService:Create(SupportedGameLabel, tweenInfo, {
        TextTransparency = 1
    }):Play()

    if loading then
        TweenService:Create(LoadingLabel, tweenInfo, {
            TextTransparency = 1
        }):Play()
    end
end

LoadAnimation()

wait(0.5)

if not gameUnsupported then
    task.spawn(LoadingAnimation)

    TweenService:Create(LoadingLabel, tweenInfo, {
        TextTransparency = 0
    }):Play()
else
    LoadingLabel.Text = 'game unsupported, please choose a supported game.'

    TweenService:Create(LoadingLabel, tweenInfo, {
        TextTransparency = 0
    }):Play()

    wait(2)

    UnloadAnimation(true)

    stopAllAnimations = true

    wait(1.5)

    Loader:Destroy()
end