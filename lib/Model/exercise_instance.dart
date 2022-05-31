class ExerciseInstance {
  int id;
  int level;
  String description;
  int totalTime;
  String type;

  ExerciseInstance(this.id, this.level, this.description, this.totalTime, this.type);

  @override
  String toString() {
    return 'ProfileInstance{id: $id, level: $level, description: $description, total: $totalTime, type: $type}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'level': level,
      'description': description,
      'totalTime': totalTime,
      'type': type
    };
  }
}

ExerciseInstance exerciseFromMap(Map<String, dynamic> map) {
  return ExerciseInstance(map['id'], map['level'], map['description'], map['totalTime'], map['type']);
}
