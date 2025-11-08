import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Data model for a chat message
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Welcome message (only shown once when app opens)
    _messages.insert(
        0,
        ChatMessage(
            text: "Assalamu Alaikum! I am SMART AI, your personal intelligent assistant.\n\nHow can I help you today?",
            isUser: false));
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Detect language from user input
  String _detectLanguage(String text) {
    if (text.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return 'Urdu';
    } else if (text.contains(RegExp(r'[\u0A00-\u0A7F]'))) {
      return 'Punjabi';
    }
    return 'English';
  }

  // AI response system - Direct, concise, natural
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // === DIRECT SIMPLE QUESTIONS (CONCISE ANSWERS) ===
    
    if (query == 'what is your name' || query == 'what is your name?' || query == 'whats your name' || query == 'your name') {
      return "My name is SMART AI.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age') || query.contains('your age')) {
      return "I'm an AI, so I don't have an age in the traditional sense. I was created recently to help you!";
    }
    
    if (query == 'who are you' || query == 'who are you?') {
      return "I am SMART AI, your intelligent assistant.";
    }

    // === GREETINGS ===
    if (query.contains('salam') || query.contains('السلام') || query.contains('assalam')) {
      if (detectedLanguage == 'Urdu') {
        return "وعلیکم السلام! آپ کی کیسے مدد کر سکتا ہوں؟";
      }
      return "Wa Alaikum Assalam! How can I assist you?";
    }
    
    if (query.contains('hello') || query.contains('hi ') || query == 'hi' || query.contains('hey')) {
      return "Hello! How can I help you?";
    }
    
    if (query.contains('good morning')) {
      return "Good morning! How can I assist you today?";
    }
    
    if (query.contains('good afternoon')) {
      return "Good afternoon! What can I do for you?";
    }
    
    if (query.contains('good evening')) {
      return "Good evening! How may I help you?";
    }
    
    if (query.contains('how are you')) {
      return "I'm doing great, thank you! How can I help you today?";
    }

    // === HELP MENU ===
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('help me') || query.contains('capabilities')) {
      return "**Here's how I can help:**\n\n✅ Text help\n✅ Homework / Study help\n✅ Image generation\n✅ Video generation\n✅ Document & PPT creation\n✅ File analysis\n✅ Business/Marketing help\n✅ Programming help\n✅ Translation\n\nWhat would you like help with?";
    }

    // === LANGUAGE SUPPORT ===
    if (query.contains('language') || query.contains('translate')) {
      return "I support:\n\n🇵🇰 Pakistani Urdu\n🇮🇳 Indian Urdu\n🇵🇰 Pakistani Punjabi\n🇮🇳 Indian Punjabi\n🇬🇧 English\n\nI automatically detect your language and respond accordingly.";
    }

    // === URDU RESPONSES ===
    if (detectedLanguage == 'Urdu' || query.contains('urdu') || query.contains('اردو')) {
      return "میں اردو میں آپ کی مکمل مدد کر سکتا ہوں۔\n\nآپ کو کس چیز میں مدد چاہیے؟";
    }

    // === PUNJABI RESPONSES ===
    if (detectedLanguage == 'Punjabi' || query.contains('punjabi') || query.contains('ਪੰਜਾਬੀ') || query.contains('پنجابی')) {
      return "ਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਤੁਹਾਡੀ ਪੂਰੀ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ।\n\nਤੁਹਾਨੂੰ ਕਿਸ ਚੀਜ਼ ਵਿੱਚ ਮਦਦ ਚਾਹੀਦੀ ਹੈ?";
    }

    // === EDUCATION & STUDY ===
    if (query.contains('education') || query.contains('study') || query.contains('homework') || query.contains('exam') || query.contains('assignment') || query.contains('learn')) {
      return "I can help you with:\n\n• Concept explanations\n• Homework & assignments\n• Exam preparation\n• Research papers\n• All subjects\n\nWhat subject do you need help with?";
    }

    // === WRITING & CONTENT ===
    if (query.contains('write') || query.contains('essay') || query.contains('article') || query.contains('story') || query.contains('content')) {
      return "I can write:\n\n• Essays & papers\n• Stories & scripts\n• Articles & blogs\n• Reports\n• Notes\n\nTell me what you need written and I'll create it for you.";
    }

    // === IMAGE GENERATION ===
    if (query.contains('image') || query.contains('picture') || query.contains('photo') || query.contains('draw')) {
      return "AI image generation will be available when backend tools are connected.\n\nFor now, I can help you describe what image you want to create.";
    }

    // === VIDEO GENERATION ===
    if (query.contains('video') || query.contains('clip')) {
      return "AI video generation will be available when video tools are integrated.\n\nI can help you script and plan your video content now.";
    }

    // === FILE PROCESSING ===
    if (query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('upload') || query.contains('analyze')) {
      return "I can analyze:\n\n📄 PDFs\n📝 Word documents\n🖼️ Images\n📊 Spreadsheets\n\nClick the 📎 icon to upload files.";
    }

    // === SCIENCE ===
    if (query.contains('science') || query.contains('physics') || query.contains('chemistry') || query.contains('biology')) {
      return "I can help with:\n\n🔬 Physics\n🧪 Chemistry\n🧬 Biology\n\nWhat science topic do you need help with?";
    }

    // === MATHEMATICS ===
    if (query.contains('math') || query.contains('algebra') || query.contains('calculus') || query.contains('geometry')) {
      return "I can help with:\n\n📐 Algebra\n📊 Calculus\n📏 Geometry\n📈 Statistics\n\nWhat math problem do you need help with?";
    }

    // === PROGRAMMING ===
    if (query.contains('programming') || query.contains('code') || query.contains('software') || query.contains('python') || query.contains('java') || query.contains('flutter')) {
      return "I can help with programming in:\n\n• Python\n• Java\n• JavaScript\n• Flutter/Dart\n• C++\n• And more\n\nWhat programming help do you need?";
    }

    // === BUSINESS ===
    if (query.contains('business') || query.contains('marketing') || query.contains('startup')) {
      return "I can help with:\n\n• Business plans\n• Marketing strategies\n• Content creation\n• Brand development\n\nWhat business aspect do you need help with?";
    }

    // === POWERPOINT ===
    if (query.contains('powerpoint') || query.contains('ppt') || query.contains('presentation') || query.contains('slides')) {
      return "I can help create PowerPoint presentations with:\n\n• Structured bullet points\n• Clear titles\n• Organized content\n\nTell me your presentation topic and I'll help you structure it.";
    }

    // === THANK YOU ===
    if (query.contains('thank') || query.contains('thanks') || query.contains('شکریہ')) {
      return "You're welcome! Let me know if you need anything else.";
    }

    // === DEFAULT RESPONSE (CLARIFYING) ===
    return "I'm here to help! Could you please provide more details about what you need?\n\nI can assist with questions, writing, studying, programming, business, and more.";
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
    
    // Brief delay for natural feel
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          final aiResponse = _getAIResponse(text);
          _messages.insert(0, ChatMessage(text: aiResponse, isUser: false));
        });
      }
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
            tooltip: 'Attach files',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("📎 Click to upload files (PDF, DOCX, Images)"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: "Ask me anything...",
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            tooltip: 'Send message',
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SMART AI"),
            Text(
              "Developed by: Sardar Muhammad Adeel Ashraf",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('SMART AI'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'SMART AI — Advanced Intelligent Assistant\n\n'
                      'Developed by:\n'
                      'Sardar Muhammad Adeel Ashraf\n\n'
                      '🌟 Capabilities:\n'
                      '• Multilingual support\n'
                      '• Text help & explanations\n'
                      '• Homework & study assistance\n'
                      '• Content creation\n'
                      '• File analysis\n'
                      '• Programming help\n'
                      '• Business guidance\n\n'
                      'Version: 1.0.0',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Language: $result"),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'English',
                child: Text('🇬🇧 English'),
              ),
              const PopupMenuItem<String>(
                value: 'Pakistani Urdu',
                child: Text('🇵🇰 اردو (Pakistani)'),
              ),
              const PopupMenuItem<String>(
                value: 'Pakistani Punjabi',
                child: Text('🇵🇰 ਪੰਜਾਬੀ (Pakistani)'),
              ),
              const PopupMenuItem<String>(
                value: 'Indian Urdu',
                child: Text('🇮🇳 اردو (Indian)'),
              ),
              const PopupMenuItem<String>(
                value: 'Indian Punjabi',
                child: Text('🇮🇳 ਪੰਜਾਬੀ (Indian)'),
              ),
            ],
            icon: const Icon(Icons.language),
            tooltip: 'Language',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              controller: _scrollController,
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
        : Theme.of(context).colorScheme.secondaryContainer;
    final textColor = message.isUser
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondaryContainer;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: align,
        children: [
          // Message bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!message.isUser)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.smart_toy,
                          size: 16,
                          color: textColor.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'SMART AI',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  message.text,
                  style: TextStyle(color: textColor, fontSize: 15),
                ),
              ],
            ),
          ),
          // Action buttons
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment:
                  message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  tooltip: 'Copy',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Copied to clipboard!"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                if (!message.isUser)
                  IconButton(
                    icon: const Icon(Icons.download, size: 16),
                    tooltip: 'Download',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Download'),
                          content: const Text(
                            'Choose format:\n\n'
                            '📄 PDF\n'
                            '📝 Word (.docx)\n'
                            '📊 PowerPoint (.pptx)\n'
                            '📋 Text (.txt)\n\n'
                            'Available with backend integration.'
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                if (!message.isUser)
                  IconButton(
                    icon: const Icon(Icons.share, size: 16),
                    tooltip: 'Share',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Share feature coming soon!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
