import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/news_app/cubit/cubit.dart';
import 'package:untitled/layout/news_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController=TextEditingController();

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var list=NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  controller: searchController,
                  label: 'Search',
                  prefix: Icons.search,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);

                  },
                  type: TextInputType.text,
                  validate: (value){
                    if(value.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),

            ],
          ),

        );
      },
    );
  }
}
