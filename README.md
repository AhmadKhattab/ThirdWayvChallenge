#  ThirdWayv iOS Challenge Architecture and Design Patterns
## Used Architecture
>This project is implemented by applying MVVM along side Clean Architecture coined by uncle bob.
>The Model-View-ViewModel pattern (MVVM) provides a clean separation of concerns between the UI and Domain.

## MVVM Benefits
* **Expressive:** The view model better expresses the business logic for the view.
* **Reduced Complexity**: MVVM makes the view controller simpler by moving a lot of business logic out of it.
* **Testability**: A view model is much easier to test than a view controller. You end up testing business logic without having to worry about view implementations.
* **Shared**: The view model can be shared across multiple views because it does not hold reference on the view.

## Layers
* **Domain Layer** = Entities + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence 
* **Presentation Layer (MVVM)** = ViewModels + Views

## Used Design Patterns
* **Repository Design Pattern** repository pattern is to isolate the data access layer and business logic. it has two 
purposes. First it is an abstraction of the data layer and second it is a way of centralizing the handling of the domain objects. **(Like in DefaultProductsRepository it holds two data sources one for remote and the other for local)**
* **Observer Design Pattern** subscription mechanism to notify multiple objects about any events that happen to the object they’re observing. And it's used in project to bind view and view model without making view model holds reference on the view. The view model only will notify the view therefore the view will interact accordingly to these changes. **(Like in ProductsViewModel and ProductsViewController)**
