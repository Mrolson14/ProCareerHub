Config = {}

Config.Debug = true

-- Questions for the application
Config.Questions = {
    [1] = {
        pedmodel = "s_m_y_cop_01",
        pedspwan = vector4(434.02, -979.24, 30.71, 95),
        policeapp = {
            [1] = "What is your name?",
            [2] = "How old are you?",
            [3] = "Why do you want to join the police force?",
            [4] = "Do you have any prior experience in law enforcement?",
            [5] = "How would you handle a high-pressure situation?",
            [6] = "Describe your communication skills.",
            [7] = "What are your strengths?",
            [8] = "What are your weaknesses?",
            [9] = "How would you handle a dispute with another officer?",
            [10] = "Any additional information you'd like to provide?"
        }
    },
    [2] = {
        pedmodel = "s_f_y_scrubs_01",
        pedspwan = vector4(309.82, -585.76, 43.25, 94),
        amblanceapp = {
            [1] = "What is your name?",
            [2] = "How old are you?",
            [3] = "Why do you want to join the ambulance service?",
            [4] = "Do you have any prior experience in emergency medical services?",
            [5] = "How would you handle a high-pressure situation?",
            [6] = "Describe your communication skills.",
            [7] = "What are your strengths?",
            [8] = "What are your weaknesses?",
            [9] = "How would you handle a dispute with another medic?",
            [10] = "Any additional information you'd like to provide?"
        }
    },
    [3] = {
        pedmodel = "mp_m_waremech_01",
        pedspwan = vector4(-226.15, -1324.31, 31.30, 81),
        mechanicapp = {
            [1] = "What is your name?",
            [2] = "How old are you?",
            [3] = "Why do you want to join the mechanic shop?",
            [4] = "Do you have any prior experience in vehicle repair?",
            [5] = "How would you handle a high-pressure situation?",
            [6] = "Describe your communication skills.",
            [7] = "What are your strengths?",
            [8] = "What are your weaknesses?",
            [9] = "How would you handle a dispute with another mechanic?",
            [10] = "Any additional information you'd like to provide?"
        }
    }
}
