import _control,liensv2;

// fver:='20081113';

// read these foreign for now, copy to demo doesn't work, layout disagreement --force ignore probably would fix it??

local_party_layout := record
  string50 tmsid;
  string50 rmsid;
  string orig_full_debtorname;
  string orig_name;
  string orig_lname;
  string orig_fname;
  string orig_mname;
  string orig_suffix;
  string9 tax_id;
  string9 ssn;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string cname;
  string orig_address1;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zip5;
  string orig_zip4;
  string orig_county;
  string orig_country;
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
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string phone;
  string name_type;
  string12 did;
  string12 bdid;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string9 app_ssn;
  string9 app_tax_id;
 END;


// file_in:= dataset('~foreign::'+_control.IPAddress.prod_thor_dali+'::'+'~thor_200::base::demo_data_file_liens_party'+fver, local_party_layout,thor);
file_in:= dataset('~thor::base::demo_data_file_liens_party_prodcopy', local_party_layout,thor);

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
      mod_file_in,      		// data set to be scrambled
      scrambled_file, 	//scrambled output data set attribute
		  true,phone,
		  false,dl_number ,   // dl_number field name
		
		  false,dob,		// DOB field name
		  true,app_ssn, //SSN field name
		  true,did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip,
		  true,zip4,
		  false,dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);
//****     REFORMAT SOME FIELDS BACK INTO THE ORIGINAL FILE
recordof(file_in) reformat(scrambled_file L):= TRANSFORM
scrambled_cname := if(l.cname<>'',demo_data_scrambler.fn_scrambleBizName(l.cname),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.app_tax_id := '';
self.tax_id := '';
self.ssn := l.app_ssn;
self.orig_full_debtorname := if(scrambled_cname='', trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname)+ ' ' + l.name_suffix,scrambled_cname);
self.orig_name	:= trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname)+ ' ' + l.name_suffix;
self.orig_lname := l.lname;
self.orig_fname	:= l.fname;
self.orig_mname	:= l.mname;
self.orig_suffix	:= l.name_suffix;
self.bdid := demo_data_scrambler.fn_scramblePII('DID',l.bdid);
self.orig_address1:=trim(clean_addr[1..8]) +' '+ TRIM(clean_addr[10..38],LEFT,RIGHT);
self.orig_address2:='';
self.orig_city := l.v_city_name;
self.cname := scrambled_cname;
self:=l;
END;

export scramble_liens_party := dedup(sort(project(scrambled_file,reformat(LEFT)),record),all);

