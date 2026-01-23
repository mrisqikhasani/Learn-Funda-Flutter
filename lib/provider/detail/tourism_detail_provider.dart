import 'package:flutter/material.dart';
import 'package:practice_class/data/api/api_services.dart';
import 'package:practice_class/static/tourism_detail_result.dart';

class TourismDetailProvider extends ChangeNotifier{
  final ApiServices _apiServices;

  TourismDetailProvider(
    this._apiServices,
  );

  TourismDetailResultState _resultState = TourismDetailNoneState();

  TourismDetailResultState get resultState => _resultState;

  Future<void> fetchTourismDetail(int id) async {
    try {
      _resultState = TourismDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getTourismDetail(id);

      if(result.error){
        _resultState = TourismDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = TourismDetailLoadedState(result.place);
        notifyListeners();
      }

    }on Exception catch (e) {
      _resultState = TourismDetailErrorState(e.toString());
      notifyListeners();
    }
  }

}