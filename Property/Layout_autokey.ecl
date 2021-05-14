IMPORT $, dx_common;

EXPORT Layout_autokey :=	RECORD
	STRING70		foreclosure_id;
	STRING20 		name_first;
	STRING20 		name_middle;
	STRING20 		name_last;
	STRING5  		name_suffix;
	UNSIGNED6 	did := 0;
	UNSIGNED1 	did_score := 0;
	UNSIGNED6 	bdid := 0;
	UNSIGNED1 	bdid_score := 0;
	STRING9 		ssn := '';
	STRING60  	name_Company;
	STRING10		site_prim_range;
	STRING2		site_predir;
	STRING28		site_prim_name;
	STRING4		site_addr_suffix;
	STRING2		site_postdir;
	STRING10		site_unit_desig;
	STRING8		site_sec_range;
	STRING25		site_p_city_name;
	STRING25		site_v_city_name;
	STRING2		site_st;
	STRING5		site_zip;
	STRING4		site_zip4;
	STRING2		source;
	UNSIGNED1	zero :=0;
	STRING1		blank :='';
	dx_common.layout_metadata; //Added for delta project DF-28049
END;