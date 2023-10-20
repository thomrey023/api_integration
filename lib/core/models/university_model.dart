// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UniversityModel {
  String name;
  dynamic stateProvince;
  dynamic domain;
  UniversityModel({
    this.name = '',
    this.stateProvince = '',
    this.domain = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'state-province': stateProvince,
      'domain': domain,
    };
  }

  factory UniversityModel.fromMap(Map<String, dynamic> map) {
    return UniversityModel(
      name: map['name'] as String,
      stateProvince: map['state-province'] as dynamic,
      domain: map['domain'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory UniversityModel.fromJson(String source) =>
      UniversityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
