import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tourism/model/common_model.dart';

class SwiperWidget extends StatefulWidget {
  final List<CommonModel> bannerList;
  final double height;
  SwiperWidget({@required this.bannerList, this.height = 160});

  _SwiperWidgetState createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Swiper(
        itemCount: widget.bannerList?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // NavigatorUtil.push();
            },
            child: Image.network(
              widget.bannerList[index]?.icon,
              fit: BoxFit.fill,
            )
          );
        },
        pagination: SwiperPagination(),
        viewportFraction: 1,
        scale: 0.5,
      ),
    );
  }
}
