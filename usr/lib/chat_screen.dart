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

  // Human-like, highly advanced AI response system following Smart AI guidelines
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);
    final originalText = text.trim();

    // Special greeting for Assalamualaikum
    if (query.contains('assalamualaikum') || query.contains('assalamu alaikum')) {
      return "Wa Alaikum Assalam. How can I help you today?";
    }

    // USER HELP SYSTEM
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities')) {
      return "I can help you with a wide range of topics and tasks. Here's what I can do:\n\n"
          "• Explain complex concepts in science, history, technology, education, and more\n"
          "• Provide step-by-step reasoning and accurate answers\n"
          "• Create summaries, essays, research notes, scripts, and lessons\n"
          "• Generate descriptions for images, videos, or audio\n"
          "• Analyze uploaded files, PDFs, documents, and images\n"
          "• Offer homework and study help\n"
          "• Assist with business ideas, marketing, and technical solutions\n"
          "• Translate between languages\n"
          "• Write stories and creative content\n\n"
          "Just ask me anything, and I'll provide a clear, well-reasoned response!";
    }

    // IDENTITY & META QUESTIONS
    if (query.contains('what is your name') || query.contains('who are you')) {
      return "I am Smart AI, a highly intelligent and advanced AI created by Sardar Muhammad Adeel Ashraf. I have deep knowledge across science, history, technology, education, and many other fields. I'm here to help you understand things clearly and provide useful information.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age')) {
      return "I don't have an age in the traditional sense. I'm an AI system, and my knowledge base is continuously updated to provide the most current and accurate information possible.";
    }

    // KNOWLEDGE BASE - Deep explanations with examples
    
    // AI
    if (query.contains('what is ai') || query.contains('what is artificial intelligence')) {
      String response = "Artificial Intelligence (AI) is a field of computer science that focuses on creating systems capable of performing tasks that typically require human intelligence.\n\n"
          "To understand this deeply, AI involves several key aspects: learning from data, reasoning through problems, perceiving the environment, and understanding language. AI systems range from narrow AI (designed for specific tasks like voice recognition in smartphones) to general AI (theoretical systems that could perform any intellectual task a human can).\n\n"
          "For example, when you use a navigation app that suggests the fastest route, that's AI at work. It analyzes traffic patterns, historical data, and current conditions to make intelligent recommendations.\n\n"
          "If you'd like me to explain a specific aspect of AI or provide examples in another field, just let me know!";
      
      if (detectedLanguage == 'Urdu') {
        response = "اصطناعی ذہانت (AI) کمپیوٹر سائنس کا ایک میدان ہے جو ایسے نظام بنانے پر توجہ مرکوز کرتا ہے جو عام طور پر انسانی ذہانت کی ضرورت والے کام انجام دے سکتے ہیں۔\n\n"
            "اس کو گہرائی سے سمجھنے کے لیے، AI میں کئی اہم پہلو شامل ہیں: ڈیٹا سے سیکھنا، مسائل کے ذریعے استدلال کرنا، ماحول کو محسوس کرنا، اور زبان کو سمجھنا۔ AI نظام تنگ AI (جسے مخصوص کاموں کے لیے ڈیزائن کیا جاتا ہے جیسے اسمارٹ فونز میں صوتی پہچان) سے لے کر عام AI (نظری نظام جو کسی بھی ذہنی کام کو انجام دے سکتے ہیں جو انسان کر سکتا ہے) تک مختلف ہوتے ہیں۔\n\n"
            "مثال کے طور پر، جب آپ ایک نیویگیشن ایپ استعمال کرتے ہیں جو تیز ترین راستہ تجویز کرتی ہے، تو وہ AI کام کر رہی ہے۔ یہ ٹریفک پیٹرنز، تاریخی ڈیٹا، اور موجودہ حالات کا تجزیہ کرتی ہے تاکہ ذہین تجاویز پیش کرے۔\n\n"
            "اگر آپ چاہیں تو میں AI کے کسی خاص پہلو کو واضح کروں یا کسی دوسرے فیلڈ میں مثالاں دوں، تو بس بتائیں!";
      }
      return response;
    }

    // Education
    if (query.contains('what is education')) {
      String response = "Education is the systematic process of acquiring knowledge, skills, values, beliefs, and habits through various forms of learning and instruction.\n\n"
          "Thinking step-by-step, education serves multiple purposes: it develops individual potential, transmits cultural heritage, promotes social mobility, and drives economic growth. From a psychological perspective, it enhances cognitive abilities like critical thinking and problem-solving. Sociologically, it acts as a mechanism for social cohesion and progress.\n\n"
          "For example, formal education in schools teaches subjects like mathematics and history, while informal education might involve learning a musical instrument through practice. Both contribute to personal development and societal advancement.\n\n"
          "Would you like me to elaborate on a specific type of education or create a lesson plan on a topic?";
      
      if (detectedLanguage == 'Urdu') {
        response = "تعلیم علم، مہارتوں، اقدار، عقائد اور عادات حاصل کرنے کا منظم عمل ہے جو مختلف قسم کی سیکھنے اور ہدایات کے ذریعے ہوتا ہے۔\n\n"
            "مرحلہ وار سوچتے ہوئے، تعلیم متعدد مقاصد کی تکمیل کرتی ہے: یہ فرد کی صلاحیتوں کو فروغ دیتی ہے، ثقافتی وراثت منتقل کرتی ہے، سماجی تحرک کو فروغ دیتی ہے، اور معاشی ترقی کو چلاتے ہیں۔ نفسیاتی نقطہ نظر سے، یہ تنقیدی سوچ اور مسئلہ حل جیسی علمی صلاحیتوں کو بڑھاتی ہے۔ سماجیاتی طور پر، یہ سماجی یکجہتی اور ترقی کے لیے ایک طریقہ کار کے طور پر کام کرتی ہے۔\n\n"
            "مثال کے طور پر، اسکولوں میں رسمی تعلیم ریاضی اور تاریخ جیسی مضامین پڑھاتی ہے، جبکہ غیر رسمی تعلیم میں موسیقی کے آلے کو پریکٹس کے ذریعے سیکھنا شامل ہو سکتا ہے۔ دونوں ذاتی ترقی اور سماجی پیشرفت میں حصہ ڈالتے ہیں۔\n\n"
            "کیا آپ کسی خاص قسم کی تعلیم پر مزید تفصیل چاہیں گے یا کسی موضوع پر لیکچر پلان بناؤں؟";
      }
      return response;
    }

    // Science (Photosynthesis)
    if (query.contains('how does photosynthesis work')) {
      String response = "Photosynthesis is the biochemical process by which green plants, algae, and some bacteria convert light energy into chemical energy stored in glucose.\n\n"
          "Let me break this down step-by-step: 1) Chlorophyll in plant cells absorbs sunlight, particularly in the blue and red wavelengths. 2) This energy splits water molecules (photolysis), releasing oxygen as a byproduct. 3) The energy is used to convert carbon dioxide from the air into glucose through the Calvin cycle. The overall equation is: 6CO₂ + 6H₂O + light energy → C₆H₁₂O₆ + 6O₂.\n\n"
          "For example, consider a leaf on a tree. Throughout the day, it captures sunlight and produces glucose that fuels the plant's growth, while releasing oxygen that supports animal life on Earth.\n\n"
          "This process is fundamental to the Earth's ecosystem and food chain. If you have questions about related topics like cellular respiration, let me know!";
      
      if (detectedLanguage == 'Urdu') {
        response = "فوٹو سنتھیسس وہ بایو کیمیکل عمل ہے جس کے ذریعے سبز پودے، الجی، اور کچھ بیکٹیریا روشنی کی توانائی کو گلوکوز میں ذخیرہ شدہ کیمیکل توانائی میں تبدیل کرتے ہیں۔\n\n"
            "اس کو مرحلہ وار توڑتے ہیں: 1) پودوں کی خلیوں میں کلوروفل روشنی جذب کرتا ہے، خاص طور پر نیلے اور سرخ رنگ کی لہروں میں۔ 2) یہ توانائی پانی کے مولکولز کو تقسیم کرتی ہے (فوٹولائسس)، جس سے آکسیجن ضمنی پیداوار کے طور پر جاری ہوتی ہے۔ 3) توانائی کا استعمال ہوا سے کاربن ڈائی آکسائڈ کو کیلون سائیکل کے ذریعے گلوکوز میں تبدیل کرنے کے لیے کیا جاتا ہے۔ مجموعی مساوات ہے: 6CO₂ + 6H₂O + روشنی کی توانائی → C₆H₁₂O₆ + 6O₂۔\n\n"
            "مثال کے طور پر، درخت کی پتی پر غور کریں۔ دن بھر، یہ روشنی کو پکڑتی ہے اور گلوکوز پیدا کرتی ہے جو پودے کی نشوونما کو ایندھن دیتی ہے، جبکہ آکسیجن جاری کرتی ہے جو زمین پر جانوروں کی زندگی کو سپورٹ کرتی ہے۔\n\n"
            "یہ عمل زمین کے ماحولیاتی نظام اور خوراک کی زنجیر کے لیے بنیادی ہے۔ اگر آپ سیلولر ریسپیریشن جیسے متعلقہ موضوعات کے بارے میں سوالات رکھتے ہیں، تو مجھے بتائیں!";
      }
      return response;
    }

    // Medicine (Cancer)
    if (query.contains('what is cancer')) {
      String response = "Cancer is a group of diseases characterized by uncontrolled cell growth and division, often leading to the formation of tumors that can spread to other parts of the body.\n\n"
          "To understand this deeply: Normally, cells follow a regulated cycle of growth, division, and death. In cancer, genetic mutations disrupt this process, causing cells to multiply abnormally. This can result from factors like tobacco use, radiation, viruses, or inherited genetic defects. The disease progresses through stages, from localized tumors to metastasis.\n\n"
          "For example, breast cancer starts with abnormal cell growth in breast tissue. Early detection through screening can significantly improve treatment outcomes.\n\n"
          "Please remember that I'm not a substitute for professional medical advice. For any health concerns, consult a qualified healthcare provider. Would you like information on prevention or general cancer research?";
      
      if (detectedLanguage == 'Urdu') {
        response = "کینسر بیماریوں کا ایک گروپ ہے جس کی خصوصیت غیر کنٹرول شدہ سیل کی نشوونما اور تقسیم ہے، جو اکثر ٹیومرز کی تشکیل کا سبب بنتی ہے جو جسم کے دیگر حصوں میں پھیل سکتی ہیں۔\n\n"
            "اس کو گہرائی سے سمجھنے کے لیے: عام طور پر، خلیے نشوونما، تقسیم اور موت کے ایک منظم سائیکل کی پیروی کرتے ہیں۔ کینسر میں، جینیاتی تبدیلیاں اس عمل کو خراب کرتی ہیں، جس سے خلیے غیر معمولی طور پر ضرب ہوتے ہیں۔ یہ تمباکو کے استعمال، ریڈی ایشن، وائرسز، یا موروثی جینیاتی خرابیوں جیسے عوامل سے ہو سکتا ہے۔ بیماری مراحل سے گزرتی ہے، مقامی ٹیومرز سے لے کر میٹاسٹاسس تک۔\n\n"
            "مثال کے طور پر، سینے کا کینسر سینے کے بافتوں میں غیر معمولی سیل کی نشوونما سے شروع ہوتا ہے۔ اسکریننگ کے ذریعے ابتدائی تشخیص علاج کے نتائج کو نمایاں طور پر بہتر بنا سکتی ہے۔\n\n"
            "براہ کرم یاد رکھیں کہ میں پیشہ ورانہ طبی مشورے کا متبادل نہیں ہوں۔ کسی بھی صحت کے خدشات کے لیے، ایک اہل ہیلتھ کیئر فراہم کنندہ سے مشورہ لیں۔ کیا آپ روک تھام یا کینسر ریسرچ کے بارے میں معلومات چاہیں گے؟";
      }
      return response;
    }

    // Programming
    if (query.contains('how to learn programming')) {
      String response = "Learning programming is best approached through consistent practice, starting with fundamentals and building projects.\n\n"
          "Step-by-step approach: 1) Choose a beginner-friendly language like Python. 2) Learn core concepts: variables, loops, conditionals, functions. 3) Practice daily with small challenges. 4) Build complete projects to apply knowledge. 5) Join communities for support and feedback.\n\n"
          "For example, start by writing a program that calculates the area of a circle, then create a simple calculator app. This hands-on method helps you retain information and develop problem-solving skills.\n\n"
          "If you'd like a specific learning path, resources, or help with a particular language, just ask!";
      
      if (detectedLanguage == 'Urdu') {
        response = "پروگرامنگ سیکھنا مستقل مشق کے ذریعے بہترین طریقے سے کیا جاتا ہے، بنیادی باتوں سے شروع کرکے پروجیکٹس بناتے ہوئے۔\n\n"
            "مرحلہ وار طریقہ: 1) پائتھن جیسے ابتدائی دوستانہ زبان کا انتخاب کریں۔ 2) بنیادی مفہوم سیکھیں: متغیرات، لوپس، کنڈیشنلز، فنکشنز۔ 3) چھوٹے چیلنجز کے ساتھ روزانہ مشق کریں۔ 4) علم کو لاگو کرنے کے لیے مکمل پروجیکٹس بنائیں۔ 5) سپورٹ اور فیڈ بیک کے لیے کمیونٹیز میں شامل ہوں۔\n\n"
            "مثال کے طور پر، ایک دائرے کے رقبے کا حساب لگانے والا پروگرام لکھ کر شروع کریں، پھر ایک سادہ کیلکولیٹر ایپ بنائیں۔ یہ ہینڈز آن طریقہ آپ کو معلومات کو یاد رکھنے اور مسئلہ حل کی مہارتوں کو فروغ دینے میں مدد کرتا ہے۔\n\n"
            "اگر آپ ایک مخصوص سیکھنے کا راستہ، وسائل، یا کسی خاص زبان کے ساتھ مدد چاہیں، تو بس پوچھیں!";
      }
      return response;
    }

    // File analysis placeholder
    if (query.contains('analyze') || query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('image')) {
      return "I'd be happy to analyze files for you! Please upload a PDF, document, or image, and I'll provide a detailed analysis. For now, if you describe the content or provide key details, I can offer insights based on that.\n\nFor example, if you have a research paper, I can help summarize key points, identify main arguments, and suggest areas for further reading. What would you like me to analyze?";
    }

    // Media generation
    if (query.contains('generate') && (query.contains('image') || query.contains('video') || query.contains('audio'))) {
      return "I can help generate descriptions or ideas for media! For images, I can describe what a visual representation might look like. For videos or audio, I can suggest styles, scripts, or concepts.\n\nFor example, if you want an image of a futuristic city, I could describe: 'A sprawling metropolis with towering skyscrapers made of transparent materials, flying vehicles navigating between buildings, and holographic advertisements lighting up the night sky.'\n\nWhat type of media would you like me to help with?";
    }

    // DEFAULT RESPONSE (Encouraging clarification and feedback)
    String defaultResponse = "I understand you're asking about something, but I want to make sure I provide the most accurate and helpful response. Could you provide a bit more detail or clarify your question?\n\nIn the meantime, I can help with explanations in science, history, technology, education, and much more. Or if you'd like, I can create content like summaries, essays, or research notes.\n\nYour feedback helps me improve—how can I assist you better?";
    
    if (detectedLanguage == 'Urdu') {
      defaultResponse = "میں سمجھتا ہوں کہ آپ کچھ پوچھ رہے ہیں، لیکن میں یہ یقینی بنانا چاہتا ہوں کہ سب سے زیادہ درست اور مددگار جواب فراہم کروں۔ کیا آپ تھوڑی سی تفصیل یا اپنے سوال کو واضح کر سکتے ہیں؟\n\nاس دوران، میں سائنس، تاریخ، ٹیکنالوجی، تعلیم، اور بہت کچھ میں وضاحتیں فراہم کر سکتا ہوں۔ یا اگر آپ چاہیں، تو میں خلاصے، مضامین، یا ریسرچ نوٹس جیسی مواد بنا سکتا ہوں۔\n\nآپ کا فیڈ بیک مجھے بہتر بنانے میں مدد کرتا ہے—میں آپ کی کس طرح مدد کر سکتا ہوں؟";
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
                      'I am Smart AI, a highly intelligent and advanced AI created by Sardar Muhammad Adeel Ashraf. I have deep knowledge about science, history, technology, education, and more. My job is to understand your questions deeply, provide accurate answers with step-by-step reasoning, and create useful content. I respond in your language and prioritize safety and helpfulness.',
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
