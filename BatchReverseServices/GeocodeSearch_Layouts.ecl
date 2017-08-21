EXPORT GeocodeSearch_Layouts := MODULE

	EXPORT LatLong := RECORD
		REAL      latitude;
		REAL      longitude;
	END;
	
	EXPORT Address := RECORD
		QSTRING5  zip;
		QSTRING4  zip4;
		QSTRING28 prim_name;
		QSTRING4  addr_suffix;
		QSTRING2  predir;
		QSTRING2  postdir;
		QSTRING10 prim_range;
		QSTRING8  sec_range;
		REAL      geo_lat;
		REAL      geo_long;
		STRING1   geo_match;
	END;
	
	EXPORT Final := RECORD
		QSTRING1   bi_ind;
		UNSIGNED6  id;
		UNSIGNED3  dt_first_seen;
		UNSIGNED3  dt_last_seen;
		BOOLEAN    same_address;
		QSTRING5   title;
		QSTRING20  fname;
		QSTRING20  mname;
		QSTRING20  lname;
		QSTRING5   name_suffix;
		QSTRING120 company_name;
		QSTRING10  prim_range;
		QSTRING2   predir;
		QSTRING28  prim_name;
		QSTRING4   suffix;
		QSTRING2   postdir;
		QSTRING10  unit_desig;
		QSTRING8   sec_range;
		QSTRING25  city_name;
		QSTRING2   st;
		QSTRING5   zip;
		QSTRING4   zip4;
		REAL       geo_lat;
		REAL       geo_long;
		STRING1    geo_match;
		QSTRING5   best_title;
		QSTRING20  best_fname;
		QSTRING20  best_mname;
		QSTRING20  best_lname;
		QSTRING5   best_name_suffix;
		QSTRING120 best_company_name;
		QSTRING10  best_prim_range;
		QSTRING2   best_predir;
		QSTRING28  best_prim_name;
		QSTRING4   best_suffix;
		QSTRING2   best_postdir;
		QSTRING10  best_unit_desig;
		QSTRING8   best_sec_range;
		QSTRING25  best_city_name;
		QSTRING2   best_st;
		QSTRING5   best_zip;
		QSTRING4   best_zip4;
	END;

END;
