import LN_PropertyV2_Services;
doxie_cbrs.mac_Selection_Declare()
export property_records_v2(dataset(doxie_cbrs.layout_references) bdids) := MODULE
	shared unlim := if(PropertyVersion in [0,2],LN_PropertyV2_Services.Embed_records(true,,bdids,Max_Properties_val,,isPeopleWise)(Include_PropertiesV2_val));
	
	export recs_trimmed := topn(unlim, Max_Properties_val, -sortby_date);
	export all_recs := unlim;
END;