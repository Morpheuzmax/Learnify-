import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
// Make sure you run: flutter pub add flutter_markdown
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // Your API Key
  static const String _apiKey = 'AIzaSyAhOnV6LqDDX3W0z8ADaKs2V3ntEv15q1I';

  late final GenerativeModel _model;
  late final ChatSession _chat;
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Using 'gemini-flash-latest' to avoid quota errors on free tier
    _model = GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: _apiKey,
    );
    _chat = _model.startChat();
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
    });
  }

  Future<void> _sendMessage() async {
    final message = _textController.text;
    if (message.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });

    _textController.clear();
    _scrollToBottom();

    try {
      String fullPrompt = message;
      // Inject personality and formatting instructions on the first message
      if (_messages.length == 1) {
        fullPrompt = "You are Clippy, a helpful and friendly Chemistry Tutor assistant. "
            "You should be encouraging and slightly quirky. "
            "IMPORTANT: Do not use LaTeX formatting, MathJax, or code blocks. "
            "Write chemical formulas in plain text (e.g. use 'H2O' or 'C=O'). "
            "Use standard bullet points. "
            "Use bold text for key chemistry terms. "
            "Only answer Chemistry questions. "
            "Student asks: $message";
      }

      final content = Content.text(fullPrompt);
      final responseMessage = ChatMessage(text: "", isUser: false);

      setState(() {
        _messages.add(responseMessage);
      });

      final stream = _chat.sendMessageStream(content);

      await for (final response in stream) {
        final textChunk = response.text;
        if (textChunk != null) {
          setState(() {
            _messages.last.text += textChunk;
          });
          _scrollToBottom();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.last.text = "Error: $e";
          _messages.last.isError = true;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ask Clippy"),
        backgroundColor: const Color(0xFFD50000),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: _clearChat,
            tooltip: "Clear History",
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildWelcomeScreen()
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Clippy is writing...",
                  style: TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Ask about Chemistry...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFFD50000),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Stack(
      children: [
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi! I'm Clippy!",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 8),
              Text(
                "I'm hanging out up here.\nAsk me anything about Chemistry!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 20,
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/clippy3.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.smart_toy, size: 80, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 4),
              child: const Icon(Icons.smart_toy, size: 20, color: Colors.grey),
            ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: msg.isError
                    ? Colors.red[100]
                    : msg.isUser
                    ? const Color(0xFFD50000)
                    : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft:
                  msg.isUser ? const Radius.circular(16) : Radius.zero,
                  bottomRight:
                  msg.isUser ? Radius.zero : const Radius.circular(16),
                ),
                boxShadow: [
                  if (!msg.isUser)
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                ],
                border: !msg.isUser
                    ? Border.all(color: Colors.grey.shade200)
                    : null,
              ),
              // Using MarkdownBody for real bold text
              child: MarkdownBody(
                data: msg.text,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(
                    color: msg.isUser ? Colors.white : Colors.black87,
                    fontSize: 16,
                  ),
                  strong: TextStyle( // "strong" means Bold
                    color: msg.isUser ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String text;
  final bool isUser;
  bool isError;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
  });
}