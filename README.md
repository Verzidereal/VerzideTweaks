# ⚡ VerzideTweaks
### High-Performance Windows Tweaks for FPS, Input Latency & System Optimization

VerzideTweaks is a modular PowerShell-based optimization toolkit built for gamers, power users, and competitive players seeking the highest possible performance from Windows.

This project focuses on **safe, modern, and clean optimizations** — no destructive debloat, no system-breaking registry changes, no sketchy "super tweaks". All tweaks are organized into modules and presets for easy customization.

---

## 🔥 Features
- ✔ Modern FPS & latency tweaks  
- ✔ GPU + scheduler optimization  
- ✔ Network stack tuning (TCP, DNS, Nagle, adapters)  
- ✔ Safe Windows debloat (no system breaking)  
- ✔ Gaming presets (MaxFPS, LowLatency, Balanced)  
- ✔ Modular PowerShell architecture  
- ✔ Open-source & community-driven  

---

## 📦 Installation

### 1. Clone the repository
```powershell
git clone https://github.com/Verzidereal/VerzideTweaks.git
cd VerzideTweaks

2. Run the installer

powershell -ExecutionPolicy Bypass -File install.ps1

3. Launch the main menu

powershell -ExecutionPolicy Bypass -File main.ps1

🧰 Presets
🎯 Balanced

General optimization without being aggressive.
Includes system cleanup, basic network tuning, gaming mode, and essential service tweaks.

./presets/Balanced.ps1

⚡ MaxFPS

Maximum performance possible without breaking Windows.
Removes light bloat, high-performance GPU mode, scheduling optimizations, network tuning.

./presets/MaxFPS.ps1

🩻 LowLatency

Designed for competitive gamers.
Focuses heavily on input latency, TCP/Nagle, adapter settings, firewall gaming mode.

./presets/LowLatency.ps1

🧩 Project Structure

VerzideTweaks/
│── main.ps1
│── install.ps1
│── modules/
│   ├── System/
│   ├── Network/
│   ├── Gaming/
│   └── Security/
│── presets/
│── tools/

🛠 Modules Overview
🖥 System Module

    Disable non-essential services

    Cortana off

    Debloat (safe)

    Cleanup tools

    HPET optimizations

    Ultimate Power Plan

🌐 Network Module

    TCP parameters

    Disable Nagle

    Optimized DNS (Cloudflare/Google)

    Network adapter low-latency settings

    Winsock + IP reset

🎮 Gaming Module

    GPU hardware scheduling

    Reduce input lag

    Game Bar / DVR disabled

    Scheduler tweaks

    Windowing latency adjustments

🔒 Security Module

    Privacy-safe registry tweaks

    Remove unsafe OEM apps

    Firewall gaming rule

    Defender safe-enable

🤝 Contributing

Contributions are welcome and encouraged!

You can help by:

    Adding new safe tweaks

    Improving existing modules

    Fixing bugs

    Adding presets

    Writing documentation

How to contribute:

    Fork the repo

    Create a new branch

    Commit your changes

    Submit a pull request

⚠️ Disclaimer

This project provides safe and reversible optimizations, but:

    Every system is different

    Some tweaks may behave differently depending on hardware

    Always create a restore point before applying large changes

You use these tweaks at your own responsibility.
📜 License

This project is licensed under the MIT License — free to use, modify, and distribute.

👑 Credits

Made with ❤ by Verzide
