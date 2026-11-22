import 'package:flutter/material.dart';

class GesturesAnimationScreen extends StatefulWidget {
  const GesturesAnimationScreen({super.key});

  @override
  State<GesturesAnimationScreen> createState() =>
      _GesturesAnimationScreenState();
}

class _GesturesAnimationScreenState extends State<GesturesAnimationScreen> {
  // Animation state
  bool _isExpanded = false;

  // Gesture status feedback
  String _gestureLog = 'Interact with the box below to test all 5 gestures!';

  void _updateLog(String message) {
    setState(() {
      _gestureLog = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestures & Animation'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '1. Interactive AnimatedContainer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                height: _isExpanded ? 180 : 100,
                decoration: BoxDecoration(
                  color: _isExpanded ? Colors.deepPurple : Colors.indigo,
                  borderRadius: BorderRadius.circular(_isExpanded ? 28 : 12),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isExpanded ? Icons.local_offer : Icons.touch_app,
                      color: Colors.white,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isExpanded
                          ? 'FLASH SALE: 20% OFF ALL ITEMS!\n(Tap to shrink)'
                          : 'Tap Me to Animate Promo Banner!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '2. Five-Gesture Detector Pad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Horizontal & Vertical Drag Area + Tap, DoubleTap, LongPress
            GestureDetector(
              onTap: () => _updateLog('Detected: onTap (Single Tap)'),
              onDoubleTap: () =>
                  _updateLog('Detected: onDoubleTap (Marked Favourite)'),
              onLongPress: () =>
                  _updateLog('Detected: onLongPress (Options Opened)'),
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  _updateLog('Detected: onHorizontalDrag (Swiped Right →)');
                } else {
                  _updateLog('Detected: onHorizontalDrag (Swiped Left ←)');
                }
              },
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  _updateLog('Detected: onVerticalDrag (Dragged Down ↓)');
                } else {
                  _updateLog('Detected: onVerticalDrag (Dragged Up ↑)');
                }
              },
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  border: Border.all(color: Colors.amber.shade700, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.gesture, size: 50, color: Colors.amber),
                    const SizedBox(height: 12),
                    const Text(
                      'Perform Tap, Double-Tap, Long-Press,\nHorizontal Swipe, or Vertical Drag here',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _gestureLog,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}