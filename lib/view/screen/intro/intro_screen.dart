import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../res/assets_res.dart';
import '../../../utill/app_colors.dart';
import '../../../utill/dimensions.dart';
import '../../widgets/custom_text_bold.dart';
import '../signIn/sign_in_screen.dart';
import 'package:gap/gap.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  int _currentPageIndex = 0;
  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        actions: [
          SkipButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
                itemCount: onboardingList.length,
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    playAnimation: true,
                    onboarding: onboardingList[index],
                  );
                },
              )),
          SmoothPageIndicator(
              controller: _pageController,
              count: onboardingList.length,
              effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: AppColors.kPrimary.withOpacity(0.2)),
              onDotClicked: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }),
          const SizedBox(height: 30),
          (_currentPageIndex < onboardingList.length - 1)
              ? NextButton(onTap: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          })
              : PrimaryButton(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            width: 166,
            text: 'Get Started',
          ),
           Gap(20),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );

          }, child: Text("ewfw"))
        ],

      ),
    );
  }
}


class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final bool isBorder;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.isBorder = false,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      alignment: Alignment.center,
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: isBorder ? Border.all(color: AppColors.kHint) : null),
      child: CustomTextBold(text,fontSize: fontSize?? 15,),
    );
  }
}

class OnboardingAnimations {
  static AnimationController createSlideController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static AnimationController createController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 1000),
    );
  }

  static AnimationController createFadeController(TickerProvider vsync) {
    return AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 200),
    );
  }

  static Animation<Offset> openSpotsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: const Offset(0.0, -0.05),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<Offset> digitalPermitsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.07),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<Offset> rewardsSlideAnimation(
      AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, -0.8),
      end: const Offset(0.0, -0.05),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const ElasticOutCurve(1.2),
    ));
  }

  static Animation<double> fadeAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
  }
}

class OnboardingCard extends StatefulWidget {
  final bool playAnimation;
  final Onboarding onboarding;
  const OnboardingCard(
      {required this.playAnimation, super.key, required this.onboarding});

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard>
    with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late Animation<Offset> _slideAnimation;

  Animation<Offset> get slideAnimation => _slideAnimation;
  AnimationController get slideAnimationController => _slideAnimationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.playAnimation) {
      _slideAnimationController.forward();
    } else {
      _slideAnimationController.animateTo(
        1,
        duration: const Duration(milliseconds: 0),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _slideAnimationController =
        OnboardingAnimations.createSlideController(this);
    _slideAnimation =
        OnboardingAnimations.openSpotsSlideAnimation(_slideAnimationController);
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            widget.onboarding.image,
            width: double.maxFinite,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(height: 20),
          Text(
            widget.onboarding.title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            widget.onboarding.description,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  const NextButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.paddingMediumLarge),
        decoration:
        const BoxDecoration(color: AppColors.kPrimary, shape: BoxShape.circle),
        child: const Icon(Icons.navigate_next, size: Dimensions.iconSizeLarge, color: Colors.white),
      ),
    );
  }
}

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingDefault, vertical: Dimensions.paddingExtraSmall),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadiusXLarge),
          color: AppColors.kAccent4,
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
              fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class Onboarding {
  String image;
  String title;
  String description;

  Onboarding(
      {required this.description, required this.image, required this.title});
}

List<Onboarding> onboardingList = [
  Onboarding(
    description: 'Learn English easily with interactive \n lessons and real-life conversations.',
    image: AssetsRes.ONBOARDING_1,
    title: 'Start Speaking Confidently',
  ),
  Onboarding(
    description: 'Build your vocabulary with fun \n games and daily practice exercises.',
    image: AssetsRes.ONBOARDING_2,
    title: 'Grow Your Vocabulary',
  ),
  Onboarding(
    description: 'Track your progress and reach \n your language goals faster.',
    image: AssetsRes.ONBOARDING_3,
    title: 'Achieve Your Goals',
  ),
];

