import 'package:formz/formz.dart';

enum StreetValidationError {
  required('This field is required. Please fill up!');

  final String message;
  const StreetValidationError(this.message);
}

class Street extends FormzInput<String, StreetValidationError> {
  const Street.pure() : super.pure('');
  const Street.dirty([String value = '']) : super.dirty(value);

  @override
  StreetValidationError? validator(String value) {
    return value.isNotEmpty ? null : StreetValidationError.required;
  }
}
