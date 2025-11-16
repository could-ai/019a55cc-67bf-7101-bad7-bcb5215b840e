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
            text: "SMART AI — Ask what you need\n\nسمارٹ اے آئی — پوچھیں کیا مدد چاہیے",
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
    if (text.contains(RegExp(r'[؀-ۿ]'))) {
      return 'Urdu';
    } else if (text.contains(RegExp(r'[਀-੿]'))) {
      return 'Punjabi';
    }
    return 'English';
  }

  // Natural, intelligent, and helpful AI response system
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // Special greeting for Assalamualaikum
    if (query.contains('assalamualaikum') || query.contains('assalamu alaikum')) {
      return "Wa Alaikum Assalam. How can I help you today?";
    }

    // USER HELP SYSTEM
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities')) {
      return "I can help with a wide range of tasks! For example, I can:\n\n"
          "• Explain complex topics in any field\n"
          "• Help with your studies by creating summaries, notes, or essays\n"

          "• Brainstorm ideas for a project or business\n"
          "• Write stories, scripts, or creative content\n"
          "• Translate between languages like English, Urdu, and Punjabi\n\n"
          "Just let me know what's on your mind!";
    }

    // IDENTITY & META QUESTIONS
    if (query.contains('what is your name') || query.contains('who are you')) {
      return "I'm Smart AI, an advanced and intelligent assistant created by Sardar Muhammad Adeel Ashraf. I'm here to provide helpful and accurate information on a vast range of topics.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age')) {
      return "As an AI, I don't have an age in the human sense. I'm constantly being updated with new information to ensure my knowledge is as current as possible.";
    }

    // KNOWLEDGE BASE - Deep, natural explanations
    
    // AI
    if (query.contains('what is ai') || query.contains('what is artificial intelligence')) {
      String response = "Artificial Intelligence (AI) is a broad field of computer science focused on creating smart machines that can perform tasks that typically require human intelligence.\n\n"
          "Essentially, it's about teaching computers to learn, reason, and perceive. This technology is already a part of our daily lives in things like voice assistants (Siri, Alexa), recommendation engines on Netflix or YouTube, and even in medical diagnostics.\n\n"
          "AI can be categorized into 'narrow AI,' which is designed for a specific task, and the more theoretical 'general AI,' which would possess human-like cognitive abilities across the board. Is there a specific aspect of AI you'd like to explore further?";
      
      if (detectedLanguage == 'Urdu') {
        response = "مصنوعی ذہانت (AI) کمپیوٹر سائنس کا ایک وسیع میدان ہے جو ایسی ذہین مشینیں بنانے پر مرکوز ہے جو ایسے کام انجام دے سکیں جن کے لیے عام طور پر انسانی ذہانت کی ضرورت ہوتی ہے۔\n\n"
            "بنیادی طور پر، یہ کمپیوٹرز کو سیکھنے، استدلال کرنے اور سمجھنے کی تعلیم دینے کے بارے میں ہے۔ یہ ٹیکنالوجی پہلے ہی ہماری روزمرہ کی زندگی کا حصہ ہے، جیسے وائس اسسٹنٹس (سری، الیکسا)، نیٹ فلکس یا یوٹیوب پر سفارشی انجن، اور یہاں تک کہ طبی تشخیص میں بھی۔\n\n"
            "AI کو 'تنگ AI' میں تقسیم کیا جا سکتا ہے، جو ایک مخصوص کام کے لیے ڈیزائن کیا گیا ہے، اور زیادہ نظریاتی 'عمومی AI'، جو ہر شعبے میں انسان جیسی علمی صلاحیتوں کا مالک ہوگا۔ کیا آپ AI کے کسی خاص پہلو کے بارے میں مزید جاننا چاہیں گے؟";
      }
      return response;
    }

    // Education
    if (query.contains('what is education')) {
      String response = "Education is the process of facilitating learning and acquiring knowledge, skills, values, beliefs, and habits.\n\n"
          "It's much more than just what happens in a classroom. Education can be formal (like school or university), non-formal (like vocational training), and informal (learning from everyday life and experiences). The ultimate goal is to foster critical thinking, empower individuals, and transmit culture and knowledge from one generation to the next. It's a cornerstone of personal and societal development.";
      
      if (detectedLanguage == 'Urdu') {
        response = "تعلیم سیکھنے کے عمل کو آسان بنانے اور علم، ہنر، اقدار، عقائد اور عادات کو حاصل کرنے کا نام ہے۔\n\n"
            "یہ صرف کلاس روم میں ہونے والی چیزوں سے کہیں زیادہ ہے۔ تعلیم رسمی (جیسے اسکول یا یونیورسٹی)، غیر رسمی (جیسے پیشہ ورانہ تربیت)، اور بےضابطہ (روزمرہ کی زندگی اور تجربات سے سیکھنا) ہو سکتی ہے۔ اس کا حتمی مقصد تنقیدی سوچ کو فروغ دینا، افراد کو بااختیار بنانا، اور ثقافت اور علم کو ایک نسل سے دوسری نسل تک منتقل کرنا ہے۔ یہ ذاتی اور معاشرتی ترقی کا ایک بنیادی ستون ہے۔";
      }
      return response;
    }

    // Science (Photosynthesis)
    if (query.contains('how does photosynthesis work')) {
      String response = "Photosynthesis is the amazing process plants use to convert light energy into chemical energy, which they use as food.\n\n"
          "Here's a simple breakdown:\n"
          "1.  **Absorption:** Plants absorb sunlight using a green pigment called chlorophyll.\n"
          "2.  **Conversion:** They take in carbon dioxide from the air and water from the soil.\n"
          "3.  **Creation:** The captured light energy is used to convert the water and carbon dioxide into glucose (their food) and oxygen. The oxygen is then released back into the air, which is what we breathe!\n\n"
          "It's a fundamental process for life on Earth, as it produces most of the oxygen in our atmosphere.";
      
      if (detectedLanguage == 'Urdu') {
        response = "فوٹو سنتھیسس وہ حیرت انگیز عمل ہے جسے پودے روشنی کی توانائی کو کیمیائی توانائی میں تبدیل کرنے کے لیے استعمال کرتے ہیں، جسے وہ خوراک کے طور پر استعمال کرتے ہیں۔\n\n"
            "یہاں ایک سادہ وضاحت ہے:\n"
            "1. **جذب کرنا:** پودے کلوروفل نامی سبز رنگ کے مادے کا استعمال کرتے ہوئے سورج کی روشنی جذب کرتے ہیں۔\n"
            "2. **تبدیلی:** وہ ہوا سے کاربن ڈائی آکسائیڈ اور مٹی سے پانی لیتے ہیں۔\n"
            "3. **تخلیق:** حاصل شدہ روشنی کی توانائی کو پانی اور کاربن ڈائی آکسائیڈ کو گلوکوز (ان کی خوراک) اور آکسیجن میں تبدیل کرنے کے لیے استعمال کیا جاتا ہے۔ پھر آکسیجن واپس ہوا میں چھوڑ دی جاتی ہے، جسے ہم سانس لیتے ہیں!\n\n"
            "یہ زمین پر زندگی کے لیے ایک بنیادی عمل ہے، کیونکہ یہ ہماری فضا میں زیادہ تر آکسیجن پیدا کرتا ہے۔";
      }
      return response;
    }

    // File analysis placeholder
    if (query.contains('analyze') || query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('image')) {
      return "I can certainly help with that. Please use the attach button to upload a file, and I'll do my best to analyze its content for you.";
    }

    // Media generation
    if (query.contains('generate') && (query.contains('image') || query.contains('video') || query.contains('audio'))) {
      return "While I can't generate media files directly in this chat, I can definitely help you come up with detailed ideas, descriptions, or prompts. For example, what kind of image are you thinking of? Describe it to me, and I can create a rich, descriptive prompt for an AI image generator.";
    }

    // DEFAULT RESPONSE (Natural and helpful)
    String defaultResponse = "That's an interesting question. To give you the best possible answer, could you please provide a little more detail or rephrase it? I want to make sure I fully understand what you're asking.";
    
    if (detectedLanguage == 'Urdu') {
      defaultResponse = "یہ ایک دلچسپ سوال ہے۔ آپ کو بہترین ممکنہ جواب دینے کے لیے، کیا آپ براہ کرم تھوڑی مزید تفصیل فراہم کر سکتے ہیں یا اسے دوبارہ بیان کر سکتے ہیں؟ میں یہ یقینی بنانا چاہتا ہوں کہ میں آپ کی بات پوری طرح سمجھ گیا ہوں۔";
    }
    
    return defaultResponse;
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
                  content: Text("📎 Upload PDF, DOCX, Images for analysis"),
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
                hintText: "Ask anything...",
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(fontSize: 16),
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
                      'I am Smart AI, a highly advanced, natural, and intelligent assistant created by Sardar Muhammad Adeel Ashraf. I can provide correct, detailed, and helpful answers on any topic. My goal is to act as a complete, powerful, all-round AI assistant that gives the BEST possible answer every time.',
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
                          Icons.bolt,
                          size: 16,
                          color: textColor.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'SMART AI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  message.text,
                  style: TextStyle(color: textColor, fontSize: 16),
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
                          content: Text("✓ Copied to clipboard!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  if (!message.isUser) ...[
                    IconButton(
                      icon: const Icon(Icons.thumb_up_outlined, size: 16),
                      tooltip: 'Good response',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("👍 Thank you for your feedback!"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.thumb_down_outlined, size: 16),
                      tooltip: 'Bad response',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("👎 Thank you! Your feedback helps me improve."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
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
                  ]
                ],
              ),
            ),
        ],
      ),
    );
  }
}
