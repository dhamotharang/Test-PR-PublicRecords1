﻿IMPORT $, Property, BIPV2;

EXPORT Layout_Foreclosure_normalized_ext := RECORD
		string20 	name_first;
	string20 	name_middle;
	string20 	name_last;
	string5  	name_suffix;
	string60  name_Company;
	string10	site_prim_range;
	string2		site_predir;
	string28	site_prim_name;
	string4		site_addr_suffix;
	string2		site_postdir;
	string10	site_unit_desig;
	string8		site_sec_range;
	string25	site_p_city_name;
	string25	site_v_city_name;
	string2		site_st;
	string5		site_zip;
	string4		site_zip4;
	unsigned1 name_indicator;
	unsigned6 did := 0;
	unsigned1 did_score := 0;
	string9 	ssn := '';
	string2		source := '';
	unsigned6 bdid := 0;
	unsigned1 bdid_score := 0;
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned8 sequence := 0;
	Property.Layout_Foreclosure_baseV2_ext - source; //source already included in normalized layout
END;