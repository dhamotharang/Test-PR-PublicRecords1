//
// phase 1 read current vehicle
//

b := vehiclev2.file_VehicleV2_Main;  // File_Vehicles.File_Base_Vehicles_Prod;
stat_layout := record
string5			make_code 	:= b.best_make_code;
string75		model_description := b.vina_model_desc;
unsigned integer4 		b_total	:= count(group);
end;
b_stat := table(b, stat_layout, best_make_code,vina_model_desc, few);
output(b_stat,,'~thor_200::temp::vehicle_make_model_for_dfacts_compare',overwrite);

stat_layoutx := record
string5			make_code 	:= b.best_make_code;
string75		make_description := b.vina_make_desc;
unsigned integer4 		b_total := count(group);
end;
b_statx := table(b(vina_make_desc<>''), stat_layoutx, best_make_code,vina_make_desc,few);
output(b_statx,,'~thor_200::temp::vehicle_make_for_dfacts_compare',overwrite);

