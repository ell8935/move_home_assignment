import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_home_assignment/shared/models/article_model.dart';
import 'package:move_home_assignment/shared/models/filters_model.dart';
import 'package:move_home_assignment/shared/api/get_articles.dart';
import 'package:move_home_assignment/shared/utils/custom_exception.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesLoading()) {
    on<LoadArticlesWithFilters>(_onLoadArticlesWithFilters);
  }

  _onLoadArticlesWithFilters(
      LoadArticlesWithFilters event, Emitter<ArticlesState> emit) async {
    try {
      final articles = await getArticles(filters: event.filters);

      final List<ArticleEntity> articlesList = articles.map((articleData) {
        return ArticleEntity.fromJson(articleData);
      }).toList();

      emit(ArticlesLoaded(articles: articlesList));
    } catch (e) {
      if (e is CustomException) emit(ArticlesError(errorMessage: e.message));
    }
  }
}
