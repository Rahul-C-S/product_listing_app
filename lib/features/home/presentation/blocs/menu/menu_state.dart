part of 'menu_bloc.dart';

@immutable
sealed class MenuState {}

final class MenuInitial extends MenuState {}
final class MenuLoading extends MenuState {}
final class ProductSuccess extends MenuState {
  final List<Product> products;

  ProductSuccess({required this.products});
}
final class MenuFailure extends MenuState {
  final String error;

  MenuFailure({required this.error});

}


