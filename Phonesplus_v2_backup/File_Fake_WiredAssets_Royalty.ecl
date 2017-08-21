fake_royalty_layout := RECORD
  unsigned8 did;
  string20 fname;
  string20 mname;
  string20 lname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
	string10 orig_phone;
  unsigned8 times_used;
  unsigned8 times_paid;
  unsigned8 times_unpaid;
 END;


export File_Fake_WiredAssets_Royalty := dataset(ut.foreign_dataland  + 'thor_data400::base::wa_royalty', fake_royalty_layout, thor);
