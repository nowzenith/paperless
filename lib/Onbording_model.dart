class OnboardModel {
  String img;
  String text;
  String desc;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
  });
}

List<OnboardModel> screens = <OnboardModel>[
  OnboardModel(
    img: 'images/Onboard1.png',
    text: "Annual leave request",
    desc:
        "Welcome to Paperless Application. Manage your leave requests quickly and easily with our user-friendly app.",
  ),
  OnboardModel(
    img: 'images/Onboard2.png',
    text: "News",
    desc:
        "Stay informed with the latest news and updates from our agency. Get all the information you need right at your fingertips.",
  ),
  OnboardModel(
    img: 'images/Onboard3.png',
    text: "Eco-Friendly",
    desc:
        "Say goodbye to piles of paperwork! Our online application saves paper and reduces waste. Help us make a difference and join us in going green.",
  ),
  OnboardModel(
    img: 'images/Onboard4.png',
    text: "Welcome",
    desc:
        "We hope you find our app enjoyable and comfortable to use. We are committed to providing you with the best user experience possible. Thank you for choosing Paperless Application.",
  ),
];
