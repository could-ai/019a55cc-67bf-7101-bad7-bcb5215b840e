import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Data model for a chat message
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add a welcome message from the AI
    _messages.insert(
        0,
        ChatMessage(
            text: "Welcome to Smart AI! How can I help you today?",
            isUser: false));
  }

  // Simulates getting a response from the AI
  String _getAIResponse(String text) {
    final query = text.toLowerCase();

    // Keyword-based responses to simulate intelligence
    if (query.contains("hello") || query.contains("hi")) {
      return "Hello there! How can I assist you today?";
    } else if (query.contains("how are you")) {
      return "I'm just a set of algorithms, but I'm functioning optimally! Thanks for asking.";
    } else if (query.contains("who are you")) {
      return "I am Smart AI, a versatile AI assistant designed to provide information and perform a variety of tasks across many domains.";
    } else if (query.contains("learn") || query.contains("update")) {
      return "I am designed to learn from vast amounts of data and my knowledge base is continuously updated to provide you with accurate and current information. To achieve true self-learning, I'll need to be connected to a backend database and machine learning models.";
    } else if (query.contains("punjabi")) {
      return "ਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਜਵਾਬ ਦੇ ਸਕਦਾ ਹਾਂ। ਤੁਸੀਂ ਕੀ ਜਾਨਣਾ ਚਾਹੁੰਦੇ ਹੋ? (I can respond in Punjabi. What would you like to know?)";
    } else if (query.contains("urdu")) {
      return "میں اردو میں جواب دے سکتا ہوں۔ آپ کیا جاننا چاہیں گے؟ (I can respond in Urdu. What would you like to know?)";
    } else if (query.contains("flutter")) {
      return "Flutter is an open-source UI software development kit created by Google. It is used to develop cross-platform applications for Android, iOS, Linux, macOS, Windows, Google Fuchsia, and the web from a single codebase.";
    } else if (query.contains("best ai") || query.contains("better than") || query.contains("advanced features")) {
      return "That's an excellent question. The AI landscape is rapidly evolving with powerful tools like Google Gemini for advanced reasoning and conversation, and specialized models like Adobe Firefly for image generation. My goal is to surpass them by integrating the most advanced features, including real-time, self-updating knowledge bases, multi-language fluency, and sophisticated content generation. My development roadmap is focused on becoming the most comprehensive and accurate AI assistant available.";
    }


    // Default response for unhandled queries
    return "Thank you for your query: \"$text\". My capabilities are expanding. For a complete answer, I need to be connected to my live, auto-updating knowledge base.";
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      // Get a simulated, more intelligent AI response
      final aiResponse = _getAIResponse(text);
      _messages.insert(
          0,
          ChatMessage(
              text: aiResponse,
              isUser: false));
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("File attachment feature coming soon!")),
              );
            },
          ),
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: "Send a message...",
              ),
              maxLines: null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart AI"),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Language switching to $result coming soon!")),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem<String>(
                value: 'ur_PK',
                child: Text('Pakistani Urdu'),
              ),
              const PopupMenuItem<String>(
                value: 'pa_PK',
                child: Text('Pakistani Punjabi'),
              ),
              const PopupMenuItem<String>(
                value: 'hi_IN',
                child: Text('Indian Hindi'),
              ),
               const PopupMenuItem<String>(
                value: 'pa_IN',
                child: Text('Indian Punjabi'),
              ),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _buildMessage(_messages[index]),
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: _buildTextComposer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    final align =
        message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = message.isUser
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
    final textColor = message.isUser
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              message.text,
              style: TextStyle(color: textColor),
            ),
          ),
          Row(
            mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
               IconButton(
                icon: const Icon(Icons.copy, size: 16),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: message.text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Copied to clipboard!")),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.download, size: 16),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Download feature coming soon!")),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
