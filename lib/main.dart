import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            title: 'InnoKalb Dashboard Demo',
            home: const BasicView(),
            debugShowCheckedModeBanner: false,
            initialRoute: Startscreen.id,
            routes: {
              BasicView.id: (context) => BasicView(),
              Startscreen.id: (context) => Startscreen(),
            },
          ),
    );
  }
}

class BasicView extends StatefulWidget {
  static String id = 'demoPictures/';
  const BasicView({super.key});

  @override
  State<BasicView> createState() => _BasicViewState();
}

class _BasicViewState extends State<BasicView> {
  final FocusNode _focusNode = FocusNode();
  int _current = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, String>> images = [
    {
      'path': 'assets/images/2.FarmOverview.webp',
      'caption':
          'Verschaffen Sie sich einen schnellen Überblick über alle Tiere Ihres Betriebes',
    },
    {
      'path': 'assets/images/3.FarmOverview.webp',
      'caption':
          'Lassen Sie sich alle Informationen eines Abschnittes als Graph darstellen',
    },
    {
      'path': 'assets/images/4.Farmoverviewscreen.webp',
      'caption':
          'Schauen Sie sich alle Graphen eines Abschnittes als große Darstellung an',
    },
    {
      'path': 'assets/images/5.FarmOverview.webp',
      'caption':
          'Wählen Sie den Zeitraum in dem Sie Ihren Betrieb betrachten wollen',
    },
    {
      'path': 'assets/images/6.CalfScreen.webp',
      'caption': 'Schauen Sie sich jedes Tier individuell an',
    },
    {
      'path': 'assets/images/7.CalfScreen.webp',
      'caption':
          'Wählen Sie welche Tränkewoche eines einzelnen Tieres Sie betrachten möchten',
    },
    {
      'path': 'assets/images/8.devices.webp',
      'caption':
          'Erfassung der Daten durch: AlmaPro + Vital Control + Digitale Kälberkarte',
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
        _carouselController.previousPage();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _carouselController.nextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(182, 187, 198, 203),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKey,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Card(
                  color: kCardBackgoundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      images[_current]['caption']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kCardTitleTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 16.h,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              images[index]['path']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 15),
                      onPageChanged:
                          (index, reason) => setState(() => _current = index),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    '${_current + 1} / ${images.length}',
                    style: TextStyle(
                      color: kCardTitleTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return Container(
                      width: 5.w,
                      height: 5.w,
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _current == index
                                ? kCardTitleTextColor.withOpacity(0.9)
                                : kCardTitleTextColor.withOpacity(0.4),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Startscreen extends StatefulWidget {
  static String id = 'startPage/';
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(182, 187, 198, 203),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 1000,
              child: Card(
                color: kCardBackgoundColor,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 5,
                          children: [
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'UrbanLogo.webp',
                            ),
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'fhLogo.webp',
                            ),
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'lkvNRWLogo.webp',
                            ),
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'lkvBWLogo.webp',
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Wrap(
                          spacing: 20,
                          children: [
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'bfel.webp',
                              radiusSize: 0.065,
                              boxSize: 0.09,
                              maxBoxSize: 110,
                            ),
                            CustomCircleAvatar(
                              color: Colors.white,
                              pictureName: 'pt.webp',
                              radiusSize: 0.065,
                              boxSize: 0.11,
                              maxBoxSize: 120,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: kCardTitleTextColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: kCardTitleTextColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, BasicView.id);
                            },
                            child: Text(
                              "Zur Bilder-Demo",
                              style: TextStyle(
                                color: kCardBackgoundColor,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.color,
    required this.pictureName,
    this.radiusSize = 0.08,
    this.boxSize = 0.12,
    this.maxBoxSize = 130,
  });

  final Color color;
  final String pictureName;
  final double radiusSize;
  final double boxSize;
  final double maxBoxSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: radiusSize.sw.clamp(0, 80),
        backgroundColor: color,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: boxSize.sw.clamp(
              0,
              maxBoxSize,
            ), // exakt oder 2 * radius - padding
            height: boxSize.sw.clamp(0, maxBoxSize),
            child: Image.asset('assets/images/$pictureName'),
          ),
        ),
      ),
    );
  }
}
