import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:menahub/Util/Widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

Widget reviewCard({BuildContext context, Map reviewDetails}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                height: 25,
                width: 25,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        0,0, 0, 0),
                    child: Image(
                      image: AssetImage('assets/user.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  reviewDetails["nickname"],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),

          sizedBoxheight10,
          SmoothStarRating(
            allowHalfRating: true,
            isReadOnly: true,
            starCount: 5,
            rating: double.parse(
                reviewDetails["rating_votes"][0]["value"]),
            size: 18.0,
            color: Colors.red,
            borderColor: Colors.red,
            spacing: 0.0,
          ),
          SmoothStarRating(
            allowHalfRating: true,
            isReadOnly: true,
            starCount: 5,
            rating: double.parse(
                reviewDetails["rating_votes"][1]["value"]),
            size: 18.0,
            color: Colors.red,
            borderColor: Colors.red,
            spacing: 0.0,
          ),
          SmoothStarRating(
            allowHalfRating: true,
            isReadOnly: true,
            starCount: 5,
            rating: double.parse(
                reviewDetails["rating_votes"][2]["value"]),
            size: 18.0,
            color: Colors.red,
            borderColor: Colors.red,
            spacing: 0.0,
          ),
          SmoothStarRating(
            allowHalfRating: true,
            isReadOnly: true,
            starCount: 5,
            rating: double.parse(
                reviewDetails["rating_votes"][3]["value"]),
            size: 18.0,
            color: Colors.red,
            borderColor: Colors.red,
            spacing: 0.0,
          ),
          sizedBoxheight5,

          Text(
            reviewDetails["title"],
            style: TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
          sizedBoxheight5,
          Text(
            DateFormat('dd/MM/yyyy').format(
                DateFormat('yyyy-MM-dd HH:mm:ss')
                    .parse(reviewDetails["created_at"])),
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
            textAlign: TextAlign.left,
          ),
          sizedBoxheight5,

          Text(
            reviewDetails["detail"],
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
          Divider(
            thickness: 2,
          )
        ],
      ),
    ),
  );
}
