
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/use_cases/get_banners.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanners _getBanners;

  BannerBloc({required GetBanners getBanners}) : _getBanners = getBanners, super(BannerInitial()) {
    on<BannerEvent>((event, emit) {
     emit(BannerLoading());
    });

    on<FetchBanners>(_onFetchBanners);
  }

  void _onFetchBanners(FetchBanners event, Emitter<BannerState> emit)async{
final res = await _getBanners(NoParams());

res.fold((l) => emit(BannerFailure(error:l.message)), (r) => emit(BannerSuccess(banners: r)),);
  }
}
