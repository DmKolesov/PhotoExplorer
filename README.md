# PhotoExplorer

### Architecture

- UIKit
- MVVM
- Coordinator — navigation and routing management
- Repository — data management through API and local storage (Realm)
- Service Layer — network requests via Alamofire
- Mappers

### Patterns

- Factory
- Delegate
- Observer — UI updates via closures and properties
- Protocol-Oriented Programming — interfaces for defining shared operations

### Dependencies

- Alamofire — network requests
- Kingfisher — image loading and caching
- Realm — local storage for favorite photos, offline mode support

### UI

- TabBarController with modules: Inspiration, Favorites, Detail
- UICollectionView with custom cells, lazy loading, UICollectionViewFlowLayout
- UISearchBar

### Overview

- Image caching
- Offline mode: access to favorite photos

---

### Архитектура

- UIKit
- MVVM
- Coordinator — маршрутизация и управление навигацией
- Repository — управление данными через API и локальное хранилище (Realm)
- Service Layer — выполнение сетевых запросов через Alamofire
- Mappers

### Паттерны

- Factory
- Delegate
- Observer — обновление UI через замыкания и свойства
- Protocol-Oriented Programming — интерфейсы для определения общих операций

### Зависимости

- Alamofire — сетевые запросы
- Kingfisher — загрузка и кеширование изображений
- Realm — локальное хранилище избранных фотографий, поддержка офлайн-режима

### UI

- TabBarController с модулями: Inspiration, Favorites, Detail
- UICollectionView с кастомными ячейками, ленивой загрузкой, UICollectionViewFlowLayout
- UISearchBar

### Overview

- Кеширование изображений
- Офлайн-режим: доступ к избранным фотографиям

---
