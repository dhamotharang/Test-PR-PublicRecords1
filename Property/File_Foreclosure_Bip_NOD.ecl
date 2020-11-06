import BIPV2;

file_in := Property.File_Foreclosure_Normalized(trim(deed_category)IN Category_filter.NOD);

BIP_layout:=record
	string70		foreclosure_id;
	string20 		name_first;
	string20 		name_middle;
	string20 		name_last;
	string5  		name_suffix;
	unsigned6 	did := 0;
	unsigned1 	did_score := 0;
	unsigned6 	bdid := 0;
	unsigned1 	bdid_score := 0;
	string9 		ssn := '';
	string60  	name_Company;
	string10		site_prim_range;
	string2			site_predir;
	string28		site_prim_name;
	string4			site_addr_suffix;
	string2			site_postdir;
	string10		site_unit_desig;
	string8			site_sec_range;
	string25		site_p_city_name;
	string25		site_v_city_name;
	string2			site_st;
	string5			site_zip;
	string4			site_zip4;
	unsigned 		zero :=0;
	string1			blank :='';
	BIPV2.IDlayouts.l_xlink_ids;		//Added for BIP project
	unsigned8 	source_rec_id :=0; 	//Added for BIP project
	string2		source;
end;

export File_Foreclosure_Bip_NOD := dedup(sort(project(file_in(site_prim_name<>'' and site_zip<>''),BIP_layout),record),record);
