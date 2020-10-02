// To parse this JSON data, do
//
//     final hechizo = hechizoFromJson(jsonString);

import 'dart:convert';

List<Hechizo> hechizoFromJson(String str) => List<Hechizo>.from(json.decode(str).map((x) => Hechizo.fromJson(x)));

String hechizoToJson(List<Hechizo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hechizo {
  Hechizo({
    this.id,
    this.spell,
    this.type,
    this.effect,
    this.v,
  });

  String id;
  String spell;
  Type type;
  String effect;
  int v;

  factory Hechizo.fromJson(Map<String, dynamic> json) => Hechizo(
    id: json["_id"],
    spell: json["spell"],
    type: typeValues.map[json["type"]],
    effect: json["effect"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "spell": spell,
    "type": typeValues.reverse[type],
    "effect": effect,
    "__v": v == null ? null : v,
  };
}

enum Type { CHARM, ENCHANTMENT, SPELL, HEX, CURSE, JINX }

final typeValues = EnumValues({
  "Charm": Type.CHARM,
  "Curse": Type.CURSE,
  "Enchantment": Type.ENCHANTMENT,
  "Hex": Type.HEX,
  "Jinx": Type.JINX,
  "Spell": Type.SPELL
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
