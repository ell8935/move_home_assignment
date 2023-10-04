import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RangeDatePicker extends StatefulWidget {
  final void Function(String from, String to) onChanged;

  const RangeDatePicker({Key? key, required this.onChanged}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _RangeDatePickerState createState() => _RangeDatePickerState();
}

class _RangeDatePickerState extends State<RangeDatePicker> {
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
          onPressed: () async {
            final DateTimeRange? dateTimeRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));
            if (dateTimeRange != null) {
              // BlocProvider.of<FiltersBloc>(context).add(LoadFilters(
              //   from: DateFormat('yyyy-MM-dd').format(selectedDates.start),
              //   to: DateFormat('yyyy-MM-dd').format(selectedDates.end),
              // ));
              widget.onChanged(
                DateFormat('yyyy-MM-dd').format(dateTimeRange.start),
                DateFormat('yyyy-MM-dd').format(dateTimeRange.end),
              );
            }
          },
          child: const Text('Date'),
        )
      ]),
    );
  }
}
