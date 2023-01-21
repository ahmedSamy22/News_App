import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

import '../app_cubit/app_cubit.dart';

Widget defaultButton({
  required Function() function,
  Color background = Colors.blue,
  required double width,
  required String text,
}) {
  return (Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: background,
    ),
    width: width,
    child: MaterialButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      onPressed: function,
    ),
  ));
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardTybe,
  bool isPassword = false,
  required IconData prefixIcon,
  required String label,
  required String? Function(dynamic value) validator,
  Function()? onTap,
  Function(String)? onChange,
  Function()? suffixPressed,
  IconData? suffix,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardTybe,
    obscureText: isPassword,
    validator: validator,
    onTap: onTap,
    onChanged: onChange,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: label,
      border: OutlineInputBorder(),
      suffixIcon: suffix != null
          ? IconButton(
        icon: Icon(suffix),
        onPressed: suffixPressed,
      )
          : null,
    ),
  );
}

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20.0,
      end: 20.0,
      bottom: 10.0,
      top: 10.0,
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 35.0,
          child: Text(
            '${model['time']}',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

      ],
    ),
  ),
  onDismissed: (direction) {
   // AppCubit.get(context).deleteFromDatabase(model['id']);
  },
);

Widget buildArticleItem(article,context)=>InkWell(
  onTap: (){
    navigateTo(context,WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0,),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(width: 20.0,),
  
        Expanded(
  
          child: Container(
  
            height: 120.0,
  
            child: Column(
  
              mainAxisSize: MainAxisSize.min,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text('${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                SizedBox(height: 20.0,),
  
                Text('${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget listDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child:   Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context),
    separatorBuilder: (context, index) => listDivider(),
    itemCount: list.length,
  ),
  fallback: (context) =>isSearch?Container(): Center(child: CircularProgressIndicator()),

);

void navigateTo(context, wedgit)=> Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => wedgit,
  ),
);