# provider_overview_15

Provider는 Widget에 non Widget Object를 제공하는것이라고 할 수 있습니다. 
만약 Provider에서 다른 Provider의 값이 필요할 때는 어떻게 할까요,
CounterProvide에서 카운터의 변경마다 ColorProvider에서 Widget의 Background를 변경한다고 생각한다면 Counter를 처리하는 곳에서는 현재 Color가 어떤값인지 알아야 하는데, 이와 같은 경우에 이를 가능하게 해주는 것이 ProxyProvider입니다.

Provider에 `Provider`, `ChangeNotifierProvider`등이 있듯이 ProxyProvider에도 같은 기능을 하는 `ProxyProvider`, `ChangeNotifierProxyProvider`등이 존재합니다. 

ProxyProvider는 다른 Provider들의 값에 의존해 값을 만들어 내는 Provider.

Constructur를 확인해 보면 일반 Provider와는 다르게 Create<R>는 Optional한 값이고, Update는 Required한 값인것을 확인 할 수 있습니다. 
또한 Update는 Create와 다르게 여러번 호출 될 수 있습니다.

ProxyProvider는 다른 Provider에 의존한다고 앞전에 이야기 했듯이 다른 Provider의 값이 변하개되면 ProxyProvider의 Update가 해당 변경을 감지하고 뷰를 업데이트 하게 됩니다.

그렇기 때문에 일반 Provider에 사용되는 Create는 한번만 사용될 수 있도록 되어있고 ProxyProvider에 사용되는 Update는 여러번 사용될 수 있도록 설계되었습니다. 

추가로 Create가 Optional인 이유는 자체적으로 Computed value를 사용할 떄 추가할 수 있도록 한 것이고, ProxyProvider가 자체적인 Computed value를 사용할 일이 없다면 사용하지 않도록 설정할 수 있도록 설계하였기 떄문입니다. 

앞에서 ProxyProvider의 Update가 여러번 불린다고 하였는데 여러번 불리는 정확한 시점은 다음과 같습니다. 
    - ProxyProvider가 의존하는 Provider의 값을 처음으로 획득 하였을 떄
    - ProxyProvider가 의존하는 Provider의 값이 바뀔 떄 마다
    - ProxyProvider가 Rebuild될 때 마다

*어떤 Provider가 변화하는 값에 의존하는 경우에도 ProxyProvider를 사용한다.(값의 변경이 일어날 떄 마다 값을 만들어야 하기 떄문)*

### Update callback of ProxyProvider

```dart
typedef ProxyProviderBuilder<T, R> = R Function(
    BuildContext context,
    T value,
    R? previous,
)
```
*R Type이 nullable인 이유는 Create가 Optional이기 떄문입니다.*

### Update callback of ProxyProvider2

```dart 
typedef ProxyProviderBuilder2<T, T2, R> = R Function(
    BuildContext context,
    T value,
    T2 value2,
    R2? previous,
)
```
*R Type이 nullable인 이유는 Create가 Optional이기 떄문입니다.*

### ProxyProviderN

ProxyProvider에서 일반적인 ProxyProvider가 있고 ProxyProvider뒤에 숫자가 2~6까지 붙어있는데,
이 모든 ProxyProvider는 ProxyProvider0의 syntax sugar입니다.

- `ProxyProvider<A, Result>` is equal to 
```dart 
ProxyProvider0<Result>(
    update: (BuildContext context, Result result) {
        final A a = Provider.of<A>(context);
        return update(BuildContext context, A a, Result result);
    }
)
```

- `ProxyProvider<A, B, Result>` is equal to 
```dart 
ProxyProvider0<Result>(
    update: (BuildContext context, Result result) {
        final A a = Provider.of<A>(context);
        final B b = Provider.of<B>(context);
        return update(BuildContext context, A a, B b, Result result);
    }
)
```
*`ProxyProvider0`를 이용하여 `ProxyProviderN* 

### ChangeNotifierProxyProvider

`ChangeNotifierProxyProvider`는 외부 `ChangeNotifier`와 값을 synchronizes하는 ChangeNotifierProvider입니다. 

```dart
ChangeNotifierProvider(
    create: (BuilderContext context) {
        return MyChangeNotifier(myModel: Provider.of<MyModel>(context, listen: false));
    },
    child: ...
)
```
MyChangeNotifier를 만드는데 myModel에 의존한다고 가정을 합니다, 그런데 create는 한 번만 불리기 떄문에 listen의 옵션을 false를 적용하였습니다.
한 번호출하고 더이상 불리지 않는데 listen을 하는것도 이상해 보이기도 합니다.

이 예에서는 MyChangeNotifier를 만드는데 MyModel에 의존하여 만들게 되는데 만약 MyModel의 값이 변하지 않는다면 크게 문제가 없겠지만, MyModel의 값이 변경된다면 값을 업데이트할 수 있는 방법이 없습니다.

이 이슈를 해결하기 위해 아래와 같은 방법을 사용할 수 있습니다. 

```dart
ChangeNotifierProvider(
    create: (_) => MyChangeNotifier(),
    update: (_, MyModel myModel, MyChangeModel myChangeNotifier) => myChangeNotifier..update(myModel),
    child: ...
)
```

MyModel이 Update될 때 마다 MyChangeNotifier가 Update되는데 다시 MyChangeNotifier가 create되는게 아니고 동일한 인스턴스를 사용하게 됩니다. 

MyChangeNotifier의 실질적인 구현의 예는 다음과 같습니다. 

```dart
class MyChangeNotifier with ChangeNotifier {
    void update(MyModel myModel) {
        // update()내에서 주입받은 myModel인스턴스를 이용해 필요한 작업을 하고 필요하면 notifyListeners()를 호출합니다. 
    }
}
```

### Things to note - in official documentation 

- ChangeNotifier Update에서 직접적으로 만들지 말아야 합니다. 
    - 이유는 의존하고 있는값이 Update될 때 State가 유실 될 수 있습니다. (MyChangeNotifier의 Update안에 async operator가 있는데, async operator가 끝나기 전에 Update가 불릴 수 있습니다)

- 가능한 ProxyProvider를 사용하는 것이 좋습니다.
    - create object가 http통신이나 다른 side-effect가 없이 다른 object들의 결합으로 이루어 진다면 ProxyProvider를 이용하여 불변의 object를 만드는것을 선호합니다.