import 'dart:convert';
import 'dart:io';

import 'package:blood_bank/helpers/helpers.dart';
import 'package:blood_bank/models/donor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Api {
  final baseURL = 'https://deploytest.ahmed.com.ly/BBank/api/donors/';
  List<Donor> donorList = [];

  String finalDonorURL = '';

  Future getDonors(int pageNo) async {
    final response = await http.get(Uri.parse(baseURL+'?page='+pageNo.toString()),);
    
    if(response.statusCode != 200) {
      return null;
    }

    final jsonBody = jsonDecode(response.body);
    final list = jsonBody['DonorList']['data'];
    for(final element in list) {
      donorList.add(Donor.fromJson(element));
    }
    return donorList;
  }

  Future getDonorsCustom(String city, String bloodType, int pageNo) async {
    if(city != 'الكل' && bloodType != 'الكل') {
      finalDonorURL = baseURL + 'search/' + city + '/' + bloodType + '?page=' + pageNo.toString();
    }
    else if(city != 'الكل' && bloodType == 'الكل') {
      finalDonorURL = baseURL + 'searchcity/' + city + '?page=' + pageNo.toString();
    }
    else if(city == 'الكل' && bloodType != 'الكل') {
      finalDonorURL = baseURL + 'searchblood/' + bloodType + '?page=' + pageNo.toString();
    }
    final response = await http.get(Uri.parse(finalDonorURL),);
    
    if(response.statusCode != 200) {
      return null;
    }

    final jsonBody = jsonDecode(response.body);
    final list = jsonBody['DonorList']['data'];
    for(final element in list) {
      donorList.add(Donor.fromJson(element));
    }
    return donorList;
  }

  Future<bool> login(String email, String password) async {
    if(email.isNotEmpty || password.isNotEmpty) {
      final body = {
        'email': email,
        'password': password,
      };
      final response = await http.post(Uri.parse(baseURL+'login'),
      body: body);

      if(response.statusCode >= 200 && response.statusCode <300) {
         final jsonBody = jsonDecode(response.body);
         final token = jsonBody['token'];
         final id = jsonBody['user']['id'];

         final prefs = await SharedPreferences.getInstance();
         prefs.setString('id', id.toString());
         prefs.setString('token', token);
         return true;
      } 
    }
    return false;
  }

  Future<bool> register(String name, String email, String password, String password_confirmation, String blood_type, String phone_number, String city) async {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'blood_type': blood_type,
      'phone_number': phone_number,
      'city': city,
    };

    final response = await http.post(Uri.parse(baseURL+'register'),
    body: body);

    if(response.statusCode >=200 && response.statusCode <300) {
      final jsonBody = jsonDecode(response.body);
      final token = jsonBody['token'];
      final id = jsonBody['user']['id'];
      
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('id', id.toString());
      prefs.setString('token', token);
      return true;
    }
    return false;
  }
  
  Future getDonorProfile() async {
    late Donor donorProfile;
    final id = await getId();
    final token = await getToken();
    final response = await http.get(Uri.parse(baseURL+id.toString()),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    },
    );

    if(response.statusCode != 200) {
      return;
    }

    final jsonBody = jsonDecode(response.body);
      donorProfile = (Donor.fromJson(jsonBody));
    return donorProfile;
  }

  Future<bool> logout() async {
    final token = await getToken();
    final response = await http.post(Uri.parse(baseURL+'logout'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if(response.statusCode != 200) {
      return false;
    }

    await clearPrefs();
    return true;
  }

  Future<bool> update(String name, String phone_number, String blood_type, String city) async {
    final id = await getId();
    final token = await getToken();

    final body = {
      'name': name,
      'phone_number': phone_number,
      'blood_type': blood_type,
      'city': city,
    };

    final response = await http.put(Uri.parse(baseURL+'update/'+id.toString()),
    body: body,
    
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });
    if(response.statusCode != 200) {
      return false;
    }

    return true;
  }

  Future<bool> delete() async {
    final id = await getId();
    final token = await getToken();
    final response = await http.delete(Uri.parse(baseURL+'delete/'+id.toString()),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if(response.statusCode != 200) {
      return false;
    }

    await clearPrefs();
    return true;
  }
}