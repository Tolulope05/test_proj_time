import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'components/new_time_slot_bs.dart';
import 'utils/app_colors.dart';
import 'model/business_hour_model.dart';
import 'view_models/business_hour_vm.dart';

class BusineshourScreen extends StatelessWidget {
  const BusineshourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BusinessHourController businessHourController =
        Get.put(BusinessHourController());

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Business Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            GetBuilder<BusinessHourController>(
                init: businessHourController,
                builder: (controller) {
                  return ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(1.sw, 40.h)),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.changeHeader(controller.headers[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: controller.selectedHeader ==
                                      controller.headers[index]
                                  ? primaryColor
                                  : whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: grey3,
                                width: 1.w,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              controller.headers[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: controller.selectedHeader ==
                                        controller.headers[index]
                                    ? whiteColor
                                    : grey7,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 5.w);
                      },
                      itemCount: controller.headers.length,
                    ),
                  );
                }),
            Divider(color: grey3, thickness: 1.w),
            Text(
              'Business Hour',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: TextEditingController(),
              readOnly: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                hintText: 'Jamuna Furniture park - Branch',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: grey7,
                ),
                prefixIcon: Icon(
                  Icons.pin_drop_outlined,
                  color: primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: grey3,
                    width: 1.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Divider(color: grey3, thickness: 1.w),
            SizedBox(height: 10.h),
            Expanded(
              child: GetBuilder<BusinessHourController>(
                  builder: (businessHourController) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, branchIndex) {
                    BusinessHourModel businnessHr =
                        businessHourController.businessHourModel[branchIndex];
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: grey4),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Days',
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
                                    businessHourController
                                        .toggleDaysInBusinesshour(businnessHr,
                                            businessHourController.days[index]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      color: businnessHr.days!.contains(
                                              businessHourController
                                                  .days[index])
                                          ? primaryLight
                                          : grey3,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: businnessHr.days!.contains(
                                                businessHourController
                                                    .days[index])
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
                                                businessHourController
                                                    .days[index])
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
                          SizedBox(height: 20.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Times',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.sp,
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: blackColor,
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    constraints: BoxConstraints.loose(
                                      Size(1.sw, 0.9.sh),
                                    ),
                                    builder: (context) => NewTimeSlotBS(
                                      businnessHr: businnessHr,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.add),
                                    SizedBox(width: 5.w),
                                    const Text("Add time slot"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Open',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: grey7,
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 50.h,
                                      maxWidth: 150.w,
                                    ),
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: businnessHr.openHours),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        hintText: '10:30 am',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                          color: grey7,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            await showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Container(
                                                constraints:
                                                    BoxConstraints.loose(
                                                  Size(1.sw, 0.5.sh),
                                                ),
                                                padding: EdgeInsets.all(20.w),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Expanded(
                                                          flex: 3,
                                                          child: SizedBox(),
                                                        ),
                                                        Text(
                                                          'Select Open Time',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: grey10,
                                                            fontSize: 24.sp,
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 2,
                                                          child: SizedBox(),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                            color: grey10,
                                                            size: 24.r,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    Divider(
                                                      color: grey3,
                                                      thickness: 1.w,
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    Flexible(
                                                      child: CupertinoTheme(
                                                        data:
                                                            CupertinoThemeData(
                                                          textTheme:
                                                              CupertinoTextThemeData(
                                                            dateTimePickerTextStyle:
                                                                TextStyle(
                                                                    color:
                                                                        blackColor),
                                                          ),
                                                        ),
                                                        child:
                                                            CupertinoDatePicker(
                                                          onDateTimeChanged:
                                                              (DateTime d) {
                                                            log(d.toString());
                                                            businessHourController
                                                                .changeOpenHours(
                                                                    businnessHr,
                                                                    d
                                                                        .toString()
                                                                        .substring(
                                                                          11,
                                                                          16,
                                                                        ));
                                                          },
                                                          minimumDate:
                                                              DateTime.now(),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ButtonStyle(
                                                        padding:
                                                            MaterialStateProperty
                                                                .all(
                                                          EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                            vertical: 16.h,
                                                          ),
                                                        ),
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    whiteColor),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                                    primaryColor),
                                                      ),
                                                      child: const Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('Select Time'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(Icons.access_time),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            color: grey3,
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('TO'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Close',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      color: grey7,
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 50.h,
                                      maxWidth: 150.w,
                                    ),
                                    child: TextField(
                                      controller: TextEditingController(),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 5.h),
                                        hintText: businnessHr.closeHours,
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                          color: grey7,
                                        ),
                                        suffixIcon: GestureDetector(
                                            onTap: () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                builder: (context) => Container(
                                                  constraints:
                                                      BoxConstraints.loose(
                                                    Size(1.sw, 0.5.sh),
                                                  ),
                                                  padding: EdgeInsets.all(20.w),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        // mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const Expanded(
                                                            flex: 3,
                                                            child: SizedBox(),
                                                          ),
                                                          Text(
                                                            'Select Close Time',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: grey10,
                                                              fontSize: 24.sp,
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            flex: 2,
                                                            child: SizedBox(),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color: grey10,
                                                              size: 24.r,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 12.h),
                                                      Divider(
                                                        color: grey3,
                                                        thickness: 1.w,
                                                      ),
                                                      SizedBox(height: 12.h),
                                                      Flexible(
                                                        child: CupertinoTheme(
                                                          data:
                                                              CupertinoThemeData(
                                                            textTheme:
                                                                CupertinoTextThemeData(
                                                              dateTimePickerTextStyle:
                                                                  TextStyle(
                                                                      color:
                                                                          blackColor),
                                                            ),
                                                          ),
                                                          child:
                                                              CupertinoDatePicker(
                                                            onDateTimeChanged:
                                                                (DateTime d) {
                                                              log(d.toString());
                                                              businessHourController
                                                                  .changeCloseHours(
                                                                      businnessHr,
                                                                      d
                                                                          .toString()
                                                                          .substring(
                                                                            11,
                                                                            16,
                                                                          ));
                                                            },
                                                            minimumDate:
                                                                DateTime.now(),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 12.h),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(
                                                            EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20.w,
                                                              vertical: 16.h,
                                                            ),
                                                          ),
                                                          foregroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      whiteColor),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      primaryColor),
                                                        ),
                                                        child: const Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('Select Time'),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            child:
                                                const Icon(Icons.access_time)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          borderSide: BorderSide(
                                            color: grey3,
                                            width: 1.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Per Hour Booking Allow',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          TextField(
                            controller: TextEditingController(
                                text: '${businnessHr.guestPerHour} Guest'),
                            readOnly: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              hintText: '5 Guest',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                                color: grey7,
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Select Guest Per Hour'),
                                          backgroundColor: Colors.white,
                                          content: SizedBox(
                                            height: 200.h,
                                            width: 200.w,
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    businessHourController
                                                        .changeGuestPerHour(
                                                      businnessHr,
                                                      businessHourController
                                                              .guestPerHourList[
                                                          index],
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 5.h),
                                                    decoration: BoxDecoration(
                                                      color: businessHourController
                                                                      .guestPerHourList[
                                                                  index] ==
                                                              businnessHr
                                                                  .guestPerHour
                                                          ? primaryLight
                                                          : grey3,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                      border: Border.all(
                                                        color: businessHourController
                                                                        .guestPerHourList[
                                                                    index] ==
                                                                businnessHr
                                                                    .guestPerHour
                                                            ? primaryColor
                                                            : grey4,
                                                        width: 1.w,
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      '${businessHourController.guestPerHourList[index]} Guests',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp,
                                                        color: businessHourController
                                                                        .guestPerHourList[
                                                                    index] ==
                                                                businnessHr
                                                                    .guestPerHour
                                                            ? primaryColor
                                                            : grey7,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                    width: 5.w, height: 5.h);
                                              },
                                              itemCount: businessHourController
                                                  .guestPerHourList.length,
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(
                                  color: grey3,
                                  width: 1.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      Divider(color: grey3, thickness: 1.w),
                  itemCount: businessHourController.businessHourModel.length,
                );
              }),
            ),
            Divider(color: grey3, thickness: 1.w),
            Center(
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blackColor,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    businessHourController.addBusinessHourModel();
                  },
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      const Icon(Icons.add),
                      SizedBox(width: 10.w),
                      const Text("Add Other Time"),
                    ],
                  )),
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
                onPressed: () {
                  businessHourController.updateProfile();
                },
                child: const Center(
                  child: Text("Update Profile"),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
