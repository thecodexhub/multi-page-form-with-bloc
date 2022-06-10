import 'package:formz/formz.dart';

enum ExpiryDateValidationError {
  required('Please provide expiry date.'),
  invalid('This field is invalid.');

  final String message;
  const ExpiryDateValidationError(this.message);
}

class ExpiryDate extends FormzInput<String, ExpiryDateValidationError> {
  const ExpiryDate.pure() : super.pure('');
  const ExpiryDate.dirty([String value = '']) : super.dirty(value);

  static final _expiryDateRegex =
      RegExp(r"^(0[1-9]|1[0-2])\/?([0-9]{4}|[0-9]{2})$");

  @override
  ExpiryDateValidationError? validator(String value) {
    return value.isEmpty
        ? ExpiryDateValidationError.required
        : _expiryDateRegex.hasMatch(value)
            ? null
            : ExpiryDateValidationError.invalid;
  }
}
