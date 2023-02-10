import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/PostModel.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<PostModel> ApiList = [];

Future<List<PostModel>> GetApi() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(response.body.toString());

  if(response.statusCode == 200){
    for(Map i in data){
      ApiList.add(PostModel.fromJson(i));
    }
     return ApiList;
  }else{
    return ApiList;

  }
  
  
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api with no model name'),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future:  GetApi(),
                builder: (context,snapshot){
                 if(!snapshot.hasData){
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }else{
                return   ListView.builder(
                       itemCount: ApiList.length,
                       itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(ApiList[index].userId.toString()),
                                Text(ApiList[index].id.toString()),
                                Text(ApiList[index].title.toString()),
                                Text(ApiList[index].body.toString()),
                              ],
                            ),
                          );

                   });



                 }


            }),
          )
        ],
      ),



    );
  }
}
