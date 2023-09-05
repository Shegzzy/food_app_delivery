import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width15),
      // alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15-5)
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress
            ),
            suggestionsCallback: (String pattern) {  },
            itemBuilder: (BuildContext context, itemData) {  },
            onSuggestionSelected: (Object? suggestion) {  },

          )
        ),
      ),
    );
  }
}
