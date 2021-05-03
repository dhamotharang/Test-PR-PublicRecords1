IMPORT Database_USA, address, ut, emailservice, mdr, _validate, Entiera, lib_StringLib, std, Email_Data;

EXPORT Map_DataBaseUSA_As_Email(version) := FUNCTION

infile     := Database_USA.Files().Base.Built;
with_email := infile(TRIM(email) <> '');

//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(with_email,domain_d,Email);
			
//************Transform to a common email layout
Email_DataV2.Layouts.Base_BIP t_map_to_common (domain_d input) := TRANSFORM
	SELF.email_src        					:= mdr.sourceTools.src_DataBase_USA;
	SELF.current_rec      					:= true;
	SELF.activecode     						:= '';
	SELF.did_type         					:= '';
	SELF.orig_pmghousehold_id  			:= '';
	SELF.orig_pmgindividual_id 			:= '';
	SELF.orig_First_Name  					:= STD.Str.CleanSpaces(input.First_Name);
	SELF.orig_Last_Name  						:= STD.Str.CleanSpaces(input.Last_Name);
	SELF.Orig_Address  							:= stringlib.stringtouppercase(TRIM(StringLib.StringCleanSpaces(input.Phy_Addr_Standardized), LEFT, RIGHT));
	SELF.Orig_City  								:= input.Phy_Addr_City;
	SELF.Orig_State  								:= input.Phy_Addr_State;
	SELF.orig_ZIP  									:= input.Phy_Addr_Zip;
	SELF.orig_zip4  								:= input.Phy_Addr_Zip4;
	SELF.orig_email 								:= STD.Str.CleanSpaces(input.Email);
	SELF.orig_ip  									:= '';
	SELF.orig_site  								:= STD.Str.CleanSpaces(input.URL);
	SELF.orig_e360_id  							:= '';
	SELF.orig_teramedia_id  				:= '';
	// SELF.orig_dob										:= input.dob;
	SELF.clean_name.title  					:= '';
	SELF.clean_name.fname  					:= input.fname;;
	SELF.clean_name.mname  					:= input.mname;
	SELF.clean_name.lname  					:= input.lname;
	SELF.clean_name.name_suffix  		:= input.name_suffix;
	SELF.clean_name.name_score  		:= input.name_score;
	SELF.clean_address.prim_range 	:= input.phy_prim_range;
	SELF.clean_address.predir  			:= input.phy_predir;
	SELF.clean_address.prim_name  	:= input.phy_prim_name;
	SELF.clean_address.addr_suffix	:= input.phy_addr_suffix;
	SELF.clean_address.postdir  		:= input.phy_postdir;
	SELF.clean_address.unit_desig 	:= input.phy_unit_desig;
	SELF.clean_address.sec_range  	:= input.phy_sec_range;
	SELF.clean_address.p_city_name 	:= input.phy_p_city_name;
	SELF.clean_address.v_city_name 	:= input.phy_v_city_name;
	SELF.clean_address.st  					:= input.phy_st;
	SELF.clean_address.zip  				:= input.phy_zip;
	SELF.clean_address.zip4  				:= input.phy_zip4;
	SELF.clean_address.cart  				:= input.phy_cart;
	SELF.clean_address.cr_sort_sz  	:= input.phy_cr_sort_sz;
	SELF.clean_address.lot  				:= input.phy_lot;
	SELF.clean_address.lot_order  	:= input.phy_lot_order;
	SELF.clean_address.dbpc  				:= input.phy_dbpc;
	SELF.clean_address.chk_digit  	:= input.phy_chk_digit;
	SELF.clean_address.rec_type  		:= input.phy_rec_type;
	SELF.clean_address.county  			:= input.phy_fips_county;
	SELF.clean_address.geo_lat  		:= input.phy_geo_lat;
	SELF.clean_address.geo_long  		:= input.phy_geo_long;
	SELF.clean_address.msa  				:= input.phy_msa;
	SELF.clean_address.geo_blk  		:= input.phy_geo_blk;
	SELF.clean_address.geo_match  	:= input.phy_geo_match;
	SELF.clean_address.err_stat  		:= input.phy_err_stat;
	SELF.append_rawaid  						:= input.phy_raw_aid;
	SELF.clean_ssn 									:= '';
	// SELF.clean_dob 									:= (integer)input.dob;
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
																						// (data)TRIM(SELF.orig_dob, LEFT, RIGHT) +
																						// (data)TRIM(input.clean_cname, LEFT, RIGHT) +
																						(data)TRIM(SELF.email_src, LEFT, RIGHT));
	SELF.orig_CompanyName						:= ut.CleanSpacesAndUpper(input.Company_Name);
	SELF.cln_CompanyName						:= ut.CleanSpacesAndUpper(input.Company_Name);	
	SELF.process_date               := (string8)input.process_date;

	SELF.rules											:= 0;
	SELF := input;
	SELF := [];
END;

t_mappend_f 	:= PROJECT(domain_d, t_map_to_common(LEFT));

addGlobalSID 	:= mdr.macGetGlobalSID(t_mappend_f,'EmailDataV2','email_src','global_sid'); //DF-25302: Populate Global_SID

RETURN addGlobalSID;
END;