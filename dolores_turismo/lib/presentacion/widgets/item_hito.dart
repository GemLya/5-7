import 'dart:math' as math;
import 'package:flutter/material.dart';

class ItemHitoAR extends StatefulWidget {
  final String nombre;
  final double escala;
  const ItemHitoAR({super.key, required this.nombre, required this.escala});

  @override
  State<ItemHitoAR> createState() => _ItemHitoARState();
}

class _ItemHitoARState extends State<ItemHitoAR> with SingleTickerProviderStateMixin {
  late final AnimationController _controladorRotacion = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _controladorRotacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.escala,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: Colors.black80, borderRadius: BorderRadius.circular(8)),
            child: Text(widget.nombre, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _controladorRotacion,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002)
                  ..rotateX(-0.3)
                  ..rotateY(_controladorRotacion.value * 2 * math.pi),
                alignment: Alignment.center,
                child: child,
              );
            },
            child: Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.amberAccent.withOpacity(0.8),
                boxShadow: const [BoxShadow(color: Colors.amber, blurRadius: 15)],
                borderRadius: const BorderRadius.all(Radius.elliptical(25, 30)),
              ),
              child: const Icon(Icons.notifications_active, size: 32, color: Colors.brown),
            ),
          ),
        ],
      ),
    );
  }
}