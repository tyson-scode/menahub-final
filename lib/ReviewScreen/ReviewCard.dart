import 'package:flutter/material.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget reviewCard({BuildContext context, Map reviewDetails}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6zes53m4a_2VLTcmTn_bHk8NO5SkuWfcQbg&usqp=CAU"),
                      ),
                    ),
                    sizedBoxwidth10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewDetails["nickname"],
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          sizedBoxheight5,
                          Text(
                            "2 weeks ago",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          sizedBoxheight5,
                          Text(
                            reviewDetails["title"],
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SmoothStarRating(
                allowHalfRating: true,
                isReadOnly: true,
                starCount: 5,
                rating: 4,
                size: 18.0,
                color: Colors.red,
                borderColor: Colors.red,
                spacing: 0.0,
              ),
            ],
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    ),
  );
}
