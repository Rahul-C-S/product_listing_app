
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_products.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetProducts _getProducts;
  MenuBloc({
    required GetProducts getProducts,
  }) : _getProducts = getProducts, super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      emit(MenuLoading());
    });
    on<FetchMenu>(_onFetchMenu);

  }

  void _onFetchMenu(FetchMenu event, Emitter<MenuState> emit) async{
    final res = await _getProducts(NoParams());

    res.fold((l) => emit(MenuFailure(error: l.message)), (r) => emit(ProductSuccess(products: r)),);
  }
}
