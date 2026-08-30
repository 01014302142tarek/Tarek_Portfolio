import '../data/portfolio_data.dart';

class AppConstants {
  static Map<String, dynamic> get _info =>
      PortfolioData.data['personalInfo'] ?? {};

  static String get devName => _info['name'] ?? 'Mohamed Refky';
  static String get devTitle => _info['title'] ?? 'Flutter Developer';
  static String get devDescription =>
      _info['description'] ??
      'I am a passionate Flutter developer with a strong foundation in mobile app development. I enjoy building high-quality, user-friendly applications that solve real-world problems. With experience in both frontend and backend development, I am committed to creating seamless and efficient mobile experiences.';

  static String get devImagePath =>
      _info['image'] ?? 'assets/images/my_image.jpg';
  static String get devCvPath =>
      _info['cv'] ??
      'https://drive.google.com/file/d/1o4O1oOJMVoQpqk9DghUuFOFuRJt7Oox4/view?usp=drive_link';

  // Social Links
  static String get githubUrl =>
      _info['github'] ?? 'https://github.com/MohamedRefky';
  static String get linkedinUrl =>
      _info['linkedin'] ?? 'https://www.linkedin.com/in/mohamedrefky/';
  static String get email =>
      'mailto:${_info['email'] ?? 'mohamedrifky9765@gmail.com'}';
  static String get whatsappNumber =>
      _info['whatsappNumber'] ?? '+201019964918';
  static String get whatsappUrl =>
      'https://wa.me/${whatsappNumber.replaceAll('+', '')}';
  static String get phoneCallUrl => 'tel:${_info['phone'] ?? '+201019964918'}';
}
