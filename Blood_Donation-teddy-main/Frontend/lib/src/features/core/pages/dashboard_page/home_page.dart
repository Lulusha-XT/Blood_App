import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/features/core/pages/blood_request/blood_requiest_page.dart';
import 'package:flutter_application_1/src/features/core/pages/chat_screen/chat_screen.dart';
import 'package:flutter_application_1/src/features/core/pages/home_page/blood_request.dart';
import 'package:flutter_application_1/src/features/core/pages/dashboard_page/widget/appbar.widget.dart';
import 'package:flutter_application_1/src/features/core/pages/dashboard_page/widget/drawer.dart';
import 'package:flutter_application_1/src/features/core/pages/donate_blood_page/donate_blood_page.dart';
import 'package:flutter_application_1/src/features/core/pages/my_donation%20_page/my_donation_page.dart';
import 'package:flutter_application_1/src/features/core/pages/my_request_page/my_request_page.dart';
import 'package:flutter_application_1/src/features/core/pages/nearby_page/nearby_page.dart';
import 'package:flutter_application_1/src/features/core/pages/setting/setting.screen.dart';
import 'package:flutter_application_1/src/features/core/pages/sponser_page/sponser_page.dart';
import 'package:flutter_application_1/src/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    const BloodPage(),
    const BloodRequestPage(),
    const DonateBloodPage(),
    const MyRequestPage(),
    const MyDonationPage(),
    const NearbyPage(),
    // ChatScreen(),
    const SponserPage(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    if (user.userId == null) {
      ref.watch(userProvider.notifier).getUser();
      return const Scaffold(
        body: Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: DashboardAppBar(user: user),
      drawer: MyDrawer(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        user: user,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
