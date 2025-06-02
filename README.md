# Vaktija Watch App

A watchOS app that displays Islamic prayer times (Vakat) for selected cities, with support for complications on Apple Watch faces.

---

## Technologies Used

- **Swift & SwiftUI** — For building the user interface and watchOS app logic  
- **Combine & MVVM Architecture** — For reactive data handling and clean code structure  
- **URLSession** — To fetch prayer times from remote API  
- **WatchKit Complications** — To display prayer times directly on watch faces  
- **App Groups & Shared UserDefaults** — For sharing data between app and complication  

---

## API Used

- Prayer times data is fetched from the official Vaktija API:  
  `https://api.vaktija.ba/vaktija/v1/{cityId}`  
  - Example: `https://api.vaktija.ba/vaktija/v1/77` returns prayer times for Sarajevo  
  - Response includes prayer names, times, and dates in JSON format

---

## Features

- Select city to get accurate prayer times  
- Real-time fetching and updating of prayer times  
- Custom Apple Watch complication displaying next prayer time, prayer name, and location  
- Clean folder structure and modular design following best practices

---

## Setup

1. Open the project in Xcode  
2. Run the main Watch App target on your device or simulator  
3. Enable the complication on your watch face to see prayer times at a glance  

---


## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/d0ec930e-df8a-4bc3-a4e5-38af7fc760b9" width="239" alt="Prayer Times View" />
  <br>
  <em>Main screen displaying today's prayer times.</em>
</p>

<p align="left">
  <img src="https://github.com/user-attachments/assets/a106dbb1-ff18-4a6b-94f2-1fd3a65332b6" width="239" alt="Edit Settings Screen" />
  <br>
  <em>Edit screen for managing user preferences.</em>
</p>


<p align="center">
  <img src="https://github.com/user-attachments/assets/ee7bed7f-bb62-4872-8ea6-171578057506" width="239" alt="Select City Screen" />
  <br>
  <em>City selection interface for choosing the location.</em>
</p>



<p align="right">
  <img src="https://github.com/user-attachments/assets/e6a1678a-b36a-4a8f-8bf8-0f21558dced7" width="239" alt="Notifications Setup" />
  <br>
  <em>Notifications settings with scheduled prayer alerts.</em>
</p>


<p align="left">
  <img src="https://github.com/user-attachments/assets/563ce745-f916-4a4a-8762-91bb9603b41a" width="239" alt="Scheduled Notification" />
  <br>
  <em>Notification alerting user for prayer.</em>
</p>


<p align="center">
  <img src="https://github.com/user-attachments/assets/e3029106-cfb6-41b1-924a-c4247a446620" width="239" alt="Apple Watch Complication" />
  <br>
  <em>Custom Apple Watch complication showing next prayer time and its name</em>
</p>



---

## License

This project is open source and free to use.

---

*Created by Mirza Kadric*
