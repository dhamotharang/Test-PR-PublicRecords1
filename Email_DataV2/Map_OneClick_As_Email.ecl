IMPORT One_Click_Data, address, ut, emailservice, mdr, _validate, Entiera, lib_StringLib, std, Email_Data;

EXPORT Map_OneClick_As_Email(version) := FUNCTION

infile     := One_Click_Data.Files().Base.Built;
with_email := infile(TRIM(rawfields.emailaddress) <> '' and did <> 0);
//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,rawfields.emailaddress);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        					:= mdr.sourceTools.src_One_Click_Data;
	SELF.current_rec      					:= true;
	SELF.activecode     						:= '';
	SELF.did_type         					:= '';
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id 			:= '';
	SELF.orig_First_Name  					:= ut.CleanSpacesAndUpper(input.rawfields.FirstName);
	SELF.orig_Last_Name  						:= ut.CleanSpacesAndUpper(input.rawfields.LastName);
	SELF.Orig_Address  							:= ut.CleanSpacesAndUpper(input.rawfields.HomeAddress);
	SELF.Orig_City  								:= ut.CleanSpacesAndUpper(input.rawfields.HomeCity);
	SELF.Orig_State  								:= ut.CleanSpacesAndUpper(input.rawfields.HomeState);
	SELF.orig_ZIP  									:= ut.CleanSpacesAndUpper(input.rawfields.HomeZip);
	SELF.orig_zip4  								:= '';
	SELF.orig_email 								:= ut.CleanSpacesAndUpper(input.rawfields.emailaddress);
	SELF.orig_site  								:= '';
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	SELF.orig_ip                    := ut.CleanSpacesAndUpper(input.rawfields.ip);
	SELF.orig_phone                 := ut.CleanSpacesAndUpper(input.rawfields.HomePhone);
	SELF.orig_ssn                   := ut.CleanSpacesAndUpper(input.rawfields.ssn);
	SELF.orig_dob                   := ut.CleanSpacesAndUpper(input.rawfields.dob);	
	SELF.clean_name.title  					:= input.clean_name.title;
	SELF.clean_name.fname  					:= input.clean_name.fname;
	SELF.clean_name.mname  					:= input.clean_name.mname;
	SELF.clean_name.lname  					:= input.clean_name.lname;
	SELF.clean_name.name_suffix  		:= input.clean_name.name_suffix;
	SELF.clean_name.name_score  		:= input.clean_name.name_score;
	SELF.clean_address.prim_range 	:= input.Clean_Home_address.prim_range;
	SELF.clean_address.predir  			:= input.Clean_Home_address.predir;
	SELF.clean_address.prim_name  	:= input.Clean_Home_address.prim_name;
	SELF.clean_address.addr_suffix	:= input.Clean_Home_address.addr_suffix;
	SELF.clean_address.postdir  		:= input.Clean_Home_address.postdir;
	SELF.clean_address.unit_desig 	:= input.Clean_Home_address.unit_desig;
	SELF.clean_address.sec_range  	:= input.Clean_Home_address.sec_range;
	SELF.clean_address.p_city_name 	:= input.Clean_Home_address.p_city_name;
	SELF.clean_address.v_city_name 	:= input.Clean_Home_address.v_city_name;
	SELF.clean_address.st  					:= input.Clean_Home_address.st;
	SELF.clean_address.zip  				:= input.Clean_Home_address.zip;
	SELF.clean_address.zip4  				:= input.Clean_Home_address.zip4;
	SELF.clean_address.cart  				:= input.Clean_Home_address.cart;
	SELF.clean_address.cr_sort_sz  	:= input.Clean_Home_address.cr_sort_sz;
	SELF.clean_address.lot  				:= input.Clean_Home_address.lot;
	SELF.clean_address.lot_order  	:= input.Clean_Home_address.lot_order;
	SELF.clean_address.dbpc  				:= input.Clean_Home_address.dbpc;
	SELF.clean_address.chk_digit  	:= input.Clean_Home_address.chk_digit;
	SELF.clean_address.rec_type  		:= input.Clean_Home_address.rec_type;
	SELF.clean_address.county  			:= input.Clean_Home_address.fips_county;
	SELF.clean_address.geo_lat  		:= input.Clean_Home_address.geo_lat;
	SELF.clean_address.geo_long  		:= input.Clean_Home_address.geo_long;
	SELF.clean_address.msa  				:= input.Clean_Home_address.msa;
	SELF.clean_address.geo_blk  		:= input.Clean_Home_address.geo_blk;
	SELF.clean_address.geo_match  	:= input.Clean_Home_address.geo_match;
	SELF.clean_address.err_stat  		:= input.Clean_Home_address.err_stat;
	SELF.append_rawaid  						:= input.raw_Home_aid;
	SELF.clean_phone                := (string10)input.clean_phones.homephone;
	SELF.clean_ssn                  := ut.CleanSpacesAndUpper(input.rawfields.ssn);
	SELF.clean_dob                  := (integer)input.rawfields.dob;	
	SELF.date_first_seen  					:= (string8)input.dt_first_seen;
	SELF.date_last_seen  						:= (string8)input.dt_last_seen;
	SELF.Date_Vendor_First_Reported := (string8)input.dt_vendor_first_reported;
	SELF.Date_Vendor_Last_Reported  := (string8)input.dt_vendor_last_reported;
	SELF.append_email_username 			:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_Username(SELF.orig_email));
	SELF.append_domain 							:= ut.CleanSpacesAndUpper(Email_Data.Fn_Clean_Email_domain(input.domain));
	SELF.append_domain_type 				:= ut.CleanSpacesAndUpper(input.domain_type);
	SELF.append_domain_root 				:= ut.CleanSpacesAndUpper(input.domain_root);
	SELF.append_domain_ext 					:= ut.CleanSpacesAndUpper(input.domain_ext);
	SELF.append_is_tld_state				:= input.is_tld_state;
	SELF.append_is_tld_generic 			:= input.is_tld_generic;
	SELF.append_is_tld_country 			:= input.is_tld_country;
	SELF.append_is_valid_domain_ext := input.is_valid_domain_ext;
	SELF.clean_email    						:= TRIM(SELF.append_email_username, LEFT,RIGHT) + '@' + TRIM(SELF.append_domain, LEFT,RIGHT);
	SELF.email_rec_key 							:= HASH64((data)TRIM(SELF.orig_first_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_last_name, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_address, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_city, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_state, LEFT, RIGHT) +
																						(data)TRIM(SELF.orig_zip, LEFT, RIGHT) +
																						(data)TRIM(SELF.clean_email, LEFT, RIGHT) + //using clean field as orig is pretty messy
                                            (data)TRIM(input.rawfields.WorkName, LEFT, RIGHT) +																						
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.orig_CompanyName						:= ut.CleanSpacesAndUpper(input.rawfields.WorkName);
	SELF.cln_CompanyName            := ut.CleanSpacesAndUpper(input.rawfields.WorkName);
	SELF.process_date               := '';
	SELF.rules											:= 0;
	SELF := input;
	SELF := [];
END;

t_mappend_f 	:= PROJECT(domain_d, t_map_to_common(LEFT));

addGlobalSID 	:= mdr.macGetGlobalSID(t_mappend_f,'EmailDataV2','email_src','global_sid'); //DF-25302: Populate Global_SID

RETURN addGlobalSID;
END;
