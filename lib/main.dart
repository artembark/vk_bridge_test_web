import 'package:flutter/material.dart';
import 'package:vk_bridge/vk_bridge.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';

Future<void> main() async {
  final result = await VKBridge.instance.init();

  print('VKBridge.init: $result');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
              future: VKBridge.instance.getUserInfo(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('FutureBuilder Error');
                }
                if (snapshot.hasData) {
                  return Text('Привет ' +
                      (snapshot.data as VKWebAppGetUserInfoResult).firstName);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
