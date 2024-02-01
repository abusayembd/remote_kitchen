import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../presentation/widgets/custom_snack_bar.dart';
import '../../model/common/error_response_model.dart';

 Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

class ApiMethod {
  ///************Get method without query parameters******************/

  Future<Map<String, dynamic>?> get(
    String url, {
    int code = 200,
    int duration = 15,
    bool showResult = false,
  }) async {
    if (kDebugMode) {
      print("------GEt Method Started------");
      print("Target url: $url");
    }

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: basicHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));
      if (kDebugMode) {
        print(
            "-----------------[[ GET ]] method response start -----------------");
        print("Target url: $url");
      }
      if (showResult) {
        if (kDebugMode) {
          print(response.body.toString());
        }
      }
      if (kDebugMode) {
        print(response.statusCode);
      }
      if (kDebugMode) {
        print(
            "-----------------[[ GET ]] method response end -----------------");
      }

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("------- Error Alert On Status Code -------");
          print("unknown error hit in status code${jsonDecode(response.body)}");
        }
        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        CustomSnackBar.error(res.message.error.toString());

        return null;
      }
    } on SocketException {
      if (kDebugMode) {
        print("------- Error Alert on Socket Exception -------");
      }

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      if (kDebugMode) {
        print("------- Error Alert Timeout Exception -------");
        print("Time out exception$url");
      }

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stacktrace) {
      if (kDebugMode) {
        print("------- Error Alert Client Exception -------");
        print("client exception hit");
        print(err.toString());
        print(stacktrace.toString());
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("------- Error Alert -------");
        print("--------Unlisted error received---------");
        print(e.toString());
      }
      return null;
    }
  }

  //
  //
  //
  //
  //
  //
  ///**************************Post Method**********************************/

  Future<Map<String, dynamic>?> post(String url, Map<String, dynamic> body,
      {int code = 201, int duration = 30, bool showResult = false}) async {
    try {
      if (kDebugMode) {
        print("------Post Method Started------");
        print("Target url: $url");
        print("Body: $body");
        print("------[[ POST ]] method details end -----");
      }
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: basicHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));

      if (kDebugMode) {
        print("------[[ POST ]] method response start -----");
      }

      if (showResult) {
        if (kDebugMode) {
          print(response.body.toString());
        }
      }

      if (kDebugMode) {
        print(response.statusCode);
        print("------[[ POST ]] method response end -----");
      }
      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("------- Error Alert On Status Code -------");
          print("unknown error hit in status code${jsonDecode(response.body)}");
        }
        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        CustomSnackBar.error(res.message.error.toString());

        return null;
      }
    } on SocketException {
      if (kDebugMode) {
        print("------- Error Alert on Socket Exception -------");
      }
      CustomSnackBar.error('Check your Internet Connection and try again!');
      return null;
    } on TimeoutException {
      if (kDebugMode) {
        print("------- Error Alert Timeout Exception -------");
        print("-----Time out exception$url ------");
      }
      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stacktrace) {
      if (kDebugMode) {
        print("------- Error Alert Client Exception -------");
        print("client exception hit");
        print(err.toString());
        print(stacktrace.toString());
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("------- Other Error Alert -------");
        print("--------Unlisted error received---------");
        print(e.toString());
      }
      return null;
    }
  }

  //
  //
  //
  //
  //
  //
  //  GET request with query parameters
  Future<Map<String, dynamic>?> paramGet(String url, Map<String, String> body,
      {int code = 200, int duration = 15, bool showResult = false}) async {
    if (kDebugMode) {
      print(
          '|Get parameter|----------------- [[ GET ]] param method Details Start ----------------');
      print("##body given --> ");
    }

    if (showResult) {
      if (kDebugMode) {
        print(body);
      }
    }
    if (kDebugMode) {
      print("##url list --> $url");
      print(
          '|Get parameter|----------------- [[ GET ]] param method details ended ** ---------------');
    }
    try {
      final response = await http
          .get(
            Uri.parse(url).replace(queryParameters: body),
            headers: basicHeaderInfo(),
          )
          .timeout(const Duration(seconds: 15));
      if (kDebugMode) {
        print(
            '|Get parameter|----------------- [[ GET ]] param method response start ----------------');
      }
      if (showResult) {
        if (kDebugMode) {
          print(response.body.toString());
        }
      }
      if (kDebugMode) {
        print(
            '|Get parameter|----------------- [[ GET ]] param method response end ----------------');
      }
      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("------- Error Alert On Status Code -------");
          print("unknown error hit in status code${jsonDecode(response.body)}");
        }

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        CustomSnackBar.error(res.message.error.toString());

        return null;
      }
    } on SocketException {
      if (kDebugMode) {
        print("------- Error Alert on Socket Exception -------");
      }

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      if (kDebugMode) {
        print("------- Error Alert Timeout Exception -------");
        print("Time out exception$url");
      }

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stacktrace) {
      if (kDebugMode) {
        print("------- Error Alert On Client Exception -------");
        print("client exception hit");
        print(err.toString());
        print(stacktrace.toString());
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("------- Error Alert -------");
        print("'#url->$url||#body -> $body'");
        print("--------Unlisted error received---------");
        print(e.toString());
      }
      return null;
    }
  }

  //
  //
  //
  //
  //
  //
  ///*********************** Delete method**********************************/

  Future<Map<String, dynamic>?> delete(String url,
      {int code = 202,
      bool isLogout = false,
      int duration = 15,
      bool showResult = false}) async {
    if (kDebugMode) {
      print(
          '-----------------[[ DELETE ]] method details start-----------------');
      print(url);
      print(
          '----------------[[ DELETE ]] method details end ------------------');
    }
    try {
      var headers = basicHeaderInfo();
      if (kDebugMode) {
        print(headers);
      }
      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(Duration(seconds: duration));
      if (kDebugMode) {
        print(
            '----------------- [[ DELETE ]] method response start-----------------');
      }

      if (showResult) {
        if (kDebugMode) {
          print(response.body.toString());
        }
      }
      if (kDebugMode) {
        print(response.statusCode);
        print(
            '----------------- [[ DELETE ]] method response start -----------------');
      }
      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("------- Error Alert On Status Code -------");
          print("unknown error hit in status code${jsonDecode(response.body)}");
        }
        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        CustomSnackBar.error(res.message.error.toString());

        return null;
      }
    } on SocketException {
      if (kDebugMode) {
        print("------- Error Alert on Socket Exception -------");
      }

      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      if (kDebugMode) {
        print("------- Error Alert Timeout Exception -------");
        print("Time out exception$url");
      }

      CustomSnackBar.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stacktrace) {
      if (kDebugMode) {
        print("------- Error Alert Client Exception -------");
        print("client exception hit");
        print(err.toString());
        print(stacktrace.toString());
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print("------- Error Alert -------");
        print("--------Unlisted error received---------");
        print(e.toString());
      }

      return null;
    }
  }

  //
  //
  //
  //
  //
  //
  /// *********************** PUT method **********************************/

  Future<Map<String, dynamic>?> put(String url, Map<String, String> body,
      {int code = 202, int duration = 15, bool showResult = false}) async {
    try {
      if (kDebugMode) {
        print(
            '-----------------[[ PUT ]] method details start-----------------');
        print(url);
        print(body);
        print('-----------------[[ PUT ]] method details end ------------');
      }

      final response = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: basicHeaderInfo(),
          )
          .timeout(Duration(seconds: duration));
      if (kDebugMode) {
        print(
            '-----------------[[ PUT ]] method response start-----------------');
      }

      if (showResult) {
        if (kDebugMode) {
          print(response.body.toString());
        }
      }
      if (kDebugMode) {
        print(response.statusCode);
        print(
            '-----------------[[ PUT ]] method response end -----------------');
      }

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("------- Error Alert On Status Code -------");
          print("unknown error hit in status code${jsonDecode(response.body)}");
        }

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        CustomSnackBar.error(res.message.error.toString());

        return null;
      }
    } on SocketException {
      if (kDebugMode) {
        print("------- Error Alert on Socket Exception -------");
      }
      CustomSnackBar.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      if (kDebugMode) {
        print("------- Error Alert Timeout Exception -------");
        print("Time out exception$url");
      }

      CustomSnackBar.error('Request Timed out! Try again');

      return null;
    } on http.ClientException catch (err, stacktrace) {
      if (kDebugMode) {
        print("------- Error Alert Client Exception -------");
        print("client exception hit");
        print(err.toString());
        print(stacktrace.toString());
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print("------- Error Alert -------");
        print("--------Unlisted error received---------");
        print(e.toString());
      }
      return null;
    }
  }
}
