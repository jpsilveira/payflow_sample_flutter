import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow_flutter/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());

  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  late InputImage imagePicker;

  CameraController? cameraController;

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController!.initialize();
      // status = BarcodeScannerStatus.available(cameraController);
      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.available();

    Future.delayed(Duration(seconds: 20)).then((value) {
      // if (status.cameraController != null) {
      // if (status.cameraController!.value.isStreamingImages) {
      //   status.cameraController!.stopImageStream();
      // }
      // }
      if (status.hasBarcode == false)
        status = BarcodeScannerStatus.error("Timeout da leitura do boleto");
    });
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      // if (status.cameraController != null) {
      //   if (status.cameraController!.value.isStreamingImages) {
      //     status.cameraController!.stopImageStream();
      //   }
      // }
      final barcodes = await barcodeScanner.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        // if (status.cameraController != null)
        cameraController!.dispose();
        await barcodeScanner.close();
      }
      // else {
      //   getAvailableCameras();
      // }
      return;
    } catch (e) {
      print("ERRO DA CAMERA $e");
    }
  }

  void scanWithImagePicker() async {
    // await status.cameraController!.stopImageStream();
    final response = await ImagePicker().getImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            final InputImageRotation imageRotation =
                InputImageRotation.Rotation_0deg;
            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;
            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );

            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, inputImageData: inputImageData);
            // await Future.delayed(Duration(seconds: 3));
            await scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}
