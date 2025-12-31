import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Payment {
  final String id;
  String title;
  int sum;
  String category;
  DateTime date;
  bool scheduled;

  Payment({
    String? id,
    required this.title,
    required this.sum,
    required this.category,
    required this.date,
    required this.scheduled,
  }) : id = id ?? _uuid.v4();

  Map toJson() => {
        'id': id,
        'title': title,
        'sum': sum,
        'category': category,
        'date': date.toIso8601String(),
        'scheduled': scheduled,
      };

  factory Payment.fromJson(Map json) {
    return Payment(
      id: json['id'],
      title: json['title'],
      sum: json['sum'],
      category: json['category'],
      date: DateTime.parse(json['date']),
      scheduled: json['scheduled'],
    );
  }

  Payment copyWith(
      {String? id, String? title, int? sum, String? category, DateTime? date, bool? scheduled}) {
    return Payment(
      id: id,
      title: title ?? this.title,
      sum: sum ?? this.sum,
      category: category ?? this.category,
      date: date ?? this.date,
      scheduled: scheduled ?? this.scheduled,
    );
  }

  get isPending => DateTime.now().isAfter(date);
}
