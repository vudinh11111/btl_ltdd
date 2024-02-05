import 'package:btl/changenotifer/changenotifier.dart';
import 'package:flutter/material.dart';

import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';

class MultiDropdown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MultiDropdown();
}

final MultiSelectController _controller1 = MultiSelectController();

class _MultiDropdown extends State<MultiDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: MultiSelectDropDown(
              hint: "Giá",
              showClearIcon: true,
              controller: _controller1,
              onOptionSelected: (options) {
                if (options.isNotEmpty) {
                  if (options[0].value == '1') {
                    context.read<Seacher_image>().ChangetuThap();
                  } else if (options[0].value == '2') {
                    context.read<Seacher_image>().ChangetuCao();
                  }
                } else {
                  context.read<Seacher_image>().Changebegin();
                }
              },
              options: const <ValueItem>[
                ValueItem(label: 'Từ thấp đến cao', value: '1'),
                ValueItem(label: 'Từ cao đến thấp', value: '2'),
              ],
              selectionType: SelectionType.single,
              chipConfig: const ChipConfig(wrapType: WrapType.wrap),
              dropdownHeight: 100,
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(Icons.check_circle),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //context.read<Seacher_image>().Changebegin();
    _controller1.clearAllSelection();
    super.dispose();
  }
}
