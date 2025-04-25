class Achievement {
  final String id;
  final String title;
  final String description;
  bool unlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.unlocked = false,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      unlocked: json['unlocked'] as bool? ?? false,
    );
  }

  /// Возвращает копию объекта с опциональным изменением полей
  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    bool? unlocked,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      unlocked: unlocked ?? this.unlocked,
    );
  }

  /// Устанавливает достижение как разблокированное
  void unlock() {
    unlocked = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'unlocked': unlocked,
    };
  }
}
