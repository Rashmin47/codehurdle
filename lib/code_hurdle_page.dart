import 'package:codehurdle/codele_view.dart';
import 'package:codehurdle/hurdle_provider.dart';
import 'package:codehurdle/keyboard_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CodeHurdlePage extends StatefulWidget {
  const CodeHurdlePage({super.key});

  @override
  State<CodeHurdlePage> createState() => _CodeHurdlePageState();
}

class _CodeHurdlePageState extends State<CodeHurdlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Code Hurdle')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Consumer<HurdleProvider>(
                  builder: (BuildContext context, provider, child) =>
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: provider.hurdleBoard.length,
                        itemBuilder: (context, index) {
                          final codele = provider.hurdleBoard[index];
                          return CodeleView(codele: codele);
                        },
                      ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedLetters,
                onPressed: (value) {
                  provider.inputLetter(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        provider.deleteLetter();
                      },
                      child: Text('DELETE'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!provider.isAValidWord) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Not a word in my dictionary'),
                            ),
                          );
                          return;
                        }
                      },
                      child: Text('SUBMIT'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }
}
