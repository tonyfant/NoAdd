#  [NoAdd] - NFC Focus Timer

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org/)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://www.apple.com/ios/)
[![Status](https://img.shields.io/badge/status-Course%20Project-blue.svg)]()

A focus application developed in Swift/SwiftUI for the "Start-Up in ICT" course. The app activates a focus session by scanning an NFC device, the flagship product of our mock start-up, **[START-UP NAME]**.

---

##  Project Context

This project was developed as a case study for the **"Start-Up in ICT"** course. The objective was to simulate the creation of a start-up, from brainstorming an innovative product (an NFC focus gadget) to developing a Minimum Viable Product (MVP) mobile app to demonstrate its functionality.

Our mock start-up, **[NoAdd]**, aims to solve the problem of smartphone distraction through an integrated physical and digital solution.

---

## How It Works

Using the app is designed to be seamless and friction-free:

1.  **Tap the Device**: The user taps their iPhone on our NFC device.
2.  **Automatic Activation**: The app detects the NFC tag and automatically starts a "focus mode" session.
3.  **Focus Mode**: During the session, the app displays a timer and limits napplications on your devidce.
4.  **Session End**: When the timer finishes, the app returns to its normal state, possibly showing a summary of the time spent in focus mode.

---

##  Key Features

* **Instant NFC Activation**: Just a tap to get started. No need to open the app and manually set a timer.
* **Minimalist Interface**: Designed to be clean and non-intrusive during study or work sessions.
* **Native Development**: Built entirely in Swift and SwiftUI to ensure optimal performance and seamless integration with iOS.
* **Innovative Concept**: Combines a physical object (the NFC tag) with a digital experience for greater effectiveness.

---

##  Tech Stack

* **Language**: Swift 5
* **UI Framework**: SwiftUI
* **Core Technologies**:
    * `Core NFC`: For reading NFC tags and triggering sessions.
    * `UserNotifications`: For managing notifications.
    * `ScreenTime`: For blocking applications during focus time.

---

## 📄 License

This is an academic project. The code is available for educational and learning purposes.
