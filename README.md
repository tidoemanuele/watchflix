# Movie Browser App Architecture

## 1. Overall Feature Architecture

![Overall Feature Architecture](docs/images/1_overall_feature_architecture.png)

The application follows a feature-first architecture with clean separation of concerns across multiple layers. The architecture is designed to be scalable, maintainable, and testable.

### Data Flow Layers
- **API Layer**: External data communication interface
- **Repository Layer**: Data operations and caching management
- **UseCase Layer**: Business logic implementation
- **Presentation Layer**: UI and state management

### Core Components
- **Router**: Navigation management using GoRouter
- **Services**: Global application services
- **Utils**: Helper functions and utilities
- **Widgets**: Reusable UI components

### Feature Flow
App Entry → Splash → Sources → List Titles → Title Details

## 2. Feature Layer Structure

![Feature Layer Structure](docs/images/2_feature_layer_structure.png)

Each feature in the application is organized into three main layers:

### Data Layer
- **Repositories**: Data operations handling
- **Models**: Data structure definitions

### Domain Layer
- **UseCases**: Business logic containers
- **Repository Interfaces**: Data contract definitions
- **Domain Models**: Business objects

### Presentation Layer
- **Cubit/Bloc**: State management
- **Screens**: UI components
- **Widgets**: Reusable UI elements

## 3. Data Flow Architecture

![Data Flow Architecture](docs/images/3_data_flow_architecture.png)

The application implements a unidirectional data flow:

1. User actions originate from Screen/Widget
2. Cubit/Bloc processes actions
3. UseCase executes business logic
4. Repository performs data operations
5. WatchmodeService handles API communication
6. Response flows back through layers
7. UI updates based on state changes

## 4. Navigation Flow

![Navigation Flow](docs/images/4_navigation_flow.png)

The application uses GoRouter for navigation with the following structure:

- **Splash**: Application entry point
- **Sources**: Content source selection
- **ListTitles**: Content browsing
- **TitleDetails**: Detailed content view

### Navigation Actions
- Select Source: Navigate to content list
- Back: Return to previous screen
- Exit: Close application
- Select Title: View content details

## 5. State Management

![State Management](docs/images/5_state_management.png)

State handling uses Bloc/Cubit pattern with Provider:

### Result States
- **Loading**: Data fetching state
- **Success**: Successful operation state
  - Contains Data Models
- **Error**: Failed operation state
  - Contains Error Message

## Technology Stack

- **State Management**: Bloc/Cubit with Provider
- **Navigation**: GoRouter
- **Architecture**: Feature-first MVVM
- **Utilities**: leancode_cubit_utils

## Getting Started

[Installation and setup instructions will go here]

## Development Guidelines

[Development guidelines and best practices will go here]