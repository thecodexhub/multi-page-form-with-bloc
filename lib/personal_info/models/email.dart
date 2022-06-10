import 'package:formz/formz.dart';

enum EmailValidationError {
  required('Email can\'t be empty'),
  invalid('This email is invalid. Please try again.');

  final String message;
  const EmailValidationError(this.message);
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.required
        : _emailRegex.hasMatch(value)
            ? null
            : EmailValidationError.invalid;
  }
}
