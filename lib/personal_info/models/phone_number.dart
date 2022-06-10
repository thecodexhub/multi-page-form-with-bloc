import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('Phone Number can\'t be empty.'),
  invalid('The phone number is invalid.');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegex =
      RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneNumberValidationError.required
        : _phoneRegex.hasMatch(value)
            ? null
            : PhoneNumberValidationError.invalid;
  }
}
