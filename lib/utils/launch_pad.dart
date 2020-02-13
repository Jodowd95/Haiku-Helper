
import 'package:url_launcher/url_launcher.dart';

//Launch Haiku
launchHaikuURL() async{
  const url = 'https://en.wikipedia.org/wiki/Haiku';
  if (await canLaunch(url)){
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}