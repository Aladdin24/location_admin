import 'package:flutter/material.dart';
import 'package:location_app/widget/specific_card.dart';
import 'utils/utils.dart';

class TypeVoiture extends StatelessWidget {



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
                onPressed: null,
                icon: Icon(Icons.bookmark,
                    size: 30, color: Theme
                        .of(context)
                        .accentColor)),
            IconButton(onPressed: null, icon: Icon(Icons.share, size: 30)),
          ],
        ),

      );
    }
  }