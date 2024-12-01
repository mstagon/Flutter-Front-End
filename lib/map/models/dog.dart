class Dog {
  final String id;
  final String name;
  final String imageUrl;
  final String breed;
  final int age;
  final double weight;

  Dog({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.breed,
    required this.age,
    required this.weight,
  });

  // JSON 변환을 위한 메서드들
  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      breed: json['breed'],
      age: json['age'],
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'breed': breed,
      'age': age,
      'weight': weight,
    };
  }
} 