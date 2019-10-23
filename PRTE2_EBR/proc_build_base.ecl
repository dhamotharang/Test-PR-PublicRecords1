import prte2, PromoteSupers, BIPV2, ut,prte_bip,std,prte2_DLV2,PromoteSupers,prte2,std,AID,Address;

 PRTE2.CleanFields(Files.IN_0010_Header, dsHeader_0010_Clean);
  
 AddressDataSet := PRTE2.AddressCleaner(dsHeader_0010_Clean,
	 ['street_address'],
	 ['addr2'],
	 ['city'],
	 ['state_code'],
	 ['orig_zip'],
	 ['clean_address'],
   ['orig_rawaid']);	
 
 DS_out	:=	Project(AddressDataSet,
 Transform(Layouts.File_0010_Header,
 
																															self.Clean_Address.prim_range		:= left.clean_address.prim_range;
																															self.Clean_Address.predir				:= left.clean_address.predir;
																															self.Clean_Address.prim_name		:= left.clean_address.prim_name;
																															self.Clean_Address.addr_suffix	:= left.clean_address.addr_suffix;
																															self.Clean_Address.postdir			:= left.clean_address.postdir;
																															self.Clean_Address.unit_desig		:= left.clean_address.unit_desig;
																															self.Clean_Address.sec_range		:= left.clean_address.sec_range;
																															self.Clean_Address.p_city_name	:= left.clean_address.p_city_name;
																															self.Clean_Address.v_city_name	:= left.clean_address.v_city_name;
																															self.Clean_Address.st						:= left.clean_address.st;
																															self.Clean_Address.zip					:= left.clean_address.zip;
																															self.Clean_Address.zip4					:= left.clean_address.zip4;
																															self.Clean_Address.cart					:= left.clean_address.cart;
																															self.Clean_Address.cr_sort_sz		:= left.clean_address.cr_sort_sz;
																															self.Clean_Address.lot					:= left.clean_address.lot;
																															self.Clean_Address.lot_order		:= left.clean_address.lot_order;
																															self.Clean_Address.dbpc					:= left.clean_address.dbpc;
																															self.Clean_Address.chk_digit		:= left.clean_address.chk_digit;
																															self.Clean_Address.rec_type			:= left.clean_address.rec_type;
																															self.Clean_Address.county				:= left.clean_address.fips_county;
																															self.Clean_Address.geo_lat			:= left.clean_address.geo_lat;
																															self.Clean_Address.geo_long			:= left.clean_address.geo_long;
																															self.Clean_Address.msa					:= left.clean_address.msa;
																															self.Clean_Address.geo_blk			:= left.clean_address.geo_blk;
																															self.Clean_Address.geo_match		:= left.clean_address.geo_match;
																															self.Clean_Address.err_stat			:= left.clean_address.err_stat;
																															self := left; self := []));


 rHeader_0010_File_old_work  := prte2.fn_PopulateLinkIDs(ds_out(Cust_name != 'LN_PR'), company_name);	

rHeader_0010_File_new:=Project(ds_out(cust_name='LN_PR'),
Transform(Layouts.File_0010_Header,
SELF.bdid := prte2.fn_AppendFakeID.bdid(left.company_name,	
                                        LEFT.clean_address.prim_range,	
																				LEFT.clean_address.prim_name, 
																				LEFT.clean_address.v_city_name, 
																				LEFT.clean_address.st,
																				LEFT.clean_address.zip,
																				left.cust_name);
																				
vLinkingIds := prte2.fn_AppendFakeID.LinkIds(Left.company_name,
                                            (string9)left.link_fein, 
																						 left.link_inc_date,
																						 LEFT.clean_address.prim_range, 
																						 LEFT.clean_address.prim_name, 
                                             LEFT.clean_address.sec_range, 
																						 LEFT.clean_address.v_city_name, 
																						 LEFT.clean_address.st, 
																						 LEFT.clean_address.zip, 
																						 Left.cust_name);
                                        
SELF.powid	:= vLinkingIds.powid;
SELF.proxid	:= vLinkingIds.proxid;
SELF.seleid	:= vLinkingIds.seleid;
SELF.orgid	:= vLinkingIds.orgid;
SELF.ultid	:= vLinkingIds.ultid;	 
self := left;));

 rHeader_0010_File_old:=Project(rHeader_0010_File_old_work,Layouts.File_0010_Header);

 rHeader_0010_File_combined:=rHeader_0010_File_old + rHeader_0010_File_new;

