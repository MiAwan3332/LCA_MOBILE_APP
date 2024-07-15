import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/generic_services.dart';
import '../../services/attendence_services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final AttendenceServices _attendenceServices = AttendenceServices();
  final GenericServices _genericServices = GenericServices();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      AttendenceServices().attendenceFunction(result!.code, context);
    } else if (result == null) {
      _genericServices.showCustomToast('Invalid Code', Colors.red);
    } else {
      _genericServices.showCustomToast('Error occurred', Colors.red);
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null) SizedBox() else const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 20,
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFFBA8E4F), // Change background color here
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Change border radius here
                            ),
                          ),
                          child: const Text('Pause',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ),
                      Container(
                        height: 20,
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(
                                0xFFBA8E4F), // Change background color here
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Change border radius here
                            ),
                          ),
                          child: const Text('Resume',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white)),
                        ),
                      ),
                      // Container(
                      //   height: 20,
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () {

                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Color(
                      //           0xFFBA8E4F), // Change background color here
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(
                      //             10.0), // Change border radius here
                      //       ),
                      //     ),
                      //     child: const Text('Debug',
                      //         style:
                      //             TextStyle(fontSize: 10, color: Colors.white)),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 2,
        borderLength: 50,
        borderWidth: 1,
        cutOutSize: 300, // Increase this value to enlarge the QR scanner square
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
