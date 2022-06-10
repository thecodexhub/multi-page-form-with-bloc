import 'package:formz/formz.dart';

enum CityValidationError {
  required('This field can\'t be empty. Please provide information.');

  final String message;
  const CityValidationError(this.message);
}

class City extends FormzInput<String, CityValidationError> {
  const City.pure() : super.pure('');
  const City.dirty([String value = '']) : super.dirty(value);

  @override
  CityValidationError? validator(String value) {
    return value.isNotEmpty ? null : CityValidationError.required;
  }
}
