import codes, lib_stringlib;

export MAC_Patch_Desc_by_codesV3(veh_file, veh_layout, veh_use, out_file) := macro

file_codesV3       := Codes.File_Codes_V3_In(file_name = 'VEHICLE_REGISTRATION'); 
						
//attempting to find experian codes in attribute before joining to codes_v3						
body_codeV3_nojoin       := veh_file(trim(Body_Code,all) = '' or trim(orig_body_desc,all)<>'');

veh_layout tjoinbody(veh_layout L, file_codesV3 R) := transform
self.orig_body_Desc := stringlib.StringToUpperCase(R.long_desc);
self := L;
end;

body_codesV3_join         := JOIN(veh_file(trim(body_Code,all) <>'' and trim(orig_body_desc,all) =''), 
							file_codesV3(trim(field_name,all) = 'BODY_CODE' AND code<>''), 
							trim(left.body_Code,all) = trim(right.code,all) and 
							trim(left.state_origin,all) = trim(right.field_name2,all), 
							tjoinbody(left, right),
							LEFT OUTER, lookup);

body_concat               := body_codeV3_nojoin+body_codesV3_join;

//ADD VEHICLE TYPE

VEH_codeV3_nojoin       := body_concat(trim(Vehicle_Type,all) = '');

veh_layout tjoinVEH(body_concat L, file_codesV3 R) := transform
self.orig_Vehicle_Type_DESC := stringlib.StringToUpperCase(R.long_desc);
self := L;
end;

veh_codesV3_join         := JOIN(body_concat(trim(Vehicle_Type,all) <>''), 
							file_codesV3(trim(field_name,all) = 'VEHICLE_TYPE' AND code<>''), 
							trim(left.Vehicle_Type, all) = trim(right.code, all) and 
							trim(left.state_origin,all) = trim(right.field_name2,all), 
							tjoinVEH(left, right),
							LEFT OUTER, lookup);

VEH_concat               := veh_codeV3_nojoin+veh_codesV3_join;

//ADD MAJOR COLOR

MAJOR_codeV3_nojoin       := VEH_concat(trim(Major_Color_Code,all) = '');

veh_layout tjoinmajor(VEH_concat L, file_codesV3 R) := transform
self.orig_Major_Color_Desc := stringlib.StringToUpperCase(R.long_desc);
self := L;
end;

MAJOR_codesV3_join         := JOIN(VEH_concat(trim(Major_Color_Code,all) <>''), 
							file_codesV3(trim(field_name) = 'MAJOR_COLOR_CODE' AND code<>''), 
							trim(left.Major_Color_Code,all) = trim(right.code,all) and 
							trim(left.state_origin,all) = trim(right.field_name2,all), 
							tjoinMajor(left, right),
							LEFT OUTER, lookup);

MAJOR_concat               := MAJOR_codeV3_nojoin+MAJOR_codesV3_join;

//ADD MINOR COLOR

MINOR_codeV3_nojoin       := MAJOR_concat(trim(MINOR_Color_Code,all) = '');

veh_layout tjoinMINOR(MAJOR_concat L, file_codesV3 R) := transform
self.orig_MINOR_Color_Desc := stringlib.StringToUpperCase(R.long_desc);
self := L;
end;

MINOR_codesV3_join         := JOIN(MAJOR_concat(MINOR_Color_Code <>''), 
							file_codesV3(trim(field_name) = 'MINOR_COLOR_CODE' AND code<>''), 
							trim(left.MINOR_Color_Code,all) = trim(right.code,all) and 
							trim(left.state_origin, all) = trim(right.field_name2, all), 
							tjoinMINOR(left, right),
							LEFT OUTER, lookup);

MINOR_concat               := MINOR_codeV3_nojoin+MINOR_codesV3_join;

//ADD VEHICLE USE

#if(veh_use)

VEH_USE_codeV3_nojoin       := MINOR_concat(trim(vehicle_use,all) = '');

veh_layout tjoinUSE(MINOR_concat L, file_codesV3 R) := transform
self.orig_vehicle_use_Desc := stringlib.StringToUpperCase(R.long_desc);
self := L;
end;

veh_use_codesV3_join         := JOIN(MINOR_concat(trim(vehicle_use,all) <>''), 
							file_codesV3(trim(field_name,all) = 'VEHICLE_USE' AND trim(code,all)<>''), 
							trim(left.vehicle_use, all) = trim(right.code, all) and 
							trim(left.state_origin, all) = trim(right.field_name2, all) , 
							tjoinUSE(left, right),
							LEFT OUTER, lookup);

out_file   := VEH_USE_codeV3_nojoin+veh_use_codesV3_join;

#else

out_file   := MINOR_concat;

#end;

endmacro;

