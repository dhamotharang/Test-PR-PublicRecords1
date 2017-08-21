Import header, emerges;

EXPORT Layouts := module

Export Layout_New_Records := header.Layout_New_Records;

Export rHuntCCWCleanAddr_layout:=emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout;

Export hunt_fish_out:=emerges.Layout.hunt_fish_out;

Export Autokey_layout:= Record
	string2 		source_code;
  emerges.Layout.CCW_out;
 end;
 
 Export Autokey_layout_w_extra_city_field_hunting:=record
	hunt_fish_out;
  string25 p_city_name;
end;
 
 Export Autokey_layout_w_extra_city_field:=record
  Autokey_layout;
  string25 p_city_name;
end;

Export Layout_CCW_did := RECORD
		unsigned6 did_out6;
		unsigned6 rid;
  END;
	
Export Layout_Hunters_did := RECORD
		unsigned6 did;
		unsigned6 rid;
  END;

Export layout_ccw_out := emerges.layout_ccw_out;

Export layout_hunters_out:=emerges.layout_hunters_out;

Export layout_ccw_out_doxie:=record
       unsigned8 did;
       emerges.layout_ccw_out;
			 unsigned integer8 __filepos {virtual(fileposition)};
		 END;
		 
Export layout_hunters_out_doxie:=record
     unsigned8 did;
     emerges.layout_hunters_out;
  	 unsigned integer8 __filepos {virtual(fileposition)};
		 END;
			 

Export Layout_Searchfile := RECORD
		unsigned6 rid;
		emerges.layout_ccw_out;
  END;
	
Export Layout_Hunters_Searchfile := RECORD
	unsigned6 rid;
	emerges.layout_hunters_out;
  END;

Export Hunters_Base_Layout := RECORD
unsigned6 did;
string8 process_date;
string8 date_first_seen;
string8 date_last_seen;
string3 score;
string9 best_ssn;
string7 source;
string4 file_id;
string13 vendor_id;
string2 source_state;
string2 source_code;
string8 file_acquired_date;
string2 _use;
string10 title_in;
string30 lname_in;
string30 fname_in;
string30 mname_in;
string30 maiden_prior;
string3 name_suffix_in;
string15 votefiller;
integer4 dob;
string30 maiden_name;
string8 regdate;
string2 race;
string1 gender;
string2 poliparty;
string10 phone;
string10 work_phone;
string1 active_status;
string1 votefiller2;
string2 voterstatus;
string40 resaddr1;
string40 resaddr2;
string40 res_city;
string2 res_state;
string9 res_zip;
string3 res_county;
string40 mail_addr1;
string40 mail_addr2;
string40 mail_city;
string2 mail_state;
string9 mail_zip;
string3 mail_county;
string10 historyfiller;
string15 huntfishperm;
string20 license_type_mapped;
string8 datelicense;
string2 homestate;
string1 resident;
string1 nonresident;
string1 hunt;
string1 fish;
string1 combosuper;
string1 sportsman;
string1 trap;
string1 archery;
string1 muzzle;
string1 drawing;
string1 day1;
string1 day3;
string1 day7;
string1 day14to15;
string1 dayfiller;
string1 seasonannual;
string1 lifetimepermit;
string1 landowner;
string1 family;
string1 junior;
string1 seniorcit;
string1 crewmemeber;
string1 retarded;
string1 indian;
string1 serviceman;
string1 disabled;
string1 lowincome;
string3 regioncounty;
string1 blind;
string47 huntfiller;
string1 freshwater;
string1 saltwater;
string1 lakesandresevoirs;
string1 setlinefish;
string1 fallfishing;
string1 snowmobile;
string1 biggame;
string1 smallgame;
string1 gun;
string1 bonus;
string1 lottery;
string83 huntfill1;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 score_on_input;
string10 prim_range;
string2 predir;
string28 prim_name;
string4 suffix;
string2 postdir;
string10 unit_desig;
string8 sec_range;
string25 p_city_name;
string25 city_name;
string2 st;
string5 zip;
string4 zip4;
string4 cart;
string1 cr_sort_sz;
string4 lot;
string1 lot_order;
string2 dpbc;
string1 chk_digit;
string2 record_type;
string2 ace_fips_st;
string3 county;
string18 county_name;
string10 geo_lat;
string11 geo_long;
string4 msa;
string7 geo_blk;
string1 geo_match;
string4 err_stat;
string10 mail_prim_range;
string2 mail_predir;
string28 mail_prim_name;
string4 mail_addr_suffix;
string2 mail_postdir;
string10 mail_unit_desig;
string8 mail_sec_range;
string25 mail_p_city_name;
string25 mail_v_city_name;
string2 mail_st;
string5 mail_ace_zip;
string4 mail_zip4;
string4 mail_cart;
string1 mail_cr_sort_sz;
string4 mail_lot;
string1 mail_lot_order;
string2 mail_dpbc;
string1 mail_chk_digit;
string2 mail_record_type;
string2 mail_ace_fips_st;
string3 mail_fipscounty;
string10 mail_geo_lat;
string11 mail_geo_long;
string4 mail_msa;
string7 mail_geo_blk;
string1 mail_geo_match;
string4 mail_err_stat;
unsigned8 persistent_record_id;
string PreyType;
string cust_name;
string bug_num;
END;

