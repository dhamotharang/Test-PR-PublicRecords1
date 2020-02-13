
IMPORT  UT, PromoteSupers, std, Prte2, Address, AID, AID_Support;

PRTE2.CleanFields(Files.incoming, clean_incoming);

dNewRecordsAddrClean := PRTE2.AddressCleaner(clean_incoming,   
                                              ['spons_dfe_mail_str_address'],                                              
                                              ['dummy1'], 
                                              ['spons_dfe_city'],
                                              ['spons_dfe_state'],                                              
                                              ['spons_dfe_zip_code'],
                                              ['clean_address'],
                                              ['temp_rawaid']);
																							
																							
layouts.base 		ConvertToBase(dNewRecordsAddrClean L) := transform
v_clean_name		:= Address.CleanPerson73_fields(STD.Str.CleanSpaces(L.spons_signed_name)); 
self.admin_signed_name			:= STD.Str.ToUpperCase(L.admin_signed_name);
self.spons_signed_name			:= STD.Str.ToUpperCase(L.spons_signed_name);
self.spons_sign_title				:= v_clean_name.title;
self.spons_sign_fname				:= v_clean_name.fname;
self.spons_sign_mname				:= v_clean_name.mname;
self.spons_sign_lname				:= v_clean_name.lname;
self.spons_sign_suffix			:= v_clean_name.name_suffix;
self.spons_sign_name_score 	:= (UNSIGNED1)v_clean_name.name_score;
self.spons_prim_range  	:=  L.clean_address.prim_range;
self.spons_predir  			:=  L.clean_address.predir;
self.spons_prim_name  	:=  L.clean_address.prim_name;
self.spons_addr_suffix  :=  L.clean_address.addr_suffix;
self.spons_postdir  		:=  L.clean_address.postdir;
self.spons_unit_desig  	:=  L.clean_address.unit_desig;
self.spons_sec_range  	:=  L.clean_address.sec_range;
self.spons_p_city_name  :=  L.clean_address.p_city_name;
self.spons_v_city_name  :=  L.clean_address.v_city_name;
self.spons_st						:=  L.clean_address.st;
self.spons_zip5  				:=  L.clean_address.zip;
self.spons_zip4  				:=  L.clean_address.zip4;
self.spons_cart  				:=  L.clean_address.cart;
self.spons_cr_sort_sz  	:=  L.clean_address.cr_sort_sz;
self.spons_lot  				:=  L.clean_address.lot;
self.spons_lot_order  	:=  L.clean_address.lot_order;
self.spons_dpbc  				:=  L.clean_address.dbpc;
self.spons_chk_digit  	:=  L.clean_address.chk_digit;
self.spons_rec_type  		:=  L.clean_address.rec_type;
self.spons_county  			:=  L.clean_address.fips_county;
self.spons_geo_lat  		:=  L.clean_address.geo_lat;
self.spons_geo_long  		:=  L.clean_address.geo_long;
self.spons_msa  				:=  L.clean_address.msa;
self.spons_geo_blk  		:=  L.clean_address.geo_blk;
self.spons_geo_match  	:=  L.clean_address.geo_match;
self.spons_err_stat  		:=  L.clean_address.err_stat;

alpha_did:=L.did;
boca_did := prte2.fn_AppendFakeID.did(self.spons_sign_fname, self.spons_sign_lname, L.link_ssn, L.link_dob, L.cust_name);
 
self.did :=If(L.Cust_name='IN_PR',alpha_did,boca_did); 

//self.did		:= 0;  	
self.bdid		:= prte2.fn_AppendFakeID.bdid(L.sponsor_dfe_name, self.spons_prim_range, self.spons_prim_name, self.spons_v_city_name, self.spons_st, self.spons_zip5, L.cust_name);
vLinkingIds := prte2.fn_AppendFakeID.LinkIds(L.sponsor_dfe_name, (string9)L.link_fein, L.link_inc_date, self.spons_prim_range, self.spons_prim_name, 
                self.spons_sec_range, self.spons_v_city_name, self.spons_st, self.spons_zip5, L.cust_name);
   	      	 	  SELF.powid	:= vLinkingIds.powid;
                SELF.proxid	:= vLinkingIds.proxid;
                SELF.seleid	:= vLinkingIds.seleid;
                SELF.orgid	:= vLinkingIds.orgid;
                SELF.ultid	:= vLinkingIds.ultid;	  

self := L;
self := [];
end;
outfile := project(dNewRecordsAddrClean(form_id<>''), ConvertToBase(Left)); 
				
ut.MAC_Append_Rcid(outfile,Source_rec_id,newfile);
									
PromoteSupers.MAC_SF_BuildProcess(newfile, Constants.base_prefix_name, bld_base,,,true);

EXPORT proc_build_base := bld_base;
