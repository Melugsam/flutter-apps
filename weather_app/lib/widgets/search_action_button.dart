import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/search_model.dart';

class SearchActionButton extends StatefulWidget {
  final BuildContext prevContext;

  const SearchActionButton({required this.prevContext, super.key});

  @override
  State<SearchActionButton> createState() => _SearchActionButtonState();
}

class _SearchActionButtonState extends State<SearchActionButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearchDialog(widget.prevContext); // Передаем context функции
      },
      icon: Icon(Icons.search),
    );
  }

  void showSearchDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final searchModel = Provider.of<SearchModel>(context);

        return AlertDialog(
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Название города',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            ),
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              setState(() {
                searchModel.searchResult = value;
                print(searchModel.searchResult);
              });
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text("Отмена"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(padding: EdgeInsetsDirectional.all(8.0)),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text("Поиск"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