Export CCW_Base_Layout := RECORD
unsigned6 did;
string8 process_date;
string8 date_first_seen;
string8 date_last_seen;
string8 unique_id;
string3 score;
string9 best_ssn;
string7 source;
string4 file_id;
string13 vendor_id;
string2 source_state;
string2 source_code;
string8 file_acquired_date;
string2 _use;
string30 lname_in;
string30 fname_in;
string30 mname_in;
string3 name_suffix_in;
integer4 dob;
string2 race;
string1 gender;
string10 phone;
string1 active_status;
string1 active_other;
string40 resaddr1;
string40 resaddr2;
string40 res_city;
string2 res_state;
string9 res_zip;
string3 res_county;
string40 mail_addr1;
string40 mail_addr2;
string40 mail_city;
string2 mail_state;
string9 mail_zip;
string3 mail_county;
string15 ccwpermnum;
string15 ccwweapontype;
string8 ccwregdate;
string8 ccwexpdate;
string46 ccwpermtype;
string10 ccwfill1;
string20 ccwfill2;
string15 ccwfill3;
string15 ccwfill4;
string15 miscfill1;
string5 title;
string20 fname;
string20 mname;
string20 lname;
string5 name_suffix;
string3 score_on_input;
string10 prim_range;
string2 predir;
string28 prim_name;
string4 suffix;
string2 postdir;
string10 unit_desig;
string8 sec_range;
string25 p_city_name;
string25 city_name;
string2 st;
string5 zip;
string4 zip4;
string4 cart;
string1 cr_sort_sz;
string4 lot;
string1 lot_order;
string2 dpbc;
string1 chk_digit;
string2 record_type;
string2 ace_fips_st;
string3 county;
string18 county_name;
string10 geo_lat;
string11 geo_long;
string4 msa;
string7 geo_blk;
string1 geo_match;
string4 err_stat;
string10 mail_prim_range;
string2 mail_predir;
string28 mail_prim_name;
string4 mail_addr_suffix;
string2 mail_postdir;
string10 mail_unit_desig;
string8 mail_sec_range;
string25 mail_p_city_name;
string25 mail_v_city_name;
string2 mail_st;
string5 mail_ace_zip;
string4 mail_zip4;
string4 mail_cart;
string1 mail_cr_sort_sz;
string4 mail_lot;
string1 mail_lot_order;
string2 mail_dpbc;
string1 mail_chk_digit;
string2 mail_record_type;
string2 mail_ace_fips_st;
string3 mail_fipscounty;
string10 mail_geo_lat;
string11 mail_geo_long;
string4 mail_msa;
string7 mail_geo_blk;
string1 mail_geo_match;
string4 mail_err_stat;
unsigned8 persistent_record_id;
string cust_name;
string bug_num;
END;


 END;