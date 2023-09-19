import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note.dart';

class newNode extends StatefulWidget {

  final Function(Note) onSave;
  newNode({required this.onSave});

  @override
  State<newNode> createState() => _newNodeState();
  
}

class _newNodeState extends State<newNode> {
  
  late Function(Note) onSave;

  final TextEditingController _headerEditingController =
      TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  
  bool _headerIsInputInProgress = false;
  bool _isInputInProgress = false;
  String header = "";
  String text = "";
  late String date;

  String getFormattedDate() {
    String day = DateTime.now().day.toString().padLeft(2, '0');
    String month = DateTime.now().month.toString().padLeft(2, '0');
    String year = DateTime.now().year.toString();
    String hour = DateTime.now().hour.toString().padLeft(2, '0');
    String minute = DateTime.now().minute.toString().padLeft(2, '0');

    return "$day.$month.$year $hour:$minute";
  }
  
  @override
  void initState() {
    super.initState();
    
    date = getFormattedDate();
    onSave = widget.onSave;
    _headerEditingController.addListener(_headerOnTextChanged);
    _textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _headerEditingController.dispose();
    super.dispose();
  }

  void _headerOnTextChanged() {
    setState(() {
      _headerIsInputInProgress = _headerEditingController.text.isNotEmpty;
      header = _headerEditingController.text.isNotEmpty
          ? _headerEditingController.text
          : "";
    });
  }

  void _onTextChanged() {
    setState(() {
      _isInputInProgress = _textEditingController.text.isNotEmpty;
      text = _textEditingController.text.isNotEmpty
          ? _textEditingController.text
          : "";
    });
  }

  void saveNote() async {
    // Проверка, что строка header не пустая и содержит хотя бы 1 символ
    if (RegExp(r"^\S").hasMatch(header) || RegExp(r"^\S").hasMatch(text)) {
      Note note = Note(header: header, text: text, date: date);
      onSave(note);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: Icon(Icons.check, color: Theme.of(context).colorScheme.onSurface),
                  onPressed: saveNote,
                  color: Theme.of(context).colorScheme.onSurface,
                  iconSize: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _headerEditingController,
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: _headerIsInputInProgress ? '' : 'Заголовок',
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                    ),
                    labelText: _isInputInProgress ? '' : 'Введите текст',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
