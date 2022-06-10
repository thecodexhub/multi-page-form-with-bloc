import 'package:formz/formz.dart';

enum NameValidationError {
  required('Name can\'t be empty'),
  invalid('Name you have entered is not valid.');

  final String message;
  const NameValidationError(this.message);
}

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  static final _nameRegex =
      RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  NameValidationError? validator(String value) {
    return value.isEmpty
        ? NameValidationError.required
        : _nameRegex.hasMatch(value)
            ? null
            : NameValidationError.invalid;
  }
}
