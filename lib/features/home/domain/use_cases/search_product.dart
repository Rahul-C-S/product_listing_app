
import 'package:fpdart/fpdart.dart';
import 'package:product_listing_app/core/errors/failures.dart';
import 'package:product_listing_app/core/use_case/use_case.dart';
import 'package:product_listing_app/features/home/domain/entities/product.dart';
import 'package:product_listing_app/features/home/domain/repositories/home_repository.dart';

class SearchProduct implements UseCase<List<Product>,SearchProductParams> {
  final HomeRepository _homeRepository;

  SearchProduct({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<Product>>> call(SearchProductParams params)async {
return await _homeRepository.search(query: params.query);
  }
}
class SearchProductParams {
  final String query;

  SearchProductParams({required this.query});
}