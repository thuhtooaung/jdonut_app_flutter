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

  @override
  State<LoginDateScreen> createState() => _LoginDateScreenState();
}

class _LoginDateScreenState extends State<LoginDateScreen> {
  final _dayController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();

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
    final date = DateTime.now();
    _dayController.text = date.day.toString();
    _yearController.text = date.year.toString();
    _monthController.text = FormatUtils.formatMonthName(date);
    super.initState();
  }

  @override
  void dispose() {
    _monthController.dispose();
    _dayController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
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
                "What's your\nname?",
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

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.go(Routes.main);
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

