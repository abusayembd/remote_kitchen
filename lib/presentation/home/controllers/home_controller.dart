import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen/infrastructure/model/employee_model.dart';
import 'package:remote_kitchen/infrastructure/services/api_services/employee_api_services.dart';

class HomeController extends GetxController {
  final employeeNameController = TextEditingController();
  final employeeSalaryController = TextEditingController();
  final employeeAgeController = TextEditingController();

  @override
  void onInit() {
    getAllEmployeeDataProcess();
    super.onInit();
  }

  ///=>************************** get all employees data  ***********************************/

  //=> set loading process & Invoice Model
  final _isLoading = false.obs;
  late EmployeeModel _employeeModel;

  //=> get loading process & Invoice Model
  bool get isLoading => _isLoading.value;

  EmployeeModel get employeeModel => _employeeModel;

  //=> get All Employee data  api Process
  Future<EmployeeModel> getAllEmployeeDataProcess() async {
    _isLoading.value = true;
    update();
    await EmployeeApiServices.getAllEmployeeInfoApi().then((value) {
      _employeeModel = value!;
      _setData(_employeeModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
    });
    _isLoading.value = false;
    update();
    return _employeeModel;
  }

  _setData(EmployeeModel employeeModel) {
    // Creating a new list to store the updated data
    List<Datum> updatedDataList = [];

    for (var element in employeeModel.data) {
      // Creating a new Datum instance with updated values
      Datum updatedDatum = Datum(
        id: element.id,
        employeeName: element.employeeName,
        employeeSalary: element.employeeSalary,
        employeeAge: element.employeeAge,
        profileImage: element.profileImage,
      );

      // Adding the updated Datum to the list
      updatedDataList.add(updatedDatum);
      if (kDebugMode) {
        print('Updated Employee ID: ${updatedDatum.id}');
        print('Updated Employee Name: ${updatedDatum.employeeName}');
        print('Updated Employee Salary: ${updatedDatum.employeeSalary}');
        print('Updated Employee Age: ${updatedDatum.employeeAge}');
        print('Updated Profile Image: ${updatedDatum.profileImage}');
        print('------------------------');
      }
    }
  }

  ///=>************************** add employee data (post method)  ***********************************/
  final _isEmployeeDataStoreLoading = false.obs;
  late EmployeeModel _employeeStoreModel;

  /// >> get employee data loading process & employee data Store Model
  bool get isInvoiceStoreLoading => _isEmployeeDataStoreLoading.value;

  EmployeeModel get employeeStoreModel => _employeeStoreModel;

  ///* create employee data process
  Future<EmployeeModel> addEmployeeDataProcess() async {
    _isEmployeeDataStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'name': employeeNameController.value,
      'salary': employeeSalaryController.value,
      'age': employeeAgeController.value,
    };
    await EmployeeApiServices.postEmployeeStoreApi(body: inputBody)
        .then((value) {
      _employeeStoreModel = value!;
      _employeeModel.data.addAll(value.data);
      _isEmployeeDataStoreLoading.value = false;
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
    });
    _isEmployeeDataStoreLoading.value = false;
    update();
    return _employeeStoreModel;
  }
}
