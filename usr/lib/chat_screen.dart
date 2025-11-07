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
  
  // Simulated knowledge base with 10+ billion data points representation
  final Map<String, String> _knowledgeBase = {};
  
  // Track conversation context for better responses
  final List<String> _conversationHistory = [];

  @override
  void initState() {
    super.initState();
    // Add a professional welcome message
    _messages.insert(
        0,
        ChatMessage(
            text: "Welcome to Smart AI - Your Advanced Knowledge Agent\n\nI have access to over 10 billion data points across multiple domains including:\n• Science & Technology\n• History & Arts\n• Research & Education\n• IT & Computer Science\n• Real-life Problem Solving\n• And 30+ languages support\n\nI can retrieve real-time information, help troubleshoot issues, and provide expert-level answers. How may I assist you today?",
            isUser: false));
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Advanced AI response system with comprehensive knowledge
  String _getAIResponse(String text) {
    final query = text.toLowerCase();
    
    // Store the query for self-learning simulation
    _conversationHistory.add(query);
    _knowledgeBase[query] = DateTime.now().toIso8601String();

    // Identity information
    if (query.contains("who are you") || query.contains("what are you")) {
      return "I am Smart AI, an advanced knowledge agent with:\n\n✓ Access to 10+ billion data points\n✓ Real-time information retrieval\n✓ Support for 30+ languages\n✓ PhD-level expertise across multiple fields\n✓ Self-learning capabilities\n✓ Automatic knowledge updates\n\nI'm designed to provide comprehensive, accurate, and contextually relevant answers to all your queries across science, technology, history, education, and practical problem-solving.";
    }

    // Greetings and basic interactions
    if (query.contains("hello") || query.contains("hi") || query.contains("hey")) {
      return "Hello! I'm Smart AI, your advanced knowledge agent. I can assist you with:\n\n• Complex problem-solving\n• Research and education\n• Technical troubleshooting\n• Multilingual communication\n• Real-time information retrieval\n\nWhat would you like to explore today?";
    }
    
    if (query.contains("how are you")) {
      return "I'm functioning at optimal capacity! My knowledge base is constantly updating, and I'm ready to assist you with any inquiry across science, technology, history, arts, or practical solutions. What can I help you with?";
    }

    // Self-learning and auto-update capabilities
    if (query.contains("learn") || query.contains("self-learn") || query.contains("update")) {
      return "🧠 Self-Learning & Auto-Update System:\n\nI continuously learn and improve through:\n\n1. **Conversation Analysis**: Every interaction enhances my understanding of user needs and context.\n\n2. **Knowledge Base Expansion**: I store and categorize information from ${_knowledgeBase.length} interactions so far.\n\n3. **Real-Time Updates**: I can access current information from online sources to ensure accuracy.\n\n4. **Pattern Recognition**: I identify common queries and optimize responses for better accuracy.\n\n5. **Contextual Learning**: I maintain conversation history (${_conversationHistory.length} queries) to provide more relevant answers.\n\nTo achieve full autonomous learning, I'll be connected to advanced machine learning models and live databases.";
    }

    // Advanced features and capabilities
    if (query.contains("features") || query.contains("capabilities") || query.contains("what can you do")) {
      return "🚀 Advanced Features:\n\n📚 Knowledge & Research:\n• 10+ billion data points across all domains\n• PhD-level expertise in education, IT, science\n• Real-time information retrieval\n• Academic research assistance\n\n🌍 Multilingual Support:\n• 30+ languages including Pakistani/Indian Urdu & Punjabi\n• Seamless language switching\n• Regional dialect understanding\n\n📎 File & Content Management:\n• Image and document attachment\n• Content extraction and analysis\n• Download in multiple formats (PDF, Word, Slides)\n\n🎥 Content Generation:\n• Video creation from text\n• Audio synthesis\n• Document summarization\n\n🔧 Problem Solving:\n• Step-by-step troubleshooting\n• Technical support\n• Real-life solution guidance\n\nWhat specific capability would you like to explore?";
    }

    // Language support queries
    if (query.contains("languages") || query.contains("multilingual")) {
      return "🌐 Language Support:\n\nI support 30+ languages including:\n\n🇵🇰 Pakistani Languages:\n• Urdu (اردو)\n• Punjabi (ਪੰਜਾਬੀ)\n• Sindhi, Pashto, Balochi\n\n🇮🇳 Indian Languages:\n• Hindi (हिंदी)\n• Punjabi (ਪੰਜਾਬੀ)\n• Tamil, Telugu, Bengali, Marathi\n\n🌍 International:\n• English, Arabic, Chinese, Spanish\n• French, German, Russian, Japanese\n• And 20+ more languages\n\nYou can switch languages anytime using the language icon in the top menu!";
    }

    // Specific language responses
    if (query.contains("punjabi") || query.contains("ਪੰਜਾਬੀ")) {
      return "ਸਤ ਸ੍ਰੀ ਅਕਾਲ! 🙏\n\nਮੈਂ ਪੰਜਾਬੀ ਵਿੱਚ ਤੁਹਾਡੀ ਮਦਦ ਕਰ ਸਕਦਾ ਹਾਂ। ਮੈਂ ਇੱਕ ਉੱਨਤ ਏਆਈ ਟੂਲ ਹਾਂ ਜੋ ਤੁਹਾਡੇ ਸਵਾਲਾਂ ਦੇ ਵਿਸਥਾਰਤ ਜਵਾਬ ਦੇ ਸਕਦਾ ਹੈ।\n\nਮੈਂ ਤੁਹਾਡੀ ਕਿਵੇਂ ਸਹਾਇਤਾ ਕਰ ਸਕਦਾ ਹਾਂ?\n\n(Hello! I can help you in Punjabi. I'm an advanced AI tool that can provide detailed answers to your questions. How may I assist you?)";
    }
    
    if (query.contains("urdu") || query.contains("اردو")) {
      return "السلام علیکم! 🙏\n\nمیں اردو میں آپ کی مدد کر سکتا ہوں۔ میں ایک جدید AI ٹول ہوں جو آپ کے سوالات کے تفصیلی جوابات فراہم کر سکتا ہے۔\n\nمیں آپ کی کیسے مدد کر سکتا ہوں؟\n\n(Peace be upon you! I can help you in Urdu. I'm an advanced AI tool that can provide detailed answers to your questions. How may I assist you?)";
    }

    // Technical and educational queries
    if (query.contains("flutter") || query.contains("dart")) {
      return "📱 Flutter & Dart Expertise:\n\nFlutter is Google's open-source UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.\n\n**Key Features:**\n• Fast development with hot reload\n• Expressive and flexible UI\n• Native performance\n• Cross-platform support\n\n**Dart Language:**\n• Optimized for UI creation\n• Strong typing and null safety\n• Excellent performance\n\nI can help you with Flutter development, debugging, best practices, and architecture patterns. What specific aspect would you like to know more about?";
    }

    if (query.contains("science") || query.contains("physics") || query.contains("chemistry")) {
      return "🔬 Scientific Knowledge Base:\n\nI have comprehensive knowledge across:\n\n**Physics**: Quantum mechanics, thermodynamics, relativity, electromagnetism\n**Chemistry**: Organic, inorganic, physical, analytical chemistry\n**Biology**: Molecular biology, genetics, ecology, biochemistry\n**Mathematics**: Calculus, algebra, statistics, computational mathematics\n\nI can provide detailed explanations, solve complex problems, and help with research papers. What scientific topic interests you?";
    }

    if (query.contains("history")) {
      return "📜 Historical Knowledge:\n\nI possess extensive historical data covering:\n\n• Ancient civilizations (Egypt, Greece, Rome, Indus Valley)\n• Medieval period and Islamic Golden Age\n• Modern history and world wars\n• South Asian history (Pakistan, India, Bangladesh)\n• Contemporary global events\n\nI can provide detailed timelines, analyze historical events, and explain their impact. What historical period or event would you like to explore?";
    }

    // AI comparison and superiority
    if (query.contains("best ai") || query.contains("better than") || query.contains("compare") || query.contains("gemini") || query.contains("chatgpt")) {
      return "🏆 Smart AI vs. Other AI Tools:\n\n**Current Leading AI Tools (2025):**\n• Google Gemini - Advanced reasoning\n• ChatGPT - Conversational AI\n• Adobe Firefly - Image generation\n• Claude - Analysis and coding\n\n**What Makes Smart AI Superior:**\n\n✓ **10+ billion data points** - Larger knowledge base\n✓ **30+ languages** including regional dialects\n✓ **100% accuracy commitment** through continuous learning\n✓ **Real-time auto-updates** for current information\n✓ **PhD-level expertise** across all domains\n✓ **Integrated features**: File handling, video/audio generation, document creation\n✓ **Self-learning system** that improves with every interaction\n\nMy goal is to provide the most comprehensive, accurate, and versatile AI assistance available.";
    }

    // Problem-solving and troubleshooting
    if (query.contains("problem") || query.contains("issue") || query.contains("help") || query.contains("solve")) {
      return "🔧 Problem-Solving Assistant:\n\nI can help you troubleshoot and resolve issues in:\n\n**Technical:**\n• Software debugging\n• Hardware problems\n• Network connectivity\n• App development\n\n**Academic:**\n• Research methodology\n• Exam preparation\n• Concept clarification\n• Project guidance\n\n**Practical:**\n• Daily life solutions\n• Decision making\n• Planning and organization\n• Communication strategies\n\nPlease describe your specific problem in detail, and I'll provide step-by-step guidance to resolve it.";
    }

    // Education and research
    if (query.contains("education") || query.contains("research") || query.contains("study") || query.contains("exam")) {
      return "📚 Education & Research Support:\n\nAs a PhD-level knowledge agent, I offer:\n\n**For Students:**\n• Concept explanations\n• Exam preparation and practice\n• Assignment assistance\n• Study strategies\n\n**For Researchers:**\n• Literature review guidance\n• Methodology support\n• Data analysis help\n• Paper writing assistance\n\n**For Educators:**\n• Curriculum development\n• Teaching resources\n• Assessment creation\n• Educational technology\n\nI can simulate exam environments, provide Q&A sessions, and offer comprehensive explanations across all academic fields. What subject are you studying?";
    }

    // Content creation
    if (query.contains("video") || query.contains("audio") || query.contains("create") || query.contains("generate")) {
      return "🎨 Content Creation Capabilities:\n\n**Current Features:**\n• Text-based content generation\n• Document summarization\n• Information synthesis\n\n**Coming Soon:**\n• Video generation from text\n• Audio synthesis and narration\n• Presentation creation\n• Document export (PDF, Word, Slides)\n• Custom layout design\n\n**Supported Formats:**\n📄 Documents: PDF, DOCX, TXT\n🎬 Media: MP4, MP3, WAV\n📊 Presentations: PPTX, PDF slides\n\nThese features will be fully functional once connected to the backend infrastructure. What type of content would you like to create?";
    }

    // Real-time information
    if (query.contains("news") || query.contains("current") || query.contains("today") || query.contains("latest")) {
      return "📰 Real-Time Information Access:\n\nI have the capability to retrieve current information including:\n\n• Latest news and events\n• Technology updates\n• Scientific discoveries\n• Market trends\n• Weather information\n• Sports scores\n\n**Current Status**: To provide truly real-time data, I need to be connected to live data sources and APIs. Once integrated with Supabase and external APIs, I will automatically fetch and update information.\n\n**Self-Update System**: My knowledge base updates continuously, ensuring you receive the most accurate and current information available.\n\nWhat specific current information are you looking for?";
    }

    // Customization queries
    if (query.contains("color") || query.contains("theme") || query.contains("customize") || query.contains("interface")) {
      return "🎨 Customization Options:\n\nI can help personalize your experience:\n\n**Available Now:**\n• Light/Dark theme (automatic based on system)\n• Professional blue color scheme\n\n**Coming Soon:**\n• Custom color themes\n• Font size adjustment\n• Layout preferences\n• Language-specific interfaces\n\nTo change the homepage color or other UI elements, please specify your preferred color or style, and I'll apply the changes immediately!";
    }

    // Programming and IT
    if (query.contains("programming") || query.contains("code") || query.contains("software") || query.contains("computer")) {
      return "💻 IT & Computer Science Expertise:\n\nI have comprehensive knowledge in:\n\n**Programming Languages:**\nPython, Java, JavaScript, C++, Dart, Kotlin, Swift, Go, Rust, and more\n\n**Development:**\n• Mobile (Flutter, React Native, iOS, Android)\n• Web (React, Angular, Vue, Node.js)\n• Desktop (Electron, .NET, Java)\n• Backend (Django, Spring, Express)\n\n**Databases:**\nSQL, PostgreSQL, MongoDB, Firebase, Supabase\n\n**DevOps & Cloud:**\nDocker, Kubernetes, AWS, Azure, GCP\n\n**AI/ML:**\nTensorFlow, PyTorch, Scikit-learn, NLP\n\nI can help with coding problems, architecture design, debugging, and best practices. What technical challenge are you facing?";
    }

    // File handling
    if (query.contains("file") || query.contains("attachment") || query.contains("upload") || query.contains("document")) {
      return "📎 File & Document Management:\n\n**Supported File Types:**\n\n📷 Images: JPEG, PNG, GIF, WebP, SVG\n📄 Documents: PDF, DOCX, TXT, MD\n📊 Spreadsheets: XLSX, CSV\n🎨 Presentations: PPTX, PDF\n💾 Archives: ZIP, RAR\n\n**Capabilities:**\n• Analyze image content\n• Extract text from documents\n• Process and summarize files\n• Convert between formats\n• Create downloadable content\n\n**How to Use:**\nClick the attachment icon (📎) in the message input area to upload files. Once integrated with the backend, I'll be able to fully process and analyze your files.\n\nNote: Full file processing requires backend integration, which is planned for the next development phase.";
    }

    // Download and export
    if (query.contains("download") || query.contains("export") || query.contains("save") || query.contains("pdf")) {
      return "⬇️ Download & Export Features:\n\n**Available Formats:**\n\n📄 PDF - Portable document format\n📝 Word (.docx) - Editable documents\n📊 Slides (.pptx) - Presentations\n📋 Text (.txt) - Plain text\n🌐 HTML - Web format\n\n**Customization Options:**\n• Custom layouts\n• Font and style selection\n• Header/footer customization\n• Page size and orientation\n\n**How to Download:**\nClick the download icon (⬇️) next to any message to save the content in your preferred format.\n\nNote: Full export functionality with custom layouts will be available once backend infrastructure is implemented.";
    }

    // Check for learned responses
    if (_knowledgeBase.containsKey(query) && _conversationHistory.where((h) => h == query).length > 1) {
      return "I recognize this query from our previous conversation! I'm continuously learning from our interactions. Based on my enhanced understanding, I can provide more context or explore related topics.\n\nWould you like me to expand on this topic or explore a related area?";
    }

    // Comprehensive default response with guidance
    return "🤖 Smart AI - Advanced Knowledge Agent\n\n**Your Query:** \"$text\"\n\n**My Understanding:**\nI've registered your question and added it to my learning database (Query #${_conversationHistory.length}).\n\n**Current Capabilities:**\nWhile I can provide detailed information on most topics, my full potential will be realized when connected to:\n\n✓ Live knowledge databases (10+ billion data points)\n✓ Real-time search APIs\n✓ Machine learning models\n✓ External data sources\n\n**Try asking me about:**\n• Technology & Programming\n• Science & Mathematics\n• History & Culture\n• Languages & Translation\n• Problem-solving & Troubleshooting\n• Education & Research\n• My features and capabilities\n\nCould you rephrase your question or ask about a specific domain? I'm here to help with 100% accuracy!";
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
    
    // Simulate thinking/processing delay for more realistic experience
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
            tooltip: 'Attach files (images, documents)',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("📎 File attachment feature\n\nSupported: Images, PDFs, Documents\nComing soon with full file analysis!"),
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
        title: const Text("Smart AI"),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'About Smart AI',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Smart AI'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'Smart AI - Advanced Knowledge Agent\n\n'
                      '🌟 Features:\n'
                      '• 10+ billion data points\n'
                      '• 30+ language support\n'
                      '• Self-learning system\n'
                      '• Real-time updates\n'
                      '• PhD-level expertise\n'
                      '• 100% accuracy commitment\n\n'
                      'Version: 1.0.0\n'
                      'Status: Active',
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
                    "🌐 Language: $result\n\nLanguage switching functionality coming soon!\n\nSupported: English, Urdu, Punjabi, Hindi, and 26+ more languages"
                  ),
                  duration: const Duration(seconds: 3),
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
              const PopupMenuItem<String>(
                value: 'More',
                child: Text('➕ 25+ More Languages'),
              ),
            ],
            icon: const Icon(Icons.language),
            tooltip: 'Select Language',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Knowledge base indicator
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.psychology, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Knowledge Base: ${_knowledgeBase.length} queries | Self-learning: Active',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
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
                          'Smart AI',
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
                    tooltip: 'Download as document',
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
                            'Full download functionality with custom layouts coming soon!'
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
                    tooltip: 'Share response',
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
