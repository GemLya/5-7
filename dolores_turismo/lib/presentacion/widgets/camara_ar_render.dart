import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CamaraArRender extends StatefulWidget {
  const CamaraArRender({super.key});

  @override
  State<CamaraArRender> createState() => _CamaraArRenderState();
}

class _CamaraArRenderState extends State<CamaraArRender> {
  CameraController? _controller;

  @override
  void initState() {
    super.initState();
    _inicializarCamara();
  }

  Future<void> _inicializarCamara() async {
    try {
      final camaras = await availableCameras();
      if (camaras.isNotEmpty) {
        _controller = CameraController(camaras.first, ResolutionPreset.medium, enableAudio: false);
        await _controller!.initialize();
        if (mounted) setState(() {});
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && _controller!.value.isInitialized) {
      return SizedBox.expand(child: CameraPreview(_controller!));
    }
    return Container(
      color: Colors.blueGrey.shade900,
      child: const Center(
        child: Icon(Icons.camera_enhance, color: Colors.white24, size: 64),
      ),
    );
  }
}