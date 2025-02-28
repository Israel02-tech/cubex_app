# cubex_app

A Flutter project that displays the names of African countries. Clicking on each country navigates to a screen showing details of the selected country.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Project Structure](#project-structure)

## Introduction
This project uses `go_router` for routing, `Bloc` for state management, `http.client` for API calls, and follows a clean architecture.

## Features
- Display a list of African countries
- Navigate to country details screen on click
- State management with Bloc
- Clean architecture

## Installation
Instructions on how to install and set up your project.

```bash
# Clone the repository
git clone https://github.com/Israel02-tech/cubex_app.git

# Navigate to the project directory
cd cubex_app

# Install dependencies
flutter pub get

# Run the app
flutter run

<!-- BEGIN PROJECT STRUCTURE -->
```
└─ lib
   ├─ core
   │  ├─ constraints.dart
   │  └─ routes.dart
   ├─ features
   │  └─ countries
   │     ├─ data
   │     │  ├─ models
   │     │  │  └─ country_model.dart
   │     │  ├─ repositories
   │     │  │  └─ country_repository.dart
   │     │  └─ sources
   │     │     └─ country_api.dart
   │     └─ presentation
   │        ├─ blocs
   │        │  └─ bloc
   │        │     ├─ country_details_bloc.dart
   │        │     ├─ country_details_event.dart
   │        │     ├─ country_details_state.dart
   │        │     ├─ country_list_bloc.dart
   │        │     ├─ country_list_event.dart
   │        │     └─ country_list_state.dart
   │        ├─ screens
   │        │  ├─ country_details_screen.dart
   │        │  └─ country_list_screen.dart
   │        └─ widgets
   │           └─ country_card.dart
   ├─ main.dart
   └─ test_api.dart

```
<!-- END PROJECT STRUCTURE -->
