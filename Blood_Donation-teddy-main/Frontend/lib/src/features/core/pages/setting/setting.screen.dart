import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Locale selectedLocale = const Locale('en', 'US');
  // Initial language selection
  // Method to update the app's language
  _updateLanguage(Locale local) {
    Get.offNamed('/home'); // Close the language selection screen
    Get.updateLocale(local); // Update the app's locale
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(
          "Setting".tr,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('ChangeLanguage'.tr,
                style: const TextStyle(fontSize: 18.0)),
            trailing: DropdownButton<Locale>(
              value: selectedLocale,
              onChanged: (Locale? newValue) {
                setState(() {
                  selectedLocale = newValue!;
                  _updateLanguage(newValue); // Call the _updateLanguage method
                });
              },
              items: const [
                DropdownMenuItem<Locale>(
                  value: Locale('en', 'US'),
                  child: Text('ENGLISH'),
                ),
                DropdownMenuItem<Locale>(
                  value: Locale('et', 'ET'),
                  child: Text('አማርኛ'),
                ),
                // DropdownMenuItem<Locale>(
                //   value: Locale('et', 'TG'),
                //   child: Text('ትግሪኛ'),
                // ),
                // DropdownMenuItem<Locale>(
                //   value: Locale('et', 'OR'),
                //   child: Text('Afaan Oromoo'),
                // ),
                // Add more locales as needed
              ],
            ),
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () {
              // Get.back(); // Replace with your screen's route name.
            },
            // Customize the button's appearance to match your app's theme
            child:
                Text('SaveChanges'.tr, style: const TextStyle(fontSize: 18.0)),
          ),
        ],
      ),
    );
  }
}
