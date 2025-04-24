import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'constants.dart'; // Stelle sicher, dass kCardBackgoundColor und kCardTitleTextColor definiert sind
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnoKalb Dashboard Demo',
      home: const BasicView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BasicView extends StatefulWidget {
  const BasicView({super.key});

  @override
  State<BasicView> createState() => _BasicViewState();
}

class _BasicViewState extends State<BasicView> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  final FocusNode _focusNode = FocusNode();
  int _current = 0;

  final List<Map<String, String>> images = [
    {
      'path': 'assets/images/1.loginScreen.png',
      'caption': 'Loggen Sie sich ein',
    },
    {
      'path': 'assets/images/2.FarmOverview.png',
      'caption':
          'Verschaffen Sie sich einen schnellen Überblick über alle Tiere Ihres Betriebes',
    },
    {
      'path': 'assets/images/3.FarmOverview.png',
      'caption':
          'Lassen Sie sich alle Informationen eines Abschnittes als Graph darstellen',
    },
    {
      'path': 'assets/images/4.Farmoverviewscreen.png',
      'caption':
          'Schauen Sie sich alle Graphen eines Abschnittes als große Darstellung an',
    },
    {
      'path': 'assets/images/5.FarmOverview.png',
      'caption':
          'Wählen Sie den Zeitraum in dem Sie Ihren Betrieb betrachten wollen',
    },
    {
      'path': 'assets/images/6.CalfScreen.png',
      'caption': 'Schauen Sie sich jedes Tier individuell an',
    },
    {
      'path': 'assets/images/7.CalfScreen.png',
      'caption':
          'Wählen Sie welche Tränkewoche eines einzelnen Tieres Sie betrachten möchten',
    },
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        buttonCarouselController.previousPage();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        buttonCarouselController.nextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(182, 187, 198, 203),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (event) {
          _handleKey(event);
        },
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                carouselController: buttonCarouselController,
                items:
                    images
                        .map(
                          (img) => _carouselItem(img['path']!, img['caption']!),
                        )
                        .toList(),

                options: CarouselOptions(
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 15),
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() => _current = index);
                  },
                ),
              ),
            ),
            Text(
              '${_current + 1} / ${images.length}',
              style: TextStyle(color: kCardTitleTextColor, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  images.asMap().entries.map((entry) {
                    return Container(
                      width: 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _current == entry.key
                                ? kCardTitleTextColor.withOpacity(0.9)
                                : kCardTitleTextColor.withOpacity(0.4),
                      ),
                    );
                  }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navButton(
                    Icons.arrow_left,
                    () => buttonCarouselController.previousPage(),
                  ),
                  _navButton(
                    Icons.arrow_right,
                    () => buttonCarouselController.nextPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _carouselItem(String path, String caption) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(path, fit: BoxFit.cover),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kCardBackgoundColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _navButton(IconData icon, VoidCallback onPressed) => IconButton(
    onPressed: onPressed,
    icon: Icon(icon, size: 60, color: kCardTitleTextColor),
  );
}
