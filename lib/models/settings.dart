class Settings {
  String locale;
  String currency;
  Set<String> categories;

  Settings({this.locale = "en_US", this.currency = "\$", this.categories = const {"Groceries", "Housing", "Entertainment", "Hobbies", "Clothing", "Income"}});

  Map toJson() => {
    'currency': currency,
    'locale': locale,
    'categories': categories,
  };

  factory Settings.fromJson(Map json) {
    return Settings(
      currency: json['currency'],
      locale: json['locale'],
      categories: json['categories'],
    );
  } 

  Settings copyWith({String? locale, String? currency, Set<String>? categories}) {
    return Settings(
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      categories: categories ?? this.categories
    );
  }
}