IMPORT PRTE2_DEADCO, InfoUSA, PRTE2, ut, Address, STD, PromoteSupers, AID, AID_Support;

//Input
PRTE2.CleanFields(PRTE2_Deadco.files.Deadco_in,d_clean);
	
//Base file - keeps consistent sequence by only sequencing new records
	dMainBase := PRTE2_DEADCO.Files.DEADCO_BaseAID_ext;
	
  dNewRecordsAddrClean := PRTE2.AddressCleaner(d_clean,   
                                              ['street1'],                                              
                                              ['dummy1'], 
                                              ['city1'],
                                              ['state1'],                                              
                                              ['zip1_5'],
                                              ['clean_address'],
                                              ['temp_rawaid']);

D_out	:=	Project(dNewRecordsAddrClean,
Transform(layouts.DEADCO_base_ext,

 CleanName        := Address.CleanPersonFML73_fields(left.contact_name);
  SELF.title			  := CleanName.title;
  SELF.fname				:= CleanName.fname;
  SELF.mname				:= CleanName.mname;
  SELF.lname				:= CleanName.lname;
  SELF.name_suffix	:= CleanName.name_suffix;
  SELF.name_cleaning_score := CleanName.name_score;         
  		
	 SELF.append_rawaid       :=left.temp_rawaid;
	 SELF.prim_range	        :=  left.clean_address.prim_range;	
	 SELF.predir			        :=	left.clean_address.predir;
	 SELF.prim_name			      :=left.clean_address.prim_name;	
	 SELF.addr_suffix					:= left.clean_address.addr_suffix;
	 SELF.postdir							:= left.clean_address.postdir;
	 SELF.unit_desig					:= left.clean_address.unit_desig;
	 SELF.sec_range						:= left.clean_address.sec_range;
	 SELF.p_city_name					:= left.clean_Address.p_city_name;
   SELF.v_city_name					:= left.clean_address.v_city_name;
	 SELF.st									:= left.clean_address.st;
	 SELF.zip5								:= left.clean_address.zip;
	 SELF.zip4								:= left.clean_address.zip4;
	 SELF.cart								:= left.clean_address.cart;
	 SELF.cr_sort_sz					:= left.clean_address.cr_sort_sz;
	 SELF.lot									:= left.clean_address.lot;
	 SELF.lot_order						:= left.clean_address.lot_order;
	 SELF.dpbc								:= left.clean_address.dbpc;
	 SELF.chk_digit						:= left.clean_address.chk_digit;
	 SELF.rec_type						:= left.clean_address.rec_type;
	 SELF.ace_fips_st					:= left.clean_address.fips_state;
 	 SELF.ace_fips_county			:= left.clean_address.fips_County;
	 SELF.geo_lat							:= left.clean_address.geo_lat;
	 SELF.geo_long						:= left.clean_address.geo_long;
	 SELF.msa									:= left.clean_address.msa;
	 SELF.geo_blk							:= left.clean_address.geo_blk;
	 SELF.geo_match						:= left.clean_address.geo_match;
	 SELF.err_stat						:=left.clean_address.err_stat;
	 SELF.prep_addr_line1			:= left.street1;
	 SELF.prep_addr_last_line	:= address.Addr2FromComponents(Left.CITY1, Left.STATE1, Left.ZIP1_5[1..5]);
	 SELF.BDID								:= Prte2.fn_AppendFakeID.bdid((string)Left.COMPANY_NAME, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip5, left.cust_name);
	 
	 vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.company_name, (string9)left.fein, left.inc_date, self.prim_range, self.prim_name, 
                  self.sec_range, self.v_city_name, self.st, self.zip5, left.cust_name);
                                        
                   SELF.powid	:= vLinkingIds.powid;
                   SELF.proxid	:= vLinkingIds.proxid;
                   SELF.seleid	:= vLinkingIds.seleid;
                   SELF.orgid	:= vLinkingIds.orgid;
                   SELF.ultid	:= vLinkingIds.ultid;	   
	 
   SELF := left;
	 SELF := [];));
	
	//Add source_rec_id
	ut.MAC_Append_Rcid(d_out, source_rec_id, full_file_recid);
	
	PromoteSupers.Mac_SF_BuildProcess(full_file_recid, Constants.BASE_PREFIX + 'infousa::deadco', build_base);
			
  EXPORT proc_build_base	:= build_base;
	
