class ProfileInstance {
  int id;
  String name;
  int age;
  double weight;
  double height;

  ProfileInstance(this.id, this.name, this.age, this.weight, this.height);

  @override
  String toString() {
    return 'ProfileInstance{id: $id, name: $name, age: $age, weight: $weight, height: $height}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
    };
  }
}