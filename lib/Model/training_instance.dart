class TrainingInstance {
  int id;
  String name;
  String dataTimeStart;
  String dataTimeFinish;
  String dataTimeTotal;
  int isOpen;

  TrainingInstance(this.id, this.name, this.dataTimeStart, this.dataTimeFinish, this.dataTimeTotal, this.isOpen);

  @override
  String toString() {
    return 'ProfileInstance{id: $id, name: $name, dataTimeStart: $dataTimeStart, dataTimeFinish: $dataTimeFinish, dataTimeTotal: $dataTimeTotal, isOpen: $isOpen}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dataTimeStart': dataTimeStart,
      'dataTimeFinish': dataTimeFinish,
      'dataTimeTotal': dataTimeTotal,
      'isOpen': isOpen
    };
  }
}

TrainingInstance trainingFromMap(Map<String, dynamic> map) {
  final String dataTimeFinish;
  final String dataTimeTotal;

  if (map['dataTimeFinish'] == null) {
    dataTimeFinish = map['dataTimeFinish'].toString();
    dataTimeTotal = map['dataTimeTotal'].toString();
  } else {
    dataTimeFinish = '';
    dataTimeTotal = '';
  }
  return TrainingInstance(map['id'], map['name'], map['dataTimeStart'], dataTimeFinish, dataTimeTotal, map['isOpen']);
}