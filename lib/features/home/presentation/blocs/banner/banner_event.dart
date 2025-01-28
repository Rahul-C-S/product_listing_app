part of 'banner_bloc.dart';

@immutable
sealed class BannerEvent {}

final class FetchBanners extends BannerEvent{ }
