export mac_patch_vehmain_by_codes(veh, veh_out) := macro

//****** Rule 4 according to Bob
/* if year_make>=1972 and ORIG_VIN contains (?) set :
        FILLERxEG1 = ORIG_VIN ;
        ORIG_VIN = string_filter_out(ORIG_VIN,'?'); */
	
VehicleV2.Layout_Experian_Updating_temp_module.layout_temp_veh_vina read_codes(veh l) := transform
	self.BODY_CODE := vehiclecodes.filterBodyStyleCode(l.state_origin, l.BODY_CODE);
	self.MINOR_COLOR_CODE := if(l.MINOR_COLOR_CODE = l.MAJOR_COLOR_CODE, '', l.MINOR_COLOR_CODE);
	self.make_description := if(l.make_code = 'FERR' and l.vehicle_Type = 'AU' and l.make_description = '','',
								if(l.vina_vin <> '', 
								   l.make_description, 
								   vehicleCodes.getMake(l.state_origin, l.make_code, l.make_description)));
	self.model_description := if(l.vina_vin <> '', l.model_description,
						         if((l.vehicle_type='VS' and (l.state_origin='FL' or l.state_origin ='MO')),
									VehicleCodes.getVehicleType(l.state_origin, l.vehicle_type, l.vessel_type, l.model_description), 
									l.model_description));
	self.orig_vin := if((integer)l.YEAR_MAKE >= 1972 and 
						stringlib.StringFind(l.state_origin, '?',1) > 0, 
						stringlib.StringFilterOut(l.state_origin, '?'),
						l.orig_vin);
	self.BODY_STYLE_DESCRIPTION := if(l.vina_vin <> '',
									  l.BODY_STYLE_DESCRIPTION,
									  VehicleCodes.getBodyType(self.BODY_CODE,l.BODY_STYLE_DESCRIPTION)
									 );
    
    
	self := l;
end;


veh_out := project(veh, read_codes(left));

endmacro;