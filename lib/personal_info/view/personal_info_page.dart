import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_page_form_with_bloc/personal_info/bloc/personal_info_bloc.dart';
import 'package:multi_page_form_with_bloc/personal_info/view/view.dart';
import 'package:user_repository/user_repository.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const PersonalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => PersonalInfoBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: const PersonalInfoForm(),
      ),
    );
  }
}
