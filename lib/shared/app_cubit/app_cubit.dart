import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/app_cubit/app_states.dart';


class AppCubit extends Cubit<AppModeStates>
{
  AppCubit() : super(AppModeInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode()
  {
    isDark = !isDark;
    emit(AppModeChangeState());

  }

}