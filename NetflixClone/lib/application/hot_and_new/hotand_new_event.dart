part of 'hotand_new_bloc.dart';

@freezed
class HotandNewEvent with _$HotandNewEvent {
  const factory HotandNewEvent.loadDatainComingSoon() = LoadDatainComingSoon;
  const factory HotandNewEvent.loadDatainEveryOneWatching() =
      LoadDatainEveryOneWatching;
}
