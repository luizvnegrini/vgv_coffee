# VGV Coffee

This project is a simple Flutter application developed for a technical test. It demonstrates the ability to load random coffee images and save them to the photo gallery. The app allows users to interact with the interface to load new images and manage their coffee album. This showcases the developer's skills in implementing state management, image handling, and user interactions in Flutter.

# Demo
https://github.com/user-attachments/assets/f6228fa2-f816-4c3c-aa65-6595fee734d2

## Main Technologies
- Flutter
- Bloc
- Dartz
- Mocktail
- Photo Manager

## Features
- Load random coffee images
- Save images to photo gallery
- Load album
- Clean Architecture

## Possible new features
- Delete image from album
- Define name to image
- Share image
- Filters on images
- Sort images by date

## SETUP

### **0 Install Flutter Framework**

[See docs here.](https://docs.flutter.dev/get-started/install)

## **1. Running the project**

First of open your terminal and go to the app main folder and run `flutter pub get` to resolve dependencies.

To run, take into account the flavors `dev`, `hml` e `prod`.  

Always run as follows:  

```bash
cd app
flutter run -t lib/main-<flavor>.dart --flavor <flavor> 
```

## **2 Creating/editing flavors**

For the creation of flavors, the package [flutter_flavorizr](https://github.com/AngeloAvv/flutter_flavorizr) was used.

Follow your documentation for adding/editing flavors.


## **3. Tests**

To maintain organization, each test file must be created in the same folder structure as the file being tested. Example:

```bash
# Implementation
/app
  /lib
    /presentation
      /home
        /home_page_bloc.dart

# Test
/app
  /test
    /presentation
      /home
        /home_page_bloc.dart
```


## **4. Design system**

Project uses Atomic Design for create the Design System. Click [here](https://bradfrost.com/blog/post/atomic-web-design/) to read about Atomic Design.

## **5. Critique and improvements**

About the project I tried to deliver something robust but there is always more to do, in this case I would like to perform more tests, different types of tests such as "golden tests" and "unit tests" that were not implemented, reevaluate the code and see if any refactoring would be necessary to leave the cleaner code.

The application has already been architected for a scale of teams, it is already a monorepo and modularized. It also uses techniques for inject dependencies lazyLoading and yield return and also using separate threads (isolates) between UI and business layer. I didn't create any more modules because it's a simple app, one module is enough.

It would certainly be possible to solve the problem proposed with a simpler app, but I want to make it clear that I did it in this way and with complexity to meet the request that the app must be scalable and also to show my knowledge, I hope I have fulfilled it.

### **5.1 Improvements**

- Have a more complete error handler
- Golden tests
- Widget tests
