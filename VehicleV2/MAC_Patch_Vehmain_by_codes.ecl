export mac_patch_vehmain_by_codes(veh, veh_layout, veh_out) := macro

//****** Rule 4 according to Bob
/* if year_make>=1972 and ORIG_VIN contains (?) set :
        FILLERxEG1 = ORIG_VIN ;
        ORIG_VIN = string_filter_out(ORIG_VIN,'?'); */
	
veh_layout read_codes(veh l) := transform
	self.BODY_CODE := vehiclecodes.filterBodyStyleCode(l.state_origin, l.BODY_CODE);
	self.MINOR_COLOR_CODE := if(l.MINOR_COLOR_CODE = l.MAJOR_COLOR_CODE, '', l.MINOR_COLOR_CODE);
	self.vina_make_desc := if(l.make_code = 'FERR' and l.vehicle_Type = 'AU' and l.vina_make_desc = '','',
								if(l.vina_vin <> '', 
								   l.vina_make_desc, 
								   vehicleCodes.getMake(l.state_origin, l.make_code, l.vina_make_desc)));
	self.vina_model_desc := if(l.vina_vin <> '', l.vina_model_desc,
						         if((l.vehicle_type='VS' and (l.state_origin='FL' or l.state_origin ='MO')),
									VehicleCodes.getVehicleType(l.state_origin, l.vehicle_type, l.vessel_type, l.vina_model_desc), 
									l.vina_model_desc));
	self.orig_vin := if((integer)l.YEAR_MAKE >= 1972 and 
						stringlib.StringFind(l.state_origin, '?',1) > 0, 
						stringlib.StringFilterOut(l.state_origin, '?'),
						l.orig_vin);
	self.VINA_BODY_STYLE_DESC := if(l.vina_vin <> '',
									  l.VINA_BODY_STYLE_DESC,
									  VehicleCodes.getBodyType(self.BODY_CODE,l.VINA_BODY_STYLE_DESC)
									 );
    
    
	self := l;
end;


veh_out := project(veh, read_codes(left));

endmacro;