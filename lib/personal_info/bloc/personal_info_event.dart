part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent extends Equatable {
  const PersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends PersonalInfoEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class NameChanged extends PersonalInfoEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class PhoneNumberChanged extends PersonalInfoEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class FormSubmitted extends PersonalInfoEvent {}
