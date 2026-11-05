-- Wait for the game workspace to fully load
if not game:IsLoaded() then game.Loaded:Wait() end

-- The 100% verified target dictionary combining all your console logs
local verifiedTargets = {
    -- Kolona Group
    ["kolona"] = true,
    ["kolona_ai"] = true,
    
    -- Operator Group
    ["operator"] = true,
    ["operator_ai"] = true,
    ["vboperator"] = true,
    ["operatorhalt"] = true,

    -- Voidbreaker Group (Added from your logs!)
    ["voidbreaker"] = true,
    ["voidbreaker_ai"] = true,

    -- Scrapmaw Group (Added from your logs!)
    ["scrapmaw"] = true,
    ["scrapmaw_ai"] = true
}

-- Target evaluation function
local function cleanTarget(instance)
    if instance then
        local lowerName = string.lower(instance.Name)
        
        -- Instantly remove if it matches any verified log entry
        if verifiedTargets[lowerName] then
            print("[Matrix Cleaner] Erased verified target: " .. tostring(instance.Name))
            instance:Destroy()
        end
    end
end

-- 1. Initial Map Sweep: Scan everything currently loaded
for _, item in pairs(workspace:GetDescendants()) do
    cleanTarget(item)
end

-- 2. Active Monitor: Intercept the exact millisecond a new instance appears
workspace.DescendantAdded:Connect(cleanTarget)

-- Standard system confirmation popup
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "All Log Entries Applied",
    Text = "Monitoring actively for Kolona, Operator, Voidbreaker, and Scrapmaw.",
    Duration = 5
})

