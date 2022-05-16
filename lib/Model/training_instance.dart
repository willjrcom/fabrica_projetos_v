class TrainingInstance {
  int id;
  String name;
  String dataTimeStart;
  String dataTimeFinish;
  String dataTimeTotal;
  int isOpen;
  List<String> exercises = [];

  TrainingInstance(this.id, this.name, this.dataTimeStart, this.dataTimeFinish, this.dataTimeTotal, this.isOpen, this.exercises);

  @override
  String toString() {
    return 'ProfileInstance{id: $id, name: $name, dataTimeStart: $dataTimeStart, dataTimeFinish: $dataTimeFinish, dataTimeTotal: $dataTimeTotal, isOpen: $isOpen, exercises: $exercises}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dataTimeStart': dataTimeStart,
      'dataTimeFinish': dataTimeFinish,
      'dataTimeTotal': dataTimeTotal,
      'isOpen': isOpen,
      'exercises': exercises,
    };
  }
}

TrainingInstance trainingFromMap(Map<String, dynamic> map) {
  final String dataTimeFinish;
  final String dataTimeTotal;
  final List<String> exercises;

  if (map['dataTimeFinish'] == null) {
    dataTimeFinish = map['dataTimeFinish'].toString();
    dataTimeTotal = map['dataTimeTotal'].toString();
    exercises = map['exercises'];
  } else {
    dataTimeFinish = '';
    dataTimeTotal = '';
    exercises = [];
  }
  return TrainingInstance(map['id'], map['name'], map['dataTimeStart'], dataTimeFinish, dataTimeTotal, map['isOpen'], exercises);
}