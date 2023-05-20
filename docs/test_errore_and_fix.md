
## Errore 1  

> [!WARNING]
> mockito Dart   
> type 'Null' is not a subtype of type 'Future<Either<FailureApp, NumberTrivial>>'

-------------   

вы можете добавить build_runner в свои dev_dependencies: в pubspec.yaml  

``
dart pub add build_runner --dev
``

и запустите   

``
flutter pub run  build_runner build --delete-conflicting-outputs
``

build runner,   
чтобы собрать файлы-заглушки для вас  


🤐🫤

-------------   


## Errore 2  


