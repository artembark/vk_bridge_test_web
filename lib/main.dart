import 'package:flutter/material.dart';
import 'package:vk_bridge/vk_bridge.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';
import 'package:vk_bridge_test_web/testing_page.dart';

Future<void> main() async {
  final result = await VKBridge.instance.init();

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
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Приветы ', //+
                        //(snapshot.data as VKWebAppGetUserInfoResult)
                        //  .firstName,
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
                  )
            ),
          ),
        ),
      );
  }
}
