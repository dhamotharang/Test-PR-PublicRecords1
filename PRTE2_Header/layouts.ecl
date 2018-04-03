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

		export insuranceheader_xlink_did := record
						unsigned6 s_did;
						unsigned6 did;
						unsigned6 rid;
						string1 pflag1;
						string1 pflag2;
						string1 pflag3;
						string2 src;
						unsigned3 dt_first_seen;
						unsigned3 dt_last_seen;
						unsigned3 dt_vendor_last_reported;
						unsigned3 dt_vendor_first_reported;
						unsigned3 dt_nonglb_last_seen;
						string1 rec_type;
						qstring18 vendor_id;
						qstring10 phone;
						qstring9 ssn;
						integer4 dob;
						qstring5 title;
						qstring20 fname;
						qstring20 mname;
						qstring20 lname;
						qstring5 name_suffix;
						qstring10 prim_range;
						string2 predir;
						qstring28 prim_name;
						qstring4 suffix;
						string2 postdir;
						qstring10 unit_desig;
						qstring8 sec_range;
						qstring25 city_name;
						string2 st;
						qstring5 zip;
						qstring4 zip4;
						string3 county;
						qstring7 geo_blk;
						qstring5 cbsa;
						string1 tnt;
						string1 valid_ssn;
						string1 jflag1;
						string1 jflag2;
						string1 jflag3;
						unsigned8 rawaid;
						unsigned8 persistent_record_id;
						string1 valid_dob;
						unsigned6 hhid;
						string18 county_name;
						string120 listed_name;
						string10 listed_phone;
						unsigned4 dod;
						string1 death_code;
						unsigned4 lookup_did;
						unsigned4 dt_effective_first;
						unsigned4 dt_effective_last;
			END;


END;