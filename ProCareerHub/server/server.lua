local QBCore = exports['qb-core']:GetCoreObject()

-- Debug Logging Function
function DebugLog(message, level)
    if not Config.Debug or not message then return end

    local log_level = level or "INFO"
    local log_colors = {
        ERROR = "^1",   -- Red
        WARNING = "^3", -- Yellow
        SUCCESS = "^2", -- Green
        INFO = "^4"     -- Blue
    }

    local color = log_colors[log_level] or "^7"  -- Default to white
    local formattedMessage = string.format("%s[Server - %s] %s^7", color, log_level, message)
    print(formattedMessage)
end

-- Helper Function to Get Discord Name
function GetDiscordName(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "discord:" then
            local discordId = string.sub(identifier, 9)
            return "<@" .. discordId .. ">" -- Discord ID mention format
        end
    end
    return "Unknown"
end

-- Event for Application Submission
RegisterServerEvent('police_app:submitApplication', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then
        DebugLog("Failed to retrieve player data for source: " .. tostring(src), "ERROR")
        return
    end

    local citizenid = Player.PlayerData.citizenid
    local playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local discordName = GetDiscordName(src)

    DebugLog("Received application submission from " .. playerName .. " with citizen ID " .. citizenid, "INFO")

    -- Determine the appropriate webhook URL
    local webhookUrl
    if data.type == "Police" then
        webhookUrl = webhookConfig.PoliceWebhookUrl
    elseif data.type == "EMS" then
        webhookUrl = webhookConfig.EMSWebhookUrl
    elseif data.type == "Mechanic" then
        webhookUrl = webhookConfig.MechanicWebhookUrl
    else
        DebugLog("Unknown application type: " .. data.type, "ERROR")
        return
    end

    DebugLog("Application type: " .. data.type, "INFO")

    -- Build the application content
    local content = string.format(
        "**Application Received**\n**Application Type:** %s\n**Discord Name:** %s\n**Citizen ID:** %s\n**Player Name:** %s\n\n",
        data.type, discordName, citizenid, playerName
    )

    for index, answer in ipairs(data.answers) do
        content = content .. string.format("**Q%d:** %s\n**A:** %s\n\n", index, data.questions[index] or "Unknown Question", answer)
    end

    DebugLog("Built application content for " .. playerName, "INFO")

    -- Send to Discord Webhook
    PerformHttpRequest(webhookUrl, function(err, text, headers)
        if err ~= 200 then
            DebugLog("Discord webhook failed with error code: " .. tostring(err), "ERROR")
        else
            DebugLog("Successfully sent application to Discord webhook for " .. playerName, "SUCCESS")
        end
    end, 'POST', json.encode({
        username = 'Application System',
        embeds = {{
            title = string.format("New %s Application", data.type),
            color = 3066993,
            description = content,
            footer = { text = "Application System" },
        }}
    }), { ['Content-Type'] = 'application/json' })
end)
