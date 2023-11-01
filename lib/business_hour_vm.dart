import 'package:get/get.dart';
import 'package:test_proj_time/business_hour_model.dart';

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
          scheduleName: "Breakfast",
          slots: [
            Slot(
              startTime: "08:00",
              endTime: "09:00",
            )
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
