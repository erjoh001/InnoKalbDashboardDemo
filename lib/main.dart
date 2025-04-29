import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(2560, 1440),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            title: 'InnoKalb Dashboard Demo',
            home: const BasicView(),
            debugShowCheckedModeBanner: false,
          ),
    );
  }
}

class BasicView extends StatefulWidget {
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
      'path': 'assets/images/1.loginScreen.webp',
      'caption': 'Loggen Sie sich ein',
    },
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
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Card(
                color: kCardBackgoundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    images[_current]['caption']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kCardTitleTextColor,
                      fontSize: 40.sp,
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
                  style: TextStyle(color: kCardTitleTextColor, fontSize: 18.sp),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  return Container(
                    width: 10.w,
                    height: 10.w,
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
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
