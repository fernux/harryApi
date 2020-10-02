// To parse this JSON data, do
//
//     final casa = casaFromJson(jsonString);

import 'dart:convert';

List<Casa> casaFromJson(String str) => List<Casa>.from(json.decode(str).map((x) => Casa.fromJson(x)));

String casaToJson(List<Casa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Casa {
  Casa({
    this.id,
    this.name,
    this.mascot,
    this.headOfHouse,
    this.houseGhost,
    this.founder,
    this.v,
    this.school,
    this.members,
    this.values,
    this.colors,
  });

  String id;
  String name;
  String mascot;
  String headOfHouse;
  String houseGhost;
  String founder;
  int v;
  String school;
  List<String> members;
  List<String> values;
  List<String> colors;

  factory Casa.fromJson(Map<String, dynamic> json) => Casa(
    id: json["_id"],
    name: json["name"],
    mascot: json["mascot"],
    headOfHouse: json["headOfHouse"],
    houseGhost: json["houseGhost"],
    founder: json["founder"],
    v: json["__v"],
    school: json["school"] == null ? null : json["school"],
    members: List<String>.from(json["members"].map((x) => x)),
    values: List<String>.from(json["values"].map((x) => x)),
    colors: List<String>.from(json["colors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "mascot": mascot,
    "headOfHouse": headOfHouse,
    "houseGhost": houseGhost,
    "founder": founder,
    "__v": v,
    "school": school == null ? null : school,
    "members": List<dynamic>.from(members.map((x) => x)),
    "values": List<dynamic>.from(values.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => x)),
  };
}
