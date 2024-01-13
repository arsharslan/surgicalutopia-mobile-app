extension StringExt on String {
  nullIfEmpty() => isEmpty ? null : this;
}

extension ListExt on List {
  nullIfEmpty() => isEmpty ? null : this;
}

extension ExtensionFunction<T, R> on T? {
  R? let(R Function(T? element) onCondition) {
    return onCondition(this);
  }
}