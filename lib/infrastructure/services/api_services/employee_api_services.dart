import 'package:flutter/foundation.dart';
import 'package:remote_kitchen/infrastructure/model/employee_model.dart';

import '../../../presentation/widgets/custom_snack_bar.dart';
import '../api_endpoint.dart';
import '../utils/api_method.dart';

class EmployeeApiServices {
  /// Get Employee info api
  static Future<EmployeeModel?> getAllEmployeeInfoApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod().get(
        ApiEndpoint.allEmployeeInfoGetURL,
        code: 200,
      );
      if (mapResponse != null) {
        EmployeeModel result = EmployeeModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      if (kDebugMode) {
        print(
          " 🚩 err from  Get Employee Api Services ==> $e ",
        );
      }
      CustomSnackBar.error('Something went Wrong! in Employee Model');
      return null;
    }
    return null;
  }
  ///
  ///
  ///
  ///
  /// Post Employee info api
  static Future<EmployeeModel?> postEmployeeStoreApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod()
          .post(ApiEndpoint.createEmployeeInfoPostURL, body, code: 200);
      if (mapResponse != null) {
        EmployeeModel result = EmployeeModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.toString());
        return result;
      }
    } catch (e) {
      if(kDebugMode){
        print("Error from post Employee Store Api service ==> $e");
      }
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
