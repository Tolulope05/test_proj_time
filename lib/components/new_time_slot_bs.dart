import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_proj_time/model/business_hour_model.dart';
import 'package:test_proj_time/utils/app_colors.dart';

import '../view_models/business_hour_vm.dart';

class NewTimeSlotBS extends StatelessWidget {
  const NewTimeSlotBS({super.key, required this.businnessHr});
  final BusinessHourModel businnessHr;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessHourController>(
        builder: (businessHourController) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(flex: 4, child: SizedBox()),
                  Text(
                    'Add Time Slot',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: grey10,
                      fontSize: 18.sp,
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: primary100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected Days',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19.sp,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.loose(Size(1.sw, 40.h)),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              businessHourController.toggleDaysInBusinesshour(
                                  businnessHr,
                                  businessHourController.days[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: businnessHr.days!.contains(
                                        businessHourController.days[index])
                                    ? primaryLight
                                    : grey3,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: businnessHr.days!.contains(
                                          businessHourController.days[index])
                                      ? primaryColor
                                      : grey4,
                                  width: 1.w,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                businessHourController.days[index]
                                    .substring(0, 3),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                  color: businnessHr.days!.contains(
                                          businessHourController.days[index])
                                      ? primaryColor
                                      : grey7,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 5.w);
                        },
                        itemCount: businessHourController.days.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: whiteColor,
                  backgroundColor: primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () {},
                child: const Center(
                  child: Text("Add Time Slot"),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      );
    });
  }
}
