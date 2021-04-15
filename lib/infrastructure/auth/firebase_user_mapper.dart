import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_firebse_ddd/domain/auth/user.dart' as domain;
import 'package:notes_firebse_ddd/domain/core/value_object.dart';

extension FirebaseUserDomainX on User {
  domain.User toDomainUser() {
    return domain.User(id: UniqueID.fromUniqueString(uid));
  }
}
