import 'package:benchmark_estimate/utils/constants/MySize.dart';
import 'package:benchmark_estimate/utils/constants/colors.dart';
import 'package:benchmark_estimate/utils/constants/textStyles.dart';
import 'package:benchmark_estimate/view/account_settings/account_settings_view.dart';
import 'package:benchmark_estimate/view/create_project/create_project_view.dart';
import 'package:benchmark_estimate/view/notifications/notification_view.dart';
import 'package:benchmark_estimate/view/project_status/project_submitted.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/image_path.dart';
import '../../utils/custom_widgets/reusable_container.dart';
import '../project_status/wait_for_delivery.dart';
import '../project_status/wait_for_quote.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProjectView()));
        },
        shape: const CircleBorder(), // Ensures the FAB is circular
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'Home',
          style: AppTextStyles.label14600ATC,
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AccountSettingsView()));
          },
          child: Padding(
            padding: EdgeInsets.all(MySize.size20),
            child: SvgPicture.asset(menu),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationView()));
              },
              icon: Icon(
                Icons.notifications,
                color: blackColor,
              ))
        ],
      ),
      body: Column(
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
                    spreadRadius: 2)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              MySize.size20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 85.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: const Color(0xFFDEE3EA),
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'In Progress',
                        style: AppTextStyles.label12500PTC,
                      )),
                    ),
                    SizedBox(
                      width: MySize.size12,
                    ),
                    Container(
                      width: 85.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: const Color(0xFFDEE3EA),
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Completed',
                        style: AppTextStyles.label12500PTC,
                      )),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size25),
                SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Projects').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Center(child: Icon(Icons.error));
                        }else if(snapshot.hasData){
                          if(snapshot.data!.docs.length > 0){
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var snap = snapshot.data!.docs[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ProjectReusableContainer(
                                      height: MySize.size90,
                                      projectName: snapshot.data!.docs[index]['projectName'],
                                      expiryDate:snap['deadLine'].toDate().toString().replaceRange(11, 23, '') ,
                                      statusText: snap['status'],
                                      textColor: snap['status'] == 'Wait for quote' ? blueDark : snap['status'] == 'Wait for delivery' ? greenDark : yellowDark,
                                      bgColor: snap['status'] == 'Wait for quote' ? blueLight : snap['status'] == 'Wait for delivery' ? greenLight : yellowLight,
                                      borderColor: snap['status'] == 'Wait for quote' ? blueDark : snap['status'] == 'Wait for delivery' ? greenDark : yellowDark,
                                      ontap: () {
                                        snap['status'] == 'Wait for quote'?
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectSubmittedView(docId: snap.id,))):
                                        snap['status'] == 'Wait for delivery'?
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> WaitForQuoteView()))
                                            :
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                        WaitForDeliveryView()))
                                        ;
                                      },
                                    ),
                                  );
                                });
                          }else{
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(noOrders),
                                  SizedBox(height: MySize.size20,),
                                  Text('No Project Found', style: AppTextStyles.label14600P,),
                                ],
                              ),
                            );
                          }
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }else{
                          return Container();
                        }
                      }),
                ),

                // SizedBox(height: MySize.size25),

                // ProjectReusableContainer( height: MySize.size90,
                //   projectName: 'Project Name',
                //   expiryDate: '21-2-24',
                //   statusText: 'Wait for quote',
                //   textColor: blueDark,
                //   bgColor: blueLight,
                //   borderColor: blueDark,
                //   ontap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=> WaitForQuoteView()));
                //
                //   },
                //
                // ),
                // SizedBox(height: MySize.size25),
                //
                // ProjectReusableContainer( height: MySize.size90,
                //   projectName: 'Project Name',
                //   expiryDate: '21-2-24',
                //   statusText: 'Waiting for Delivery',
                //   textColor: greenDark,
                //   bgColor: greenLight,
                //   borderColor: greenDark,
                //   ontap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=> WaitForDeliveryView()));
                //   },
                //
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
