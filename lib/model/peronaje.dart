// To parse this JSON data, do
//
//     final personaje = personajeFromJson(jsonString);

import 'dart:convert';

List<Personaje> personajeFromJson(String str) => List<Personaje>.from(json.decode(str).map((x) => Personaje.fromJson(x)));

String personajeToJson(List<Personaje> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Personaje {
  Personaje({
    this.id,
    this.name,
    this.role,
    this.house,
    this.school,
    this.v,
    this.ministryOfMagic,
    this.orderOfThePhoenix,
    this.dumbledoresArmy,
    this.deathEater,
    this.bloodStatus,
    this.species,
    this.boggart,
    this.alias,
    this.animagus,
    this.wand,
    this.patronus,
  });

  String id;
  String name;
  String role;
  House house;
  School school;
  int v;
  bool ministryOfMagic;
  bool orderOfThePhoenix;
  bool dumbledoresArmy;
  bool deathEater;
  BloodStatus bloodStatus;
  String species;
  String boggart;
  String alias;
  String animagus;
  String wand;
  String patronus;

  factory Personaje.fromJson(Map<String, dynamic> json) => Personaje(
    id: json["_id"],
    name: json["name"],
    role: json["role"] == null ? null : json["role"],
    house: json["house"] == null ? null : houseValues.map[json["house"]],
    school: json["school"] == null ? null : schoolValues.map[json["school"]],
    v: json["__v"],
    ministryOfMagic: json["ministryOfMagic"],
    orderOfThePhoenix: json["orderOfThePhoenix"],
    dumbledoresArmy: json["dumbledoresArmy"],
    deathEater: json["deathEater"],
    bloodStatus: bloodStatusValues.map[json["bloodStatus"]],
    species: json["species"],
    boggart: json["boggart"] == null ? null : json["boggart"],
    alias: json["alias"] == null ? null : json["alias"],
    animagus: json["animagus"] == null ? null : json["animagus"],
    wand: json["wand"] == null ? null : json["wand"],
    patronus: json["patronus"] == null ? null : json["patronus"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role == null ? null : role,
    "house": house == null ? null : houseValues.reverse[house],
    "school": school == null ? null : schoolValues.reverse[school],
    "__v": v,
    "ministryOfMagic": ministryOfMagic,
    "orderOfThePhoenix": orderOfThePhoenix,
    "dumbledoresArmy": dumbledoresArmy,
    "deathEater": deathEater,
    "bloodStatus": bloodStatusValues.reverse[bloodStatus],
    "species": species,
    "boggart": boggart == null ? null : boggart,
    "alias": alias == null ? null : alias,
    "animagus": animagus == null ? null : animagus,
    "wand": wand == null ? null : wand,
    "patronus": patronus == null ? null : patronus,
  };
}

enum BloodStatus { HALF_BLOOD, UNKNOWN, PURE_BLOOD, MUGGLE, MUGGLE_BORN, QUARTER_VILLA, SQUIB, HALF_GIANT }

final bloodStatusValues = EnumValues({
  "half-blood": BloodStatus.HALF_BLOOD,
  "half-giant": BloodStatus.HALF_GIANT,
  "muggle": BloodStatus.MUGGLE,
  "muggle-born": BloodStatus.MUGGLE_BORN,
  "pure-blood": BloodStatus.PURE_BLOOD,
  "quarter-villa": BloodStatus.QUARTER_VILLA,
  "squib": BloodStatus.SQUIB,
  "unknown": BloodStatus.UNKNOWN
});

enum House { HUFFLEPUFF, GRYFFINDOR, SLYTHERIN, RAVENCLAW }

final houseValues = EnumValues({
  "Gryffindor": House.GRYFFINDOR,
  "Hufflepuff": House.HUFFLEPUFF,
  "Ravenclaw": House.RAVENCLAW,
  "Slytherin": House.SLYTHERIN
});

enum School { HOGWARTS_SCHOOL_OF_WITCHCRAFT_AND_WIZARDRY, BEAUXBATONS_ACADEMY_OF_MAGIC, DURMSTRANG_INSTITUTE, HOGWARTS_ACADEMY_OF_WITCHCRAFT_AND_WIZARDRY }

final schoolValues = EnumValues({
  "Beauxbatons Academy of Magic": School.BEAUXBATONS_ACADEMY_OF_MAGIC,
  "Durmstrang Institute": School.DURMSTRANG_INSTITUTE,
  "Hogwarts Academy of Witchcraft and Wizardry": School.HOGWARTS_ACADEMY_OF_WITCHCRAFT_AND_WIZARDRY,
  "Hogwarts School of Witchcraft and Wizardry": School.HOGWARTS_SCHOOL_OF_WITCHCRAFT_AND_WIZARDRY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
