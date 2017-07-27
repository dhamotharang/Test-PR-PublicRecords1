import doxie_cbrs, ln_propertyv2_services;

doxie_cbrs.mac_Selection_Declare()
export property_records_source(dataset(doxie_cbrs.layout_references) bdids) := module
	export assessments := 
		if(PropertyVersion in [0,2],sort( nofold(LN_PropertyV2_Services.Source_records(, bdids, Max_Properties_val, TRUE))(fid_type='A'), -sortby_date, record));
	export deeds :=
		if(PropertyVersion in [0,2],sort( nofold(LN_PropertyV2_Services.Source_records(, bdids, Max_Properties_val, TRUE))(fid_type='D'), -sortby_date, record));
end;
