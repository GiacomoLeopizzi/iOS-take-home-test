# iOS Home Test

## How to Run

The app can be run on either an iOS Simulator or a physical device using Xcode. Additionally, it supports previews in Xcode.

Before running the project, you must provide an API key in the `NooroWeatherApp.swift` file by replacing `HERE THE API KEY` in the following line:

```swift
.environment(\.weatherService, WeatherApiService(apiKey: "HERE THE API KEY"))
```

> **Note:** The API key has not been included in this repository to adhere to best security practices. Sharing sensitive information such as API keys in a public repository is discouraged.

When running the app in an Xcode preview, a mock WeatherAPI service is used, as previews do not support network requests.

The project is built using **Swift 6** and leverages the latest Swift features, particularly in ensuring thread safety.

---

## Project Description

### Key Features and Principles

- **Localization-Ready:** While not fully localized, the app is prepared for future localization. Care has been taken to use `Text(verbatim:)` instead of `Text(_:)` to prevent unintended localization issues and improve performance.
- **Consistent Color Management:** All colors are defined in the **Assets catalog** for ease of modification and consistent styling.
- **Logging with OSLog:** The app uses **OSLog** for structured and efficient logging, as recommended by Apple.
- **Dependency Injection with SwiftUI Environment:** Dependencies are injected through SwiftUI's environment system, eliminating the need for third-party libraries. The `@Entry` macro is used for concise dependency declarations.
- **Temperature Unit Preference:** The app checks the user's locale to determine whether temperatures should be displayed in Fahrenheit or Celsius.
- **State Machine in SearchViewModel:** A state-machine approach is used in the `SearchViewModel` to ensure consistent app behavior. While the current implementation is simple, this pattern improves scalability and reliability.

---

### Folder Structure

The project is organized into several key components under the `Features` folder:

1. **CacheService:**  
   A protocol defining how to save and retrieve the last opened city. The city is saved as a JSON file in the OS's temporary directory, rather than using `UserDefaults`, which is unsuitable for binary payloads. This design ensures flexibility, as the cache implementation can be modified without affecting views or view models.

2. **Logging:**  
   The app uses **OSLog** for structured and efficient logging, enabling better control as the app grows.

3. **Networking:**  
   Networking is abstracted behind a protocol, allowing for two implementations:
   - One for live API calls to WeatherAPI.
   - A mock implementation for providing fake data, enabling seamless Xcode preview functionality and faster development.

4. **TemperatureFormatter:**  
   Formats temperatures based on user settings, ensuring that US users see temperatures in Fahrenheit, while others see Celsius.

5. **WeatherImage:**  
   Matches weather condition codes from the API to local vector images, providing high-resolution icons when the API's images are insufficient. If the injected class is disabled or a code is not recognized, the app falls back to the API's image, ensuring robust error handling.

---

### API Key Handling

As mentioned earlier, the API key is not included in this repository for security reasons. In a production environment, the key should ideally:
- Be fetched dynamically from a secure API and stored in the device's Keychain (recommended approach).
- Be included in the app in an obfuscated format to prevent easy extraction using a binary debugger.
