# provider_overview_05

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### `context.read<T>() -> T`

`context.read<T>() -> T`는 `Provider.of<T>(context, listen: false)` 와 같은 동작을 실행한다.

### `context.watch<T>() -> T`

`context.watch<T>() -> T`는 `Provider.of<T>(context)`와 같은 동작을 실행한다.

### `context.select<T, R>(R selector(T value)) -> R`

특정 property에 변화만 listen하기 위해 사용한다.