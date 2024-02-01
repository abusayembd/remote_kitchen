
class EmployeeModel {
  final String status;
  final List<Datum> data;
  final String message;

  EmployeeModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  final int id;
  final String employeeName;
  final int employeeSalary;
  final int employeeAge;
  final String? profileImage;

  Datum({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
    profileImage: json["profile_image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,
  };
}
