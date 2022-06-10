import 'package:formz/formz.dart';

enum CvvNumberValidationError {
  required('Please provide CVV.'),
  invalid('CVV is invalid.');

  final String message;
  const CvvNumberValidationError(this.message);
}

class CvvNumber extends FormzInput<String, CvvNumberValidationError> {
  const CvvNumber.pure() : super.pure('');
  const CvvNumber.dirty([String value = '']) : super.dirty(value);

  static final _cvvNumberRegex = RegExp(r"^[0-9]{3}$");

  @override
  CvvNumberValidationError? validator(String value) {
    return value.isEmpty
        ? CvvNumberValidationError.required
        : _cvvNumberRegex.hasMatch(value)
            ? null
            : CvvNumberValidationError.invalid;
  }
}
