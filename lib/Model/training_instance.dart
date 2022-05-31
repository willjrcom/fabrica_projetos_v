class TrainingInstance {
  int id;
  String dataTimeStart;
  String dataTimeFinish;
  String dataTimeTotal;
  int isOpen;
  String exercises;
  int totalMinutesToComplete;

  TrainingInstance(this.id, this.dataTimeStart, this.dataTimeFinish, this.dataTimeTotal, this.isOpen, this.exercises, this.totalMinutesToComplete);

  @override
  String toString() {
    return 'ProfileInstance{id: $id, dataTimeStart: $dataTimeStart, dataTimeFinish: $dataTimeFinish, dataTimeTotal: $dataTimeTotal, isOpen: $isOpen, exercises: $exercises, minutes: $totalMinutesToComplete}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataTimeStart': dataTimeStart,
      'dataTimeFinish': dataTimeFinish,
      'dataTimeTotal': dataTimeTotal,
      'isOpen': isOpen,
      'exercises': exercises,
      'totalMinutesToComplete': totalMinutesToComplete,
    };
  }

  String getUpdateQuery0() {
    return "UPDATE training SET "
      "dataTimeFinish = '$dataTimeFinish', "
      "dataTimeTotal = '$dataTimeTotal', "
      "isOpen = '$isOpen' "
      "WHERE id = $id";
  }
}

TrainingInstance trainingFromMap(Map<String, dynamic> map) {
  return TrainingInstance(map['id'], map['dataTimeStart'], map["dataTimeFinish"], map["dataTimeTotal"], map['isOpen'], map['exercises'], map["totalMinutesToComplete"]);
}