class Number {
  int text1,text2,text3;
  String comment;
  String date;
  
  Number({this.text1, this.text2, this.text3, this.comment, this.date})

  factory Number.fromMap(Map<String, dynamic> json) => new Number(
    text1: json["text1"],
    text2: json["text2"],
    text3: json["text3"],
    comment: json["comment"],
    date: json["date"],
  );

  Map<String, dynamic> toMap() => {
    "text1": text1,
    "text2":text2,
    "text3":text3,
    "comment" : comment,
    "date":date
  };
}