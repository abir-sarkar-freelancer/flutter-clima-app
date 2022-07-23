import 'package:http/http.dart' as http;

class NetWorkService {
  final String uri;
  NetWorkService({
    required this.uri,
  });

  Future<String> getData() async {
    http.Response response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      return response.body;
    }

    return "failed";
  }
}
