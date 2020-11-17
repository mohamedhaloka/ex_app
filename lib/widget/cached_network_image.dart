import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../const.dart';

Widget cachedNetworkImage({imgSrc, width, height}) {
  return CachedNetworkImage(
    imageUrl: "$imgSrc",
    placeholder: (context, url) => SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: accentColor,
        highlightColor: subAccentColor,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage("$imgSrc"), fit: BoxFit.cover)),
        ),
      ),
    ),
    imageBuilder: (context, builder) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          image: DecorationImage(
              image: NetworkImage("$imgSrc"), fit: BoxFit.cover)),
    ),
    errorWidget: (context, url, error) => Container(),
  );
}
