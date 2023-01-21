import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/app_cubit/app_cubit.dart';
import 'package:news_app/shared/app_cubit/app_states.dart';

import 'layout/cubit/cubit.dart';


void main() {

  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> NewsCubit()..getBusinessNews()..getScienceNews()..getSportsNews(),),
        BlocProvider(create: (context)=>AppCubit())
      ],
      child: BlocConsumer<AppCubit,AppModeStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,

              ),
              // textTheme: TextTheme(
              //   bodyText1:TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.0,
              //     color: Colors.black,
              //   ),
              // ),

            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('#3F3F3F'),
              appBarTheme:  AppBarTheme(
                backgroundColor: HexColor('#3F3F3F'),
                elevation: 0.0,
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#3F3F3F'),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                backgroundColor: HexColor('#3F3F3F'),
                unselectedItemColor: Colors.grey,

              ),
              // textTheme: const TextTheme(
              //   bodyText1:TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.0,
              //     color: Colors.white,
              //   ),
              // ),
            ),
            themeMode: AppCubit.get(context).isDark? ThemeMode.dark :ThemeMode.light ,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

