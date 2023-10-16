import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({super.key});

  @override
  State<NearbyPage> createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> {
  void launchUrl() async {
    const url =
        "https://www.google.co.uk/maps/place/Student's+Clinic/@11.0495425,39.7474534,417m/data=!3m1!1e3!4m6!3m5!1s0x16479dc587f46b15:0x77cf17af4bfa91a0!8m2!3d11.0499626!4d39.7477662!16s%2Fg%2F11dxhzqrzf";
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void getCurrentLocation() async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Location services are not enabled, handle accordingly
        return;
      }
    }
    // Check for location permission
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Location permission not granted, handle accordingly
        return;
      }
    }
    // Get the current location
    final currentLocation = await location.getLocation();
    print('Latitude: ${currentLocation.latitude}');
    print('Longitude: ${currentLocation.longitude}');
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    launchUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                launchUrl();
              },
              child: // ...
                  Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Colors.red), // Add red border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on, // Add a location icon
                      color: Colors.red, // Set icon color to red
                      size: 24, // You can adjust the icon size as needed
                    ),
                    const SizedBox(
                        width: 8), // Add some space between icon and text
                    Text(
                      "Nearby".tr,
                      style: const TextStyle(
                        color: Colors.red, // Set the text color to red
                        fontSize: 18, // You can adjust the font size as needed
                        fontWeight: FontWeight
                            .bold, // You can adjust the font weight as needed
                      ),
                    ),
                  ],
                ),
              ),
// ...
            ),
          ),
        ],
      ),
    );
  }
}
