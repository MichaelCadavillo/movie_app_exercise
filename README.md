# movie_app_exercise

A simple movie app built using Flutter.

## Libraries used
- flutter_bloc
  -  Used Cubit as state management for handling business logic code and connects the UI component to the repositories.
- equatable
  - Used to compare equality of two objects easily without needing to have lots of boilerplate code. 
- infinite_scroll_pagination
  - Used for implementing pagination for the list of Movies that were being fetched from the API.
- dio
  - An HTTP client primarily used for connecting the app to movieDB REST API endpoints 

### Running the project
1. Replace the `apiKey` in `network_service.dart` with your own API key from developers.themoviedb.org
2. Run the command: `flutter run`
