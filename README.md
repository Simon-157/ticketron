# Ticketron App

A Flutter application for browsing and purchasing tickets for events.

## Features

- User authentication (sign in, sign up)
- Browse events by category
- View event details
- Purchase tickets
- View and manage favorite events
- View upcoming and past tickets
- User profile management
- QR code generation for event tickets

## Directory Structure

- `lib/models`: Contains the data models used in the application.
- `lib/screens`: Contains the UI screens for various parts of the application.
  - `auth`: Screens related to authentication (sign in, sign up).
  - `event`: Screens related to viewing event details and event list.
  - `profile`: Screen related to user profile management.
  - `home_screen.dart`: Home screen of the app.
  - `explore_screen.dart`: Screen for browsing events.
  - `favorites_screen.dart`: Screen for viewing favorite events.
  - `tickets_screen.dart`: Screen for viewing upcoming and past tickets.
- `lib/services`: Contains the services for API calls and authentication.
- `lib/utils`: Contains utility functions and constants.
- `lib/widgets`: Contains reusable UI components.

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your local machine.
- A code editor such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/event_ticketing_app.git
    cd event_ticketing_app
    ```

2. Install dependencies:

    ```bash
    flutter pub get
    ```

3. Run the application:

    ```bash
    flutter run
    ```

## Models

The application uses several data models, located in `lib/models`:

- `agenda_item.dart`: Defines the AgendaItem model.
- `contact_info.dart`: Defines the ContactInfo model.
- `event.dart`: Defines the Event model.
- `explore_event.dart`: Defines the ExploreEvent model.
- `favorite.dart`: Defines the Favorite model.
- `image.dart`: Defines the Image model.
- `order.dart`: Defines the Order model.
- `organizer.dart`: Defines the Organizer model.
- `price.dart`: Defines the Price model.
- `qr_code.dart`: Defines the QRCode model.
- `sign_in.dart`: Defines the SignIn model.
- `sign_up.dart`: Defines the SignUp model.
- `social_link.dart`: Defines the SocialLink model.
- `ticket.dart`: Defines the Ticket model.
- `user.dart`: Defines the User model.

## Screens

The application contains the following screens:

- Authentication screens (Sign In, Sign Up)
- Home screen
- Explore events screen
- Event details screen
- Favorites screen
- Tickets screen (upcoming and past)
- Profile screen

## Services

- `api_service.dart`: Contains functions for API calls.
- `auth_service.dart`: Contains functions for authentication-related operations.
- `event_service.dart`: Contains functions for event-related operations.

## Utils

- `constants.dart`: Defines constant values used in the app.
- `helpers.dart`: Contains helper functions.

## Widgets

- `custom_button.dart`: A reusable button widget.
- `custom_text_field.dart`: A reusable text field widget.

## Contributing

Contributions are welcome! Please submit a pull request or create an issue to discuss your ideas.

## License

This project is licensed under the MIT License.
# ticketron