PRTE2.CleanFields(Files.IN_5600_Demographic_Data, clean_IN_5600_Demographic_Data);

dsDemographic_5600_File_new := JOIN(rHeader_0010_File_new,
                                 clean_IN_5600_Demographic_Data(Cust_name='LN_PR'), 
                                 LEFT.file_number = RIGHT.file_number,
                                 TRANSFORM(Layouts.File_5600_Demographic,
                                             SELF.bdid:=  LEFT.bdid;
																					   SELF.powid	:= left.powid;
                                             SELF.proxid	:= left.proxid;
                                             SELF.seleid	:= left.seleid;
                                             SELF.orgid	:= left.orgid;
                                             SELF.ultid	:= left.ultid;	 
																						 SELF := RIGHT;));
																						 
																						 
dsDemographic_5600_File_old :=  Project(clean_IN_5600_Demographic_Data(cust_name != 'LN_PR'),Layouts.File_5600_Demographic);                                                                                  
 
dsDemographic_5600_File_combined:=dsDemographic_5600_File_old + dsDemographic_5600_File_new; 

//This function does not work on that specific tired file
//PRTE2.CleanFields(Files.IN_5610_Demographic_Data, clean_IN_5610_Demographic_Data);

dsDemographic_5610_File_new := JOIN(rHeader_0010_File_new,
                                 Files.IN_5610_Demographic_Data(Cust_name='LN_PR'), 
                                 LEFT.file_number = RIGHT.file_number,
                                 TRANSFORM(Layouts.File_5610_Demographic,
                                             SELF.bdid:=  LEFT.bdid;
																					   SELF.powid	:= left.powid;
                                             SELF.proxid	:= left.proxid;
                                             SELF.seleid	:= left.seleid;
                                             SELF.orgid	:= left.orgid;
                                             SELF.ultid	:= left.ultid;
																						 self.clean_officer_name.fname:= std.str.ToUpperCase(trim(right.officer_first_name));
																						 self.clean_officer_name.mname:= std.str.toUpperCase(trim(right.officer_m_i));
																						 self.clean_officer_name.lname:= std.str.ToUpperCase(trim(right.officer_last_name));
																						 SELF.did :=  prte2.fn_AppendFakeID.did(self.clean_officer_name.fname, self.clean_officer_name.lname, right.link_ssn, right.link_dob, std.str.ToUpperCase(trim(right.cust_name)));
																						 SELF := RIGHT;));                                          
 
 
dsDemographic_5610_File_old:=project(Files.IN_5610_Demographic_Data(cust_name != 'LN_PR'),Layouts.File_5610_Demographic);

dsDemographic_5610_File_combined:=dsDemographic_5610_File_old + dsDemographic_5610_File_new;

dsDemographic_5610_File_combined_2 := project(dsDemographic_5610_File_combined, transform(Layouts.File_5610_Demographic, 
																																									 self.profit_range_actual := STD.Str.FindReplace(left.profit_range_actual,'000000{','0000000'),
																																									 self.net_worth_actual := STD.Str.FindReplace(left.net_worth_actual,'000000{','0000000'),
																																									 self := left; self := []));


 PromoteSupers.Mac_SF_BuildProcess(rHeader_0010_File_combined,Constants.base_prefix_name+'0010_header',header_0010_out,,,true);
 PromoteSupers.Mac_SF_BuildProcess(dsDemographic_5600_File_combined,Constants.base_prefix_name+'5600_demographic_data',demographic_5600_out,,,true);
 PromoteSupers.Mac_SF_BuildProcess(dsDemographic_5610_File_combined_2,Constants.base_prefix_name+'5610_demographic_data',demographic_5610_out,,,true);



EXPORT proc_build_base := sequential(header_0010_out,demographic_5600_out,demographic_5610_out);	

