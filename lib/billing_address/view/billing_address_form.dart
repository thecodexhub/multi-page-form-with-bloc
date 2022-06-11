import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:multi_page_form_with_bloc/billing_address/bloc/billing_address_bloc.dart';
import 'package:multi_page_form_with_bloc/checkout/checkout.dart';

class BillingAddressForm extends StatelessWidget {
  const BillingAddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BillingAddressBloc, BillingAddressState>(
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
          _StreetInput(),
          const SizedBox(height: 12.0),
          _ApartmentInput(),
          const SizedBox(height: 12.0),
          _CityInput(),
          const SizedBox(height: 12.0),
          _CountryInput(),
          const SizedBox(height: 12.0),
          _PostcodeInput(),
          const SizedBox(height: 12.0),
          Row(
            children: [
              _SubmitButton(),
              const SizedBox(width: 8.0),
              _CancelButton(),
            ],
          ),
        ],
      )),
    );
  }
}

class _StreetInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.street != current.street,
      builder: (context, state) {
        return TextField(
          key: const Key('billingAddressForm_streetInput_textField'),
          onChanged: (street) =>
              context.read<BillingAddressBloc>().add(StreetChanged(street)),
          decoration: InputDecoration(
            labelText: 'Street address',
            errorText:
                state.street.invalid ? state.street.error?.message : null,
          ),
        );
      },
    );
  }
}

class _ApartmentInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.apartment != current.apartment,
      builder: (context, state) {
        return TextField(
          key: const Key('billingAddressForm_apartmentInput_textField'),
          onChanged: (apartment) => context
              .read<BillingAddressBloc>()
              .add(ApartmentChanged(apartment)),
          decoration: const InputDecoration(
            labelText: 'Apt, suite etc (Optional)',
          ),
        );
      },
    );
  }
}

class _CityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return TextField(
          key: const Key('billingAddressForm_cityInput_textField'),
          onChanged: (city) =>
              context.read<BillingAddressBloc>().add(CityChanged(city)),
          decoration: InputDecoration(
            labelText: 'City',
            errorText: state.city.invalid ? state.city.error?.message : null,
          ),
        );
      },
    );
  }
}

class _CountryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.country != current.country,
      builder: (context, state) {
        return TextField(
          key: const Key('billingAddressForm_countryInput_textField'),
          onChanged: (country) =>
              context.read<BillingAddressBloc>().add(CountryChanged(country)),
          decoration: InputDecoration(
            labelText: 'Country',
            errorText:
                state.country.invalid ? state.country.error?.message : null,
          ),
        );
      },
    );
  }
}

class _PostcodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.postcode != current.postcode,
      builder: (context, state) {
        return TextField(
          key: const Key('billingAddressForm_postcodeInput_textField'),
          onChanged: (postcode) =>
              context.read<BillingAddressBloc>().add(PostcodeChanged(postcode)),
          decoration: InputDecoration(
            labelText: 'ZIP / postcode',
            errorText:
                state.postcode.invalid ? state.postcode.error?.message : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillingAddressBloc, BillingAddressState>(
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
                key:
                    const Key('billingAddressForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: state.status.isValidated
                    ? () =>
                        context.read<BillingAddressBloc>().add(FormSubmitted())
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
    return BlocBuilder<BillingAddressBloc, BillingAddressState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const SizedBox.shrink()
            : TextButton(
                key:
                    const Key('billingAddressForm_cancelButton_elevatedButton'),
                onPressed: () => context.read<CheckoutCubit>().stepCancelled(),
                child: const Text('CANCEL'),
              );
      },
    );
  }
}
