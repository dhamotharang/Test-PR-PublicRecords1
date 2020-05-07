import ut, PromoteSupers, PRTE2, STD, Address, AID_Support, AID, NID, mdr;

EXPORT proc_build_base(string filedate) := function

//uppercase and remove spaces from in files
	PRTE2.CleanFields(files.infile, cln_infile);
	
//clean address
	dAddressCleaned := PRTE2.AddressCleaner(cln_infile,
																					['Address_Line_1','IndividualOwner_Address_Line_1','BusinessOwner_Address_Line_1'],
																					['dummy1','dummy2', 'dummy3'], //blank field, not used but passed for attribute purposes
																					['City','IndividualOwner_Address_City','BusinessOwner_Address_City'],
																					['State','IndividualOwner_Address_State','BusinessOwner_Address_State'],
																					['Zip_Code_or_CA_Postal_Code','IndividualOwner_Address_Zip_Code_or_CA_Postal_Code','BusinessOwner_Address_Zip_Code_or_CA_Postal_Code'],
																					['clean_address', 'clean_address_indvowner', 'clean_address_busowner'],
																					['temp_rawaid', 'indvowner_rawaid','busowner_rawaid']
																					);	


PRTE2_business_credit.Layouts.base xform_Base(dAddressCleaned L) := TRANSFORM
		//clean Name
		v_clean_name := Address.CleanPersonFML73_fields(L.Original_fname + ' '+ L.Original_mname + ' '+ L.Original_lname + ' '+ L.Original_suffix);
		self.Clean_fname 	:= if(L.cust_name = 'IN_PR',L.Original_fname, v_clean_name.fname);
		self.Clean_mname 	:= if(L.cust_name = 'IN_PR',L.Original_mname, v_clean_name.mname);
		self.Clean_lname 	:= if(L.cust_name = 'IN_PR',L.Original_lname, v_clean_name.lname);
		self.Clean_suffix := if(L.cust_name = 'IN_PR',L.Original_suffix , v_clean_name.name_suffix);
		
		//Map Addresses
		self.rawaid				:= L.temp_rawaid;
		self.prim_range		:= L.clean_address.prim_range; 
		self.predir				:= L.clean_address.predir;	
		self.prim_name		:= L.clean_address.prim_name;	
		self.addr_suffix	:= L.clean_address.addr_suffix; 
		self.postdir			:= L.clean_address.postdir;	
		self.unit_desig		:= L.clean_address.unit_desig;	
		self.sec_range		:= L.clean_address.sec_range;	
		self.p_city_name	:= L.clean_address.p_city_name;	
		self.v_city_name	:= L.clean_address.v_city_name; 
		self.st						:= L.clean_address.st;	
		self.zip					:= L.clean_address.zip;	
		self.zip4					:= L.clean_address.zip4;	
		self.cart					:= L.clean_address.cart;	
		self.cr_sort_sz		:= L.clean_address.cr_sort_sz;	
		self.lot					:= L.clean_address.lot;	
		self.lot_order		:= L.clean_address.lot_order;	
		self.dbpc					:= L.clean_address.dbpc;	
		self.chk_digit		:= L.clean_address.chk_digit;	
		self.rec_type			:= L.clean_address.rec_type;	
		self.fips_state		:= L.clean_address.fips_state;	
		self.fips_county	:= L.clean_address.fips_county;	
		self.geo_lat			:= L.clean_address.geo_lat;	
		self.geo_long			:= L.clean_address.geo_long;	
		self.msa					:= L.clean_address.msa;	
		self.geo_blk			:= L.clean_address.geo_blk;	
		self.geo_match		:= L.clean_address.geo_match;	
		self.err_stat			:= L.clean_address.err_stat;	
	
	//clean individual address
		self.indvowner_rawaid				:= L.temp_rawaid;
		self.clean_indvowner.prim_range		:= L.clean_address_indvowner.prim_range; 
		self.clean_indvowner.predir				:= L.clean_address_indvowner.predir;	
		self.clean_indvowner.prim_name		:= L.clean_address_indvowner.prim_name;	
		self.clean_indvowner.addr_suffix	:= L.clean_address_indvowner.addr_suffix; 
		self.clean_indvowner.postdir			:= L.clean_address_indvowner.postdir;	
		self.clean_indvowner.unit_desig		:= L.clean_address_indvowner.unit_desig;	
		self.clean_indvowner.sec_range		:= L.clean_address_indvowner.sec_range;	
		self.clean_indvowner.p_city_name	:= L.clean_address_indvowner.p_city_name;	
		self.clean_indvowner.v_city_name	:= L.clean_address_indvowner.v_city_name; 
		self.clean_indvowner.st						:= L.clean_address_indvowner.st;	
		self.clean_indvowner.zip					:= L.clean_address_indvowner.zip;	
		self.clean_indvowner.zip4					:= L.clean_address_indvowner.zip4;	
		self.clean_indvowner.cart					:= L.clean_address_indvowner.cart;	
		self.clean_indvowner.cr_sort_sz		:= L.clean_address_indvowner.cr_sort_sz;	
		self.clean_indvowner.lot					:= L.clean_address_indvowner.lot;	
		self.clean_indvowner.lot_order		:= L.clean_address_indvowner.lot_order;	
		self.clean_indvowner.dbpc					:= L.clean_address_indvowner.dbpc;	
		self.clean_indvowner.chk_digit		:= L.clean_address_indvowner.chk_digit;	
		self.clean_indvowner.rec_type			:= L.clean_address_indvowner.rec_type;	
		self.clean_indvowner.fips_state		:= L.clean_address_indvowner.fips_state;	
		self.clean_indvowner.fips_county	:= L.clean_address_indvowner.fips_county;	
		self.clean_indvowner.geo_lat			:= L.clean_address_indvowner.geo_lat;	
		self.clean_indvowner.geo_long			:= L.clean_address_indvowner.geo_long;	
		self.clean_indvowner.msa					:= L.clean_address_indvowner.msa;	
		self.clean_indvowner.geo_blk			:= L.clean_address_indvowner.geo_blk;	
		self.clean_indvowner.geo_match		:= L.clean_address_indvowner.geo_match;	
		self.clean_indvowner.err_stat			:= L.clean_address_indvowner.err_stat;	
		
	//Business Owner Address
		self.busowner_rawaid							:= L.temp_rawaid;
		self.clean_busowner.prim_range		:= L.clean_address_busowner.prim_range; 
		self.clean_busowner.predir				:= L.clean_address_busowner.predir;	
		self.clean_busowner.prim_name			:= L.clean_address_busowner.prim_name;	
		self.clean_busowner.addr_suffix		:= L.clean_address_busowner.addr_suffix; 
		self.clean_busowner.postdir				:= L.clean_address_busowner.postdir;	
		self.clean_busowner.unit_desig		:= L.clean_address_busowner.unit_desig;	
		self.clean_busowner.sec_range			:= L.clean_address_busowner.sec_range;	
		self.clean_busowner.p_city_name		:= L.clean_address_busowner.p_city_name;	
		self.clean_busowner.v_city_name		:= L.clean_address_busowner.v_city_name; 
		self.clean_busowner.st						:= L.clean_address_busowner.st;	
		self.clean_busowner.zip						:= L.clean_address_busowner.zip;	
		self.clean_busowner.zip4					:= L.clean_address_busowner.zip4;	
		self.clean_busowner.cart					:= L.clean_address_busowner.cart;	
		self.clean_busowner.cr_sort_sz		:= L.clean_address_busowner.cr_sort_sz;	
		self.clean_busowner.lot						:= L.clean_address_busowner.lot;	
		self.clean_busowner.lot_order			:= L.clean_address_busowner.lot_order;	
		self.clean_busowner.dbpc					:= L.clean_address_busowner.dbpc;	
		self.clean_busowner.chk_digit			:= L.clean_address_busowner.chk_digit;	
		self.clean_busowner.rec_type			:= L.clean_address_busowner.rec_type;	
		self.clean_busowner.fips_state		:= L.clean_address_busowner.fips_state;	
		self.clean_busowner.fips_county		:= L.clean_address_busowner.fips_county;	
		self.clean_busowner.geo_lat				:= L.clean_address_busowner.geo_lat;	
		self.clean_busowner.geo_long			:= L.clean_address_busowner.geo_long;	
		self.clean_busowner.msa						:= L.clean_address_busowner.msa;	
		self.clean_busowner.geo_blk				:= L.clean_address_busowner.geo_blk;	
		self.clean_busowner.geo_match			:= L.clean_address_busowner.geo_match;	
		self.clean_busowner.err_stat			:= L.clean_address_busowner.err_stat;	
		
	//Append lexid(s)
		self.did	:= if(L.did > 0, L.did, prte2.fn_AppendFakeID.did(self.Clean_fname, self.Clean_lname, L.link_ssn, L.link_dob, L.cust_name));
		self.bdid := prte2.fn_AppendFakeID.bdid(L.account_holder_business_name, L.clean_address.prim_range, 
																						L.clean_address.prim_name, L.clean_address.v_city_name, 
																						L.clean_address.st, L.clean_address.zip, L.cust_name); 
		
		
		vLinkingIds :=  prte2.fn_AppendFakeID.LinkIds(L.account_holder_business_name, L.link_fein, L.link_inc_date, 
																									L.clean_address.prim_range, L.clean_address.prim_name, 
																									L.clean_address.sec_range, L.clean_address.v_city_name, 
																									L.clean_address.st, L.clean_address.zip, L.cust_name);
												 
		self.powid	:=  vLinkingIds.powid;
		self.proxid	:=  vLinkingIds.proxid;
		self.seleid	:=  vLinkingIds.seleid;
		self.orgid	:=  vLinkingIds.orgid;
		self.ultid	:=  vLinkingIds.ultid;
		
	//Populated dates
		self.dt_first_seen  									:= (unsigned)L.link_inc_date;
		self.dt_last_seen											:= (unsigned)L.process_date;
		self.dt_vendor_first_reported					:= (unsigned)L.link_inc_date;
		self.dt_vendor_last_reported					:= (unsigned)L.process_date;
		self.dt_datawarehouse_first_reported	:= (unsigned)L.link_inc_date;
		self.dt_datawarehouse_last_reported		:= (unsigned)L.process_date;
		
		self.source_record_id 								:= HASH64(	TRIM(L.Header_Sbfe_Contributor_Number,LEFT,RIGHT)+
																												TRIM(L.Original_Contract_Account_Number,LEFT,RIGHT)+
																												TRIM(L.Header_Extracted_Date,LEFT,RIGHT)+
																												TRIM(L.Header_Cycle_End_Date,LEFT,RIGHT)+
																												TRIM(L.Account_Holder_Business_Name,LEFT,RIGHT)+
																												TRIM(L.Parent_Sequence_Number,LEFT,RIGHT)+
																												TRIM(L.File_Sequence_Number,LEFT,RIGHT));
		self.source 								:= prte2_business_credit.constants.source;
		
		v_Account_Type_Reported := (integer)L.Account_Type_Reported;
		self.account_type_reported 	:= INTFORMAT(v_Account_Type_Reported,3,1);
		
		SELF	:= L;
		self	:= [];
  END;
	
	df_denormalized := project(dAddressCleaned, xform_Base(left));
	
//Populate global sids
	assign_global_sid := MDR.macGetGlobalSid(df_denormalized, 'SBFECV', '', 'global_sid');		
	
	PromoteSupers.MAC_SF_BuildProcess(assign_global_sid, prte2_business_credit.constants.base_prefix + 'denormalized', denormalized_out);	
   
	return denormalized_out;

end;