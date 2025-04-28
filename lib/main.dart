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
      'caption': 'Überblick über alle Tiere',
    },
    {
      'path': 'assets/images/3.FarmOverview.webp',
      'caption': 'Infos als Graph anzeigen',
    },
    {
      'path': 'assets/images/4.Farmoverviewscreen.webp',
      'caption': 'Große Darstellung der Graphen',
    },
    {
      'path': 'assets/images/5.FarmOverview.webp',
      'caption': 'Zeitraum auswählen',
    },
    {
      'path': 'assets/images/6.CalfScreen.webp',
      'caption': 'Individuelle Tieransicht',
    },
    {
      'path': 'assets/images/7.CalfScreen.webp',
      'caption': 'Tränkewoche eines Tieres wählen',
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color.fromARGB(182, 187, 198, 203),
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: _handleKey,
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
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navButton(
                    Icons.arrow_left,
                    () => _carouselController.previousPage(),
                    isWideScreen,
                  ),
                  _navButton(
                    Icons.arrow_right,
                    () => _carouselController.nextPage(),
                    isWideScreen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, VoidCallback onPressed, bool isWide) =>
      IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: isWide ? 60.sp : 36.sp,
          color: kCardTitleTextColor,
        ),
      );
}
