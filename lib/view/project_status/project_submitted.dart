import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/MySize.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/textStyles.dart';
import '../../utils/constants/image_path.dart';
import '../../utils/custom_widgets/reusable_container.dart';
import 'package:benchmark_estimate/view_model/provider/file_picker_provider.dart';

class ProjectSubmittedView extends StatelessWidget {
  final String docId;

  ProjectSubmittedView({super.key, required this.docId});

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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Projects').doc(docId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found'));
          } else {
            var projectData = snapshot.data!.data() as Map<String, dynamic>;
            String date = projectData['deadLine'].toDate().toString().replaceRange(11, 23, '');
            String details = projectData['message'];

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2,
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
                                SvgPicture.asset(statusHalf),
                                SizedBox(height: MySize.size30),
                                const Text('Project Submitted', style: AppTextStyles.label12600B),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(statusZero),
                                SizedBox(height: MySize.size30),
                                const Text('Wait for quote', style: AppTextStyles.label12600B),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(statusZero),
                                SizedBox(height: MySize.size30),
                                const Text('Wait for Delivery', style: AppTextStyles.label12600B),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.size30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Project Details', style: AppTextStyles.label14700B),
                            Text(date, style: AppTextStyles.label14400BTC),
                          ],
                        ),
                        SizedBox(height: MySize.size20),
                        AccountReusableContainer(
                          height: MySize.size50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Project Category 1', style: AppTextStyles.label13500BTC),
                              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: bodyTextColor),
                            ],
                          ),
                          ontap: () {
                            _showModalBottomSheet(context);
                          },
                        ),
                        SizedBox(height: MySize.size20),
                        AccountReusableContainer(
                          height: MySize.size50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Project Category 2', style: AppTextStyles.label13500BTC),
                              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: bodyTextColor),
                            ],
                          ),
                          ontap: () {
                            _showModalBottomSheet(context);
                          },
                        ),
                        SizedBox(height: MySize.size20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFFDEE3EA),
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(MySize.size10),
                            child: Center(
                              child: Text(
                                details,
                                style: AppTextStyles.label12500BTC,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MySize.size20),
                        Wrap(
                          children: projectData['fileUrls'].map<Widget>((file) {
                            return Container(
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
                                      file,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  List<String> modalOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
  ];

  List<bool> selectedOptions = [true, true, true];

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(modalOptions.length, (index) {
                    return CheckboxListTile(
                      title: Text(modalOptions[index]),
                      value: selectedOptions[index],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedOptions[index] = value!;
                        });
                      },
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
