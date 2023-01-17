// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_riverpod_firebase/src/features/authentication/domain/app_user.dart';

class FakeAppUser extends AppUser {
  FakeAppUser({
    required super.uid,
    required super.email,
    required this.password,
  });
  final String password;
}
