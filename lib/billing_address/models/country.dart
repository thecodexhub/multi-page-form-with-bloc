import 'package:formz/formz.dart';

enum CountryValidationError {
  required('This field can\'t be empty. Please provide information.');

  final String message;
  const CountryValidationError(this.message);
}

class Country extends FormzInput<String, CountryValidationError> {
  const Country.pure() : super.pure('');
  const Country.dirty([String value = '']) : super.dirty(value);

  @override
  CountryValidationError? validator(String value) {
    return value.isNotEmpty ? null : CountryValidationError.required;
  }
}
