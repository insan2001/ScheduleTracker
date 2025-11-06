import 'dart:async';

class Company {
  String name;
  double pay;
  bool _isClockedIn = false;
  DateTime? _clockInTime;
  DateTime? _clockOutTime;
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  void Function()? onTick;

  final void Function()? onStatusChange;

  Company({
    required this.name,
    required this.pay,
    this.onTick,
    this.onStatusChange,
  });

  bool get isClockedIn => _isClockedIn;
  DateTime? get clockInTime => _clockInTime;
  DateTime? get clockOutTime => _clockOutTime;
  Duration get elapsed => _elapsed;

  void toggleClock() {
    if (_isClockedIn) {
      clockOut();
    } else {
      clockIn();
    }
  }

  void clockIn() {
    _isClockedIn = true;
    _clockInTime = DateTime.now();
    _clockOutTime = null;
    _elapsed = Duration.zero;
    onStatusChange?.call();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed = DateTime.now().difference(_clockInTime!);
      onTick?.call();
    });
  }

  void clockOut() {
    _isClockedIn = false;
    _clockOutTime = DateTime.now();
    _timer?.cancel();
    onTick?.call();
    onStatusChange?.call();
  }

  String get formattedElapsed {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(_elapsed.inHours);
    final m = twoDigits(_elapsed.inMinutes.remainder(60));
    final s = twoDigits(_elapsed.inSeconds.remainder(60));
    return "$h:$m:$s";
  }

  void dispose() {
    _timer?.cancel();
  }
}
