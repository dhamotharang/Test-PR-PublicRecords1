import doxie_raw,doxie,business_header;

Business_Header.doxie_MAC_Field_Declare()
doxie.MAC_Selection_Declare()

export motor_vehicle_records_dayton(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

raw := Doxie_Raw.Veh_Raw(doxie_raw.ds_EmptyDIDs,
												 vin_value,
												 tag_value,
												 '',
												 '',
												 '',
												 company_name_value,
												 dateVal,
												 dppa_purpose,
												 glb_purpose,
												 ln_branded_value,
												 ssn_mask_value,
												 dl_mask_value,
                         project(bdids, doxie.Layout_ref_bdid),,,application_type_value);
		
return if(VehicleVersion in [0,1],raw);
END;