import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedBottomBarIndex = 0;
  bool _isMapLoading = false;
  late List<Widget> pages;
  late List<BarItem> barItems;
  late Future<bool> future;

  Future<bool> _loadViews() async {
    setState(() {
      _isMapLoading = true;
    });
    return _isMapLoading;
  }

  @override
  void initState() {
    userController.initUser();
    pageController = PageController(initialPage: selectedBottomBarIndex);
    future = _loadViews();
    pages = const <Widget>[
      HomeScreen(),
      ReportScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];
    barItems = <BarItem>[
      BarItem(
        icon: Icons.store_mall_directory_outlined,
        iconSize: 24,
        text: "Home",
        textSize: 18,
        color: const Color(0xFF4B6700),
      ),
      BarItem(
        icon: LineAwesomeIcons.balance_scale,
        iconSize: 24,
        text: "Report",
        textSize: 18,
        color: const Color(0xFF5A6400),
      ),
      BarItem(
        icon: LineAwesomeIcons.user_shield,
        iconSize: 24,
        text: "Profile",
        textSize: 18,
        color: const Color(0xFF695F00),
      ),
      BarItem(
        icon: LineAwesomeIcons.cog,
        iconSize: 24,
        text: "Settings",
        textSize: 18,
        color: const Color(0xFF5A6400),
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  String getAppBarTitle() {
    if (selectedBottomBarIndex == 0) {
      return StringResource.homeText;
    }
    if (selectedBottomBarIndex == 1) {
      return StringResource.reportText;
    }
    if (selectedBottomBarIndex == 2) {
      return StringResource.profileText;
    }
    if (selectedBottomBarIndex == 3) {
      return StringResource.settingsText;
    }
    return StringResource.appName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            LineAwesomeIcons.bars,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: AutoSizeText(
          getAppBarTitle().toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 18.0.sp,
            color: Theme.of(context).colorScheme.onPrimary,
            letterSpacing: 1.5,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              NavigationService.navigateTo(
                navigationMethod: NavigationMethod.push,
                page: NotificationScreen.id,
                isNamed: true,
              );
            },
            icon: Icon(
              LineAwesomeIcons.bell,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                children: <Widget>[
                  Container(),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      LineAwesomeIcons.home,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      StringResource.homeText.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      NavigationService.goBack();
                    },
                  ),
                  Expanded(child: Container()),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: CustomButton(
                      title: "GET IN TOUCH",
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        showCustomFlushBar(
                          context: context,
                          message: "Get in touch with us",
                          icon: LineAwesomeIcons.phone,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                        );
                      },
                    ),
                  ),
                  Gap(20.0.h),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: future,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: 4,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  // hide all keyboard when page changes
                  FocusScope.of(context).unfocus();
                  selectedBottomBarIndex = index;
                  setState(() {
                    selectedBottomBarIndex = index;
                  });
                },
                controller: pageController,
                itemBuilder: (BuildContext context, int index) => pages[index],
              );
            }
            return const SafeArea(child: LoadingScreen());
          },
        ),
      ),
      bottomNavigationBar: AnimatedBottomBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        onItemTap: (int index) {
          // hide all keyboard when page changes
          FocusScope.of(context).unfocus();
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
          );
        },
        barItems: barItems,
        currBarItem: selectedBottomBarIndex,
        animationDuration: const Duration(milliseconds: 150),
        elevation: 25,
      ),
    );
  }
}
