### WTF CPP

Keynote: C++ Painkillers for C++ Developers - The Evolution of C++ Tooling - Anastasia Kazakova, 50:26

```cpp
template <int>
struct x {
    int z;
    bool p;
    x(int i ) {}
};

void foo(int y) {
    const int a = 100;
    // instance of "x"
    auto k = x<a>(0);
    // BINARY EXPRTESSIOON, "l" is a bool!!!!
    auto l = y<a>(0);
}
```
