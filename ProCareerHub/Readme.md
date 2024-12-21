# 🚀 **ProCareerHub**  
_A seamless and dynamic career application system for FiveM._

## 🌟 Features
- 🧑‍✈️ **Police Applications:** Apply for law enforcement positions.
- 🚑 **EMS Applications:** For aspiring medics and first responders.
- 🔧 **Mechanic Applications:** Perfect for those who love to tinker with engines.
- 🎯 **Target System Integration:** Works with `qb-target` or `ox_target` for smooth in-game interactions.
- 💬 **Discord Webhook Integration:** Sends detailed application submissions directly to Discord.
- ⚙️ **Fully Configurable:** Easily customize questions, peds, and webhooks.

---

## 🛠️ Installation
1. **Download or Clone** the resource:
   ```bash
   git clone https://github.com/Mrolson14/ProCareerHub
   ```

2. **Move it to your server’s `resources` folder.**

3. **Add to your `server.cfg`:**
   ```cfg
   ensure ProCareerHub
   ```

4. **Dependencies Required:**
   - [QBCore Framework](https://github.com/qbcore-framework)
   - [ox_lib](https://overextended.dev/)
   - [oxmysql](https://github.com/overextended/oxmysql)

---

## ⚙️ Configuration
1. Open `config.lua` to customize:
   - **Enable Debug Mode:**
     ```lua
     Config.Debug = true -- Set to true to enable debug logs
     ```
   - **Define Questions and Peds:**
     Add job-specific questions and ped locations:
     ```lua
     Config.Questions = {
         [1] = {
             pedmodel = "s_m_y_cop_01",
             pedspwan = vector3(-1732.80, -736.93, 10.41),
             heading = 180.0,
             policeapp = {
                 [1] = "What is your name?",
                 [2] = "How old are you?",
                 [3] = "Why do you want to join the police force?",
                 ...
             }
         },
         ...
     }
     ```

2. Edit `webhook.lua` to set up Discord webhooks:
   ```lua
   webhookConfig = {
       PoliceWebhookUrl = "YOUR_POLICE_WEBHOOK_URL",
       EMSWebhookUrl = "YOUR_EMS_WEBHOOK_URL",
       MechanicWebhookUrl = "YOUR_MECHANIC_WEBHOOK_URL",
   }
   ```

---

## 📖 How to Use
1. **Interact with Application Peds:**
   - Peds spawn at predefined locations (configured in `config.lua`).
   - Use `qb-target` or `ox_target` to interact.

2. **Complete an Application:**
   - Fill out the application form via in-game prompts.
   - Submissions are sent directly to the appropriate Discord channel.

3. **View Applications on Discord:**
   - Each submission includes:
     - Application type (Police, EMS, Mechanic)
     - Player’s in-game name, citizen ID, and Discord name
     - Answers to all application questions

---

## 📌 Example Discord Output
**Title:**  
`New Mechanic Application`

**Content:**  
```markdown
**Application Received**
**Application Type:** Mechanic
**Discord Name:** @⸸♱♥ 𝓜𝓻.𝓢𝓜𝓤𝓡𝓕 ♥♱⸸
**Citizen ID:** ZRG34725
**Player Name:** John Doe

**Q1:** What is your name?  
**A:** John Doe  

**Q2:** How old are you?  
**A:** 29  

...
```

---

## 🧑‍💻 Contributors
- **Author:** Mr.Olson14  
- **Contributor:** ⸸♱♥ 𝓜𝓻.𝓢𝓜𝓤𝓡𝓕 ♥♱⸸  

---

## ❤️ Feedback and Support
Have questions or suggestions?  
Reach out to the contributors or join the **Discord community** for assistance!  

---