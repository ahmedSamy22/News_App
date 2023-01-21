import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {  @override
  Widget build(BuildContext context) {
  var controller = TextEditingController();
   return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context, state) {

     },
     builder: (context, state) {
       return Scaffold(
         appBar: AppBar(),
         body: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: defaultFormField(
                   controller: controller,
                   keyboardTybe: TextInputType.text,
                   prefixIcon: Icons.search,
                   label: 'Search',
                   onChange: (value) {
                     NewsCubit.get(context).getSearchNews(value);
                   },
                   validator: (value)
                   {
                     if(value==null || value.isEmpty)
                     {
                       return 'Search can\'t be empty';
                     }
                     return null;
                   }
               ),
             ),
             Expanded(
                 child: articleBuilder(NewsCubit.get(context).search, context,isSearch: true),
             ),
           ],
         ),
       );
     },
   );
  }
}
