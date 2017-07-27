export VehicleV2Keys := macro
output(choosen(VehicleV2.Key_Vehicle_Main_Key,10));
output(choosen(VehicleV2.Key_Vehicle_Party_Key,10));
output(choosen(vehiclev2.Key_Boolean_Map,10));
//output(choosen(text_search.Key_Boolean_dictindx('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_seglist('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_dstat('vehiclev2'),10));
//output(choosen(text_search.Key_Boolean_nidx('vehiclev2'),10));
//output(choosen(text_search.Key_Boolean_dictindx2('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('vehiclev2'),10));
//output(choosen(text_search.Key_Boolean_nidx2('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_nidx3('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_EKeyIn('vehiclev2'),10));
output(choosen(text_search.Key_Boolean_EKeyout('vehiclev2'),10));
//output(choosen(dataset('~thor_data400::hole::wildcard_' + doxie_build.buildstate, vehicle_wildcard.layout_hole_veh, THOR, preload(0)),10));
//output(choosen(Vehicle_wildcard.key_ModelIndex,10));
endmacro;