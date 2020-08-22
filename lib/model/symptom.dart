class Symptom {
  final String text;
  List<bool> answer;

  Symptom(this.text, this.answer);
}

Map<String, dynamic> listSymptomToJson(List<Symptom> list) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (list != null) {
    list.forEach(
        (element) => data.putIfAbsent(element.text, () => element.answer));
  }
  return data;
}

List<Symptom> listSymptomFromJson(Map<String, dynamic> json) {
  List<Symptom> data = [];
  if (json != null) {
    symptomList.forEach((element) =>
        data.add(Symptom(element.text, json[element.text].cast<bool>())));
  }
  return data;
}

List<Symptom> symptomList = [
  Symptom("Apakah hari ini anda merasa demam?", [false, false]),
  Symptom("Apakah hari ini anda merasa batuk kering?", [false, false]),
  Symptom("Apakah hari ini anda merasa kelelahan?", [false, false]),
  Symptom(
      "Apakah hari ini anda merasa tidak nyaman dan nyeri?", [false, false]),
  Symptom("Apakah hari ini anda merasa nyeri tenggorokan?", [false, false]),
  Symptom("Apakah hari ini anda merasa diare?", [false, false]),
  Symptom("Apakah hari ini mata anda merah?", [false, false]),
  Symptom("Apakah hari ini anda merasa sakit kepala?", [false, false]),
  Symptom("Apakah hari ini indera perasa atau penciuman anda terganggu?",
      [false, false]),
  Symptom(
      "Apakah hari ini ada ruam pada kulit, atau perubahan warna pada jari tangan atau jari kaki?",
      [false, false]),
  Symptom("Apakah hari ini anda merasa kesulitan bernapas atau sesak napas?",
      [false, false]),
  Symptom(
      "Apakah hari ini anda merasa nyeri dada atau rasa tertekan pada dada?",
      [false, false]),
  Symptom(
      "Apakah hari ini anda merasa kesulitan untuk berbicara atau bergerak?",
      [false, false])
];
