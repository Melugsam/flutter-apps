import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String content;
  final int color;
  final String createdTime;

  const NoteTile(
      {super.key,
      required this.title,
      required this.content,
      required this.color,
      required this.createdTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(color),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 4,),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(createdTime),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(144, 149, 161, 1),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String formatTime(String createdTime) => createdTime.substring(0, 5);
}
