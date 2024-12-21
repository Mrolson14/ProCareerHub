local QBCore = exports['qb-core']:GetCoreObject()

function DebugLog(message, level)
    if not Config.Debug or not message then return end

    local log_level = level or "INFO"
    local color = "^7"  -- Default color (white)

    local log_colors = {
        ERROR = "^1",   -- Red
        WARNING = "^3", -- Yellow
        SUCCESS = "^2", -- Green
        INFO = "^4"     -- Blue
    }

    color = log_colors[log_level] or color

    local formattedMessage = string.format("%s[Client - %s] %s%s^7", color, log_level, message, color)
    print(formattedMessage)
end

-- Spawn Ped and Register Target
function spawnPedAndRegisterTarget()
    DebugLog("Starting to spawn peds and register targets", "INFO")
    for _, pedData in pairs(Config.Questions) do
        DebugLog("Loading ped model: " .. pedData.pedmodel, "INFO")
        -- Load the ped model
        local model = GetHashKey(pedData.pedmodel)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end

        DebugLog("Creating ped at coordinates: " .. pedData.pedspwan.x .. ", " .. pedData.pedspwan.y .. ", " .. pedData.pedspwan.z, "INFO")
        -- Create the ped
        local ped = CreatePed(4, model, pedData.pedspwan.x, pedData.pedspwan.y, pedData.pedspwan.z - 1.0, pedData.heading, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        -- Define the target label dynamically
        local label = "Apply for " .. (pedData.policeapp and "Police Force" or pedData.amblanceapp and "Ambulance Service" or pedData.mechanicapp and "Mechanic Job" or "Job")
        DebugLog("Target label defined: " .. label, "INFO")

        -- Determine which application to use based on available questions
        local eventName = 'application:' .. (_ or 'generic')
        DebugLog("Event name defined: " .. eventName, "INFO")

        RegisterNetEvent(eventName, function()
            openApplicationForm(pedData)
        end)

        -- Register the ped with qb-target or ox_target
        if GetResourceState('qb-target') == 'started' then
            DebugLog("Registering ped with qb-target", "INFO")
            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        type = "client",
                        event = eventName,
                        label = label,
                        icon = "fas fa-id-card"
                    }
                },
                distance = 2.5,
            })
        elseif GetResourceState('ox_target') == 'started' then
            DebugLog("Registering ped with ox_target", "INFO")
            exports['ox_target']:addEntity(ped, {
                {
                    name = eventName,
                    label = label,
                    icon = "fas fa-id-card",
                    event = eventName,
                }
            })
        else
            DebugLog("Neither qb-target nor ox_target is available!", "ERROR")
            print("[ERROR] Neither qb-target nor ox_target is available!")
        end
    end
    DebugLog("Finished spawning peds and registering targets", "INFO")
end

-- Open Application Form
function openApplicationForm(pedData)
    DebugLog("Opening application form", "INFO")
    local questions = pedData.policeapp or pedData.amblanceapp or pedData.mechanicapp
    local formFields = {}

    -- Prepare form fields using ox_lib input dialog
    for i, question in ipairs(questions) do
        DebugLog("Adding question to form: " .. question, "INFO")
        table.insert(formFields, {
            type = 'textarea', -- Using textarea for long text input
            label = question,
            name = 'q' .. i, -- Unique name for each input field
            required = true, -- Make the input required
            placeholder = "Write your answer here..." -- Placeholder text
        })
    end

    -- Open the input dialog
    local answers = lib.inputDialog("Application Form", formFields)

    if answers then
        DebugLog("Application submitted with answers", "SUCCESS")
        -- Send answers to the server
        TriggerServerEvent('police_app:submitApplication', {
            answers = answers,
            questions = pedData.policeapp or pedData.amblanceapp or pedData.mechanicapp,
            type = pedData.policeapp and "Police" or pedData.amblanceapp and "EMS" or "Mechanic"
        })
        lib.notify({
            title = 'Application Submitted',
            description = 'Your application has been submitted successfully!',
            type = 'success'
        })
    else
        DebugLog("Application canceled", "WARNING")
        lib.notify({
            title = 'Application Canceled',
            description = 'You canceled the application.',
            type = 'error'
        })
    end
end

-- Spawn peds and register target
CreateThread(function()
    DebugLog("Starting thread to spawn peds and register targets", "INFO")
    spawnPedAndRegisterTarget()
end)
