class Source {

  const Source({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.type,
    this.isSubscription,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logo_url'] as String,
      type: json['type'] as String?,
      isSubscription: json['is_subscription'] as bool?,
    );
  }
  final String id;
  final String name;
  final String logoUrl;
  final String? type;
  final bool? isSubscription;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'type': type,
      'is_subscription': isSubscription,
    };
  }
}
