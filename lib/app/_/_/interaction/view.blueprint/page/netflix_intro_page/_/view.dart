import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../main.dart';
import '../screen/view.dart';
import '_/state_child.dart';
import '_/state_mother.dart';

class NewView extends StatefulWidget {
  NewView({super.key});

  @override
  State<NewView> createState() => StateChild();
}

class NewViewState extends State<NewView> with StateMother {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.98),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Image.asset('assets/view/netflix_intro_page/logo.webp'),
        actions: [
          TextButton(
              onPressed: () {
                launchUrl(Uri.parse(
                    'https://help.netflix.com/legal/privacy?netflixsource=android&fromApp=true'));
              },
              child: Text(
                'Privacy'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
          TextButton(
              onPressed: () {},
              child: Text(
                'sign in'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
          PopupMenuButton(
              constraints: const BoxConstraints.expand(width: 230, height: 110),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(value: 1, child: Text('FAQs')),
                const PopupMenuItem(value: 2, child: Text('HELP'))
              ])
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              Colors.transparent,
              Color.fromARGB(210, 0, 0, 0),
              Colors.black
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return _buildPage(index);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 229, 9, 20),
                  minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: Text(
                  'Get started'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )).padding(horizontal: 10),
            const SizedBox(height: 20),
          ],
        ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: DotsIndicator(
            dotsCount: 4,
            position: _currentPage.round(),
            decorator: const DotsDecorator(
                size: Size.square(9.0),
                activeSize: Size(18.0, 9.0),
                activeShape: CircleBorder(),
                activeColor: Colors.white),
          ),
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ScreenView(
          imagePath: 'assets/view/netflix_intro_page/background-image.webp',
          title: 'Unlimited movies, TV shows & more.',
          subtitle: 'Watch anywhere. Cancel  anytime.',
        );
      case 1:
        return ScreenView(
          imagePath: 'assets/view/netflix_intro_page/screen_2.webp',
          title: 'Download and watch offline',
          subtitle: 'Always have something to watch offline.',
        );
      case 2:
        return ScreenView(
          imagePath: 'assets/view/netflix_intro_page/screen_3.webp',
          title: 'No annoying contracts',
          subtitle: 'Join today, cancel anytime',
        );
      case 3:
        return ScreenView(
          imagePath: 'assets/view/netflix_intro_page/screen_4.webp',
          title: 'Watch everywhere',
          subtitle: 'Stream on your phone, tablet, laptop, TV and more.',
        );
      default:
        return Container();
    }
  }

}

main() async {
  return buildApp(appHome: NewView());
}
