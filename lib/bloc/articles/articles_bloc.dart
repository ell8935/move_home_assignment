import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_home_assignment/models/article_model.dart';
import 'package:move_home_assignment/models/filters_model.dart';
import 'package:move_home_assignment/ui/modules/shared/api/get_articles.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc() : super(ArticlesLoading()) {
    on<LoadArticles>(_onLoadArticles);
    on<LoadArticlesWithFilters>(_onLoadArticlesWithFilters);
  }

  _onLoadArticles(LoadArticles event, Emitter<ArticlesState> emit) async {
    try {
      final articles = await getArticles(filters: const FiltersEntity());

      final List<ArticleEntity> articlesList = articles.map((articleData) {
        return ArticleEntity.fromJson(articleData);
      }).toList();

      emit(ArticlesLoaded(articles: articlesList));
    } catch (e) {
      emit(const ArticlesError(errorMessage: 'Failed to load articles'));
    }
  }
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
    if (e is DioException) {
      emit(ArticlesError(errorMessage: e.message!));
    } else if (e is Exception) {
      emit(ArticlesError(errorMessage: e.toString()));
    }
  }
}
