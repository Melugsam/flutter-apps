import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/theme_bloc.dart';

class SettingsActionButton extends StatefulWidget {
  final BuildContext prevContext;
  const SettingsActionButton({required this.prevContext, super.key});

  @override
  State<SettingsActionButton> createState() => _SettingsActionButtonState();
}

class _SettingsActionButtonState extends State<SettingsActionButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showSettingsDialog(widget.prevContext);
        },
        icon: Icon(Icons.settings));
  }

  showSettingsDialog(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'Настройки',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
             ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Темная тема'),
              trailing: Switch(
                value: themeBloc.state.value,
                  onChanged: (newValue) {
                    themeBloc.add(ThemeSwitchEvent.toggle);
                  },
              ),
            ),
          ]),
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
                    child: Text("Готово"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(padding: EdgeInsetsDirectional.all(8.0)),
              ],
            ),
          ],
        );
      },
    );
  }
}
