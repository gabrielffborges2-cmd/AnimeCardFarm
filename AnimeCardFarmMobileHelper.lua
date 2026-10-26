-- Anime Card Farm Mobile Helper
-- Tenta usar os botoes nativos visiveis do jogo; nomes da interface podem variar.
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local previous = playerGui:FindFirstChild("AnimeCardFarmHelper")
if previous then previous:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "AnimeCardFarmHelper"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(250, 230)
panel.Position = UDim2.new(0, 14, 0.35, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 27, 38)
panel.BorderSizePixel = 0
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(105, 115, 255)
outline.Thickness = 1.5
outline.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -42, 0, 34)
title.Position = UDim2.fromOffset(10, 4)
title.BackgroundTransparency = 1
title.Text = "ANIME CARD FARM"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(28, 28)
close.Position = UDim2.new(1, -34, 0, 7)
close.Text = "X"
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(160, 55, 65)
close.Parent = panel
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)
close.Activated:Connect(function() gui:Destroy() end)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 32)
status.Position = UDim2.fromOffset(10, 38)
status.BackgroundTransparency = 1
status.Text = "Status: pronto"
status.TextColor3 = Color3.fromRGB(205, 208, 225)
status.TextWrapped = true
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.Parent = panel

local function findButton(words)
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Visible then
            local txt = string.lower(obj.Text or "")
            for _, word in ipairs(words) do
                if string.find(txt, word, 1, true) then return obj end
            end
        end
    end
end

local function activateNative(words)
    local button = findButton(words)
    if not button then return false, "Abra a tela do jogo com essa opcao primeiro." end
    local ok = pcall(function() button:Activate() end)
    if ok then return true, "Acionado: " .. button.Text end
    return false, "O jogo nao permitiu acionar esse botao."
end

local function makeButton(text, y, words)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 38)
    b.Position = UDim2.fromOffset(10, y)
    b.BackgroundColor3 = Color3.fromRGB(60, 66, 112)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.Parent = panel
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.Activated:Connect(function()
        local ok, message = activateNative(words)
        status.Text = (ok and "OK: " or "Aviso: ") .. message
    end)
end

makeButton("Compra Automatica", 78, {"compra automatica", "compra automática", "auto buy"})
makeButton("Geracao Automatica", 122, {"geracao automatica", "geração automática", "auto generation"})
makeButton("Transportador Automatico", 166, {"transportador automatico", "transportador automático", "auto conveyor"})

local note = Instance.new("TextLabel")
note.Size = UDim2.new(1, -20, 0, 22)
note.Position = UDim2.fromOffset(10, 207)
note.BackgroundTransparency = 1
note.Text = "Se nao encontrar, use as opcoes nativas."
note.TextColor3 = Color3.fromRGB(160, 165, 190)
note.Font = Enum.Font.Gotham
note.TextSize = 9
note.Parent = panel
