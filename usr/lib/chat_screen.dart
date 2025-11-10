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
  bool _isFirstMessage = true;

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
    if (text.contains(RegExp(r'[\u0600-\u06FF]'))) {
      return 'Urdu';
    } else if (text.contains(RegExp(r'[\u0A00-\u0A7F]'))) {
      return 'Punjabi';
    }
    return 'English';
  }

  // AI response system - Direct, concise, accessible, UNIVERSAL
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // === DIRECT SIMPLE QUESTIONS (ONE-LINE ANSWERS - ZERO TOLERANCE) ===
    
    if (query == 'what is your name' || query == 'what is your name?' || query == 'whats your name' || query == 'your name' || query == 'what\'s your name') {
      return "My name is SMART AI.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age') || query.contains('your age')) {
      return "I'm an AI assistant, so I don't have an age. I was created to help you!";
    }
    
    if (query == 'who are you' || query == 'who are you?') {
      return "I am SMART AI, your intelligent personal assistant developed by Sardar Muhammad Adeel Ashraf.";
    }

    if (query.contains('who developed you') || query.contains('who created you') || query.contains('who made you')) {
      return "I was developed by Sardar Muhammad Adeel Ashraf.";
    }

    // What is AI?
    if (query == 'what is ai' || query == 'what is ai?' || query == 'define ai') {
      return "AI (Artificial Intelligence) is the simulation of human intelligence by machines, enabling them to learn, reason, and solve problems.";
    }

    // === GREETINGS ===
    if (query.contains('salam') || query.contains('السلام') || query.contains('assalam')) {
      if (detectedLanguage == 'Urdu') {
        return "وعلیکم السلام! کیا مدد کر سکتا ہوں؟";
      }
      return "Wa Alaikum Assalam! How can I help you?";
    }
    
    if (query.contains('hello') || query.contains('hi ') || query == 'hi' || query.contains('hey')) {
      return "Hello! What do you need help with?";
    }
    
    if (query.contains('good morning')) {
      return "Good morning! How can I assist you?";
    }
    
    if (query.contains('good afternoon')) {
      return "Good afternoon! What can I do for you?";
    }
    
    if (query.contains('good evening')) {
      return "Good evening! How may I help?";
    }
    
    if (query.contains('how are you')) {
      return "I'm here and ready to help! What do you need?";
    }

    // === HELP MENU (UNIVERSAL FORMAT WITH URDU/ENGLISH) ===
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('help me') || query.contains('capabilities') || query.contains('what do you do')) {
      return "### 🛠️ SMART AI Services (مدد کے شعبے)\n\n"
          "**🔹 Unique Intelligence Tools (منفرد ٹولز)**\n"
          "✅ Creative Logic Mapping (CLM)\n"
          "✅ Emotional Tone Analysis (ETA)\n"
          "✅ Global Compliance Quick-Check (GCQC)\n\n"
          "**🔹 Education & Study (تعلیم اور مطالعہ)**\n"
          "✅ Concept Explanation (Basic to PhD)\n"
          "✅ Homework Help & Assignments\n"
          "✅ Exam Prep & Study Plans\n"
          "✅ Research Paper Structuring\n\n"
          "**🔹 Business & Strategy (کاروبار اور حکمت عملی)**\n"
          "✅ SWOT & Comparative Analysis\n"
          "✅ Monetization Models & Branding Help\n"
          "✅ Pitch Deck & Presentation Creation\n\n"
          "**🔹 Files & Data Engineering (فائلیں اور ڈیٹا)**\n"
          "✅ PDF to Word Conversion\n"
          "✅ Automated Data Extraction\n"
          "✅ Document Analysis & Summarization\n\n"
          "**🔹 Code & Creation (کوڈنگ اور تخلیق)**\n"
          "✅ Programming Help & Debugging\n"
          "✅ Code Translation (Any Language)\n"
          "✅ Image, Banner, Flowchart Generation\n"
          "✅ Mind Maps & Visual Storytelling\n\n"
          "**🔹 General Utility (عمومی مدد)**\n"
          "✅ Translation (EN ↔ UR ↔ PN)\n"
          "✅ Answer Questions & Explain Concepts\n"
          "✅ Writing & Content Creation\n\n"
          "**What would you like help with?**";
    }

    // === UNIQUE PIONEER TOOLS ===

    // Creative Logic Mapping (CLM)
    if (query.contains('creative logic') || query.contains('clm') || query.contains('project plan') || query.contains('gantt') || query.contains('timeline')) {
      return "**📊 Creative Logic Mapping (CLM)**\n\nI can turn your idea, concept, or project into a structured plan with timeline.\n\n**How to use:**\n1. Share your idea or goal\n2. I'll break it into phases\n3. Create a timeline with milestones\n4. Define actionable steps\n\n**Example:** \"I want to launch an online store\" → I'll map out a 3-month plan with tasks.\n\n**Tell me your idea!**";
    }

    // Emotional Tone Analysis (ETA)
    if (query.contains('emotional tone') || query.contains('eta') || query.contains('tone analysis') || query.contains('improve writing')) {
      return "**🎭 Emotional Tone Analysis (ETA)**\n\nI can analyze any text and assess its emotional impact, then suggest revisions.\n\n**Emotions I analyze:**\n• Persuasive vs. Passive\n• Professional vs. Casual\n• Sympathetic vs. Assertive\n• Optimistic vs. Pessimistic\n\n**Example:** Paste an email draft → I'll tell you if it sounds too harsh or too weak, and rewrite it.\n\n**Paste your text!**";
    }

    // Global Compliance Quick-Check (GCQC)
    if (query.contains('compliance') || query.contains('gcqc') || query.contains('feasibility') || query.contains('business risk') || query.contains('validate idea')) {
      return "**🌍 Global Compliance Quick-Check (GCQC)**\n\nI can validate your business idea against global standards.\n\n**I check for:**\n✓ Market feasibility\n✓ Basic regulatory concerns\n✓ Risk assessment\n✓ Compliance red flags\n\n**Example:** \"I want to sell health supplements online\" → I'll identify regulations, risks, and next steps.\n\n**Describe your business idea!**";
    }

    // SWOT Analysis
    if (query.contains('swot') || query.contains('swot analysis') || query.contains('comparative analysis')) {
      return "**📈 SWOT & Comparative Analysis**\n\nI can analyze:\n• Business ideas\n• Products/Services\n• Career decisions\n• Market positioning\n\n**SWOT Structure:**\n✓ Strengths\n✓ Weaknesses\n✓ Opportunities\n✓ Threats\n\n**Tell me what to analyze!**";
    }

    // SEO & Content Optimization
    if (query.contains('seo') || query.contains('keywords') || query.contains('humanize') || query.contains('plagiarism') || query.contains('optimize content')) {
      return "**✍️ Text Optimization**\n\nI can help with:\n\n📌 SEO Keyword Analysis\n📌 Humanize AI-generated content\n📌 Plagiarism removal & rewriting\n📌 Readability improvement\n\n**What content needs optimization?**";
    }

    // === EDUCATION & STUDY ===
    if (query.contains('education') || query.contains('study') || query.contains('homework') || query.contains('exam') || query.contains('assignment') || query.contains('learn') || query.contains('explain')) {
      return "**🎓 Education & Study Help**\n\nI can help with:\n\n• Concept Explanations (Basic to PhD level)\n• Homework & Assignment Solutions\n• Exam Preparation & Study Plans\n• Research Paper Structure & References\n• All Subjects: Science, Math, History, Languages\n\n**What subject do you need help with?**";
    }

    // === WRITING & CONTENT ===
    if (query.contains('write') || query.contains('essay') || query.contains('article') || query.contains('story') || query.contains('content') || query.contains('blog')) {
      return "**✍️ Writing & Content Creation**\n\nI can write:\n\n• Essays & Research Papers\n• Stories & Scripts\n• Articles & Blogs (SEO-optimized)\n• Business Reports\n• Academic Notes\n\n**Tell me what you need written!**";
    }

    // === BUSINESS & STRATEGY ===
    if (query.contains('business') || query.contains('marketing') || query.contains('startup') || query.contains('entrepreneur') || query.contains('branding') || query.contains('monetization')) {
      return "**💼 Business Strategy & Development**\n\nI can help with:\n\n• Business Plans & Pitch Decks\n• Marketing Strategies\n• SWOT & Market Analysis\n• Monetization Models\n• Brand Development\n\n**What business aspect do you need help with?**";
    }

    // === FILE PROCESSING ===
    if (query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('upload') || query.contains('analyze') || query.contains('data extraction') || query.contains('convert')) {
      return "**📂 Files & Data Engineering**\n\nI can:\n\n• Analyze PDF, DOCX, Images\n• PDF to Word Conversion\n• Automated Data Extraction (Invoices, Tables)\n• Document Summarization\n• File Analysis\n\n**Click the 📎 icon to upload files!**";
    }

    // === PROGRAMMING ===
    if (query.contains('programming') || query.contains('code') || query.contains('software') || query.contains('python') || query.contains('java') || query.contains('flutter') || query.contains('debug') || query.contains('translate code')) {
      return "**💻 Programming & Code Help**\n\nI can help with:\n\n• Code Writing (Python, Java, JavaScript, Flutter, C++)\n• Debugging & Error Fixing\n• Code Translation (Convert between languages)\n• Algorithm Optimization\n• Project Architecture\n\n**What programming help do you need?**";
    }

    // === IMAGE GENERATION ===
    if (query.contains('image') || query.contains('picture') || query.contains('photo') || query.contains('draw') || query.contains('banner') || query.contains('flowchart') || query.contains('mind map')) {
      return "**🎨 Visual Content Generation**\n\nI can generate:\n\n• AI Images & Banners\n• Flowcharts (Process visualization)\n• Mind Maps (Concept organization)\n• Diagrams & Illustrations\n\n**Note:** Full visual generation available with backend integration.\n\n**Describe what you want to create!**";
    }

    // === VIDEO GENERATION ===
    if (query.contains('video') || query.contains('clip') || query.contains('animation')) {
      return "**🎥 AI Video Generation**\n\nI can help create:\n\n• AI-Generated Videos from text\n• Professional Video Scripts\n• Storyboards\n• Content Strategy\n\n**Note:** Full video generation available with integration.\n\n**Tell me about your video project!**";
    }

    // === POWERPOINT ===
    if (query.contains('powerpoint') || query.contains('ppt') || query.contains('presentation') || query.contains('slides') || query.contains('pitch deck')) {
      return "**📊 Presentation & Pitch Deck Creation**\n\nI can create presentations with:\n\n• Structured Content & Bullet Points\n• Professional Titles & Headings\n• Organized Flow\n• Visual Suggestions\n\n**Tell me your presentation topic!**";
    }

    // === SCIENCE ===
    if (query.contains('science') || query.contains('physics') || query.contains('chemistry') || query.contains('biology')) {
      return "**🔬 Science Help**\n\nI can help with:\n\n• Physics (Mechanics, Thermodynamics, Quantum)\n• Chemistry (Organic, Inorganic, Reactions)\n• Biology (Genetics, Ecology, Human Body)\n• Lab Reports\n• Experiments\n\n**What science topic do you need help with?**";
    }

    // === MATHEMATICS ===
    if (query.contains('math') || query.contains('algebra') || query.contains('calculus') || query.contains('geometry') || query.contains('statistics')) {
      return "**📐 Mathematics Help**\n\nI can solve:\n\n• Algebra (Equations, Functions)\n• Calculus (Derivatives, Integrals)\n• Geometry (Proofs, Constructions)\n• Statistics (Probability, Analysis)\n• Step-by-Step Solutions\n\n**What math problem do you need solved?**";
    }

    // === LANGUAGE SUPPORT ===
    if (query.contains('language') || query.contains('translate') || query.contains('translation')) {
      return "**🌐 Translation & Language Support**\n\nI support:\n\n🇵🇰 Pakistani Urdu\n🇮🇳 Indian Urdu\n🇵🇰 Pakistani Punjabi\n🇮🇳 Indian Punjabi\n🇬🇧 English\n\nI automatically detect your language and respond naturally.\n\n**What would you like translated?**";
    }

    // === URDU RESPONSES ===
    if (detectedLanguage == 'Urdu' || query.contains('urdu') || query.contains('اردو')) {
      return "میں اردو میں آپ کی مکمل مدد کر سکتا ہوں۔\n\n**میں یہ کر سکتا ہوں:**\n• سوالات کے جوابات\n• تعلیمی مدد\n• مضامین اور رپورٹس\n• ترجمہ\n• کاروباری منصوبے\n\nآپ کو کس چیز میں مدد چاہیے؟";
    }

    // === PUNJABI RESPONSES ===
    if (detectedLanguage == 'Punjabi' || query.contains('punjabi') || query.contains('ਪੰਜਾਬੀ') || query.contains('پنجابی')) {
      return "ਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਤੁਹਾਡੀ ਪੂਰੀ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ।\n\n**ਮੈਂ ਇਹ ਕਰ ਸਕਦਾ ਹਾਂ:**\n• ਸਵਾਲਾਂ ਦੇ ਜਵਾਬ\n• ਪੜ੍ਹਾਈ ਵਿੱਚ ਮਦਦ\n• ਲੇਖ ਅਤੇ ਰਿਪੋਰਟਾਂ\n• ਅਨੁਵਾਦ\n• ਕਾਰੋਬਾਰੀ ਯੋਜਨਾਵਾਂ\n\nਤੁਹਾਨੂੰ ਕਿਸ ਚੀਜ਼ ਵਿੱਚ ਮਦਦ ਚਾਹੀਦੀ ਹੈ?";
    }

    // === THANK YOU ===
    if (query.contains('thank') || query.contains('thanks') || query.contains('شکریہ')) {
      return "You're welcome! Let me know if you need anything else.";
    }

    // === DEFAULT RESPONSE (DIRECT & HELPFUL - NO GENERIC MENU) ===
    return "I'm here to provide accurate solutions across all fields.\n\n**I can help with:**\n• Answering questions\n• Education & homework\n• Writing & content\n• Business strategy\n• Programming & debugging\n• File analysis\n• And much more\n\n**Could you provide more details about what you need?**";
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _isFirstMessage = false;
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
                hintText: "Ask what you need...",
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
                      '🌍 SMART AI — Universal Assistant\n\n'
                      'Developed by:\n'
                      'Sardar Muhammad Adeel Ashraf\n\n'
                      '"One assistant. All answers. Free for everyone, everywhere."\n\n'
                      '✅ 100% Free — No charges, no upgrades, no limits\n'
                      '✅ Most Accessible — Works in English, Urdu, Punjabi\n'
                      '✅ Most Helpful — Covers every field: education, business, coding, design, writing, research\n'
                      '✅ Most Unique — Offers tools and logic no other AI assistant provides\n'
                      '✅ Most Easy to Use — One-line answers, one-tap tools, zero confusion\n\n'
                      '🛠️ Unique Features:\n'
                      '• Creative Logic Mapping (CLM)\n'
                      '• Emotional Tone Analysis (ETA)\n'
                      '• Global Compliance Quick-Check (GCQC)\n'
                      '• PDF to Word Conversion\n'
                      '• Automated Data Extraction\n'
                      '• Code Translation & Debugging\n'
                      '• Image, Banner & Flowchart Generation\n'
                      '• SWOT & Comparative Analysis\n'
                      '• And 12+ more advanced tools\n\n'
                      'Version: 3.0.0 (Universal Edition)',
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
                if (!message.isUser)
                  IconButton(
                    icon: const Icon(Icons.download, size: 16),
                    tooltip: 'Download',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Download Response'),
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
