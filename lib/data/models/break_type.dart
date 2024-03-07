enum BreakType {
  contrahentChange,
  waxing,
  breakTime,
}

extension BreakTypeExtension on BreakType {
  String get displayName {
    switch (this) {
      case BreakType.contrahentChange:
        return 'Zmiana kontrahenta';
      case BreakType.waxing:
        return 'Woskowanie';
      case BreakType.breakTime:
        return 'Przerwa';
    }
  }
}
