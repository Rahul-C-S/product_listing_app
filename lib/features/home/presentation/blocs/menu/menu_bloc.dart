import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/domain/use_cases/add_remove_wishlist_item.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_products.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_wishlist.dart';
import 'package:product_listing_app/features/home/domain/use_cases/search_product.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetProducts _getProducts;
  final GetWishlist _getWishlist;
  final AddRemoveWishlistItem _addRemoveWishlistItem;
  final SearchProduct _search;

  MenuBloc({
    required GetProducts getProducts,
    required GetWishlist getWishlist,
    required AddRemoveWishlistItem addRemoveWishlistItem,
    required SearchProduct search,
  })  : _getProducts = getProducts,
        _addRemoveWishlistItem = addRemoveWishlistItem,
        _getWishlist = getWishlist,
        _search = search,
        super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      emit(MenuLoading());
    });
    on<FetchMenu>(_onFetchMenu);
    on<FetchWishlist>(_onFetchWishlist);
    on<UpdateWishlist>(_onUpdateWishlist);
    on<Search>(_onSearch);
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

  void _onSearch(Search event, Emitter<MenuState> emit) async{

    final res = await _search(SearchProductParams(query: event.query,),);

    res.fold((l) => emit(MenuFailure(error: l.message)), (r) => emit(ProductSuccess(products: r)),);

  }
}
