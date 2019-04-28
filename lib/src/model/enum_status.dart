import 'package:hupomnesis/src/resources/enum_manager.dart';

///
/// Represents the different types of status allowed
/// 
enum Status {
  NORMAL, ARCHIVED, PINNED,
}

final EnumManager<Status> statusValues = EnumManager<Status> (<String, Status> {
    'NORMAL': Status.NORMAL,
    'ARCHIVED': Status.ARCHIVED,
    'PINNED': Status.PINNED,
});