import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_firebse_ddd/domain/notes/i_note_repository.dart';
import 'package:notes_firebse_ddd/domain/notes/note.dart';
import 'package:notes_firebse_ddd/domain/notes/note_failure.dart';
import 'package:notes_firebse_ddd/infrastructure/core/firestore_helpers.dart';
import 'package:notes_firebse_ddd/infrastructure/notes/note_dtos.dart';
import 'package:rxdart/rxdart.dart';

class NoteRepository implements INoteRepository {
  final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.notesCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<NoteFailure, KtList<Note>>(
            snapshot.docs
                .map((doc) => NoteDTO.fromFirestore(doc).toDomain())
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((e) {
      if (e is FirebaseException && e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        //TODO: Log This Error
        print('Unexpected Note Failure caught.error: $e');
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.notesCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) => NoteDTO.fromFirestore(doc).toDomain(),
          ),
        )
        .map(
          (notes) => right<NoteFailure, KtList<Note>>(
            notes
                .where((note) =>
                    note.todos.getOrCrash().any((todoItem) => !todoItem.done))
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((e) {
      if (e is FirebaseException && e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // REMINDER: Remove this log in prod
        developer.log('Unexpected Note Failure caught', error: e);
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<NoteFailure, Unit>> create(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDTO.fromDomain(note);

      await userDoc.notesCollection
          .doc(noteDto.id)
          .set(noteDto.toFirestoreJson());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        // REMINDER: Remove this log in prod
        developer.log('Unexpected Note Failure caught', error: e);
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> update(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteDto = NoteDTO.fromDomain(note);
      await userDoc.notesCollection
          .doc(noteDto.id)
          .update(noteDto.toFirestoreJson());
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (e.message!.contains('not-found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        // REMINDER: Remove this log in prod
        developer.log('Unexpected Note Failure caught', error: e);
        return left(const NoteFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<NoteFailure, Unit>> delete(Note note) async {
    try {
      final userDoc = await _firestore.userDocument();
      final noteId = note.id.getOrCrash();
      await userDoc.notesCollection.doc(noteId).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('permission-denied')) {
        return left(const NoteFailure.insufficientPermission());
      } else if (e.message!.contains('not-found')) {
        return left(const NoteFailure.unableToUpdate());
      } else {
        // REMINDER: Remove this log in prod
        print('Unexpected Note Failure caught.error: $e');
        return left(const NoteFailure.unexpected());
      }
    }
  }
}
