import 'package:eat_together/global/auth.controller.dart';
import 'package:eat_together/initialize/initialize_failed.exception.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppInitialize {
  Future<void> initialize() async {
    await Firebase.initializeApp();
    await Get.put(AuthController(), permanent: true).initialize();
    await _geolocatorInitialize();
    await dotenv.load();
  }

  Future<void> _geolocatorInitialize() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw InitializeFailedException(
        InitializeFailType.locationServiceDisable
      );
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw InitializeFailedException(
          InitializeFailType.locationPermissionDeny
        );
      }
    }
    
    if (permission == LocationPermission.deniedForever) { 
      throw InitializeFailedException(
          InitializeFailType.locationPermissionDenyForever
        );
    }
  }
}