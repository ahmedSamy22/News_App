import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';

import '../shared/app_cubit/app_cubit.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit=NewsCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: Text(
            cubit.titles[cubit.currentIndex],
           ),
          actions: [
            IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){
                AppCubit.get(context).changeAppMode();
                NewsCubit.get(context).getSportsNews();
                NewsCubit.get(context).getBusinessNews();
                NewsCubit.get(context).getScienceNews();
               // NewsCubit.get(context).refresh();
              },
              icon: Icon(Icons.brightness_4_outlined),
            ),
          ],
        ),
        body:cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: cubit.navigationItems,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeNavBarState(index);
          },
        ),
      );
      },

    );
  }
}
