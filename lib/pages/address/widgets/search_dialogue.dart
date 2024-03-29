import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:get/get.dart';

import '../../../widgets/small_text.dart';

class SearchDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width15+5),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15-5)
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            width: Dimensions.screenWidth,
            height: Dimensions.height45,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                autofocus: true,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText:  'search location',
                  hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.font18-3
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                    borderSide: const BorderSide(
                      style: BorderStyle.none,
                      width: 0
                    )
                  )
                )
              ),
              suggestionsCallback: (pattern) async {
                return await locationController.locationSearch(context, pattern);
              },
              itemBuilder: (context, Prediction suggestion) {
                return Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_sharp),
                      Expanded(child: Text(
                        suggestion.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: Dimensions.font18-3
                        ),
                        )
                      )
                    ],
                  ),
                );
              },
              onSuggestionSelected: (Prediction suggestion) {
                locationController.selectedPlace(suggestion.placeId!, suggestion.description!, mapController);
                Get.back();
              },

            )
          ),
        ),
      ),
    );
  }
}
