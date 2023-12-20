import 'package:gemini_integrate_app/constants.dart';
import 'package:google_gemini/google_gemini.dart';

class GeminiServices {
  static  final gemini = GoogleGemini(
    apiKey: Constants.api_key,
  );

  Future<void> askQuestion(String question)async {
    gemini.generateFromText(question);
  }


}
