// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// Future<String> sendEmail(String name, String email, String questions) async {
//   final smtpServer = gmail('benmos16@gmail.com', 'mosboy24');

//   final message = Message()
//     ..from = Address('benmos16@gmail.com', 'Moses Benjamin')
//     ..recipients.add('mgenius303@gmail.com') // Company's email address
//     ..subject = '$name Message Submission'
//     ..text = 'Name: $name\nEmail: $email\nQuestions: $questions';

//   try {
//     final sendReport = await send(message, smtpServer);
//     return ('Message sent: ${sendReport.mail}');
//   } catch (e) {
//     print(e);
//     throw Exception('Error sending email: $e');
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> sendEmail(String name, String email, String questions) async {
  final databaseReference = FirebaseDatabase.instance.ref();
  final newMessageRef = databaseReference.child('messages').push();

  try {
    final messageData = {
      'name': name,
      'email': email,
      'questions': questions,
    };

    await newMessageRef.set(messageData);
    return "Message Sent";
  } catch (e) {
    throw Exception('Error sending message: $e');
  }
}
