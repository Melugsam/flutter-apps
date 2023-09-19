import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeListener.dart';

class settingsBar extends StatefulWidget {
  const settingsBar({super.key});

  @override
  State<settingsBar> createState() => _settingsBarState();
}

class _settingsBarState extends State<settingsBar> {
  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<themeListener>(context);
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Настройки',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Темная тема'),
              trailing: Switch(
                value: appSettings.darkTheme,
                onChanged: (value) {
                  appSettings.darkTheme = value;
                  print(value);
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // Закрываем диалог при нажатии кнопки "Готово"
              },
              child: Text(
                'Готово',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
