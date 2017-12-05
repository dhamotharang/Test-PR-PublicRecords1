﻿export Layout_ACA_Internal := record
	//PROJECT INTERNAL DATA INTO FULL LAYOUT
	string5  	zip;
	string10 	prim_range;
	string28 	prim_name;
	string4  	addr_suffix;
	string2  	predir;
	string2  	postdir;
	string5  	unit_desig;
	string8  	sec_range;
	string25	p_city_name;
	string25	v_city_name;
	//string25 	city;
	string2  	st;
	string4  	zip4;
	unsigned6 aid;
	string7	 	geo_blk;
	string13	geolink;
	string7		streetlink;
	string3		county;
	string4		msa;
	qstring10	geo_lat;
	qstring11	geo_long;	
	unsigned4	dt_first_seen;
	unsigned4	dt_last_seen;
	string2		source;
	boolean		current;
	string6		cnp_status;
	unsigned6	powid;
	string250 cnp_name;
	string10  cnp_phone;
	string9 	cnp_fein;
	string60	company_org_structure_derived;	
	string4		rc;
	string10	inst_class;
	string10	inst_type;
	boolean 	prison := FALSE;
	boolean 	parole := FALSE;
	boolean 	nis := FALSE;
	boolean 	inc_srv := FALSE;
	boolean 	includes := FALSE;
	boolean 	excludes := FALSE;
	boolean 	absolute := FALSE;
	boolean 	pri_sic := FALSE;
	boolean 	pri_naics := FALSE;
	boolean 	par_sic := FALSE;
	boolean 	par_naics := FALSE;
	boolean 	po_box := FALSE;
	//ADVO address attributes
	string1  	addr_type;
	integer4 	biz_use;
	integer4 	vacant;
	integer4 	dnd;
	integer4 	rural;
	integer4 	owgm;
	integer4 	drop;
	integer4 	deliverable;
	integer4 	undel_sec;
	string6 	naics1;
	string6 	naics2;
	string6 	naics3;
	string6 	naics4;
	string6 	naics5;
	string6 	sic1;
	string6 	sic2;
	string6 	sic3;
	string6 	sic4;
	string6 	sic5;
end;