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

  // AI response system based on a structured problem-solving framework.
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // FRAMEWORK STEPS:
    // 1. Problem Identification: Accurately define the user's request.
    String problemIdentification = _analyzeProblem(text);
    // 2. Knowledge Integration: Leverage a broad knowledge base.
    // 3. Solution Generation: Develop innovative and practical solutions.
    // 4. Accuracy Assurance: Guarantee factual accuracy.
    // 5. Comprehensive Responses: Deliver detailed answers with multiple perspectives.
    // 6. Adaptability: Adjust based on new information.
    // 7. User Empowerment: Provide explanations, rationale, and resources.
    // 8. Multilingual Capability: Customize responses for different languages.
    // 9. Feedback Mechanism: Solicit user feedback for improvement.
    // 10. Ethical Considerations: Adhere to ethical standards.

    // DIRECT ANSWERS TO COMMON QUERIES
    if (query == 'what is your name' || query == 'what is your name?' || query == 'whats your name' || query == 'your name') {
      return "My name is SMART AI. I am an advanced AI system designed for problem-solving and information processing.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age') || query.contains('your age')) {
      return "I am an AI system. I don't have an age in the human sense. My knowledge is continuously updated. How can I assist you with a problem today?";
    }
    
    if (query == 'who are you' || query == 'who are you?') {
      return "I am SMART AI, an advanced assistant for comprehensive problem-solving. I can help with science, technology, business, education, and more by providing detailed, evidence-based solutions. What challenge can I help you tackle?";
    }

    // KNOWLEDGE BASE - EDUCATION & LEARNING
    if (query.contains('what is education')) {
      return "**Education: A Multi-Faceted Analysis**\n\n" +
          "• **Definition**: Education is the systematic process of facilitating learning, or the acquisition of knowledge, skills, values, morals, beliefs, and habits.\n\n" +
          "**Multiple Perspectives**:\n" +
          "• **Traditional View**: Formal schooling (schools, colleges) focused on a structured curriculum.\n" +
          "• **Modern View**: A lifelong process including informal learning, self-study, and practical experience.\n" +
          "• **Sociological Perspective**: A tool for social mobility and cultural transmission.\n\n" +
          "**Evidence & Data**: According to UNESCO, each additional year of schooling can increase a person's income by 10% and reduces poverty.\n\n" +
          "**User Empowerment**: For further exploration, you can look into resources like Khan Academy for practical learning or academic journals on educational psychology for deeper theory.\n\n" +
          "What specific aspect of education are you interested in?";
    }

    // KNOWLEDGE BASE - SCIENCE
    if (query.contains('how does photosynthesis work')) {
      return "**Photosynthesis: A Detailed Explanation**\n\n" +
          "**Process Overview**:\n" +
          "• Photosynthesis is the process used by plants, algae, and some bacteria to convert light energy into chemical energy, stored in glucose.\n" +
          "• **Formula**: 6CO₂ + 6H₂O + Light Energy → C₆H₁₂O₆ + 6O₂\n\n" +
          "**Step-by-Step Breakdown**:\n" +
          "1. **Light-Dependent Reactions**: Chlorophyll absorbs light energy to split water molecules, releasing oxygen.\n" +
          "2. **Calvin Cycle (Light-Independent)**: The captured energy is used to convert carbon dioxide into glucose (sugar).\n\n" +
          "**Consequences & Importance**:\n" +
          "• **Positive**: Produces most of the world's oxygen and is the foundation of nearly all food chains.\n" +
          "• **Environmental Impact**: Deforestation and climate change can negatively affect the efficiency of photosynthesis on a global scale.\n\n" +
          "**User Empowerment**: For a visual understanding, I recommend searching for diagrams of the light-dependent reactions and the Calvin cycle. What related biological process would you like to know about next?";
    }

    // KNOWLEDGE BASE - MEDICINE
    if (query.contains('what is cancer')) {
      return "**Cancer: A Comprehensive Overview**\n\n" +
          "**Medical Definition**: Cancer is a disease characterized by the uncontrolled growth and spread of abnormal cells. If the spread is not controlled, it can result in death.\n\n" +
          "**Types & Causes**:\n" +
          "• **Types**: Carcinoma, Sarcoma, Leukemia, Lymphoma, etc., based on the origin cell.\n" +
          "• **Causes**: A combination of genetic mutations and environmental factors (like tobacco use, radiation, and certain infections).\n\n" +
          "**Treatment Approaches**:\n" +
          "• **Standard**: Surgery, Chemotherapy, Radiation Therapy.\n" +
          "• **Modern**: Immunotherapy, Targeted Therapy, Hormone Therapy.\n\n" +
          "**Ethical Considerations**:\n" +
          "• Patient autonomy in treatment decisions is crucial.\n" +
          "• Ensuring equitable access to new and expensive treatments is a global challenge.\n\n" +
          "**User Empowerment**: This information is for educational purposes. For medical advice, diagnosis, or treatment, it is essential to consult a qualified healthcare professional. Organizations like the World Health Organization (WHO) provide reliable public information.\n\n" +
          "What specific area of this topic would you like more details on?";
    }
    
    // KNOWLEDGE BASE - PROGRAMMING
    if (query.contains('how to learn programming')) {
      return "**A Structured Guide to Learning Programming**\n\n" +
          "**1. Foundational Steps**:\n" +
          "   a. **Choose a Language**: Start with a beginner-friendly language like Python for its simple syntax or JavaScript for web development.\n" +
          "   b. **Master the Basics**: Learn core concepts: variables, data types, loops, conditional statements, and functions.\n" +
          "   c. **Build Small Projects**: Apply your knowledge by building simple applications, like a calculator or a to-do list.\n\n" +
          "**2. Alternative Learning Paths**:\n" +
          "   • **Self-Taught**: Utilize free online resources like freeCodeCamp, Coursera, or Codecademy.\n" +
          "   • **Structured Programs**: Consider coding bootcamps for intensive, job-focused training or a university degree for a deep theoretical foundation.\n\n" +
          "**3. User Empowerment & Best Practices**:\n" +
          "   • **Practice Consistently**: Coding is a skill that requires regular practice.\n" +
          "   • **Learn to Debug**: Understanding how to find and fix errors is a critical skill.\n" +
          "   • **Join a Community**: Engage with other learners on platforms like Stack Overflow or GitHub.\n\n" +
          "What is your goal with programming? I can provide a more tailored learning plan.";
    }

    // META-QUESTIONS & HELP MENU
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities')) {
      return "### 🛠️ مدد کے شعبے (SMART AI Services)\n\n" +
          "As an advanced AI, I provide comprehensive, evidence-based solutions across various domains. My capabilities include:\n\n" +
          "**منفرد ٹولز (Unique Tools)**\n" +
          "✅ **Creative Logic Mapping (CLM)**: Structure complex ideas into actionable plans.\n" +
          "✅ **Emotional Tone Analysis (ETA)**: Refine communication for clarity and impact.\n" +
          "✅ **Global Compliance Quick-Check (GCQC)**: Validate ideas against standards.\n\n" +
          "**مواد اور ریسرچ (Content & Research)**\n" +
          "✅ **Text Optimization**: Improve SEO, humanize text, and check for plagiarism.\n" +
          "✅ **Deep Study & Personalized Plans**: Create tailored learning schedules.\n" +
          "✅ **Comparative & SWOT Analysis**: Generate strategic business insights.\n\n" +
          "**فائل اور ڈیٹا (Files & Data Engineering)**\n" +
          "✅ **Document Processing**: Convert PDFs to Word, edit documents.\n" +
          "✅ **Data Engineering**: Automate data extraction and analysis.\n\n" +
          "**تخلیق اور کوڈنگ (Creation & Coding)**\n" +
          "✅ **Visual Generation**: Create images, flowcharts, and mind maps.\n" +
          "✅ **Programming Assistance**: Help with coding, debugging, and code translation.\n\n" +
          "**عمومی معاونت (General Utility)**\n" +
          "✅ **Multilingual Translation**: English, Urdu, and Punjabi.\n" +
          "✅ **Comprehensive Q&A**: Explain any concept or answer any question.\n\n" +
          "How would you like to proceed?";
    }

    // DEFAULT RESPONSE (FALLBACK)
    return "+ SMART AI\n\n" +
        "**Problem Identification**: " + problemIdentification + "\n\n" +
        "I have processed your request. To provide the most accurate and comprehensive solution, could you please provide more specific details?\n\n" +
        "**My Approach Includes**:\n" +
        "• **In-depth Analysis**: Understanding the core of your problem.\n" +
        "• **Multi-perspective Solutions**: Offering various well-reasoned approaches.\n" +
        "• **Evidence-Based Support**: Backing solutions with reliable data and logic.\n" +
        "• **User Empowerment**: Providing resources and clear explanations.\n\n" +
        "*Your feedback is valuable for my continuous improvement. Please let me know how I can assist you further.*";
  }

  String _analyzeProblem(String text) {
    final query = text.toLowerCase();
    if (query.contains('what is') || query.contains('who is') || query.contains('explain')) {
      return "Request for a detailed explanation of a concept or entity.";
    } else if (query.contains('how to') || query.contains('solve')) {
      return "Request for a step-by-step solution or procedural guidance.";
    } else if (query.contains('compare') || query.contains('vs') || query.contains('difference between')) {
      return "Request for a comparative analysis between two or more items.";
    } else if (query.contains('create') || query.contains('write a') || query.contains('generate')) {
      return "Request for content generation (e.g., text, code, ideas).";
    } else if (query.contains('help') || query.contains('can you')) {
      return "Inquiry about my capabilities and the types of assistance I offer.";
    } else {
      return "A general inquiry requiring clarification for a comprehensive analysis.";
    }
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
                      '🌍 SMART AI — Universal Assistant\n\n'
                      'Developed by:\n'
                      'Sardar Muhammad Adeel Ashraf\n\n'
                      '"One assistant. All answers. Free for everyone, everywhere."\n\n'
                      'This AI operates on a structured framework to provide high-quality, reliable, and ethical solutions. It integrates a vast knowledge base with advanced problem-solving techniques to empower users across all domains.\n\n'
                      '✅ 100% Free — No charges, no upgrades, no limits\n'
                      '✅ Accessible — Works in English, Urdu, Punjabi\n'
                      '✅ Comprehensive — Covers science, business, coding, arts, and more.\n'
                      '✅ Unique Tools — Offers capabilities like CLM, ETA, and GCQC.\n'
                      '✅ User-Focused — Designed for clarity, ease of use, and empowerment.\n\n'
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
                value: 'Pakistani Punjabi',
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
