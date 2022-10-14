import 'package:blood_bank/models/donor.dart';
import 'package:blood_bank/services/api.dart';
import 'package:flutter/foundation.dart';

class DonorProvider extends ChangeNotifier {
  bool _isBusy = true;
  bool _isMore = false;
  List<Donor> _listOfDonors = [];
  int _pageNo = 1;

  bool get isBusy => _isBusy;
  bool get isMore => _isMore;
  List<Donor> get listOfDonors => _listOfDonors;

  setIsBusy(value) {
    _isBusy = value;
    notifyListeners();
  }

   setIsMore(value) {
    _isMore = value;
    notifyListeners();
  }

  setListOfDonors(value) {
    _listOfDonors += value;
    notifyListeners();
  }

  clearListOfDonors() {
    _listOfDonors = [];
    _listOfDonors.clear();
  }

  setPagination() {
    _pageNo++;
  }

  getPagination() {
    return _pageNo;
  }

  resetPagination() {
    _pageNo = 1;
  }

  getDonorsFromApi() async {
    setIsBusy(true);
    setIsMore(true);
    final donors = await Api().getDonors(_pageNo);
    setPagination();
    setListOfDonors(donors);
    setIsBusy(false);
    setIsMore(false);
  }

  getDonorsFromApiCustom(String city, String bloodType) async {
    if(city != 'الكل' || bloodType != 'الكل') {
    setIsBusy(true);
    setIsMore(true);
    final donors = await Api().getDonorsCustom(city, bloodType, _pageNo);
    setPagination();
    setListOfDonors(donors);
    setIsBusy(false);
    setIsMore(false);
    }
    else { getDonorsFromApi(); }
  }
}
