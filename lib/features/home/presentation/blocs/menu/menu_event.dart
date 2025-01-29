part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent {}

final class FetchMenu extends MenuEvent {}

final class UpdateWishlist extends MenuEvent {
  final int productId;

  UpdateWishlist({required this.productId});
}

final class FetchWishlist extends MenuEvent {}

final class Search extends MenuEvent {
  final String query;

  Search({required this.query});
}
