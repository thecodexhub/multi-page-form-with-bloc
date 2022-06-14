import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_page_form_with_bloc/checkout/checkout.dart';
import 'package:multi_page_form_with_bloc/personal_info/bloc/personal_info_bloc.dart';

class PersonalInfoForm extends StatelessWidget {
  const PersonalInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _EmailInput(),
            const SizedBox(height: 12.0),
            _NameInput(),
            const SizedBox(height: 12.0),
            _PhoneNumberInput(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                _SubmitButton(),
                const SizedBox(width: 8.0),
                _CancelButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('personalInfoForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<PersonalInfoBloc>().add(EmailChanged(email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? state.email.error?.message : null,
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('personalInfoForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<PersonalInfoBloc>().add(NameChanged(name)),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? state.name.error?.message : null,
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('personalInfoForm_phoneNumberInput_textField'),
          onChanged: (phoneNumber) => context
              .read<PersonalInfoBloc>()
              .add(PhoneNumberChanged(phoneNumber)),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            errorText: state.phoneNumber.invalid
                ? state.phoneNumber.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoBloc, PersonalInfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<CheckoutCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('personalInfoForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: state.status.isValidated
                    ? () =>
                        context.read<PersonalInfoBloc>().add(FormSubmitted())
                    : null,
                child: const Text('SUBMIT'),
              );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : TextButton(
                key: const Key('personalInfoForm_cancelButton_elevatedButton'),
                onPressed: () => context.read<CheckoutCubit>().stepCancelled(),
                child: const Text('CANCEL'),
              );
      },
    );
  }
}
