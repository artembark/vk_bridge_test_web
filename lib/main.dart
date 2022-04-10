import 'package:flutter/material.dart';
import 'package:vk_bridge/vk_bridge.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';
import 'package:vk_bridge_test_web/testing_page.dart';

Future<void> main() async {
  final result = await VKBridge.instance.init();

  print('VKBridge.init: $result');

  runApp(MyApp());
}

Future<String> data =
    Future.delayed(Duration(seconds: 2)).then((value) => 'Hello');

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
              //future: data,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Загружаем...');
                }
                if (snapshot.hasError) {
                  return const Text('FutureBuilder Error');
                }
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Привет ' +
                            (snapshot.data as VKWebAppGetUserInfoResult)
                                .firstName,
                        style: const TextStyle(fontSize: 40.0),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TestingPage(),
                              ),
                            );
                          },
                          child: const Text('Поиграем?'))
                    ],
                  );
                }
                return Text('Загружаем...');
              },
            ),
          ),
        ),
      ),
    );
  }
}
