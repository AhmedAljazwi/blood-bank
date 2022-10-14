import 'package:blood_bank/models/donor.dart';
import 'package:blood_bank/services/api.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isBusy = true;
  late Donor _profileOfDonor;

  bool get isBusy => _isBusy;
  Donor get profileOfDonor => _profileOfDonor;

  setIsBusy(value) {
    _isBusy = value;
    notifyListeners();
  }

  setProfileOfDonors(value) {
    _profileOfDonor = value;
    notifyListeners();
  }

  getDonorProfileFromApi() async {
   setIsBusy(true);
    final donors = await Api().getDonorProfile();
    setProfileOfDonors(donors);
    setIsBusy(false);
  }

  Future<bool> updateDonorProfileFromApi(String name, String phone_number, String blood_type, String city) async {
    setIsBusy(true);
    if(await Api().update(name, phone_number, blood_type, city)) { setIsBusy(false); return true; }
    setIsBusy(false);
    return false;
  }

  Future<bool> logOutDonorProfileFromApi() async {
    setIsBusy(true);
    if(await Api().logout()) { setIsBusy(false); return true; }
    setIsBusy(false);
    return false;
  }

  Future<bool> deleteDonorProfileFromApi() async {
    setIsBusy(true);
    if(await Api().delete()) { setIsBusy(false); return true; }
    setIsBusy(false);
    return false;
  }
}