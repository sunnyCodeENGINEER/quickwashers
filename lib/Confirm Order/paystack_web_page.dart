import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackWebPage extends StatefulWidget {
  const PaystackWebPage({super.key});

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

    // openURL(Uri.parse(
    //     'https://www.google.com/search?q=viewing+website+in+flutter+app&oq=viewing+website+in+flutter+app&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRifBdIBCTEzMzk1ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:
            'https://www.google.com/search?q=viewing+website+in+flutter+app&oq=viewing+website+in+flutter+app&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigATIHCAEQIRigATIHCAIQIRigATIHCAMQIRigATIHCAQQIRifBdIBCTEzMzk1ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8',
      ),
    );
  }
}
