class Number {
  int text1,text2,text3;
  String comment;
  String date;
  
  Number(int text1,int text2,int text3,String comment,String date){
    this.text1 = text1;
    this.text2 = text2;
    this.text3 = text3;
    this.comment = comment;
    this.date = date;
  }

  factory Number.fromMap(Map<String, dynamic> json) => new Number(
    json["text1"],
    json["text2"],
    json["text3"],
    json["comment"],
    json["date"],
  );

  Map<String, dynamic> toMap() => {
    "text1": text1,
    "text2":text2,
    "text3":text3,
    "comment" : comment,
    "date":date
  };
}