import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ServiceMode extends StatelessWidget {
  const ServiceMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new LayoutBuilder(builder: (context, constraint) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.yellowAccent,
                      size: constraint.biggest.height / 3,
                    ),
                    AutoSizeText(
                      "Service Mode Enabled",
                      minFontSize: 28,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
