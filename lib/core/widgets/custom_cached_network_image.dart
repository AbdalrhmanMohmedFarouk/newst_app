import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, this.height,this.width, required this.imagePath});
final double? height;
final double? width ;
final String imagePath ;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      width:width ?? 140,
      height:height ?? 80,
      placeholder: (context, url) =>
          Shimmer.fromColors( baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100,child: Container(
            height:height ?? 80,
            width: width ?? 140,
            color: Colors.white,
          ),),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
    );
  }
}
