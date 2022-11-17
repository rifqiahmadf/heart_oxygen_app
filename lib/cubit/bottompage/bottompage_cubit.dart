import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottompage_state.dart';

class BottompageCubit extends Cubit<int> {
  BottompageCubit() : super(2);

  void setPage(int newPage) {
    emit(newPage);
  }
}
