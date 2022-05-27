part of 'drawer_cubit.dart';

@immutable
abstract class DrawerState {}

class DrawerInitial extends DrawerState {}

class DrawerLoading extends DrawerState {}

class GotUserData extends DrawerState {
  final String nid;
  final bool isAdmin;
  final Certificate? certificate;

  GotUserData(this.nid, {required this.isAdmin, this.certificate});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GotUserData && other.nid == nid;
  }

  @override
  int get hashCode => nid.hashCode;
}
