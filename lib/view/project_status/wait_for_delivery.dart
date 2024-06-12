import 'package:benchmark_estimate/utils/constants/image_path.dart';
import 'package:benchmark_estimate/utils/custom_widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/MySize.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/textStyles.dart';
import '../../view_model/provider/file_picker_provider.dart';
import '../chat_screen/chat_screen_view.dart';

class WaitForDeliveryView extends StatelessWidget {
  const WaitForDeliveryView({super.key});

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
            Padding(
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
                          SvgPicture.asset(statusComplete),
                          SizedBox(height: MySize.size30,),
                          const Text('Wait for quote',style: AppTextStyles.label12600B ,)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(statusHalf),
                          SizedBox(height: MySize.size30,),
                          const Text('Wait for Delivery',style: AppTextStyles.label12600B ,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MySize.size30,
                  ),
                  const Text('Change Request', style: AppTextStyles.label14700B,),
                  SizedBox(
                    height: MySize.size12,
                  ),
                  const Text('Lorem Ipsum is simply dummy text of the printing and type setting industry.'
                      ' Lorem Ipsum is simply dummy text of the printing.', style: AppTextStyles.label14500BTC,),
                  SizedBox(
                    height: MySize.size20,
                  ),

                  Consumer<FilePickerProvider>(builder: (context, filePickerProvider, child){
                    if (kIsWeb) {
                      return Wrap(
                        children: filePickerProvider.webFiles.map((file) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(uFile),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: MySize.size80,
                                      child: Text(
                                        file.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 2,
                                child: InkWell(
                                  onTap: () {
                                    filePickerProvider.removeWebFile(file);
                                  },
                                  child: SvgPicture.asset(close, width: 20, height: 20,),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    } else {
                      return Wrap(
                        children: filePickerProvider.files.map((file) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(uFile),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: MySize.size80,
                                      child: Text(
                                        file.path.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 2,
                                top: 2,
                                child: InkWell(
                                  onTap: () {
                                    filePickerProvider.removeFile(file);
                                  },
                                  child: SvgPicture.asset(close, width: 20, height: 20,),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }
                  })

                ],
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
                height: 50,
                text: 'Change Request',
                onPressed: (){
                  Navigator.of(context).pop();
                }),
            CustomButton8(text: 'Mark Completed', onPressed: (){
              showCustomDialog(context);
            },
              width:kIsWeb ? MySize.scaleFactorWidth * 100:MySize.scaleFactorWidth * 160,
              height: 50,)
          ],
        ),
      ),
    );
  }
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              width: MySize.size335,
              // height: 392,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    projectCreated, // Replace with your image URL
                    width: MySize.size120,
                    height: MySize.size120,
                  ),
                  SizedBox(height: MySize.size10),
                  Text(
                    'Confirmation',
                    style: TextStyle(
                        fontSize: MySize.size20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: MySize.size8),
                  Text(
                    'Would you like to Complete this Project?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: MySize.size16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      CustomBorderedButton(
                          width:120,
                          height: 40,
                          text: 'Cancel',
                          onPressed: (){
                            Navigator.of(context).pop();
                          }),
                      CustomButton8(
                        width:120,
                        height: 40,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Yes',
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
