import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackWebPage extends StatefulWidget {
  final String url;
  const PaystackWebPage({super.key, required this.url});

  @override
  State<PaystackWebPage> createState() => _PaystackWebPageState();
}

class _PaystackWebPageState extends State<PaystackWebPage> {
  void openURL(Uri url) async {
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Can not process request.')));
    // }

    try {
      await launchUrl(url);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:
            widget.url,
            javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
