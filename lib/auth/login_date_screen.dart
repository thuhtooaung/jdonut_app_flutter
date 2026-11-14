import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jdonut_app_flutter/auth/widgets/auth_top_bar_widget.dart';
import 'package:jdonut_app_flutter/routing/routes.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';
import 'package:jdonut_app_flutter/utils/format_utils.dart';
import 'package:jdonut_app_flutter/widgets/accept_aggrement_widget.dart';

class LoginDateScreen extends StatefulWidget {
  const LoginDateScreen({super.key});

  static const int minAge = 13;

  @override
  State<LoginDateScreen> createState() => _LoginDateScreenState();
}

class _LoginDateScreenState extends State<LoginDateScreen> {
  final _dayController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();

  String? _dateError;

  static const List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    final now = DateTime.now();
    final defaultDate = DateTime(now.year - LoginDateScreen.minAge, now.month, now.day);
    _dayController.text = defaultDate.day.toString();
    _yearController.text = defaultDate.year.toString();
    _monthController.text = FormatUtils.formatMonthName(defaultDate);
    super.initState();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  int _getDaysInMonth(int year, int month) {
    if (month < 1 || month > 12) return 0;
    final List<int> days = [
      31,
      _isLeapYear(year) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];
    return days[month - 1];
  }

  int _getMonthIndex(String monthName) {
    final index = _monthNames.indexOf(monthName);
    return index != -1 ? index + 1 : 1;
  }

  void _validateAndAdjustDay() {
    final year = int.tryParse(_yearController.text) ?? DateTime.now().year;
    final month = _getMonthIndex(_monthController.text);
    final maxDays = _getDaysInMonth(year, month);
    final currentDay = int.tryParse(_dayController.text) ?? 1;

    if (currentDay > maxDays) {
      _dayController.text = maxDays.toString();
    }
  }

  String? _validateDate() {
    final year = int.tryParse(_yearController.text);
    final month = _getMonthIndex(_monthController.text);
    final day = int.tryParse(_dayController.text);

    if (year == null || day == null) {
      return 'Please select a valid date';
    }

    final maxDays = _getDaysInMonth(year, month);
    if (day < 1 || day > maxDays) {
      return 'Invalid calendar date';
    }

    final selectedDate = DateTime(year, month, day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (selectedDate.isAfter(today)) {
      return 'Date cannot be in the future';
    }

    int age = today.year - selectedDate.year;
    if (today.month < selectedDate.month ||
        (today.month == selectedDate.month && today.day < selectedDate.day)) {
      age--;
    }

    if (age < LoginDateScreen.minAge) {
      return 'You must be at least ${LoginDateScreen.minAge} years old';
    }

    return null;
  }

  void _showMonthPicker() {
    final currentMonth = _monthController.text;
    int selectedIndex = _monthNames.indexOf(currentMonth);
    if (selectedIndex == -1) selectedIndex = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 280,
          child: Column(
            children: [
              _buildPickerHeader(
                title: 'Select Month',
                onDone: () {
                  setState(() {
                    _monthController.text = _monthNames[selectedIndex];
                    _validateAndAdjustDay();
                    _dateError = _validateDate();
                  });
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  onSelectedItemChanged: (index) {
                    selectedIndex = index;
                  },
                  children: _monthNames.map((month) {
                    return Center(
                      child: Text(
                        month,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: AppTypo.generalSans,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDayPicker() {
    final year = int.tryParse(_yearController.text) ?? DateTime.now().year;
    final month = _getMonthIndex(_monthController.text);
    final maxDays = _getDaysInMonth(year, month);

    final currentDay = int.tryParse(_dayController.text) ?? 1;
    int selectedIndex = (currentDay.clamp(1, maxDays)) - 1;

    final days = List.generate(maxDays, (index) => index + 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 280,
          child: Column(
            children: [
              _buildPickerHeader(
                title: 'Select Day',
                onDone: () {
                  setState(() {
                    _dayController.text = days[selectedIndex].toString();
                    _dateError = _validateDate();
                  });
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  onSelectedItemChanged: (index) {
                    selectedIndex = index;
                  },
                  children: days.map((day) {
                    return Center(
                      child: Text(
                        day.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: AppTypo.generalSans,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showYearPicker() {
    final currentYearVal = DateTime.now().year;
    const startYear = 1900;
    final endYear = currentYearVal + 50;
    final years =
        List.generate(endYear - startYear + 1, (index) => startYear + index);

    final currentSelectedYear =
        int.tryParse(_yearController.text) ?? currentYearVal;
    int selectedIndex = years.indexOf(currentSelectedYear);
    if (selectedIndex == -1) {
      selectedIndex = years.indexOf(currentYearVal);
      if (selectedIndex == -1) selectedIndex = 0;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: 280,
          child: Column(
            children: [
              _buildPickerHeader(
                title: 'Select Year',
                onDone: () {
                  setState(() {
                    _yearController.text = years[selectedIndex].toString();
                    _validateAndAdjustDay();
                    _dateError = _validateDate();
                  });
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: selectedIndex,
                  ),
                  onSelectedItemChanged: (index) {
                    selectedIndex = index;
                  },
                  children: years.map((year) {
                    return Center(
                      child: Text(
                        year.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: AppTypo.generalSans,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPickerHeader({
    required String title,
    required VoidCallback onDone,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: AppTypo.generalSans,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppTypo.menco,
            ),
          ),
          TextButton(
            onPressed: onDone,
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4AC3E2),
                fontFamily: AppTypo.generalSans,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFF7F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTopBarWidget(progress: 1),
              const SizedBox(height: 32),
              const Text(
                "When's your\nbirthday?",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: AppTypo.menco,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _monthController,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppTypo.generalSans,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: _showMonthPicker,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _dayController,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppTypo.generalSans,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: _showDayPicker,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _yearController,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: AppTypo.generalSans,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: _showYearPicker,
              ),

              if (_dateError != null) ...[
                const SizedBox(height: 12),
                Text(
                  _dateError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: AppTypo.generalSans,
                  ),
                ),
              ],

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    final error = _validateDate();
                    if (error == null) {
                      context.go(Routes.main);
                    } else {
                      setState(() {
                        _dateError = error;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFF4AC3E2),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: AppTypo.menco,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              AcceptAgreementWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

