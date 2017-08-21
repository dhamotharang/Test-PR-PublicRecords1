import Lib_StringLib, ut, vehlic, standard,vehicleCodes, codes;

//combine monthly and annual files

combined_file := VehicleV2.Experian_Updating_Monthly_annual_Rollup;

//fix lessee only issue

VehicleV2.Mac_fix_lessee_lessor_only(combined_file, combined_file_fixed)

//modify pname and cname issues when orig_party_type = 'B' and 'I'

VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2 tfixname(VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2 L) := transform


boolean ispname := if(L.title <> '' and L.name_score = '98'and trim(L.orig_name, left, right) = trim(L.fname, left, right)+ ' ' + trim(L.mname, left, right) + ' ' + trim(L.lname, left, right) 
	                                             and ~regexfind('SHERIFF| CU |FCU| PO | BO ', L.orig_name), true, false);

boolean iscname := if(L.lname in ['LT', 'INFINITI LT'], true, false);																						 
												 
    self.title 		 :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.title, ''), L.title));                                                                                                                      
    self.fname 		 :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.fname, ''), L.fname));                                                                                                                                                                                              
    self.mname 		 :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.mname, ''), L.mname));                                                                                                                                                                                           
    self.lname 		 :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.lname, ''), L.lname));                                                                                                                                                                                           
    self.name_suffix :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.name_suffix, ''), L.name_suffix));                                                                                                                                                                                           
    self.name_score	 :=  if(iscname, '',   if(L.orig_party_type = 'B', if(ispname, L.name_score, ''), L.name_score));                                                                      
    self.Append_Clean_cname := if(iscname, l.orig_name, l.Append_Clean_cname);                            
    self.body_code := vehiclev2.simplify_experian_body_codes(L.body_code);
	  self.orig_Make_Desc					:= if(L.make_code <> '', stringlib.StringToUpperCase(VehicleCodes.getMake(L.state_origin, L.Make_code)), L.orig_make_desc);
	  self.orig_Series_Desc				:=L.SERIES;
	  self.orig_Model_Desc				:=L.MODEL;
	  self.orig_Body_Desc					:= if(L.body_code <> '', stringlib.StringToUpperCase(vehiclev2.translate_experian_body_codes(self.body_code)), L.orig_body_desc);
		self := L;
	
end;

veh_exp := project(combined_file_fixed, tfixname(left));


//****** Join to VINA file

// change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.

VehicleV2.Mac_validVIN_exp(VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, veh_exp, validVin_out) 

//****** Improve descriptions
VehicleV2.MAC_Patch_Vehmain_by_codes(validVin_out, VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, veh_vins_done)	

//patch descriptions from codesV3

VehicleV2.MAC_Patch_Desc_by_codesV3(veh_vins_done, VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2, false, veh_patch_desc_out)

export experian_updating_as_vehicleV2 := veh_patch_desc_out;	 