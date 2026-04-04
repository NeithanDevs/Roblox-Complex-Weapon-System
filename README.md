 🔫 Roblox Weapon System Prototype

A modular hitscan-based weapon system built in Lua for Roblox.

Designed to demonstrate client-server architecture, raycasting, and scalable weapon configuration.

---

 🎮 Demo

https://drive.google.com/file/d/1d6tacsdsTBXAf8QrgPZ8JubfDMO2mwcM/view?usp=sharing


 ⚙️ Features

- Hitscan shooting using raycasting  
- Client → Server validation  
- Fire rate control (cooldown system)  
- Basic recoil effect  
- Tool-based weapon system  

---

 🧠 Technical Highlights

- Client-Server Separation  
  Input handled on client, validation and damage handled on server.

- Raycasting System
  Uses `workspace:Raycast()` for accurate hit detection.

- Modular Configuration 
  Weapon stats defined in a centralized config module.

- Scalable Architecture  
  Structured to easily support multiple weapons and attachments.

---

 📁 Structure
 
src/
├── client/ # Handles input and shooting requests
├── server/ # Handles validation and damage
├── shared/ # Weapon configuration
└── remotes/ # RemoteEvents


---

🛠️ Developer Notes

This system was built to simulate a simplified weapon framework similar to FPS-style systems.

The focus was on:
- Clean architecture
- Reliable client-server communication
- Expandability for future features (attachments, multiple weapons, etc.)


---

 📌 Summary

This project demonstrates:
- Understanding of Roblox networking  
- Ability to structure scalable systems  
- Implementation of real-time gameplay mechanics
