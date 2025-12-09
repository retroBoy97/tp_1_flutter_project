import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/quote.dart';
import '../services/quote_api_service.dart';

class QuoteScreenRetrofit extends StatefulWidget {
  const QuoteScreenRetrofit({super.key});

  @override
  State<QuoteScreenRetrofit> createState() => _QuoteScreenRetrofitState();
}

class _QuoteScreenRetrofitState extends State<QuoteScreenRetrofit> {
  Quote? _quote;
  bool _isLoading = false;
  late QuoteApiService _apiService;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    _apiService = QuoteApiService(dio);
    _loadQuote();
  }

  Future<Quote> _fetchQuote() async {
    try {
      final quotes = await _apiService.getRandomQuote();
      if (quotes.isNotEmpty) {
        return quotes[0];
      } else {
        return Quote(text: 'No quote available', author: '');
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote with Retrofit'),
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
                          'Using Retrofit + Dio',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
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
}
