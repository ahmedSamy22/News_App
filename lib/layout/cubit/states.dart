abstract class NewsStates {}

class AppInitialState extends NewsStates{}

class AppChangeNavBarState extends NewsStates{}

class BusinessNewsLoadingState extends NewsStates{}
class BusinessNewsSuccessState extends NewsStates{}
class BusinessNewsErrorState extends NewsStates{
  late final String error;
  BusinessNewsErrorState(this.error);

}

class SportsNewsLoadingState extends NewsStates{}
class SportsNewsSuccessState extends NewsStates{}
class SportsNewsErrorState extends NewsStates{
  late final String error;
  SportsNewsErrorState(this.error);

}

class ScienceNewsLoadingState extends NewsStates{}
class ScienceNewsSuccessState extends NewsStates{}
class ScienceNewsErrorState extends NewsStates{
  late final String error;
  ScienceNewsErrorState(this.error);

}

class SearchNewsLoadingState extends NewsStates{}
class SearchNewsSuccessState extends NewsStates{}
class SearchNewsErrorState extends NewsStates{
  late final String error;
  SearchNewsErrorState(this.error);

}

