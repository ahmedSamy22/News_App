import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(AppInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  List<String> titles = [
    'Business News',
    'Sports News',
    'Science News',
    // 'Settings News',
  ];

  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
      label: 'business',
      icon: Icon(Icons.work),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports_soccer),
    ),
    BottomNavigationBarItem(
      label: 'Science',
      icon: Icon(Icons.science),
    ),
    // BottomNavigationBarItem(
    //   label: 'Settings',
    //   icon: Icon(Icons.settings),
    // ),
  ];

  void changeNavBarState(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSportsNews();
    } else if (currentIndex == 2) {
      getScienceNews();
    }
    emit(AppChangeNavBarState());
  }

  List<dynamic> business = [];

  void getBusinessNews() {
    emit(BusinessNewsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '2c2fc412c9c94a80acf417a3c42ec89a',
      },
    ).then((value) {
      business = value.data['articles'];
      print(business.length);

      emit(BusinessNewsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BusinessNewsErrorState(error));
    });
  }

  ////////////////
  List<dynamic> sports = [];

  void getSportsNews() {
    emit(SportsNewsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sport',
          'apiKey': '2c2fc412c9c94a80acf417a3c42ec89a',
        },
      ).then((value) {
        sports = value.data['articles'];

        emit(SportsNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SportsNewsErrorState(error));
      });
    } else {
      emit(SportsNewsSuccessState());
    }
  }

  /////////
  List<dynamic> science = [];

  void getScienceNews() {
    emit(ScienceNewsLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '2c2fc412c9c94a80acf417a3c42ec89a',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(ScienceNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ScienceNewsErrorState(error));
      });
    } else {
      emit(ScienceNewsSuccessState());
    }
  }


  List<dynamic> search = [];

  void getSearchNews(String value) {
    emit(SearchNewsLoadingState());

      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': value,
          'apiKey': '2c2fc412c9c94a80acf417a3c42ec89a',
        },
      ).then((value) {
        search = value.data['articles'];
        emit(SearchNewsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SearchNewsErrorState(error));
      });

  }




}
