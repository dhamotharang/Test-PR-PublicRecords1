import PromoteSupers, prte2, ut, address, PromoteSupers, std, AID, AID_Support;

PRTE2.CleanFields(PRTE2_utility.files.infile,d_clean);

AddrClean := PRTE2.AddressCleaner(d_clean,   
                                              ['orig_addr1'],                                              
                                              ['dummy1'], 
                                              ['orig_city'],
                                              ['orig_st'],                                              
                                              ['orig_zip'],
                                              ['clean_address'],
                                              ['temp_rawaid']);

	

D_out	:=	Project(AddrClean,
Transform(layouts.base,
  	
	 SELF.prim_range	        := left.clean_address.prim_range;	
	 SELF.predir			        := left.clean_address.predir;
	 SELF.prim_name			      := left.clean_address.prim_name;	
	 SELF.addr_suffix					:= left.clean_address.addr_suffix;
	 SELF.postdir							:= left.clean_address.postdir;
	 SELF.unit_desig					:= left.clean_address.unit_desig;
	 SELF.sec_range						:= left.clean_address.sec_range;
	 SELF.p_city_name					:= left.clean_Address.p_city_name;
   SELF.v_city_name					:= left.clean_address.v_city_name;
	 SELF.st									:= left.clean_address.st;
	 SELF.zip 								:= left.clean_address.zip;
	 SELF.zip4								:= left.clean_address.zip4;
	 SELF.cart								:= left.clean_address.cart;
	 SELF.cr_sort_sz					:= left.clean_address.cr_sort_sz;
	 SELF.lot									:= left.clean_address.lot;
	 SELF.lot_order						:= left.clean_address.lot_order;
	 SELF.dbpc								:= left.clean_address.dbpc;
	 SELF.chk_digit						:= left.clean_address.chk_digit;
	 SELF.rec_type						:= left.clean_address.rec_type;
	 SELF.county			:= left.clean_address.fips_County;
	 SELF.geo_lat							:= left.clean_address.geo_lat;
	 SELF.geo_long						:= left.clean_address.geo_long;
	 SELF.msa									:= left.clean_address.msa;
	 SELF.geo_blk							:= left.clean_address.geo_blk;
	 SELF.geo_match						:= left.clean_address.geo_match;
	 SELF.err_stat						:= left.clean_address.err_stat;
	 self.company_name        := left.company_name;
	 
	 self.address_street := left.clean_address.prim_range;	
	 self.address_street_name  := left.clean_address.prim_name;
	 self.address_street_type:= left.clean_address.addr_suffix;
	 self.address_street_direction:= left.clean_address.postdir;
	 self.address_city:=left.orig_city;
	 self.address_state:=left.orig_st;
	 self.address_zip:=left.orig_zip;
	 Self.address_apartment := (varstring)Trim(left.clean_address.unit_desig) + ' ' +  (varstring)Trim(left.clean_address.sec_range);
													
  full_clean_name		:= Left.orig_fname + ' ' + left.orig_mname + ' ' + Left.orig_lname + ' ' + Left.orig_name_suffix;

  CleanName        := Address.CleanPersonFML73_fields(full_clean_name);
  SELF.title       := if(self.company_name!='','',CleanName.title);
  SELF.fname			 := if(self.company_name!='','',CleanName.fname);
  SELF.mname			 := if(self.company_name!='','',CleanName.mname);
  SELF.lname			 := if(self.company_name!='','',CleanName.lname);
  SELF.name_suffix := if(self.company_name!='','',CleanName.name_suffix);
  SELF.name_score  := if(self.company_name!='','',CleanName.name_score);   
	
	temp_did:=	(string12)prte2.fn_AppendFakeID.did(self.fname, self.lname, left.link_ssn, Left.link_dob, Left.cust_num);
	self.did:=if (self.company_name = '',temp_did,'0');
 
  temp_bdid:=(string12)prte2.fn_AppendFakeID.bdid(self.company_name,self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, left.cust_num);
  self.bdid:=If(self.company_name = '','0',temp_bdid);
                               
  vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.company_name, (string9)left.link_fein, left.link_inc_date, self.prim_range, self.prim_name, 
                 self.sec_range, self.v_city_name, self.st, self.zip, left.cust_num);
      
  SELF.powid  :=if(left.company_name ='',0,vLinkingIds.powid);
  SELF.proxid	:=if(left.company_name ='',0,vLinkingIds.proxid);
  SELF.seleid	:=if(left.company_name ='',0, vLinkingIds.seleid);
  SELF.orgid	:=if(left.company_name ='',0, vLinkingIds.orgid);
  SELF.ultid	:=if(left.company_name ='',0, vLinkingIds.ultid);	  
					
	self.source_rec_id := HASH64( left.id +
													 	  Left.exchange_serial_number +
															Left.date_first_seen +
															Left.date_added_to_exchange+
															Left.connect_date +
															Left.record_date +
															Left.util_type +
															Left.orig_lname +
															Left.orig_fname +
															Left.orig_mname +
															Left.orig_name_suffix +
															Left.dob +
															Left.addr_dual +
															Left.addr_type +
															Left.address_street +
															Left.address_street_Name +
															Left.address_street_Type +
															Left.address_street_direction +
															Left.address_apartment +
															Left.address_city +
															Left.address_state +
															Left.address_zip +
															Left.ssn +
															Left.work_phone +
															Left.phone +
															Left.drivers_license_state_code +
															Left.drivers_license +
															self.company_name);  

self := Left;
self := [];));

								
PromoteSupers.MAC_SF_BuildProcess(d_out, Constants.base_prefix_name, bld_base,,,true);

EXPORT proc_build_base := bld_base;
