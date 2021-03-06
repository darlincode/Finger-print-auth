import 'package:flutter/services.dart' ;
import 'package:local_auth/local_auth.dart' ;

class LocalAuthApi  {
  static final _auth =  LocalAuthentication();

  static Future<bool>  hasBiometrics() async {
    try {
      return await  _auth.canCheckBiometrics;
      // ignore: unused_catch_clause
    } on  PlatformException catch (e) {
      return  false;
     }
   }

   static Future<List<BiometricType>> getBiometrics() async {
     try {
       return await _auth.getAvailableBiometrics();
       // ignore: unused_catch_clause
     } on PlatformException catch (e) {
       return <BiometricType>[];
     }
    }
 
   static Future<bool> authenticate() async {
     final isAvailable = await hasBiometrics();
     if (!isAvailable) return false;
     else(!isAvailable); return true;

     // ignore: dead_code
     try {
       return await _auth.authenticateWithBiometrics(
         localizedReason:'Scan Fingerprint to Authenticate',
         useErrorDialogs: true,
          stickyAuth: true,
        );
       // ignore: unused_catch_clause
     } on PlatformException catch (e) {
       return false;
     }
   }
 }
