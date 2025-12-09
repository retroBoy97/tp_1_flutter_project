import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/quote.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const address = 'https://zenquotes.io/api/random';
  Quote? _quote;
  bool _isLoading = false;

  Future<Quote> _fetchQuote() async {
    final Uri url = Uri.parse(address);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List quoteJson = json.decode(response.body);
      Quote quote = Quote.fromJSON(quoteJson[0]);
      return quote;
    } else {
      return Quote(text: 'Error retrieving quote', author: '');
    }
  }

  void _loadQuote() async {
    setState(() {
      _isLoading = true;
    });

    final quote = await _fetchQuote();

    setState(() {
      _quote = quote;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote of the Day'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: _isLoading
              ? const CircularProgressIndicator()
              : _quote != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '"${_quote!.text}"',
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '- ${_quote!.author}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _loadQuote,
                          child: const Text('Get New Quote'),
                        ),
                      ],
                    )
                  : const Text('No quote available'),
        ),
      ),
    );
  }
}
