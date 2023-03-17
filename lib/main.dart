import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/layout/news_app/news_layout.dart';
import 'package:untitled/layout/shop_app/cubit/shop_cubit.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/layout/todo_app/todo_home_layout.dart';
import  'package:untitled/layout/todo_app/todo_home_layout.dart';

import 'package:untitled/modules/counter/counter.dart';
import 'package:untitled/modules/shop_app/on_boarding/on_boardingScreen.dart';
import 'package:untitled/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:untitled/modules/social_app/social_login/social_login_screen.dart';

import 'package:untitled/shared/bloc_observer.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'package:untitled/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();




  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();


  Widget widget;
  bool? isDark= CacheHelper.getData(key: 'isDark');


  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  final Widget startWidget ;
  MyApp({required this.isDark, required this.startWidget});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        // news app
        BlocProvider( create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience()) ,
        BlocProvider(create: (context) => AppCubit()..changeMode(fromShared: isDark,)),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context, state) {

        },
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme:darkTheme ,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
