import 'package:flutter/material.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:rfid77workflow/features/activity_evaluation/components/labeled_field.dart';

class LabeledDropdownButtonWithSearch<T> extends StatelessWidget {
  const LabeledDropdownButtonWithSearch({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.widthModifier = 0.222,
    this.shouldWrapInCard = false,
    this.searchController,
    this.isError = false,
  });

  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final double widthModifier;
  final T? selectedValue;
  final TextEditingController? searchController;
  final void Function(T?)? onChanged;
  final bool shouldWrapInCard;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey;
    if (selectedValue != null) {
      borderColor = const Color.fromARGB(255, 58, 173, 61);
    } else if (isError) {
      borderColor = const Color.fromARGB(255, 255, 0, 0);
    }

    final Size size = MediaQuery.of(context).size;

    return LabeledField(
      labelText: labelText,
      shouldWrapInCard: shouldWrapInCard,
      widthModifier: widthModifier,
      isRequired: true,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          dropdownSearchData: dropdownSearchData(),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                width: 1.4,
                color: Colors.grey[300]!,
              ),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            width: size.width * widthModifier,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.8,
                color: borderColor,
              ),
            ),
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              hintText,
            ),
          ),
          enableFeedback: true,
          items: items,
          disabledHint: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Brak dostępnych opcji'),
          ),
          value: selectedValue,
          onChanged: onChanged,
          onMenuStateChange: (isOpen) {
            if (searchController != null && !isOpen) {
              searchController!.clear();
            }
          },
        ),
      ),
    );
  }

  DropdownSearchData<T> dropdownSearchData() {
    return DropdownSearchData(
      searchController: searchController ?? SearchController(),
      searchInnerWidget: searchController != null
          ? Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
          : null,
      // searchMatchFn: (item, searchValue) {
      //   // return item.value!.name.toLowerCase().contains(
      //   //       searchValue.toLowerCase(),
      //   //     );
      // },
    );
  }
}
