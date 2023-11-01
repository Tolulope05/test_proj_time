import 'package:flutter/cupertino.dart';
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
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time Slot',
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
                              businessHourController.addNewShift(businnessHr);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add),
                                SizedBox(width: 5.w),
                                const Text("Add new shift"),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(1.sw, 500.h)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, shiftIndex) {
                            Timeslot shift = businnessHr.timeslots![shiftIndex];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Schedule Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                TextField(
                                  controller: TextEditingController(
                                      text: shift.scheduleName),
                                  onSubmitted: (value) {
                                    businessHourController.changeScheduleName(
                                      businnessHr,
                                      shift,
                                      shift.scheduleName!,
                                      value,
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Morning',
                                    hintStyle: TextStyle(
                                      color: greyTextInput,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                        color: grey4,
                                        width: 1.w,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                        color: grey4,
                                        width: 1.w,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 1.w,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                ConstrainedBox(
                                  constraints:
                                      BoxConstraints.loose(Size(1.sw, 200.h)),
                                  child: ListView.separated(
                                      itemCount: shift.slots!.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                      itemBuilder: (context, slotIndex) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Slot - ${slotIndex + 1}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.sp,
                                                color: grey7,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 50.h,
                                                    maxWidth: 150.w,
                                                  ),
                                                  child: TextField(
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 5.h),
                                                      hintText: '10:30 am',
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp,
                                                        color: grey7,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        borderSide: BorderSide(
                                                          color: grey3,
                                                          width: 1.w,
                                                        ),
                                                      ),
                                                      suffixIcon: InkWell(
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                              constraints:
                                                                  BoxConstraints
                                                                      .loose(
                                                                Size(1.sw,
                                                                    0.5.sh),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.w),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Row(
                                                                    // mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      const Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            SizedBox(),
                                                                      ),
                                                                      Text(
                                                                        'Select Open Time',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              grey10,
                                                                          fontSize:
                                                                              24.sp,
                                                                        ),
                                                                      ),
                                                                      const Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            SizedBox(),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              grey10,
                                                                          size:
                                                                              24.r,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  Divider(
                                                                    color:
                                                                        grey3,
                                                                    thickness:
                                                                        1.w,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  Flexible(
                                                                    child:
                                                                        CupertinoTheme(
                                                                      data:
                                                                          CupertinoThemeData(
                                                                        textTheme:
                                                                            CupertinoTextThemeData(
                                                                          dateTimePickerTextStyle:
                                                                              TextStyle(color: blackColor),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          CupertinoDatePicker(
                                                                        onDateTimeChanged:
                                                                            (DateTime
                                                                                d) {
                                                                          //  businnessHr.timeslots![shiftIndex].slots![slotIndex].startTime = d.toString().substring(11, 16);
                                                                          businessHourController
                                                                              .changeScheduleSlotStartTime(
                                                                            businnessHr,
                                                                            shift,
                                                                            shift.slots![slotIndex],
                                                                            d.toString().substring(11,
                                                                                16),
                                                                          );
                                                                        },
                                                                        minimumDate:
                                                                            DateTime.now(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style:
                                                                        ButtonStyle(
                                                                      padding:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                          horizontal:
                                                                              20.w,
                                                                          vertical:
                                                                              16.h,
                                                                        ),
                                                                      ),
                                                                      foregroundColor:
                                                                          MaterialStateProperty.all(
                                                                              whiteColor),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              primaryColor),
                                                                    ),
                                                                    child:
                                                                        const Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            'Select Time'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Icon(
                                                            Icons.access_time),
                                                      ),
                                                    ),
                                                    controller:
                                                        TextEditingController(
                                                            text: shift
                                                                .slots![
                                                                    slotIndex]
                                                                .startTime!),
                                                  ),
                                                ),
                                                Text(
                                                  'to',
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
                                                    readOnly: true,
                                                    controller:
                                                        TextEditingController(
                                                            text: shift
                                                                .slots![
                                                                    slotIndex]
                                                                .endTime!),
                                                    decoration: InputDecoration(
                                                      suffixIcon: InkWell(
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                              constraints:
                                                                  BoxConstraints
                                                                      .loose(
                                                                Size(1.sw,
                                                                    0.5.sh),
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.w),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Row(
                                                                    // mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      const Expanded(
                                                                        flex: 3,
                                                                        child:
                                                                            SizedBox(),
                                                                      ),
                                                                      Text(
                                                                        'Select Open Time',
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              grey10,
                                                                          fontSize:
                                                                              24.sp,
                                                                        ),
                                                                      ),
                                                                      const Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            SizedBox(),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              grey10,
                                                                          size:
                                                                              24.r,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  Divider(
                                                                    color:
                                                                        grey3,
                                                                    thickness:
                                                                        1.w,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  Flexible(
                                                                    child:
                                                                        CupertinoTheme(
                                                                      data:
                                                                          CupertinoThemeData(
                                                                        textTheme:
                                                                            CupertinoTextThemeData(
                                                                          dateTimePickerTextStyle:
                                                                              TextStyle(color: blackColor),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          CupertinoDatePicker(
                                                                        onDateTimeChanged:
                                                                            (DateTime
                                                                                d) {
                                                                          //  businnessHr.timeslots![shiftIndex].slots![slotIndex].startTime = d.toString().substring(11, 16);
                                                                          businessHourController
                                                                              .changeScheduleSlotEndTime(
                                                                            businnessHr,
                                                                            shift,
                                                                            shift.slots![slotIndex],
                                                                            d.toString().substring(11,
                                                                                16),
                                                                          );
                                                                        },
                                                                        minimumDate:
                                                                            DateTime.now(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          12.h),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style:
                                                                        ButtonStyle(
                                                                      padding:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        EdgeInsets
                                                                            .symmetric(
                                                                          horizontal:
                                                                              20.w,
                                                                          vertical:
                                                                              16.h,
                                                                        ),
                                                                      ),
                                                                      foregroundColor:
                                                                          MaterialStateProperty.all(
                                                                              whiteColor),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(
                                                                              primaryColor),
                                                                    ),
                                                                    child:
                                                                        const Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            'Select Time'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Icon(
                                                            Icons.access_time),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 5.h),
                                                      hintText: '10:30 am',
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.sp,
                                                        color: grey7,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
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
                                        );
                                      }),
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: blackColor,
                                    ),
                                    onPressed: () async {
                                      businessHourController.addNewTimeSlot(
                                        businnessHr,
                                        shift,
                                      );
                                    },
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add),
                                        SizedBox(width: 5.w),
                                        const Text("Add new slot"),
                                      ],
                                    )),
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(height: 20.h),
                          itemCount: businnessHr.timeslots!.length),
                    )
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
