import 'package:get/get.dart';
import 'package:test_proj_time/model/business_hour_model.dart';

class BusinessHourController extends GetxController {
  List<String> headers = [
    "Descriptions",
    "Business Hours",
    "Closed on",
    "Gallery",
    "Location",
    "Contact Us",
    "Social Media",
  ];

  String selectedHeader = "Descriptions";

  void changeHeader(String header) {
    selectedHeader = header;
    update();
  }

  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<String> selectedDays = [];

  List<String> guestPerHourList = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  final List<BusinessHourModel> _businessHourModel = [
    BusinessHourModel(
      closeHours: "20:00",
      days: ["Monday", "Tuesday", "Thursday", "Friday"],
      guestPerHour: "5",
      openHours: "08:00",
      timeslots: [
        Timeslot(
          scheduleName: "Morning",
          slots: [
            Slot(
              startTime: "08:00",
              endTime: "09:00",
            ),
            Slot(
              startTime: "09:00",
              endTime: "10:00",
            ),
          ],
        )
      ],
    )
  ];

  List<BusinessHourModel> get businessHourModel => _businessHourModel;

  void addBusinessHourModel(BusinessHourModel businessHourModel) {
    _businessHourModel.add(businessHourModel);
    update();
  }

  void toggleDaysInBusinesshour(
      BusinessHourModel businessHourModel, String day) {
    if (businessHourModel.days!.contains(day)) {
      businessHourModel.days!.remove(day);
    } else {
      businessHourModel.days!.add(day);
    }
    update();
  }

  void changeGuestPerHour(
      BusinessHourModel businessHourModel, String guestPerHour) {
    businessHourModel.guestPerHour = guestPerHour;
    update();
  }

  void changeOpenHours(BusinessHourModel businessHourModel, String openHours) {
    businessHourModel.openHours = openHours;
    update();
  }

  void changeCloseHours(
      BusinessHourModel businessHourModel, String closeHours) {
    businessHourModel.closeHours = closeHours;
    update();
  }

  void changeScheduleName(BusinessHourModel businessHourModel, Timeslot shift,
      String scheduleName, String? newScheduleName) {
    businessHourModel.timeslots!
        .firstWhere((element) => element.scheduleName == shift.scheduleName)
        .scheduleName = newScheduleName;
    update();
  }

  void changeScheduleSlotStartTime(BusinessHourModel businessHourModel,
      Timeslot shift, Slot slot, String? startTime) {
    businessHourModel.timeslots!
        .firstWhere((element) => element.scheduleName == shift.scheduleName)
        .slots!
        .firstWhere((element) => element == slot)
        .startTime = startTime;
    update();
  }

  void changeScheduleSlotEndTime(BusinessHourModel businessHourModel,
      Timeslot shift, Slot slot, String? endTime) {
    businessHourModel.timeslots!
        .firstWhere((element) => element.scheduleName == shift.scheduleName)
        .slots!
        .firstWhere((element) => element == slot)
        .endTime = endTime;
    update();
  }

  void addNewShift(BusinessHourModel businessHourModel) {
    // businessHourModel.timeslots!.add(shift); can use this, but i want to add new shift without having to edit the start time and end time
    businessHourModel.timeslots!.add(Timeslot(
      scheduleName: 'New Shift',
      slots: [
        Slot(
          startTime: "00:00",
          endTime: "00:00",
        ),
      ],
    ));
    update();
  }

  void addNewTimeSlot(BusinessHourModel businessHourModel, Timeslot shift) {
    businessHourModel.timeslots!
        .firstWhere((element) => element.scheduleName == shift.scheduleName)
        .slots!
        .add(
          Slot(
            startTime: "00:00",
            endTime: "00:00",
          ),
        );
    update();
  }
}

/**
 * The GetX library is a state management library that is easy to use and has a very small footprint.
 * SAMPLE DATA :
 * [
	{
		"close_hours": "20:00",
		"days": [
			"Monday",
			"Tuesday",
			"Wednesday",
			"Thursday",
			"Friday"
		],
		"guest_per_hour": "5",
		"open_hours": "08:00",
		"timeslots": [
			{
				"schedule_name": "Breakfast",
				"slots": [
					{
						"start_time": "08:00",
						"end_time": "09:00"
					}
				]
			}
		]
	}
]
 */
