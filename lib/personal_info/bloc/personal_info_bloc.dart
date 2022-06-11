import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_page_form_with_bloc/personal_info/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final UserRepository userRepository;

  PersonalInfoBloc({required this.userRepository})
      : super(const PersonalInfoState()) {
    on<EmailChanged>(_onEmailChanged);
    on<NameChanged>(_onNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.name, state.phoneNumber]),
    ));
  }

  void _onNameChanged(
    NameChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([state.email, name, state.phoneNumber]),
    ));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PersonalInfoState> emit,
  ) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([state.email, state.name, phoneNumber]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<PersonalInfoState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updatePersonalInfo(
          name: state.name.value,
          email: state.email.value,
          phoneNumber: state.phoneNumber.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
