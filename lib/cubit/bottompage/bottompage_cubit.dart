import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottompage_state.dart';

class BottompageCubit extends Cubit<int> {
  BottompageCubit() : super(2);

  void setPage(int newPage) {
    emit(newPage);
  }
}
