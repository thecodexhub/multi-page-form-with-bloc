part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  const PersonalInfoState({
    this.email = const Email.pure(),
    this.name = const Name.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Name name;
  final PhoneNumber phoneNumber;
  final FormzStatus status;

  PersonalInfoState copyWith({
    Email? email,
    Name? name,
    PhoneNumber? phoneNumber,
    FormzStatus? status,
  }) {
    return PersonalInfoState(
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, name, phoneNumber, status];
}
