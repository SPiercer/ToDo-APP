# Documentation

### **Arch. used** : MVVM (Model View ViewModel)
### **Time taken** : 
- ### Design : *Two days* 
- ### Backend and Logic: *Four Days*
> Notice that this project was made under severe conditions

---
## Content
* Lib
  * Components
    * [AddTaskBottomSheet.dart](lib/Components/AddTaskBottomSheet.dart)
    * [EditTaskBottomSheet.dart](lib/Components/EditTaskBottomSheet.dart)
    * [RadioItem.dart](lib/Components/RadioItem.dart)
    * [TaskItem.dart](lib/Components/TaskItem.dart) 
  * Models
    * [Radio.dart](lib/Models/Radio.dart) 
    * [Task.dart](lib/Models/Task.dart) 
    * [User.dart](lib/Models/User.dart) 
  * Providers
    * [Theme.dart](lib/Providers/Theme.dart)
    * [User.dart](lib/Providers/User.dart)
  * Screens
    * [Home.dart](lib/Screens/Home.dart)
    * [Landing.dart](lib/Screens/Landing.dart)
  * Services
    * [Auth.dart](lib/Services/Auth.dart)
    * [Constants.dart](lib/Services/Constants.dart)
    * [Helpers.dart](lib/Services/Helpers.dart)
    * [Tasks.dart](lib/Services/Tasks.dart)
  * [main.dart](lib/main.dart)

### Components
* Add/EditTaskBottomSheet
  * A custom made BottomSheet for adding/editing tasks
* RadioItem
  * A custom made Container with Radio functionalities
* TaskItem
  * A custom made ListTile containing a RadioButton for setting the task state weather it's completed or not
### Models
* Radio
  * Radio model class for the RadioItem containing two values 
  ```Dart
  class RadioModel {
    bool isSelected;
    final String buttonText;

    RadioModel(this.isSelected, this.buttonText);
  }
  ``` 
* Task
  * Task model class for the TaskItem containing three values
  ```Dart
  class Task {
    final String time;
    final String title;
    bool isCompleted;
  
    Task({this.time, this.title, this.isCompleted});
  }
  ```
* User 
  * User model class for handeling the user containing four values w/ serialization ablility
  ```Dart
  class User {
    String name;
    String email;
    String imgURL;
    String uid;
  
    User({this.name, this.email, this.imgURL, this.uid});

    User.fromJson(Map<String, dynamic> json)
        : name = json['name'],
          email = json['email'],
          imgURL = json['picture']['data']['url'],
          uid = json['id'];

    Map<String, dynamic> toJson(User user) {
      return <String, dynamic>{
        'name': user.name,
        'email': user.email,
        'img': user.imgURL,
        'uid': user.uid
      };
    }
  }
  ```
### Providers
* Theme
  * A ThemeProvider class which extends ChangeNotifier holding one value w/ a function two swtich themes
  ```Dart
  class ThemeProvider with ChangeNotifier {
    bool isDarkMode = false;

    void updateTheme(bool isDarkMode) {
      this.isDarkMode = isDarkMode;
      notifyListeners();
    }
  }  
  ```
* User
  * A UserProvider class which extends ChangeNotifier holding one value w/ a getter of the user instance
  ```Dart
  import '../Models/User.dart';

  class UserProvider extends ChangeNotifier {
    final User _user = User();
    User get user => _user;
  } 
  ```  
### Screens
* Home
  * The homepage screen
* Landing
  * The first-time screen showing the landing screen of the app and alongside of two login buttons (Facebook and Google)
### Services
* Auth
  * An Authenticaiton Class holding all the User interaction functions such as login and logouts and creating accounts
* Constants
  * A file containing two constant widgets of the dismissable swipe backgrounds
* Helpers
  * A helper class containing one static function of showing an alert dialog
* Tasks
  * A Tasks class containing all the CRUD services except the read service because we use StreamBuilder to read it from the database inside the homepage
### main.dart
* the Entry point of the application which extends ChangeNotifierProvider and MultiProvider to get the value of the ThemeMode and the User
  also this file has two classes : The MyApp class which return another class called Wrapper in which it returns the Homepage or the LandingPage according to the user weather it's logged in or not
```Dart
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    if (user == null) {
      return LandingScreen();
    } else {
      return HomeScreen();
    }
  }
}
```
## Packages
Package | Explain
---|---
[flutter_auth_buttons](https://pub.dev/packages/flutter_auth_buttons) | Material buttons for social media login
[provider](https://pub.dev/packages/provider) | State management
[cloud_firestore](https://pub.dev/packages/cloud_firestore) | Firestore database
[firebase_auth](https://pub.dev/packages/firebase_auth) | Firebase authentication
[intl](https://pub.dev/packages/intl) | Change DateTime format 
[flutter_facebook_login](https://pub.dev/packages/flutter_facebook_login) | Facebook login
[google_sign_in](https://pub.dev/packages/google_sign_in) | Google login
[http](https://pub.dev/packages/http) | HTTP requests
## How To Use

To clone and run this application, you'll need [Git](https://git-scm.com) and [Flutter](https://flutter.dev/docs/get-started/install) installed on your computer. From your command line:

```bash
# Clone this repository
$ git clone https://github.com/SPiercer/ToDo-APP.git

# Go into the repository
$ cd ToDo-APP

# Install dependencies
$ flutter packages get

# Run the app
$ flutter run
```