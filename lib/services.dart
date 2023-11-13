import "package:http/http.dart" as http;
import "dart:convert";

class OpenAIServices {
  final List<Map<String, String>> messages = []; // creating a list of maps to store messages. 

  static const String apiKey =
      'your-api-key-here';

  Future<String> isAskingImg(prompt) async {
    try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": {
              "role": "user",
              "content":
                  "Does this user asking for an image or not ? Simply answer with yes or no.",
            }
          }));
      print(response.body);
      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content']; //store what gpt turns to us.
        content = content.trim().toLowerCase().substring(0,3);
        if (content == "yes")
        {
          final response = await dallEAPI(content);
          return response;
        }
        else
        {
          final response = await chatGPTAPI(content);
          return response;
        }
      }
      else{
        return "response failed";
      }
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> chatGPTAPI(prompt) async {
      messages.add({
        "role": "user",
        "content": prompt,
      });
      try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messages,
          }));
      if (response.statusCode == 200) {
        String content = jsonDecode(response.body)['choices'][0]['message']['content']; //store what gpt turns to us.
        messages.add({ // add gpts responses to messages list.
          "role": "assistant",
          "content": content,
        });

        return content;
      }
      else{
        return "response failed";
      }
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> dallEAPI(prompt) async {
          messages.add({
        "role": "user",
        "prompt": prompt,
      });
      try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
          body: jsonEncode({
            "model": "dall-e-3",
            "prompt": messages,
            "n": 1,
          }));
      if (response.statusCode == 200) {
        String imgURL = jsonDecode(response.body)['data'][0]['url']; //store what gpt turns to us.
        messages.add({ // add gpts responses to messages list.
          "role": "assistant",
          "prompt": imgURL,
        });
        return imgURL;
      }
      else{
        return "response failed";
      }
    } catch (e) {
      return (e).toString();
    }
  }
}
