import 'package:benchmark_estimate/utils/constants/image_path.dart';
import 'package:benchmark_estimate/utils/custom_widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/MySize.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/textStyles.dart';
import '../chat_screen/chat_screen_view.dart';

class WaitForQuoteView extends StatelessWidget {
  const WaitForQuoteView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Project Status',
          style: AppTextStyles.label14600ATC,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body:  SingleChildScrollView(
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
            SizedBox(
              height: MySize.screenHeight >700 ? MySize.screenHeight * 0.74: MySize.screenHeight * 0.77,
              child: Padding(
                padding: kIsWeb
                    ? EdgeInsets.symmetric(
                    vertical: MySize.size20, horizontal: MySize.screenWidth * 0.2)
                    : EdgeInsets.all(MySize.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(statusComplete),
                            SizedBox(height: MySize.size30,),
                            const Text('Project Submitted',style: AppTextStyles.label12600B ,)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(statusHalf),
                            SizedBox(height: MySize.size30,),
                            const Text('Wait for quote',style: AppTextStyles.label12600B ,)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(statusZero),
                            SizedBox(height: MySize.size30,),
                            const Text('Wait for Delivery',style: AppTextStyles.label12600B ,)
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: MySize.size30,
                    ),
                    const Text('Quotation Received', style: AppTextStyles.label14700B,),
                    SizedBox(
                      height: MySize.size12,
                    ),
                    const Text('Lorem Ipsum is simply dummy text of the printing and type setting industry.'
                        ' Lorem Ipsum is simply dummy text of the printing.', style: AppTextStyles.label14500BTC,),
                    SizedBox(
                      height: MySize.size20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount', style: AppTextStyles.label14700B,),
                        Text('\$500', style: AppTextStyles.label14700P,),
                      ],
                    ),
                    SizedBox(
                      height: MySize.size22,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date', style: AppTextStyles.label14700B,),
                        Text('13 May 2024', style: AppTextStyles.label14400BTC,),
                      ],
                    ),
                    SizedBox(
                      height: MySize.size22,
                    ),
                    Container(
                      // width: MySize.size100,
                      // height: 21.0,
                      decoration: BoxDecoration(
                        color: yellowLight,
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: yellowDark,
                          width: 1.0,
                        ),),
                      child: Padding(
                        padding:  EdgeInsets.all( MySize.size10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning, size: MySize.size20,color: yellowDark,),
                            SizedBox(width: MySize.size10,),
                            Text('Pay your payment to proceed to the next step.', style:   AppTextStyles.label12500YD),
                          ],
                        ),
                      ),),
                    

                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: kIsWeb
            ? EdgeInsets.symmetric(
            vertical: MySize.size20, horizontal: MySize.screenWidth * 0.2)
            : EdgeInsets.all(MySize.size20),
        child: FloatingActionButton(
            shape: CircleBorder(          ),
            backgroundColor: primaryColor,
            child:SvgPicture.asset(message),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
            }),
      ),
      bottomNavigationBar: Padding(
        padding: kIsWeb
            ? EdgeInsets.symmetric(
            vertical: MySize.size20, horizontal: MySize.screenWidth * 0.2)
            : EdgeInsets.all(MySize.size20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBorderedButton(
                width:kIsWeb ? MySize.scaleFactorWidth * 100:MySize.scaleFactorWidth * 160,
                height: MySize.size50,
                text: 'Preview',
                onPressed: (){
                  Navigator.of(context).pop();
                }),
            CustomButton8(text: 'Pay', onPressed: (){},
              width:kIsWeb ? MySize.scaleFactorWidth * 100:MySize.scaleFactorWidth * 160,
              height: MySize.size50,)
          ],
        ),
      ),
    );
  }
}
