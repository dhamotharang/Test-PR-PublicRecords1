IMPORT header;
EXPORT layouts := MODULE

    EXPORT header := header.Layout_Header;
    h:=header;
    EXPORT Header_layout_prep_for_keys := record
      h.zip;
      qstring28 prim_name;// := ut.StripOrdinal(h.prim_name);
      h.prim_range;
      h.city_name;
      h.st;
      h.lname;
      h.mname;
      h.fname;
      typeof(h.fname) pfname;// := NID.PreferredFirstVersionedStr(h.fname, NID.version);
      h.ssn;
      h.valid_ssn;
      h.phone;
      string6  dph_lname;// := metaphonelib.DMetaPhone1(h.lname);
      h.did;
      h.rid;
      h.dob;
      unsigned2 yob;// := h.dob div 10000;
      h.sec_range;
      unsigned8 states := 0;
      unsigned4 lname1 := 0;
      unsigned4 lname2 := 0;
      unsigned4 lname3 := 0;
      unsigned4 fname1 := 0;
      unsigned4 fname2 := 0;
      unsigned4 fname3 := 0;
      unsigned4 city1 := 0;
      unsigned4 city2 := 0;
      unsigned4 city3 := 0;
      unsigned4 rel_fname1 := 0;
      unsigned4 rel_fname2 := 0;
      unsigned4 rel_fname3 := 0; 
      unsigned6 first_seen;// := header.get_header_first_seen(h);
      unsigned6 last_seen;// := header.get_header_last_seen(h);
      h.dt_nonglb_last_seen;
      unsigned4 lookups := 0;
    end;   

    EXPORT doxie_Lookups:= record
      unsigned6 did;
      unsigned2 veh_cnt := 0;
      unsigned2 dl_cnt := 0;
      unsigned2 head_cnt := 0;
      unsigned2 crim_cnt := 0;
      unsigned2 sex_cnt := 0;
      unsigned2 ccw_cnt := 0;
      unsigned2 rel_count := 0;
      unsigned2 fire_count := 0;
      unsigned2 faa_count := 0;
      unsigned2 prof_count := 0;
      unsigned2 vess_count := 0;
      unsigned2 bus_count := 0;
      unsigned2 paw_count := 0;	// new for hfss
      unsigned2 bc_count := 0;	// new for hfss
      unsigned2 prop_count := 0;
      unsigned2 prop_asses_count := 0;	// new for hfss
      unsigned2 prop_deeds_count := 0;	// new for hfss
      unsigned2 bk_count := 0;
      unsigned4 lookups := 0;
  end;


END;