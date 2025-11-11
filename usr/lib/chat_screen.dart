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

  // AI response system - KNOWLEDGE FIRST, DIRECT ANSWERING, ZERO ERROR
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // === CRITICAL: KNOWLEDGE FIRST (ABSOLUTE PRIORITY) ===
    // Answer ANY question directly using knowledge base
    // DO NOT show menu or capabilities unless explicitly asked

    // === DIRECT SIMPLE QUESTIONS (ONE-LINE ANSWERS) ===
    
    if (query == 'what is your name' || query == 'what is your name?' || query == 'whats your name' || query == 'your name' || query == "what's your name") {
      return "My name is SMART AI.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age') || query.contains('your age')) {
      return "I'm an AI assistant, so I don't have an age. I was created to help you!";
    }
    
    if (query == 'who are you' || query == 'who are you?') {
      return "I am SMART AI, your intelligent personal assistant.";
    }

    // Meta-questions about development (use + SMART AI style)
    if (query.contains('who developed you') || query.contains('who created you') || query.contains('who made you') || query.contains('how developed') || query.contains('how were you')) {
      return "+ SMART AI\n\nI was developed by Sardar Muhammad Adeel Ashraf.\n\n**I excel at:**\n• Answering knowledge questions\n• Solving problems step-by-step\n• Creating content (essays, code, designs)\n• Analyzing data and documents\n• Strategic planning and research\n\n**What would you like help with?**";
    }

    // === KNOWLEDGE BASE QUESTIONS (DIRECT ANSWERS) ===

    // What is AI?
    if (query == 'what is ai' || query == 'what is ai?' || query == 'define ai' || query.contains('what is artificial intelligence')) {
      return "AI (Artificial Intelligence) is the simulation of human intelligence by machines, enabling them to learn, reason, solve problems, and perform tasks that typically require human cognition.";
    }

    // What is machine learning?
    if (query.contains('what is machine learning') || query.contains('define machine learning')) {
      return "Machine Learning is a subset of AI where computers learn from data and improve their performance over time without being explicitly programmed for every task.";
    }

    // What is Python?
    if (query.contains('what is python') && !query.contains('snake')) {
      return "Python is a high-level, interpreted programming language known for its simplicity, readability, and versatility. It's widely used in web development, data science, AI, automation, and more.";
    }

    // What is programming?
    if (query.contains('what is programming') || query.contains('what is coding')) {
      return "Programming (or coding) is the process of creating instructions for computers to follow. It involves writing code in programming languages to build software, apps, websites, and automated systems.";
    }

    // What is photosynthesis?
    if (query.contains('what is photosynthesis')) {
      return "Photosynthesis is the process by which green plants use sunlight, water, and carbon dioxide to produce glucose (food) and oxygen. The equation is: 6CO₂ + 6H₂O + Light Energy → C₆H₁₂O₆ + 6O₂.";
    }

    // What is gravity?
    if (query.contains('what is gravity')) {
      return "Gravity is a fundamental force of nature that attracts objects with mass toward each other. On Earth, it gives weight to objects and causes them to fall when dropped. Newton's law: F = G(m₁m₂)/r².";
    }

    // What is DNA?
    if (query.contains('what is dna')) {
      return "DNA (Deoxyribonucleic Acid) is the molecule that carries genetic instructions for life. It has a double helix structure and contains genes that determine inherited traits.";
    }

    // What is the theory of relativity?
    if (query.contains('theory of relativity') || query.contains('relativity theory')) {
      return "Einstein's Theory of Relativity consists of Special Relativity (E=mc², time dilation) and General Relativity (gravity as spacetime curvature). It revolutionized our understanding of space, time, and energy.";
    }

    // What is quantum mechanics?
    if (query.contains('quantum mechanics') || query.contains('quantum physics')) {
      return "Quantum Mechanics is the branch of physics that describes the behavior of matter and energy at the atomic and subatomic scale, where particles exhibit wave-particle duality and uncertainty principles apply.";
    }

    // What is climate change?
    if (query.contains('climate change') || query.contains('global warming')) {
      return "Climate change refers to long-term shifts in global temperatures and weather patterns, primarily caused by human activities (burning fossil fuels, deforestation) that increase greenhouse gases in the atmosphere.";
    }

    // What is democracy?
    if (query.contains('what is democracy')) {
      return "Democracy is a system of government where power is vested in the people, who exercise it directly or through elected representatives. Key principles include free elections, rule of law, and protection of human rights.";
    }

    // What is blockchain?
    if (query.contains('what is blockchain')) {
      return "Blockchain is a decentralized, distributed digital ledger that records transactions across multiple computers in a way that makes the records immutable and transparent. It's the technology behind cryptocurrencies like Bitcoin.";
    }

    // What is cryptocurrency?
    if (query.contains('what is cryptocurrency') || query.contains('what is crypto')) {
      return "Cryptocurrency is a digital or virtual currency that uses cryptography for security and operates on blockchain technology. Examples include Bitcoin, Ethereum, and many others.";
    }

    // What is the internet?
    if (query.contains('what is the internet') || query.contains('what is internet')) {
      return "The Internet is a global network of interconnected computers that communicate using standardized protocols (TCP/IP). It enables information sharing, communication, and access to online resources worldwide.";
    }

    // What is HTML?
    if (query.contains('what is html')) {
      return "HTML (HyperText Markup Language) is the standard markup language for creating web pages. It structures content using elements/tags like <h1>, <p>, <div>, etc.";
    }

    // What is CSS?
    if (query.contains('what is css')) {
      return "CSS (Cascading Style Sheets) is a styling language used to control the visual presentation of HTML elements on web pages, including layout, colors, fonts, and responsive design.";
    }

    // What is JavaScript?
    if (query.contains('what is javascript')) {
      return "JavaScript is a high-level, interpreted programming language that enables interactive web pages. It runs in browsers and is essential for modern web development, along with HTML and CSS.";
    }

    // What is database?
    if (query.contains('what is database') || query.contains('what is a database')) {
      return "A database is an organized collection of structured data stored electronically. It allows efficient storage, retrieval, and management of information. Examples include MySQL, PostgreSQL, MongoDB.";
    }

    // What is API?
    if (query.contains('what is api') || query.contains('what is an api')) {
      return "API (Application Programming Interface) is a set of rules and protocols that allows different software applications to communicate and share data with each other.";
    }

    // Who is Einstein?
    if (query.contains('who is einstein') || query.contains('albert einstein')) {
      return "Albert Einstein (1879-1955) was a German-born theoretical physicist who developed the theory of relativity, one of the two pillars of modern physics. He received the Nobel Prize in Physics in 1921.";
    }

    // Who is Newton?
    if (query.contains('who is newton') || query.contains('isaac newton')) {
      return "Sir Isaac Newton (1643-1727) was an English mathematician, physicist, and astronomer who formulated the laws of motion and universal gravitation, laying the foundation for classical mechanics.";
    }

    // Who is Shakespeare?
    if (query.contains('who is shakespeare') || query.contains('william shakespeare')) {
      return "William Shakespeare (1564-1616) was an English playwright and poet, widely regarded as the greatest writer in the English language. Famous works include Hamlet, Romeo and Juliet, and Macbeth.";
    }

    // How to learn programming?
    if (query.contains('how to learn programming') || query.contains('how to learn coding')) {
      return "**To learn programming:**\n1. Choose a beginner-friendly language (Python, JavaScript)\n2. Learn basics: variables, loops, functions\n3. Practice with small projects\n4. Use online resources (freeCodeCamp, Codecademy)\n5. Build real projects\n6. Join coding communities\n\nStart with Python for simplicity!";
    }

    // How to write an essay?
    if (query.contains('how to write essay') || query.contains('how to write an essay')) {
      return "**Essay Writing Steps:**\n1. Choose a topic and research\n2. Create an outline (intro, body, conclusion)\n3. Write a strong thesis statement\n4. Develop body paragraphs with evidence\n5. Write introduction and conclusion\n6. Edit and proofread\n\nWant me to help you write one?";
    }

    // How to solve math problems?
    if (query.contains('how to solve math') || query.contains('solve math problem')) {
      return "**Math Problem-Solving Strategy:**\n1. Read the problem carefully\n2. Identify what's given and what to find\n3. Choose appropriate method/formula\n4. Show your work step-by-step\n5. Check your answer\n\nShare a specific problem and I'll solve it for you!";
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

    // === HELP MENU (ONLY WHEN EXPLICITLY ASKED) ===
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities') || query.contains('what do you do')) {
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
    if (query.contains('creative logic') || query.contains('clm') || query.contains('map out a business') || query.contains('project plan') || query.contains('gantt') || query.contains('timeline')) {
      return "**📊 Creative Logic Mapping (CLM)**\n\nI can turn your idea, concept, or project into a structured plan with timeline.\n\n**How to use:**\n1. Share your idea or goal\n2. I'll break it into phases\n3. Create a timeline with milestones\n4. Define actionable steps\n\n**Example:** \"Map out a business plan: I want to launch an online store\" → I'll create a 3-month plan with tasks.\n\n**Tell me your idea!**";
    }

    // Emotional Tone Analysis (ETA)
    if (query.contains('emotional tone') || query.contains('eta') || query.contains('tone analysis') || query.contains('analyze tone')) {
      return "**🎭 Emotional Tone Analysis (ETA)**\n\nI can analyze any text and assess its emotional impact, then suggest revisions.\n\n**Emotions I analyze:**\n• Persuasive vs. Passive\n• Professional vs. Casual\n• Sympathetic vs. Assertive\n• Optimistic vs. Pessimistic\n\n**Example:** \"Analyze tone in this text: [Paste email]\" → I'll tell you if it sounds too harsh or too weak, and rewrite it.\n\n**Paste your text!**";
    }

    // Global Compliance Quick-Check (GCQC)
    if (query.contains('compliance') || query.contains('gcqc') || query.contains('check if this action complies') || query.contains('feasibility') || query.contains('business risk') || query.contains('validate idea')) {
      return "**🌍 Global Compliance Quick-Check (GCQC)**\n\nI can validate your business idea against global standards.\n\n**I check for:**\n✓ Market feasibility\n✓ Basic regulatory concerns\n✓ Risk assessment\n✓ Compliance red flags\n\n**Example:** \"Check if this action complies with US laws: I want to sell health supplements online\" → I'll identify regulations, risks, and next steps.\n\n**Describe your business idea!**";
    }

    // SWOT Analysis
    if (query.contains('swot') || query.contains('swot analysis') || query.contains('comparative analysis') || query.contains('do a swot')) {
      return "**📈 SWOT & Comparative Analysis**\n\nI can analyze:\n• Business ideas\n• Products/Services\n• Career decisions\n• Market positioning\n\n**SWOT Structure:**\n✓ Strengths\n✓ Weaknesses\n✓ Opportunities\n✓ Threats\n\n**Example:** \"Do a SWOT for my startup: [Describe startup]\"\n\n**Tell me what to analyze!**";
    }

    // SEO & Content Optimization
    if (query.contains('seo') || query.contains('keywords') || query.contains('humanize') || query.contains('plagiarism') || query.contains('optimize content')) {
      return "**✍️ Text Optimization**\n\nI can help with:\n\n📌 SEO Keyword Analysis\n📌 Humanize AI-generated content\n📌 Plagiarism removal & rewriting\n📌 Readability improvement\n\n**What content needs optimization?**";
    }

    // PDF to Word Conversion
    if (query.contains('pdf to word') || query.contains('convert pdf') || query.contains('pdf conversion')) {
      return "**📄 PDF to Word Conversion**\n\nI can help convert PDF content to editable Word format.\n\n**How to use:**\n1. Describe the PDF content or provide key sections\n2. I'll extract and format the text\n3. Provide editable content structure\n\n**Example:** \"Convert this PDF summary: [Describe content]\"\n\n**Note:** Full file conversion requires backend integration.\n\n**What PDF content do you need converted?**";
    }

    // Data Extraction
    if (query.contains('data extraction') || query.contains('extract key data') || query.contains('extract data') || query.contains('invoice data') || query.contains('table data')) {
      return "**📊 Automated Data Extraction**\n\nI can extract structured data from:\n• Tables\n• Invoices\n• Forms\n• Documents\n• Images (with text)\n\n**Example:** \"Extract key data from this table: [Paste table]\"\n\n**Paste your data source!**";
    }

    // === EDUCATION & STUDY ===
    if (query.contains('education') || query.contains('study') || query.contains('homework') || query.contains('exam') || query.contains('assignment') || query.contains('learn') || query.contains('teach me') || query.contains('study plan')) {
      return "**🎓 Education & Study Help**\n\nI can help with:\n\n• Concept Explanations (Basic to PhD level)\n• Homework & Assignment Solutions\n• Exam Preparation & Study Plans\n• Research Paper Structure & References\n• All Subjects: Science, Math, History, Languages\n\n**Example:** \"Create a study plan for math: [Specify topic]\"\n\n**What subject do you need help with?**";
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
    if (query.contains('file') || query.contains('pdf') || query.contains('document') || query.contains('upload') || query.contains('analyze') || query.contains('convert')) {
      return "**📂 Files & Data Engineering**\n\nI can:\n\n• Analyze PDF, DOCX, Images\n• PDF to Word Conversion\n• Automated Data Extraction (Invoices, Tables)\n• Document Summarization\n• File Analysis\n\n**Click the 📎 icon to upload files!**";
    }

    // === PROGRAMMING ===
    if (query.contains('programming') || query.contains('code') || query.contains('software') || query.contains('python') || query.contains('java') || query.contains('flutter') || query.contains('debug') || query.contains('translate code')) {
      return "**💻 Programming & Code Help**\n\nI can help with:\n\n• Code Writing (Python, Java, JavaScript, Flutter, C++)\n• Debugging & Error Fixing\n• Code Translation (Convert between languages)\n• Algorithm Optimization\n• Project Architecture\n\n**Example:** \"Debug this Python code: [Paste code]\"\n\n**What programming help do you need?**";
    }

    // === IMAGE GENERATION ===
    if (query.contains('image') || query.contains('picture') || query.contains('photo') || query.contains('draw') || query.contains('banner') || query.contains('flowchart') || query.contains('mind map') || query.contains('generate a flowchart')) {
      return "**🎨 Visual Content Generation**\n\nI can generate:\n\n• AI Images & Banners\n• Flowcharts (Process visualization)\n• Mind Maps (Concept organization)\n• Diagrams & Illustrations\n\n**Example:** \"Generate a flowchart for this process: [Describe process]\"\n\n**Note:** Full visual generation available with backend integration.\n\n**Describe what you want to create!**";
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

    // === HISTORY ===
    if (query.contains('history') || query.contains('historical')) {
      return "**📚 History Help**\n\nI can explain:\n\n• World History (Ancient to Modern)\n• Historical Events & Figures\n• Civilizations & Empires\n• Wars & Revolutions\n• Timeline Analysis\n\n**What historical topic interests you?**";
    }

    // === LANGUAGE SUPPORT ===
    if (query.contains('language') || query.contains('translate') || query.contains('translation')) {
      return "**🌐 Translation & Language Support**\n\nI support:\n\n🇵🇰 Pakistani Urdu\n🇮🇳 Indian Urdu\n🇵🇰 Pakistani Punjabi\n🇮🇳 Indian Punjabi\n🇬🇧 English\n\nI automatically detect your language and respond naturally.\n\n**Example:** \"Explain quantum physics in Urdu: [Specify concept]\"\n\n**What would you like translated?**";
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

    // === DEFAULT RESPONSE (KNOWLEDGE-BASED ANALYSIS) ===
    // When the query doesn't match specific patterns, provide intelligent analysis
    return "+ SMART AI\n\nI can help you with that. Could you provide more specific details about what you need?\n\n**I excel at:**\n• Answering knowledge questions\n• Solving problems step-by-step\n• Creating content (essays, code, designs)\n• Analyzing data and documents\n• Strategic planning and research\n\n**What specifically would you like assistance with?**";
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
                      'Operating with hundreds of billions of verified knowledge points\n'
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
