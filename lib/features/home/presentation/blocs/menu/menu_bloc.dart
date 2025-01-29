import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/domain/use_cases/add_remove_wishlist_item.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_products.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_wishlist.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetProducts _getProducts;
  final GetWishlist _getWishlist;
  final AddRemoveWishlistItem _addRemoveWishlistItem;
  MenuBloc({
    required GetProducts getProducts,
    required GetWishlist getWishlist,
    required AddRemoveWishlistItem addRemoveWishlistItem,
  })  : _getProducts = getProducts,
        _addRemoveWishlistItem = addRemoveWishlistItem,
        _getWishlist = getWishlist,
        super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      emit(MenuLoading());
    });
    on<FetchMenu>(_onFetchMenu);
    on<FetchWishlist>(_onFetchWishlist);
    on<UpdateWishlist>(_onUpdateWishlist);
  }

  void _onFetchMenu(FetchMenu event, Emitter<MenuState> emit) async {
    final res = await _getProducts(NoParams());

    res.fold(
      (l) => emit(MenuFailure(error: l.message)),
      (r) => emit(ProductSuccess(products: r)),
    );
  }

  void _onUpdateWishlist(UpdateWishlist event, Emitter<MenuState> emit) async {
    final res = await _addRemoveWishlistItem(
        AddRemoveWishlistItemParams(productId: event.productId));

    res.fold(
      (l) => emit(MenuFailure(error: l.message)),
      (r) => emit(WishListUpdateSuccess(message: r)),
    );
  }

  void _onFetchWishlist(FetchWishlist event, Emitter<MenuState> emit) async {
    final res = await _getWishlist(NoParams());

    res.fold(
      (l) => emit(MenuFailure(error: l.message)),
      (r) => emit(WishlistFetchSuccess(products: r)),
    );
  }
}
