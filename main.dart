import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(XtremeApp());

class XtremeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xtreme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: XtremeHome(),
    );
  }
}

class XtremeHome extends StatefulWidget {
  @override
  _XtremeHomeState createState() => _XtremeHomeState();
}

class _XtremeHomeState extends State<XtremeHome> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';
  String _selectedMode = 'Banana';

  final List<String> _modes = [
    'Banana',
    'Alternate Caps',
    'Monospace',
    'CHIPKU',
    'Echo',
  ];

  void _convertText() {
    final input = _controller.text;
    String result = '';

    switch (_selectedMode) {
      case 'Banana':
        result = input
            .split('')
            .map((c) => c.toUpperCase() + c.toLowerCase())
            .join(' ');
        break;
      case 'Alternate Caps':
        result = input
            .split('')
            .asMap()
            .map((i, c) => MapEntry(i, i % 2 == 0 ? c.toUpperCase() : c.toLowerCase()))
            .values
            .join();
        break;
      case 'Monospace':
        result = input.split('').join(' ').toUpperCase();
        break;
      case 'CHIPKU':
        result = input
            .split('')
            .map((c) => c + c)
            .join()
            .toUpperCase();
        break;
      case 'Echo':
        result = input
            .split('')
            .map((c) => c.toUpperCase() + c.toUpperCase())
            .join(' ');
        break;
    }

    setState(() {
      _output = result;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _output));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xtreme Text Styler'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your text',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedMode,
              items: _modes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  _selectedMode = val!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertText,
              child: Text('Stylize Text'),
            ),
            SizedBox(height: 16),
            SelectableText(
              _output,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _copyToClipboard,
              child: Text('Copy to Clipboard'),
            ),
          ],
        ),
      ),
    );
  }
}