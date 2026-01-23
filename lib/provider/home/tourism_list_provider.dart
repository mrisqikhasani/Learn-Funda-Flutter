import 'package:flutter/widgets.dart';
import 'package:practice_class/data/api/api_services.dart';
import 'package:practice_class/static/tourism_list_result_state.dart';

class TourismListProvider extends ChangeNotifier {
  final ApiServices _apiservices;

  TourismListProvider(this._apiservices);

  TourismListResultState _resultState = TourismListNoneState();

  TourismListResultState get resultState => _resultState;

  Future<void> fetchTourismList() async {
      try {
        _resultState = TourismListLoadingState();
        notifyListeners();

        final result = await _apiservices.getTourismList();

        if(result.error){
          _resultState = TourismListErrorState(result.message);
          notifyListeners();
        } else {
          _resultState = TourismListLoadedState(result.places);
          notifyListeners();
        }

      } on Exception catch (e) {
        _resultState = TourismListErrorState(e.toString());
        notifyListeners();
      }
  }
}
