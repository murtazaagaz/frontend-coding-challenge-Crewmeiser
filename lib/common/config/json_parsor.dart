import 'package:crewmeister_test/common/config/data_state.dart';
import 'package:crewmeister_test/common/constants/api_constants.dart';

class JsonParser {
  static DataState parseJson(Map<String, dynamic> body) {
    try {
      if (body[ApiConstants.message] == ApiConstants.success) {
        return DataSuccess(body[ApiConstants.payload]);
      }
      return DataFailed(body[ApiConstants.message]);
    } catch (e) {
      return DataFailed('Something went wrong');
    }
  }
}
