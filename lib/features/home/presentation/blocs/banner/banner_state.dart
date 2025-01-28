part of 'banner_bloc.dart';

@immutable
sealed class BannerState {}

final class BannerInitial extends BannerState {}
final class BannerLoading extends BannerState {}
final class BannerFailure extends BannerState {
  final String error;

  BannerFailure({required this.error});
}
final class BannerSuccess extends BannerState {
  final List<String> banners;

  BannerSuccess({required this.banners});
}
