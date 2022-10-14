import 'dart:convert';

Donor donorFromJson(String str) => Donor.fromJson(json.decode(str));

String donorToJson(Donor data) => json.encode(data.toJson());

class Donor {
    Donor({
        required this.bloodType,
        required this.name,
        required this.phoneNumber,
        required this.city,
    });

    String bloodType;
    String name;
    String phoneNumber;
    String city;

    factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        bloodType: json["blood_type"] == null ? null : json["blood_type"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        city: json["city"] == null ? null : json["city"],
    );

    Map<String, dynamic> toJson() => {
        "blood_type": bloodType == null ? null : bloodType,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "city": city == null ? null : city,
    };
}
