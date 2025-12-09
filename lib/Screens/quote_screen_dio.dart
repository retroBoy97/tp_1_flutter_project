import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/quote.dart';

class QuoteScreenDio extends StatefulWidget {
  const QuoteScreenDio({super.key});

  @override
  State<QuoteScreenDio> createState() => _QuoteScreenDioState();
}

class _QuoteScreenDioState extends State<QuoteScreenDio> {
  static const address = 'https://zenquotes.io/api/random';
  Quote? _quote;
  bool _isLoading = false;
  final Dio _dio = Dio();

  Future<Quote> _fetchQuote() async {
    try {
      final response = await _dio.get(address);

      if (response.statusCode == 200) {
        final List quoteJson = response.data;
        Quote quote = Quote.fromJson(quoteJson[0]);
        return quote;
      } else {
        return Quote(text: 'Error retrieving quote', author: '');
      }
    } catch (e) {
      return Quote(text: 'Error: $e', author: '');
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
        title: const Text('Quote with Dio'),
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
                        const Text(
                          'Using Dio',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
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

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }
}
