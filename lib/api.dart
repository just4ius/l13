import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Піддомен на requestcatcher.com, куди надсилаються дані форм.
// Відкрий цю адресу в браузері, щоб бачити запити, що приходять.
const baseUrl = 'https://just4ius-lab13.requestcatcher.com';

final dio = Dio(BaseOptions(baseUrl: baseUrl));

// Надсилає дані форми POST-запитом і показує результат у діалозі.
Future<void> sendForm(
  BuildContext context,
  String path,
  Map<String, String> data,
) async {
  String message;
  try {
    final response = await dio.post(path, data: data);
    message = 'Request sent! Status: ${response.statusCode}';
  } on DioException catch (e) {
    message = 'Error: ${e.message}';
  }

  if (!context.mounted) return;
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Message'),
      content: Text(message),
    ),
  );
}
