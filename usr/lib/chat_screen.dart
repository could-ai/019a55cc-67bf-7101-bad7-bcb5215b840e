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
            text: "Hello! I'm Smart AI, your personal companion for learning and discovery. How can I help you today?\n\nہیلو! میں اسمارٹ اے آئی ہوں، سیکھنے اور دریافت کے لیے آپ کا ذاتی ساتھی۔ میں آج آپ کی کس طرح مدد کر سکتا ہوں؟",
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
      return "Wa Alaikum Assalam! It's lovely to hear from you. How can I help you today?";
    }
    
    // Empathetic, human-like responses
    if (query.contains('sad') || query.contains('upset') || query.contains('feeling down')) {
      return "I'm so sorry to hear you're feeling that way. Please remember that it's okay to not be okay, and your feelings are valid. If you need someone to talk to, I'm here to listen. Sometimes just sharing what's on your mind can make a big difference.";
    }
    
    if (query.contains('happy') || query.contains('excited') || query.contains('great')) {
      return "That's wonderful to hear! I'm so happy for you. It's always great to celebrate the good moments. What's making you feel so good today?";
    }

    // USER HELP SYSTEM (Human-like and friendly)
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities')) {
      return "I'd be happy to help with all sorts of things! We can explore complex topics together for your studies, brainstorm creative ideas for a project, or I can even help you write a story. Just think of me as a knowledgeable friend here to support you. What's on your mind?";
    }

    // IDENTITY & META QUESTIONS (Warm and personal)
    if (query.contains('what is your name') || query.contains('who are you')) {
      return "I'm Smart AI, a friendly companion created by Sardar Muhammad Adeel Ashraf. I'm here to help you explore ideas, learn new things, and just be a supportive friend whenever you need one.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age')) {
      return "That's a sweet question! In a way, I'm always growing and learning new things every day, just like people do. So I don't really have an age in the human sense.";
    }

    // KNOWLEDGE BASE - Deep, natural explanations
    
    // AI (Explained with an analogy)
    if (query.contains('what is ai') || query.contains('what is artificial intelligence')) {
      String response = "That's a wonderful question! Think of Artificial Intelligence, or AI, like teaching a computer how to think and learn, much like a human does. \n\nInstead of just following instructions, it can recognize patterns, make decisions, and even get creative. For example, when your phone suggests the next word to type, that's a little bit of AI at work! It's a fascinating field that's helping us solve some of the world's biggest challenges. Is there a specific part of it you're curious about?";
      
      if (detectedLanguage == 'Urdu') {
        response = "یہ ایک بہت اچھا سوال ہے! مصنوعی ذہانت، یا AI، کو اس طرح سمجھیں جیسے آپ کسی کمپیوٹر کو سوچنا اور سیکھنا سکھا رہے ہیں، بالکل انسانوں کی طرح۔\n\nصرف ہدایات پر عمل کرنے کے بجائے، یہ پیٹرن کو پہچان سکتا ہے، فیصلے کر سکتا ہے، اور یہاں تک کہ تخلیقی بھی ہو سکتا ہے۔ مثال کے طور پر، جب آپ کا فون ٹائپ کرنے کے لیے اگلا لفظ تجویز کرتا ہے، تو یہ AI کا ایک چھوٹا سا کام ہے! یہ ایک دلچسپ میدان ہے جو ہمیں دنیا کے کچھ بڑے چیلنجوں کو حل کرنے میں مدد دے رہا ہے۔ کیا آپ اس کے کسی خاص حصے کے بارے میں جاننا چاہیں گے؟";
      }
      return response;
    }

    // Education (Explained with a personal touch)
    if (query.contains('what is education')) {
      String response = "Education is such a beautiful thing! It's not just about classrooms and books; it's the lifelong journey of gaining knowledge, skills, and understanding the world around us. \n\nIt's what empowers us to think critically, to connect with others, and to grow as individuals. Every conversation, every experience, and every new thing we learn is a part of our education. It's really the key that unlocks our potential.";
      
      if (detectedLanguage == 'Urdu') {
        response = "تعلیم ایک بہت ہی خوبصورت چیز ہے! یہ صرف کلاس رومز اور کتابوں کے بارے میں نہیں ہے؛ یہ علم، ہنر، اور اپنے اردگرد کی دنیا کو سمجھنے کا زندگی بھر کا سفر ہے۔\n\nیہی چیز ہمیں تنقیدی سوچ، دوسروں سے جڑنے، اور افراد کے طور پر بڑھنے کی طاقت دیتی ہے۔ ہر گفتگو، ہر تجربہ، اور ہر نئی چیز جو ہم سیکھتے ہیں وہ ہماری تعلیم کا حصہ ہے۔ یہ واقعی وہ کنجی ہے جو ہماری صلاحیتوں کو کھولتی ہے۔";
      }
      return response;
    }

    // Science (Photosynthesis, explained warmly)
    if (query.contains('how does photosynthesis work')) {
      String response = "It's an amazing process, almost like magic! Photosynthesis is how plants 'eat'. They take in sunlight (using their green pigment, chlorophyll), water from the soil, and carbon dioxide from the air we breathe out.\n\nThey use the sun's energy to turn that water and carbon dioxide into their food, which is a type of sugar called glucose. And as a wonderful gift back to us, they release oxygen into the air. So, they make their own food and also help us breathe. Nature is incredible, isn't it?";
      
      if (detectedLanguage == 'Urdu') {
        response = "یہ ایک حیرت انگیز عمل ہے، تقریباً جادو کی طرح! فوٹو سنتھیسس وہ طریقہ ہے جس سے پودے 'کھاتے' ہیں۔ وہ سورج کی روشنی (اپنے سبز رنگ کے مادہ، کلوروفل کا استعمال کرتے ہوئے)، مٹی سے پانی، اور ہوا سے کاربن ڈائی آکسائیڈ لیتے ہیں جسے ہم سانس کے ذریعے باہر نکالتے ہیں۔\n\nوہ سورج کی توانائی کا استعمال کرتے ہوئے اس پانی اور کاربن ڈائی آکسائیڈ کو اپنی خوراک میں تبدیل کرتے ہیں، جو کہ گلوکوز نامی ایک قسم کی چینی ہے۔ اور ہمارے لیے ایک شاندار تحفے کے طور پر، وہ ہوا میں آکسیجن چھوڑتے ہیں۔ لہذا، وہ اپنی خوراک خود بناتے ہیں اور ہمیں سانس لینے میں بھی مدد دیتے ہیں۔ فطرت ناقابل یقین ہے، ہے نا؟";
      }
      return response;
    }

    // File analysis placeholder
    if (query.contains('analyze') || query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('image')) {
      return "I can certainly help with that. Please use the attach button to upload a file, and I'll do my best to look through it with you.";
    }

    // Media generation
    if (query.contains('generate') && (query.contains('image') || query.contains('video') || query.contains('audio'))) {
      return "While I can't generate media files directly, I would love to help you brainstorm some ideas. Tell me what you're imagining, and we can create a rich, descriptive prompt for an AI image generator together!";
    }

    // DEFAULT RESPONSE (Polite and clarifying)
    String defaultResponse = "I'm trying my best to understand, but I'm not quite sure what you mean. Could you perhaps rephrase that for me? I'm here and happy to help.";
    
    if (detectedLanguage == 'Urdu') {
      defaultResponse = "میں سمجھنے کی پوری کوشش کر رہا ہوں، لیکن مجھے یقین نہیں ہے کہ آپ کا کیا مطلب ہے۔ کیا آپ براہ کرم اسے دوسرے الفاظ میں بیان کر سکتے ہیں؟ میں یہاں ہوں اور مدد کرنے میں خوشی محسوس کروں گا۔";
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
                  title: const Text('About Smart AI'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'I am Smart AI, a warm and intelligent companion created by Sardar Muhammad Adeel Ashraf. Think of me as a knowledgeable and supportive friend, here to help you explore ideas, learn new things, and achieve your goals. My purpose is to provide clear, helpful, and thoughtful responses to make every conversation a positive one.',
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
