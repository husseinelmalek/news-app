import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/modules/news_app/search/search_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/cubit/cubit.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state)
      {},
      builder: (context, state){
        var cubit= NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:Text('News App'),
            actions: [
              IconButton(
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  } ,
                  icon: Icon(
                    Icons.search,

                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed:(){
                    AppCubit.get(context).changeMode();
                    NewsCubit.get(context).changeI();

                  } ,
                  icon: Icon(
                    NewsCubit.get(context).changeIcon ? Icons.toggle_off_outlined : Icons.toggle_off,
                    size: 40,
                    color: Colors.black87,

                  ),
                ),
              ),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeBottomNav(value);

            },
            items:cubit.bottomItem,
          ),
        );
      }

    );
  }
}
