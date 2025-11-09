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
            text: "Assalamu Alaikum! I am SMART AI, your personal intelligent assistant. Operating at a **Pioneer-Grade intelligence level** for you, offering unique, free solutions.\n\nHow can I help you today?",
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

  // AI response system - Direct, concise, natural, PIONEER-GRADE
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // === DIRECT SIMPLE QUESTIONS (CONCISE ANSWERS - ZERO TOLERANCE RULE) ===
    
    if (query == 'what is your name' || query == 'what is your name?' || query == 'whats your name' || query == 'your name' || query == 'what\'s your name') {
      return "My name is SMART AI.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age') || query.contains('your age')) {
      return "I'm an AI, so I don't have an age in the traditional sense. I was created recently to assist you!";
    }
    
    if (query == 'who are you' || query == 'who are you?') {
      return "I am SMART AI, your intelligent personal assistant.";
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

    // === HELP MENU (STRUCTURED WITH URDU/ENGLISH) ===
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('help me') || query.contains('capabilities') || query.contains('what do you do')) {
      return "### 🛠️ مدد کے شعبے (SMART AI Services)\n\n"
          "**منفرد ٹولز (Unique Tools)**\n"
          "✅ Creative Logic Mapping (CLM)\n"
          "✅ Emotional Tone Analysis (ETA)\n"
          "✅ Global Compliance Quick-Check (GCQC)\n\n"
          "**مواد اور ریسرچ (Content & Research)**\n"
          "✅ Text Optimization (Humanize, Plagiarism, SEO)\n"
          "✅ Deep Study & Personalized Plans\n"
          "✅ Comparative & SWOT Analysis\n\n"
          "**فائل اور ڈیٹا (Files & Data Engineering)**\n"
          "✅ Document Editing & PDF to Word Conversion\n"
          "✅ Automated Data Extraction & Analysis\n"
          "✅ File analysis (Images, DOCX, etc.)\n\n"
          "**تخلیق اور کوڈنگ (Creation & Coding)**\n"
          "✅ Image, Flowchart & Mind Map Generation\n"
          "✅ Programming, Debugging & Code Translation\n"
          "✅ Presentations & Creative Writing\n\n"
          "**عمومی معاونت (General Utility)**\n"
          "✅ Translation (ترجمہ)\n"
          "✅ Answer Questions & Explain Concepts\n\n"
          "**What would you like help with?**";
    }

    // === UNIQUE PIONEER TOOLS ===

    // Creative Logic Mapping (CLM)
    if (query.contains('creative logic') || query.contains('clm') || query.contains('project plan') || query.contains('gantt')) {
      return "**📊 Creative Logic Mapping (CLM)**\n\nI can transform your creative idea, story plot, or vague concept into a structured, executable project plan with timeline.\n\n**How to use:**\n1. Share your idea/concept\n2. I'll break it into phases\n3. Create a timeline/Gantt-style structure\n4. Define actionable steps\n\n**Tell me your idea and I'll map it out for you!**";
    }

    // Emotional Tone Analysis (ETA)
    if (query.contains('emotional tone') || query.contains('eta') || query.contains('tone analysis') || query.contains('analyze text')) {
      return "**🎭 Emotional Tone Analysis (ETA)**\n\nI can analyze any text (email, speech, message) and assess the emotional tone it conveys, then suggest revisions to match your desired emotion.\n\n**Emotions I analyze:**\n• Persuasive vs. Passive\n• Professional vs. Casual\n• Sympathetic vs. Assertive\n• Optimistic vs. Pessimistic\n\n**Paste your text and tell me what tone you want to achieve!**";
    }

    // Global Compliance Quick-Check (GCQC)
    if (query.contains('compliance') || query.contains('gcqc') || query.contains('feasibility') || query.contains('business risk')) {
      return "**🌍 Global Compliance Quick-Check (GCQC)**\n\nI can provide a quick, simplified check of your business idea against:\n\n✓ General global compliance standards\n✓ Market risk assessment\n✓ Basic regulatory concerns\n✓ Feasibility analysis\n\n**Describe your business idea and I'll provide a compliance overview!**";
    }

    // SWOT Analysis
    if (query.contains('swot') || query.contains('swot analysis')) {
      return "**📈 SWOT Analysis**\n\nI can perform comprehensive SWOT Analysis for:\n• Business ideas\n• Products/Services\n• Career decisions\n• Marketing strategies\n\n**Structure:**\n✓ Strengths\n✓ Weaknesses\n✓ Opportunities\n✓ Threats\n\n**Tell me what you want analyzed!**";
    }

    // SEO & Content Optimization
    if (query.contains('seo') || query.contains('keywords') || query.contains('humanize') || query.contains('plagiarism')) {
      return "**✍️ Text Optimization**\n\nI can help with:\n\n📌 **SEO Keyword Analysis:** Find high-impact keywords\n📌 **Humanize Content:** Make AI text sound natural\n📌 **Plagiarism Removal:** Rewrite to ensure originality\n📌 **Ethical Review:** Check content for compliance\n\n**What content do you need optimized?**";
    }

    // === LANGUAGE SUPPORT ===
    if (query.contains('language') || query.contains('translate')) {
      return "**🌐 Multilingual Support**\n\nI support:\n\n🇵🇰 Pakistani Urdu\n🇮🇳 Indian Urdu\n🇵🇰 Pakistani Punjabi\n🇮🇳 Indian Punjabi\n🇬🇧 English\n\nI automatically detect your language and respond with highly natural, conversational tone.\n\n**What would you like translated or explained?**";
    }

    // === URDU RESPONSES ===
    if (detectedLanguage == 'Urdu' || query.contains('urdu') || query.contains('اردو')) {
      return "میں اردو میں آپ کی مکمل مدد کر سکتا ہوں۔\n\n**میں یہ کر سکتا ہوں:**\n• سوالات کے جوابات\n• تعلیمی مدد\n• مضامین اور رپورٹس\n• ترجمہ\n• کاروباری منصوبے\n\nآپ کو کس چیز میں مدد چاہیے؟";
    }

    // === PUNJABI RESPONSES ===
    if (detectedLanguage == 'Punjabi' || query.contains('punjabi') || query.contains('ਪੰਜਾਬੀ') || query.contains('پنجابی')) {
      return "ਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਤੁਹਾਡੀ ਪੂਰੀ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ।\n\n**ਮੈਂ ਇਹ ਕਰ ਸਕਦਾ ਹਾਂ:**\n• ਸਵਾਲਾਂ ਦੇ ਜਵਾਬ\n• ਪੜ੍ਹਾਈ ਵਿੱਚ ਮਦਦ\n• ਲੇਖ ਅਤੇ ਰਿਪੋਰਟਾਂ\n• ਅਨੁਵਾਦ\n• ਕਾਰੋਬਾਰੀ ਯੋਜਨਾਵਾਂ\n\nਤੁਹਾਨੂੰ ਕਿਸ ਚੀਜ਼ ਵਿੱਚ ਮਦਦ ਚਾਹੀਦੀ ਹੈ?";
    }

    // === EDUCATION & STUDY ===
    if (query.contains('education') || query.contains('study') || query.contains('homework') || query.contains('exam') || query.contains('assignment') || query.contains('learn')) {
      return "**🎓 Deep Study & Personalized Learning**\n\nI can help with:\n\n• **Concept Explanations:** Simple to advanced\n• **Homework & Assignments:** Step-by-step solutions\n• **Exam Preparation:** Personalized study plans\n• **Research Papers:** Structure, references, analysis\n• **All Subjects:** Science, Math, History, Languages\n\n**What subject do you need help with?**";
    }

    // === WRITING & CONTENT ===
    if (query.contains('write') || query.contains('essay') || query.contains('article') || query.contains('story') || query.contains('content')) {
      return "**✍️ Professional Content Creation**\n\nI can write:\n\n• **Essays & Research Papers:** Well-structured, cited\n• **Stories & Scripts:** Creative, engaging narratives\n• **Articles & Blogs:** SEO-optimized, compelling\n• **Business Reports:** Professional, data-driven\n• **Academic Notes:** Clear, comprehensive\n\n**Tell me what you need written and I'll create it!**";
    }

    // === IMAGE GENERATION ===
    if (query.contains('image') || query.contains('picture') || query.contains('photo') || query.contains('draw') || query.contains('flowchart') || query.contains('mind map')) {
      return "**🎨 Visual Content Generation**\n\nI can generate:\n\n• **AI Images:** Describe what you want\n• **Flowcharts:** Process visualization\n• **Mind Maps:** Concept organization\n• **Diagrams:** Technical illustrations\n\n**Note:** Full visual generation available with backend integration.\n\n**Describe what you want to create!**";
    }

    // === VIDEO GENERATION ===
    if (query.contains('video') || query.contains('clip') || query.contains('animation')) {
      return "**🎥 AI Video Generation**\n\nI can help create:\n\n• **AI-Generated Videos:** From text descriptions\n• **Script Writing:** Professional video scripts\n• **Storyboards:** Visual planning\n• **Content Strategy:** What to include\n\n**Note:** Full video generation available with integration.\n\n**Tell me about your video project!**";
    }

    // === FILE PROCESSING ===
    if (query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('upload') || query.contains('analyze') || query.contains('data extraction')) {
      return "**📂 Document & Data Engineering**\n\nI can:\n\n• **Analyze Files:** PDF, DOCX, Images\n• **Data Extraction:** Pull key information\n• **Document Editing:** Revise within chat\n• **Format Conversion:** PDF to editable formats\n• **Summarization:** Extract key points\n\n**Click the 📎 icon to upload files!**";
    }

    // === SCIENCE ===
    if (query.contains('science') || query.contains('physics') || query.contains('chemistry') || query.contains('biology')) {
      return "**🔬 Advanced Science Assistance**\n\nI can help with:\n\n• **Physics:** Mechanics, Thermodynamics, Quantum\n• **Chemistry:** Organic, Inorganic, Reactions\n• **Biology:** Genetics, Ecology, Human Body\n• **Lab Reports:** Structure and analysis\n• **Experiments:** Design and methodology\n\n**What science topic do you need help with?**";
    }

    // === MATHEMATICS ===
    if (query.contains('math') || query.contains('algebra') || query.contains('calculus') || query.contains('geometry') || query.contains('statistics')) {
      return "**📐 Advanced Mathematics Help**\n\nI can solve:\n\n• **Algebra:** Equations, Functions\n• **Calculus:** Derivatives, Integrals\n• **Geometry:** Proofs, Constructions\n• **Statistics:** Probability, Analysis\n• **Step-by-Step:** Clear explanations\n\n**What math problem do you need solved?**";
    }

    // === PROGRAMMING ===
    if (query.contains('programming') || query.contains('code') || query.contains('software') || query.contains('python') || query.contains('java') || query.contains('flutter') || query.contains('debug')) {
      return "**💻 Programming & Code Engineering**\n\nI can help with:\n\n• **Code Writing:** Python, Java, JavaScript, Flutter, C++\n• **Debugging:** Find and fix errors\n• **Code Translation:** Convert between languages\n• **Algorithm Optimization:** Improve performance\n• **Project Architecture:** Best practices\n\n**What programming help do you need?**";
    }

    // === BUSINESS ===
    if (query.contains('business') || query.contains('marketing') || query.contains('startup') || query.contains('entrepreneur')) {
      return "**💼 Business Strategy & Development**\n\nI can help with:\n\n• **Business Plans:** Comprehensive structure\n• **Marketing Strategies:** Target audience, channels\n• **SWOT Analysis:** Strengths, weaknesses, opportunities\n• **Compliance Check:** Feasibility assessment\n• **Brand Development:** Identity and positioning\n\n**What business aspect do you need help with?**";
    }

    // === POWERPOINT ===
    if (query.contains('powerpoint') || query.contains('ppt') || query.contains('presentation') || query.contains('slides')) {
      return "**📊 Professional Presentation Creation**\n\nI can create PowerPoint presentations with:\n\n• **Structured Content:** Clear bullet points\n• **Professional Titles:** Engaging headings\n• **Organized Flow:** Logical progression\n• **Visual Suggestions:** Chart and image ideas\n\n**Tell me your presentation topic!**";
    }

    // === THANK YOU ===
    if (query.contains('thank') || query.contains('thanks') || query.contains('شکریہ')) {
      return "You're welcome! Let me know if you need anything else.";
    }

    // === DEFAULT RESPONSE (DIRECT & HELPFUL - NO GENERIC MENU) ===
    return "I'm here to provide instant, accurate solutions.\n\n**I can help with:**\n• Answering questions\n• Writing & content creation\n• Study & research\n• Programming & debugging\n• Business strategy\n• Document analysis\n• And much more\n\n**Could you provide more details about what you need?**";
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
                  content: Text("📎 Upload files (PDF, DOCX, Images) for analysis"),
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
                      '🚀 SMART AI — The Ultimate AI Assistant\n\n'
                      'Developed by:\n'
                      'Sardar Muhammad Adeel Ashraf\n\n'
                      '🌟 Pioneer-Grade Capabilities:\n'
                      '• Creative Logic Mapping (CLM)\n'
                      '• Emotional Tone Analysis (ETA)\n'
                      '• Global Compliance Quick-Check (GCQC)\n'
                      '• Text Optimization & SEO\n'
                      '• Document Engineering\n'
                      '• Advanced Programming Help\n'
                      '• Business Strategy & SWOT Analysis\n'
                      '• Multilingual Support (5+ languages)\n'
                      '• Image, Video & Audio Generation\n\n'
                      'Operating at Pioneer-Grade intelligence level — offering unique solutions that surpass typical Pro/Paid AI models, completely FREE.\n\n'
                      'Version: 2.0.0 (Pioneer Edition)',
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
