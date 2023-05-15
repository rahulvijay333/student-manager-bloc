import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:student/domain/db_model/db_mode.dart';
import 'package:student/domain/db_model/db_service.dart';

part 'insert_event.dart';
part 'insert_state.dart';

@injectable
class InsertBloc extends Bloc<InsertEvent, InsertState> {
  final StudentDbFunctions _studentDbFunctions;

  InsertBloc(this._studentDbFunctions) : super(InsertState()) {
    on<InsertStudent>((event, emit) async {
      await _studentDbFunctions.insertStudent(event.student);
    });
  }
}
