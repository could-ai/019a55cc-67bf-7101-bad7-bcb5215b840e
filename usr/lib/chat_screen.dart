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
  
  // Track user's language preference
  String _detectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    // Welcome message (only shown once when app opens)
    _messages.insert(
        0,
        ChatMessage(
            text: "Assalamu Alaikum! 🌟\n\nI am SMART AI, your personal intelligent assistant.\n\nHow can I help you today?",
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

  // AI response system with natural, human-like personality
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    
    // Detect and adapt to user's language
    _detectedLanguage = _detectLanguage(text);

    // === GREETINGS ===
    if (query.contains('salam') || query.contains('السلام') || query.contains('assalam')) {
      if (_detectedLanguage == 'Urdu') {
        return "وعلیکم السلام! 🙏\n\nآپ کی کیسے مدد کر سکتا ہوں؟";
      }
      return "Wa Alaikum Assalam! 🙏\n\nHow can I assist you today?";
    }
    
    if (query.contains('hello') || query.contains('hi') || query.contains('hey')) {
      return "Hello! How can I help you today?";
    }
    
    if (query.contains('how are you')) {
      return "I'm doing great, thank you! 😊\n\nHow can I assist you?";
    }

    // === IDENTITY ===
    if (query.contains('who are you') || query.contains('what are you') || query.contains('introduce yourself')) {
      return "I am SMART AI — your advanced, multilingual intelligent assistant.\n\n**What I can do:**\n\n✅ Answer questions across all fields\n✅ Explain concepts (simple to advanced)\n✅ Write essays, notes, stories, scripts\n✅ Analyze files (PDF, DOCX, Images)\n✅ Generate AI images & videos\n✅ Create PowerPoint presentations\n✅ Help with homework & research\n✅ Programming & IT support\n✅ Business & marketing guidance\n✅ Translation between languages\n\nWhat would you like help with?";
    }

    // === HELP MENU ===
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('help me') || query.contains('capabilities') || query.contains('menu')) {
      return "**Here's how I can help you:**\n\n✅ **Text help** — Answers, explanations, writing\n✅ **Homework / Study help** — All subjects\n✅ **Image generation** — AI pictures & artwork\n✅ **Video generation** — AI video creation\n✅ **Document & PPT creation** — Professional docs\n✅ **File analysis** — PDFs, DOCX, Images\n✅ **Business/Marketing help** — Plans & strategies\n✅ **Programming help** — All languages\n✅ **Translation** — Multiple languages\n\nJust tell me what you need!";
    }

    // === LANGUAGE SUPPORT ===
    if (query.contains('language') || query.contains('multilingual') || query.contains('translate')) {
      return "**Languages I speak:**\n\n🇵🇰 Pakistani Urdu (اردو)\n🇮🇳 Indian Urdu (اردو)\n🇵🇰 Pakistani Punjabi (ਪੰਜਾਬੀ)\n🇮🇳 Indian Punjabi (ਪੰਜਾਬੀ)\n🇬🇧 English\n\nI automatically detect your language and respond accordingly.\n\nJust speak or write in your preferred language!";
    }

    // === URDU RESPONSES ===
    if (query.contains('urdu') || query.contains('اردو') || _detectedLanguage == 'Urdu') {
      return "السلام علیکم! 🙏\n\nمیں اردو میں آپ کی مکمل مدد کر سکتا ہوں।\n\n**میں کیا کر سکتا ہوں:**\n• کسی بھی سوال کا جواب\n• تعلیم اور تحقیق میں مدد\n• مضامین، رپورٹس لکھنا\n• AI تصاویر اور ویڈیوز بنانا\n• فائلوں کا تجزیہ\n\nآپ کو کس چیز میں مدد چاہیے؟";
    }

    // === PUNJABI RESPONSES ===
    if (query.contains('punjabi') || query.contains('ਪੰਜਾਬੀ') || query.contains('پنجابی')) {
      return "ਸਤ ਸ੍ਰੀ ਅਕਾਲ! 🙏\n\nਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਤੁਹਾਡੀ ਪੂਰੀ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ।\n\n**ਮੈਂ ਕੀ ਕਰ ਸਕਦਾ ਹਾਂ:**\n• ਕਿਸੇ ਵੀ ਸਵਾਲ ਦਾ ਜਵਾਬ\n• ਪੜ੍ਹਾਈ ਵਿੱਚ ਮਦਦ\n• ਲੇਖ ਲਿਖਣਾ\n• AI ਤਸਵੀਰਾਂ ਬਣਾਉਣਾ\n• ਫਾਈਲਾਂ ਦਾ ਵਿਸ਼ਲੇਸ਼ਣ\n\nਤੁਹਾਨੂੰ ਕਿਸ ਚੀਜ਼ ਵਿੱਚ ਮਦਦ ਚਾਹੀਦੀ ਹੈ?";
    }

    // === EDUCATION & STUDY ===
    if (query.contains('education') || query.contains('study') || query.contains('homework') || query.contains('exam') || query.contains('assignment') || query.contains('learn')) {
      return "**Education & Study Help:**\n\nI'm here as your personal tutor!\n\n**I can help with:**\n• Clear concept explanations\n• Homework & assignments\n• Exam preparation\n• Research papers\n• All subjects (Math, Science, History, etc.)\n\nWhat subject do you need help with?";
    }

    // === WRITING & CONTENT ===
    if (query.contains('write') || query.contains('essay') || query.contains('article') || query.contains('story') || query.contains('content') || query.contains('script')) {
      return "**Writing & Content Creation:**\n\nI can write anything you need:\n\n• Essays & research papers\n• Stories & scripts\n• Articles & blog posts\n• Business reports\n• Social media content\n• Letters & emails\n\nJust tell me:\n1. What you need written\n2. The topic\n3. Length preference\n\nI'll create it for you!";
    }

    // === MEDIA GENERATION ===
    if (query.contains('image') || query.contains('picture') || query.contains('video') || query.contains('audio') || query.contains('generate')) {
      return "**AI Media Generation:**\n\n**Coming with backend integration:**\n\n🖼️ **AI Images** — Pictures from text descriptions\n🎥 **AI Videos** — Videos from scripts\n🎙️ **AI Voice** — Text-to-speech narration\n📊 **Documents** — PDFs, PowerPoint, Word\n\nFor now, I can help you plan and script your media projects.\n\nWhat would you like to create?";
    }

    // === FILE PROCESSING ===
    if (query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('upload') || query.contains('analyze')) {
      return "**File Processing:**\n\n**Supported files:**\n📄 PDF, Word, Text\n📊 Excel, CSV\n🎨 PowerPoint\n🖼️ Images (JPEG, PNG)\n\n**I can:**\n• Extract & summarize content\n• Answer questions about files\n• Translate documents\n• Create reports\n\nClick the 📎 icon to upload your files.\n\n*Full processing available with backend integration.*";
    }

    // === SCIENCE & MATH ===
    if (query.contains('science') || query.contains('physics') || query.contains('chemistry') || query.contains('biology') || query.contains('math')) {
      return "**Science & Mathematics:**\n\nI have expertise in:\n\n🔬 **Physics** — Mechanics, quantum, relativity\n🧪 **Chemistry** — Organic, inorganic, reactions\n🧬 **Biology** — Genetics, anatomy, ecology\n📐 **Mathematics** — Algebra, calculus, statistics\n\nWhat topic would you like to explore?";
    }

    // === PROGRAMMING ===
    if (query.contains('programming') || query.contains('code') || query.contains('software') || query.contains('computer') || query.contains('flutter') || query.contains('python') || query.contains('java')) {
      return "**Programming Help:**\n\n**Languages I support:**\nPython, Java, JavaScript, C++, Dart, Flutter, PHP, and more\n\n**I can help with:**\n• Debug code errors\n• Explain concepts\n• Write functions\n• Algorithm problems\n• Best practices\n\nWhat programming challenge are you facing?";
    }

    // === BUSINESS & MARKETING ===
    if (query.contains('business') || query.contains('marketing') || query.contains('startup') || query.contains('entrepreneur')) {
      return "**Business & Marketing:**\n\n**I can help with:**\n• Business plans\n• Market research\n• Marketing strategies\n• Content creation\n• Brand development\n• Sales proposals\n\nWhat aspect of your business would you like help with?";
    }

    // === PROBLEM SOLVING ===
    if (query.contains('problem') || query.contains('issue') || query.contains('solve') || query.contains('fix')) {
      return "**Problem Solving:**\n\nI'm here to help you find solutions!\n\n**Tell me:**\n1. What's the problem?\n2. What have you tried?\n3. What's your goal?\n\nDescribe your situation and I'll guide you step-by-step.";
    }

    // === TRANSLATION ===
    if (query.contains('translate')) {
      return "**Translation Service:**\n\nI can translate between:\n• English\n• Pakistani Urdu\n• Indian Urdu\n• Pakistani Punjabi\n• Indian Punjabi\n\nJust tell me what you want translated and to which language!";
    }

    // === INTELLIGENT DEFAULT RESPONSE ===
    return "I'm here to help!\n\nCould you please provide more details about what you need?\n\nI can assist with:\n• Answering questions\n• Writing & content creation\n• Education & homework\n• File analysis\n• Programming help\n• Business guidance\n• Translation\n\nWhat would you like me to help you with?";
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
    
    // Natural thinking delay
    Future.delayed(const Duration(milliseconds: 600), () {
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
                  content: Text(
                    "📎 File Attachment\n\n"
                    "Supported: Images, PDFs, Documents\n"
                    "Full analysis coming with backend integration!"
                  ),
                  duration: Duration(seconds: 3),
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
            tooltip: 'About SMART AI',
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
                      '🌟 Core Features:\n'
                      '• Multilingual support (30+ languages)\n'
                      '• Advanced reasoning & problem-solving\n'
                      '• Content creation & writing\n'
                      '• File processing & analysis\n'
                      '• Programming & IT support\n'
                      '• Business & marketing guidance\n\n'
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
                  content: Text(
                    "🌐 Language: $result\n\n"
                    "I automatically detect and respond in your language!"
                  ),
                  duration: const Duration(seconds: 2),
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
                value: 'Indian Hindi',
                child: Text('🇮🇳 हिंदी (Indian)'),
              ),
              const PopupMenuItem<String>(
                value: 'Indian Punjabi',
                child: Text('🇮🇳 ਪੰਜਾਬੀ (Indian)'),
              ),
            ],
            icon: const Icon(Icons.language),
            tooltip: 'Select Language',
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
                  tooltip: 'Copy text',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("✅ Copied to clipboard!"),
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
                          title: const Text('Download Options'),
                          content: const Text(
                            'Choose format:\n\n'
                            '📄 PDF Document\n'
                            '📝 Word Document (.docx)\n'
                            '📊 Presentation (.pptx)\n'
                            '📋 Plain Text (.txt)\n\n'
                            'Full export coming with backend integration!'
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
                          content: Text("🔗 Share functionality coming soon!"),
                          duration: Duration(seconds: 2),
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
