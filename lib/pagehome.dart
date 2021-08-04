import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'main.dart';
class hihome extends StatefulWidget {

  @override
  _hihomeState createState() => _hihomeState();
}

class _hihomeState extends State<hihome> {
  late CameraImage imgcam;
  late CameraController cameraController;
  bool isWorking = false;
  String res="";

  initcamera()
  {
    cameraController = CameraController(camera[0],ResolutionPreset.medium);
    cameraController.initialize().then((value)
    {
      if(!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
          if(!isWorking)
            {
              isWorking = true,
              imgcam = imageFromStream,
              runModel(),
            }


        });
      });
    });
  }

  loadModel() async
  {
    await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
    );
  }

  runModel() async{
    if(imgcam != null) {
      var recognisation= await Tflite.runModelOnFrame(
          bytesList: imgcam.planes.map((plane)
          {
            return  plane.bytes;
          }).toList(),
        imageHeight: imgcam.height,
        imageWidth: imgcam.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
          numResults: 1,
        threshold: 0.1,
          asynch: true,
      );
      res="";
      recognisation?.forEach((response) {
        res += response["label"] +"\n";
      });
      setState(() {
        res;
      });

      isWorking=false;
    }

  }

  @override
  void initState(){
    super.initState();
    initcamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Text(
                    res,
                    style: TextStyle(
                      backgroundColor: Colors.black54,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),
            ),
            body: Column(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  height: size.height-100,
                    width: size.width,
                  child: Container(
                    height: size.height-100,
                    child: (!cameraController.value.isInitialized)
                        ? Container()
                        :AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: (CameraPreview(cameraController)),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
