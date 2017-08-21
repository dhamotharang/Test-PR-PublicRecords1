import demo_data;
import bbb2;

my_layout :=  record
  unsigned integer6 bdid;
  unsigned integer4 date_first_seen;
  unsigned integer4 date_last_seen;
  unsigned integer4 dt_vendor_first_reported;
  unsigned integer4 dt_vendor_last_reported;
  unsigned integer4 process_date_first_seen;
  unsigned integer4 process_date_last_seen;
  string1 record_type;
  string7 bbb_id;
  string60 company_name;
  string100 address;
  string12 country;
  string14 phone;
  string8 phone_type;
  string8 report_date;
  string120 http_link;
  string60 member_title;
  string8 member_since_date;
  string100 member_category;
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
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string10 phone10;
 END;

file_in:= dataset('~thor::base::demo_data_file_bbb2_member_prodcopy', my_layout,flat);	// bbb2.Layout_Member_Base,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
      mod_file_in,      // data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  true, phone10,
		  false, x_DL_Number,   // dl_number field name
		  false, cont_dob,		// DOB field name
		  false, cont_ssn,	//SSN field name
		  false, did,  		// DID field name
		  true, bdid,		// BDID field name
		  false, cont_fname,
		  false, cont_mname,
		  false, cont_lname,
		  false, append_clean_name,	// cleanName field name
		  //
		  true, company_name, // businessName Field
		  //
		  true, street,
		  true, v_city_name,
		  true, st,
		  true, zip,
		  true, zip4,
		  false, dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//
file_in to_fix_bdids(scrambled_file l) := transform
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.bbb_id := demo_data_scrambler.fn_scramblePII('NUMBER',l.bbb_id);
self.report_date := demo_data_scrambler.fn_scramblePII('DOB',l.report_date);
self.member_since_date := demo_data_scrambler.fn_scramblePII('DOB',l.member_since_date);
self.address := '';
self.phone := '';
self.http_link := 'http://www.bbb_everywhere.org/cgi-bin/reason.dl?ID=0';
self.member_title := l.company_name;
self := l;
end;

scrambled := project(scrambled_file, to_fix_bdids(left));

export scramble_bbb2_member := dedup(sort(scrambled,record),all);