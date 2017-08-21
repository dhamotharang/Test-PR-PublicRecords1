import prte2, PromoteSupers, BIPV2, ut,prte_bip,std;


//Process Header File
dsHeader_0010_File := project(Files.IN_0010_Header, transform(Layouts.File_0010_Header, 
																															self.Clean_Address.prim_range		:= left.prim_range;
																															self.Clean_Address.predir				:= left.predir;
																															self.Clean_Address.prim_name		:= left.prim_name;
																															self.Clean_Address.addr_suffix	:= left.addr_suffix;
																															self.Clean_Address.postdir			:= left.postdir;
																															self.Clean_Address.unit_desig		:= left.unit_desig;
																															self.Clean_Address.sec_range		:= left.sec_range;
																															self.Clean_Address.p_city_name	:= left.p_city_name;
																															self.Clean_Address.v_city_name	:= left.v_city_name;
																															self.Clean_Address.st						:= left.st;
																															self.Clean_Address.zip					:= left.zip;
																															self.Clean_Address.zip4					:= left.zip4;
																															self.Clean_Address.cart					:= left.cart;
																															self.Clean_Address.cr_sort_sz		:= left.cr_sort_sz;
																															self.Clean_Address.lot					:= left.lot;
																															self.Clean_Address.lot_order		:= left.lot_order;
																															self.Clean_Address.dbpc					:= left.dbpc;
																															self.Clean_Address.chk_digit		:= left.chk_digit;
																															self.Clean_Address.rec_type			:= left.rec_type;
																															self.Clean_Address.county				:= left.county;
																															self.Clean_Address.geo_lat			:= left.geo_lat;
																															self.Clean_Address.geo_long			:= left.geo_long;
																															self.Clean_Address.msa					:= left.msa;
																															self.Clean_Address.geo_blk			:= left.geo_blk;
																															self.Clean_Address.geo_match		:= left.geo_match;
																															self.Clean_Address.err_stat			:= left.err_stat;
																															self := left; self := []));
rHeader_0010_File  := prte2.fn_PopulateLinkIDs(dsHeader_0010_File, company_name);	

//Process Demograohic Data Files
dsDemographic_5600_File := project(Files.IN_5600_Demographic_Data, transform(Layouts.File_5600_Demographic, self := left; self := []));
dsDemographic_5610_File := project(Files.IN_5610_Demographic_Data, transform(Layouts.File_5610_Demographic, 
																																									self.profit_range_actual := STD.Str.FindReplace(left.profit_range_actual,'000000{','0000000'),
																																									self.net_worth_actual := STD.Str.FindReplace(left.net_worth_actual,'000000{','0000000'),
																																									self := left; self := []));


PromoteSupers.Mac_SF_BuildProcess(rHeader_0010_File,Constants.base_prefix_name+'0010_header',header_0010_out,,,true);
PromoteSupers.Mac_SF_BuildProcess(dsDemographic_5600_File,Constants.base_prefix_name+'5600_demographic_data',demographic_5600_out,,,true);
PromoteSupers.Mac_SF_BuildProcess(dsDemographic_5610_File,Constants.base_prefix_name+'5610_demographic_data',demographic_5610_out,,,true);



EXPORT proc_build_base := sequential(header_0010_out,demographic_5600_out,demographic_5610_out);	