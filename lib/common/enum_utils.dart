T enumFromString<T>(
  Iterable<T> values,
  String value, {
  T Function() orElse,
  bool caseInsensitive = true,
}) {
  if (caseInsensitive) value = value.toLowerCase();
  return values.firstWhere(
    (type) {
      final enumString = enumAsString(type);
      if (caseInsensitive)
        return enumString.toLowerCase() == value;
      else
        return enumString == value;
    },
    orElse: orElse ??
        () => throw 'error converting string: [$value] to enum: [$values]',
  );
}

String enumAsString(Object value) {
  return value.toString().split('.').last;
}
