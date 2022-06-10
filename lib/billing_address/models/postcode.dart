import 'package:formz/formz.dart';

enum PostcodeValidationError {
  required('Please provide ZIP / postcode.'),
  invalid('Invalid pincode. Try again!');

  final String message;
  const PostcodeValidationError(this.message);
}

class Postcode extends FormzInput<String, PostcodeValidationError> {
  const Postcode.pure() : super.pure('');
  const Postcode.dirty([String value = '']) : super.dirty(value);

  static final _postcodeRegex = RegExp(r"[0-9]{6}");

  @override
  PostcodeValidationError? validator(String value) {
    return value.isNotEmpty
        ? _postcodeRegex.hasMatch(value)
            ? null
            : PostcodeValidationError.invalid
        : PostcodeValidationError.required;
  }
}
