import 'package:flutter/material.dart';
void main() {
  runApp(ResetPasswordPage());
}
class ResetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'NIP'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email Pemulihan'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement password reset functionality
                },
                child: Text('PROSES'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}