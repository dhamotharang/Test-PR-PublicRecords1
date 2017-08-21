import PromoteSupers, prte2, BIPV2,prte_bip,std,ut, address;

//Process File
Layouts.base		xConvertFile(Files.infile L) := transform

//Name Cleaning
v_clean_name		:= Address.CleanPersonFML73(STD.Str.CleanSpaces(L.orig_fname+' '+L.orig_mname+' '+L.orig_lname+' '+L.orig_name_suffix));

//Address Cleaning
v_prep_line1  	:= STD.Str.CleanSpaces(L.address_street+' '+ L.address_street_Name+ ' '+ L.address_street_Type+ ' '
																			 +L.address_street_direction+ ' '+L.address_apartment);
v_prep_line2		:= STD.Str.CleanSpaces(L.address_city+ ' ' +L.address_state+ ' ' +L.address_zip);																			 

clean_address		:= Address.CleanAddress182(v_prep_line1, v_prep_line2);
	
self.title				:= v_clean_name[1..5];
self.fname				:= v_clean_name[6..25];
self.mname				:= v_clean_name[26..45];
self.lname				:= v_clean_name[46..65];
self.name_suffix	:= v_clean_name[66..70];
self.name_score 	:= v_clean_name[71..73];
self.company_name := '';
self.prim_range  	:=  clean_address[1..10];
self.predir  			:=  clean_address[11..12];
self.prim_name  	:=  clean_address[13..40];
self.addr_suffix  :=  clean_address[41..44];
self.postdir  		:=  clean_address[45..46];
self.unit_desig  	:=  clean_address[47..56];
self.sec_range  	:=  clean_address[57..64];
self.p_city_name  :=  clean_address[65..89];
self.v_city_name  :=  clean_address[90..114];
self.st						:=  clean_address[115..116];
self.zip  				:=  clean_address[117..121];
self.zip4  				:=  clean_address[122..125];
self.cart  				:=  clean_address[126..129];
self.cr_sort_sz  	:=  clean_address[130];
self.lot  				:=  clean_address[131..134];
self.lot_order  	:=  clean_address[135];
self.dbpc  				:=  clean_address[136..137];
self.chk_digit  	:=  clean_address[138];
self.rec_type  		:=  clean_address[139..140];
self.county  			:=  clean_address[141..145];
self.geo_lat  		:=  clean_address[146..155];
self.geo_long  		:=  clean_address[156..166];
self.msa  				:=  clean_address[167..170];
self.geo_blk  		:=  clean_address[171..177];
self.geo_match  	:=  clean_address[178];
self.err_stat  		:=  clean_address[179..182];

self.source_rec_id := HASH64( ut.CleanSpacesAndUpper(L.id +
													 	  L.exchange_serial_number +
															L.date_first_seen +
															L.date_added_to_exchange+
															L.connect_date +
															L.record_date +
															L.util_type +
															L.orig_lname +
															L.orig_fname +
															L.orig_mname +
															L.orig_name_suffix +
															L.dob +
															L.addr_dual +
															L.addr_type +
															L.address_street +
															L.address_street_Name +
															L.address_street_Type +
															L.address_street_direction +
															L.address_apartment +
															L.address_city +
															L.address_state +
															L.address_zip +
															L.ssn +
															L.work_phone +
															L.phone +
															L.drivers_license_state_code +
															L.drivers_license +
															self.company_name));  
//Appending DID
self.bdid		:= (string12)prte2.fn_AppendFakeID.bdid(self.company_name, self.prim_range, self.prim_range, self.v_city_name, self.st, self.zip, L.cust_num); 	  
self.did		:= (string12)prte2.fn_AppendFakeID.did(self.fname, self.lname, L.ssn, L.dob, L.cust_num); 	
self := L;
self := [];
end;															

incoming_file := project(Files.infile, xConvertFile(left)); 
										
//Populate LinkID fields

PromoteSupers.MAC_SF_BuildProcess(incoming_file, Constants.base_prefix_name, bld_base,,,true);

EXPORT proc_build_base := bld_base;