import FLAccidents_eCrash;
layout_time_location := doxie_crs.layout_FSR_time_location;
layout_accident_char := doxie_crs.layout_FSR_accident_char;
layout_vehicle := doxie_crs.layout_FSR_vehicle;
layout_driver := doxie_crs.layout_FSR_driver;
layout_passenger := doxie_crs.layout_FSR_passenger;
layout_pedestrian := doxie_crs.layout_FSR_pedestrian;

export layout_FLCrash_Search_Records := record, maxlength(200000)
	string40 accident_nbr := '';
	string2 accident_state := '';
  dataset(layout_time_location) flcrash_time_location;
	dataset(layout_accident_char) flcrash_accident_char;
  dataset(Layout_vehicle) flcrash_vehicle;
	dataset(recordof(FLAccidents_eCrash.Key_eCrash3v)) flcrash_towed_trailer_vehicle;
  dataset(Layout_Driver) flcrash_driver;
	dataset(Layout_Passenger) flcrash_passenger;
	dataset(Layout_Pedestrian) flcrash_pedestrian;
	dataset(recordof(FLAccidents_eCrash.Key_eCrash7)) flcrash_property;
end;
