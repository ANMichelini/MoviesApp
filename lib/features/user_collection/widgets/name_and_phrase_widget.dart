import 'package:flutter/material.dart';

import '../../../shared_preferences.dart/preferences.dart';

class NameAndPhraseWidget extends StatefulWidget {
  const NameAndPhraseWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<NameAndPhraseWidget> createState() => _NameAndPhraseWidgetState();
}

class _NameAndPhraseWidgetState extends State<NameAndPhraseWidget> {
  @override
  Widget build(BuildContext context) {
    final preferences = Preferences();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Text(
              preferences.username.split('').first.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: Preferences.phrase,
            onChanged: (value) {
              Preferences.phrase = value;
              setState(() {});
            },
            autofocus: false,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.white,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontStyle: FontStyle.italic, overflow: TextOverflow.ellipsis),
            autocorrect: false,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              border: InputBorder.none,
              alignLabelWithHint: true,
              hintText: '"Life imitates art far more than art imitates life."',
              hintStyle:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          Divider(
            height: 2,
            color: Colors.grey[700],
            thickness: 1,
          )
        ],
      ),
    );
  }
}
