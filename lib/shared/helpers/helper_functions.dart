import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  HelperFunctions._();

  static Future<void> iLaunchUrl(String url) async {
    // convert the url to a Uri
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
    await launchUrl(uri);
  }
}
