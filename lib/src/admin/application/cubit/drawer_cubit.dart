import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nfc/src/common/domain/certificate.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  Future<void> setNID(
    String nid, {
    required bool isAdmin,
    Certificate? certificate,
  }) async {
    emit(DrawerLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(GotUserData(nid, certificate: certificate, isAdmin: isAdmin));
  }

  void flush() {
    emit(DrawerInitial());
  }
}
