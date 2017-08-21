IMPORT PRTE2, PRTE2_MFind, PromoteSupers, Address;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

df_mfind :=  PROJECT
	(Files.file_IN(file_id <> ''), 
   TRANSFORM(	Layouts.layout_base,
							//address cleaning
							addr1 						:= TRIM(LEFT.str_addr_1  + ' ' + LEFT.str_addr_2);
							addrlast 					:= LEFT.city + ', ' + LEFT.state + ' ' + LEFT.orig_zip;
							addrclean182 			:= address.CleanAddress182(addr1, addrlast);
							SELF.prim_range		:=  address.CleanFields(addrclean182).prim_range;
							SELF.predir				:= 	address.CleanFields(addrclean182).predir;
							SELF.prim_name		:= 	address.CleanFields(addrclean182).prim_name;
							SELF.addr_suffix	:=  address.CleanFields(addrclean182).addr_suffix;
							SELF.postdir			:= 	address.CleanFields(addrclean182).postdir;
							SELF.unit_desig		:= 	address.CleanFields(addrclean182).unit_desig;
							SELF.sec_range		:= 	address.CleanFields(addrclean182).sec_range;
							SELF.p_city_name	:= 	address.CleanFields(addrclean182).p_city_name;
							SELF.v_city_name	:=  address.CleanFields(addrclean182).v_city_name;
							SELF.st						:= 	address.CleanFields(addrclean182).st;
							SELF.zip					:= 	address.CleanFields(addrclean182).zip;
							SELF.zip4					:= 	address.CleanFields(addrclean182).zip4;
							SELF.cart					:= 	address.CleanFields(addrclean182).cart;
							SELF.cr_sort_sz		:= 	address.CleanFields(addrclean182).cr_sort_sz;
							SELF.lot					:= 	address.CleanFields(addrclean182).lot;
							SELF.lot_order		:= 	address.CleanFields(addrclean182).lot_order;
							SELF.dbpc					:= 	address.CleanFields(addrclean182).dbpc;
							SELF.chk_digit		:= 	address.CleanFields(addrclean182).chk_digit;
							SELF.rec_type			:= 	address.CleanFields(addrclean182).rec_type;
							SELF.county				:=  address.CleanFields(addrclean182).county;
							SELF.geo_lat			:= 	address.CleanFields(addrclean182).geo_lat;
							SELF.geo_long			:= 	address.CleanFields(addrclean182).geo_long;
							SELF.msa					:= 	address.CleanFields(addrclean182).msa;
							SELF.geo_blk			:= 	address.CleanFields(addrclean182).geo_blk;
							SELF.geo_match		:= 	address.CleanFields(addrclean182).geo_match;
							SELF.err_stat			:= 	address.CleanFields(addrclean182).err_stat;
							//name
							SELF.title 				:= '';
							SELF.fname 				:= LEFT.curr_name_first;
							SELF.mname 				:= LEFT.curr_name_m_initial;
							SELF.lname 				:= LEFT.curr_name_last;
							SELF.name_suffix 	:= LEFT.curr_name_suffix;
							SELF.name_score 	:= '';
							//generating fake did
							SELF.did 					:= prte2.fn_AppendFakeID.did
																		(LEFT.curr_name_first, LEFT.curr_name_last, 
																		 LEFT.ssn, LEFT.dob, LEFT.cust_name);	
							SELF.trim_vid			 := TRIM(LEFT.trim_vid,all);
							//everything else
							SELF := LEFT;
						)
	);

PromoteSupers.MAC_SF_BuildProcess(df_mfind,Constants.base_mfind, writefile_base);

sequential(writefile_base);

Return 'success';
END;