/*--SOAP--
<message name="VehicleWeekly">
</message>
*/


export Vehicle_Weekly := MACRO
output(choosen(doxie_files.Key_Vehicles,10));
output(choosen(doxie_files.key_vehicle_addr,10));
output(choosen(doxie_files.Key_Vehicle_id,10));
output(choosen(doxie_files.key_vehicle_did,10));
output(choosen(doxie_files.key_vehicle_tag,10));
output(choosen(doxie_files.key_vehicle_vin,10));
output(choosen(doxie_files.key_vehicle_bdid,10));
output(choosen(doxie_files.Key_Vehicle_coName,10));
output(choosen(doxie_files.Key_Vehicle_St_VNum,10));
// output(choosen(Vehicle_wildcard.key_NameIndex,10));
// output(choosen(Vehicle_wildcard.key_ModelIndex,10));
// output(choosen(doxie_files.Key_BocaShell_Vehicles,10));
output(choosen(Vehicle_wildcard.File_Veh_Hole,10));
// output(choosen(dataset('~thor_data400::hole::wildcard_' + doxie_build.buildstate, vehicle_wildcard.layout_hole_veh, THOR, preload(0)),10));


ENDMACRO;