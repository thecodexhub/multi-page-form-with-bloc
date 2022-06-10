import 'package:formz/formz.dart';

enum CardNumberValidationError {
  required('Card number can\'t be empty'),
  invalid('Please provide a valid card number');

  final String message;
  const CardNumberValidationError(this.message);
}

class CardNumber extends FormzInput<String, CardNumberValidationError> {
  const CardNumber.pure() : super.pure('');
  const CardNumber.dirty([String value = '']) : super.dirty(value);

  static final _cardNumberRegex = RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$");

  @override
  CardNumberValidationError? validator(String value) {
    return value.isEmpty
        ? CardNumberValidationError.required
        : _cardNumberRegex.hasMatch(value)
            ? null
            : CardNumberValidationError.invalid;
  }
}
