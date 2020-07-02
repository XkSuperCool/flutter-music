import 'package:flutter/cupertino.dart';
import 'package:flutter_music/extension/num_extension.dart';

class DiscoveryTitle extends StatelessWidget {
  final String title;
  final Widget rightBtn;

  DiscoveryTitle(this.title, { this.rightBtn });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 5.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: TextStyle(
            color: Color.fromRGBO(50, 50, 52, 1),
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
          // TODO： 如果没有传递 rightBtn，那下面 Container 就不显示了
          rightBtn != null ? Container(
            padding: EdgeInsets.symmetric(vertical: 2.px, horizontal: 10.px),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(228, 228, 228, 1)),
              borderRadius: BorderRadius.circular(100.px)
            ),
            child: rightBtn,
          ) : SizedBox()
        ],
      ),
    );
  }
}