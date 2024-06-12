import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants/MySize.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/textStyles.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text('Notification', style: AppTextStyles.label14600ATC,),
        centerTitle: true,
        automaticallyImplyLeading: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 0.5,
              decoration: const BoxDecoration(
                color: secondaryColor,

                boxShadow: [
                  BoxShadow(
                    // offset: Offset(3 , 3),
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 2
                  )
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: MySize.size20),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                    return Column(
                      children: [
                        Container(
                          color: index == 0? appColor: whiteColor,
                          width: MySize.screenWidth,
                          child: Padding(
                            padding:  EdgeInsets.all(MySize.size24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: MySize.screenWidth*0.7,
                                  child: Text('Shely has requested the Loan at urgent bases 4626876374',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: AppTextStyles.label14600ATC,),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('2m',  style: AppTextStyles.label12400BTC,),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: MySize.screenWidth *0.7,
                            height: 1,
                            color: Color(0xffE2E8F0),
                          ),
                        ),

                      ],
                    );
                  })

                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
