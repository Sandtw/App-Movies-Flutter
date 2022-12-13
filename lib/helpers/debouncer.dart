import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

class Debouncer<T> {

  Debouncer({ 
    required this.duration, //* Cantidad de tiempo a esperar antes de emitir un valor
    this.onValue //* Metodo a disparar cuando ya tenga un valor
  });

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;
  
  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }  
}