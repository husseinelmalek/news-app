

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/modules/news_app/business/business_screen.dart';
import 'package:untitled/modules/news_app/science/science_screen.dart';
import 'package:untitled/modules/news_app/sports/sports_screen.dart';

import 'package:untitled/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) =>BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItem=[
    BottomNavigationBarItem(
  icon:Icon(
    Icons.business,
  ),
      label: 'business',
  ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon:Icon(
    //     Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];
List<Widget> screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
  //SettingsScreen(),

];
  void changeBottomNav(int index)
  {
    currentIndex=index;
    // if(index==1) {
    //   getSports();
    // }
    // if(index==2) {
    //   getScience();
    // }
    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    if(business.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'f19947eb27f24263a6ce455661f3a2b2',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        business=value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print('hussein elmalek is absorbed ${error.toString()}');
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }else {
      emit(NewsGetBusinessSuccessState());
    }

  }


  List<dynamic> sports=[];

  void getSports(){
    emit(NewsGetSportsLoadingState());

    if(sports.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'f19947eb27f24263a6ce455661f3a2b2',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print('hussein elmalek is absorbed ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }

  }


  List<dynamic> science=[];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'f19947eb27f24263a6ce455661f3a2b2',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print('hussein elmalek is absorbed ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }

  }

bool changeIcon=true;
  void changeI(){
    changeIcon=!changeIcon;
    emit(NewsChangeIState());

  }

  List<dynamic> search=[];

  void getSearch(String? value){
    emit(NewsGetSearchLoadingState());
    //search=[];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$value',
        'apiKey':'f19947eb27f24263a6ce455661f3a2b2',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search=value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print('hussein elmalek is absorbed ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });

  }

}