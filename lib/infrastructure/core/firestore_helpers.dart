import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_firebse_ddd/domain/core/errors.dart';
import 'package:notes_firebse_ddd/providers.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await providerContainer
        .read(firebaseAuthFacadeProvider)
        .getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get notesCollection => collection('notes');
}
