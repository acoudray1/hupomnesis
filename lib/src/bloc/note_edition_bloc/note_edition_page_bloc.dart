import 'dart:async';

import 'package:hupomnesis/src/model/enum_edition_status.dart';
import 'package:rxdart/rxdart.dart';

///
/// Business Logic class to manage the view for the edition of notes
///
class NoteEditionPageBloc {

  EditionStatus editionStatus = EditionStatus.WRITING;

  final BehaviorSubject<EditionStatus> _editionStatus = BehaviorSubject<EditionStatus>();
  Observable<EditionStatus> get editionStatusStream => _editionStatus.stream;
  StreamSink<EditionStatus> get editionStatusSink => _editionStatus.sink;

  ///
  /// Handle the change to Writing Mode or Rendering Mode
  /// 
  void toggleEditionMode() {
    switch (editionStatus) {
      case EditionStatus.WRITING:
        editionStatus = EditionStatus.RENDERING;
        editionStatusSink.add(editionStatus);
        print(editionStatus);
        break;
      case EditionStatus.RENDERING:
        editionStatus = EditionStatus.WRITING;
        editionStatusSink.add(editionStatus);
        print(editionStatus);
        break;
    }
  }

  ///
  /// Dispose the different controllers
  ///
  void dispose() {
    _editionStatus.close();
  }
}