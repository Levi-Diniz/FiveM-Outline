# Technical Reference: Outline System (Borders) - FiveM

<img width="825" height="703" alt="image" src="https://github.com/user-attachments/assets/21a7bbb7-9a5c-4798-a830-0bbf4d73b5d9" />
<br/>
This repository serves as a **reference guide and technical example** for developers looking to implement entity outlines (borders) in FiveM using GTA V’s native rendering functions.

> [!NOTE]  
> This is not a "plug-and-play" script, but a didactic foundation to help developers understand the logic and build their own custom systems.

---

## 🧠 Implementation Logic

The Outline system operates through a rendering loop that monitors specific entities and applies the visual effect. The fundamental logic explained here is:

1.  **Global Configuration**: Define once (or upon change) how the line should look (Color, Shader, and Technique).
2.  **Monitoring Loop**: Constantly check which nearby players meet the criteria (distance, health, ally/enemy status).
3.  **State Activation**: Toggle the outline on the entity as needed.

---

## 🛠️ Technical Details (Reference)

### Core Natives
* `SetEntityDrawOutline(entity, toggle)`: The primary command to enable/disable the border.
* `SetEntityDrawOutlineColor(r, g, b, a)`: Defines the visual aesthetics (RGBA).
* `SetEntityDrawOutlineShader(shader)`: Sets the glow style (commonly `1`).
* `SetEntityDrawOutlineRenderTechnique(technique)`: Sets the technique (e.g., `"waterreflection"` for higher sharpness).

### Commented Code Snippet (`client-side/core.lua`)

```lua
-- Rendering Loop Example
Citizen.CreateThread(function()
    setupOutline() -- Configure colors and shaders once

    while true do
        -- Logic to find players...
        
        -- Conditional Application
        if shouldShow then
            SetEntityDrawOutline(targetPed, true)
        else
            SetEntityDrawOutline(targetPed, false)
        end

        Citizen.Wait(500) -- Performance interval to prevent overhead
    end
end)
```

---

## 🚀 How to use as a Reference

1.  **Study the Loop**: Observe how the script manages activation/deactivation to avoid calling the `true` native every frame unnecessarily.
2.  **Adapt Alliance Logic**: The script includes a sample `isAlly` function that can be replaced by `StateBags`, `Teams`, or `Factions` checks from your own framework.
3.  **Experiment with Techniques**: Test different strings in `SetEntityDrawOutlineRenderTechnique` to discover visual variations.

---

## 📂 Example Structure
* `client-side/core.lua`: Contains all commented rendering logic.
* `server-side/core.lua`: Basic structure for those wishing to expand with server-client synchronization.
* `fxmanifest.lua`: Basic resource configuration.

---
*This material was created for educational purposes for the FiveM developer community.*
