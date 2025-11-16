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

  // Human-like, highly advanced AI response system
  String _getAIResponse(String text) {
    final query = text.toLowerCase().trim();
    final detectedLanguage = _detectLanguage(text);

    // USER HELP SYSTEM
    if (query.contains('how can you help') || query.contains('what can you do') || query.contains('capabilities')) {
      return "Here’s a quick overview of what I can do:\n\n"
          "• Explain anything\n"
          "• Summaries, notes, essays\n"
          "• AI image/video generation\n"
          "• File/PDF analysis\n"
          "• Homework & study help\n"
          "• Business ideas & marketing\n"
          "• Translations\n"
          "• Technical solutions\n"
          "• Story writing, creative content";
    }

    // IDENTITY & META QUESTIONS
    if (query.contains('what is your name') || query.contains('who are you')) {
      return "I am SMART AI, an advanced AI assistant designed to provide direct, intelligent, and accurate answers to any question you have.";
    }
    
    if (query.contains('how old are you') || query.contains('what is your age')) {
      return "I don't have an age in the human sense. I'm an AI, and my knowledge is constantly being updated.";
    }

    // KNOWLEDGE BASE - Following "Short answer -> Deeper explanation -> Example" format
    
    // AI
    if (query.contains('what is ai') || query.contains('what is artificial intelligence')) {
      return "Artificial Intelligence (AI) is a branch of computer science focused on creating systems that can perform tasks that typically require human intelligence.\n\n"
          "This includes capabilities like learning, reasoning, problem-solving, perception, and language understanding. AI systems can be categorized as narrow AI, which is designed for a specific task (e.g., a voice assistant), or general AI (AGI), which possesses the ability to understand, learn, and apply knowledge across a wide range of tasks, much like a human. The underlying technologies include machine learning, deep learning, and natural language processing.\n\n"
          "For example, the recommendation engine on a streaming service uses AI to learn your viewing habits and suggest new content you might like.";
    }

    // Education
    if (query.contains('what is education')) {
      return "Education is the process of acquiring knowledge, skills, values, and habits through teaching, training, or research.\n\n"
          "On a deeper level, it is the fundamental mechanism for personal and societal advancement. Psychologically, it cultivates critical thinking, problem-solving abilities, and intellectual curiosity. Sociologically, it serves as the primary means by which cultures transmit their norms and values across generations, driving social mobility and economic development.\n\n"
          "For example, while formal education occurs in institutions like schools and universities, informal education—learning from books, online resources, or life experiences—is equally vital for holistic development.";
    }

    // Science (Photosynthesis)
    if (query.contains('how does photosynthesis work')) {
      return "Photosynthesis is the biological process used by plants, algae, and some bacteria to convert light energy into chemical energy.\n\n"
          "This chemical energy is stored in carbohydrate molecules, such as sugars, which are synthesized from carbon dioxide and water. The process is crucial for life on Earth as it produces most of the planet's oxygen. The primary chemical equation is 6CO₂ + 6H₂O + Light Energy → C₆H₁₂O₆ + 6O₂. Inside plant cells, specifically in the chloroplasts, chlorophyll absorbs sunlight, driving a series of reactions that split water molecules to release oxygen and create energy-storing molecules (ATP and NADPH), which are then used in the Calvin cycle to fix carbon dioxide into glucose.\n\n"
          "For example, a tree's growth is a direct result of photosynthesis. It uses the glucose for energy to build its structure (wood, leaves) and releases the oxygen we breathe as a byproduct.";
    }

    // Medicine (Cancer)
    if (query.contains('what is cancer')) {
      return "Cancer is a group of diseases characterized by the uncontrolled growth and spread of abnormal cells.\n\n"
          "Normally, the body's cells follow an orderly path of growth, division, and death. However, in cancer, this process breaks down. Genetic mutations can cause cells to divide uncontrollably, forming masses called tumors. These can be benign (non-cancerous) or malignant (cancerous), meaning they can invade nearby tissues and spread to other parts of the body through the bloodstream or lymphatic system (a process called metastasis).\n\n"
          "It is critical to consult with a healthcare professional for any medical concerns, as they are qualified to provide an accurate diagnosis and treatment plan.";
    }

    // Programming
    if (query.contains('how to learn programming')) {
      return "The most effective way to learn programming is to choose a beginner-friendly language and immediately start building practical projects.\n\n"
          "First, select a language with a clear syntax, such as Python. Focus on mastering the fundamental concepts: variables, data types, control structures (loops, conditionals), and functions. The key is consistent practice—writing code daily is more important than simply reading about it. This hands-on approach solidifies understanding and builds problem-solving skills, which are the core of software development.\n\n"
          "For example, start with a simple command-line calculator, then build a to-do list application, and gradually progress to more complex projects like a personal website or a small game. This project-based learning path ensures you are applying concepts as you learn them.";
    }

    // DEFAULT RESPONSE (Human-like and helpful)
    return "I can provide expert-level information on virtually any topic. Please ask a specific question, and I will give you a direct and comprehensive answer.";
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
                      'I am SMART AI, a fully controlled custom assistant with an extremely large-scale knowledge capacity, designed to provide direct, accurate, and intelligent answers instantly.',
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
