import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Http {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: 'http://192.168.0.104:8989',
    connectTimeout: 10000
  );

  static Dio dio = Dio(baseOptions);

  static request(String url, { String method = 'get', Map<String, dynamic> data, Interceptor inter}) async {
    final options = Options(method: method);

    Interceptor dInter = InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String cookie = prefs.getString('cookie');
        options.headers = {
          'Cookie': cookie
        };
        return options;
      },
      onResponse: (Response response) {},
      onError: (DioError error) {}
    );

    List<Interceptor> inters = [ dInter ];

    if (inter != null) inters.add(inter);

    dio.interceptors.addAll(inters);

    try {
      Response result = await dio.request(url, queryParameters: data, options: options, data: data);

      return result.data;
    } catch(e) {
      return Future.error(e);
    }
  }
}
