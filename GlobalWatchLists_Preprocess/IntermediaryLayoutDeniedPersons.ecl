EXPORT IntermediaryLayoutDeniedPersons := MODULE

EXPORT tempLayout := RECORD
	Layouts.rDeniedPersons;
	string mod_citation;
END;

EXPORT tempLayout1 := RECORD
  string6 	ent_key;
  string55 	source;
  string8 	lst_vend_upd;
  string54 	lstd_entity;
  string200 address_1;
  string150 address_2;
  string2 	country;
  string10 	eff_date;
  string10 	exp_date;
  string20 	standard_order;
  string360 mod_citation;
  string35 	Federal_Citation_1;
  string35 	Federal_Citation_2;
  string35 	Federal_Citation_3;
  string35 	Federal_Citation_4;
  string35 	Federal_Citation_5;
  string35 	Federal_Citation_6;
  string35 	Federal_Citation_7;
  string35 	Federal_Citation_8;
  string35 	Federal_Citation_9;
  string35 	Federal_Citation_10;
	string55  orig_raw_name;
END;

EXPORT tempLayout2 := RECORD
	tempLayout1;
  rNameAddress.rName 		the_name;
  rNameAddress.rAddress the_address;
END;

END;