
Import ut, aid, data_services,AID_Support,PromoteSupers,RoxieKeyBuild,prte2,address,header, prte2, std, PRTE2_LNProperty;

EXPORT Build_Deed_Tax_Base(String filedate) := FUNCTION

alpha_deed_file:=Project(files.ln_propertyv2_alpha_deed,TRANSFORM(Layouts.prte__ln_propertyV2__base__deed,
													SELF := LEFT, 
													SELF := []));	
													

deed_file_accum:= dedup(alpha_deed_file + Files.ln_propertyv2_deed_in, record, all);													


Layouts.layout_deed_mortgage_common_model_base_ext PhysicalAddress(layouts.prte__ln_propertyV2__base__deed L, INTEGER C) :=	TRANSFORM
						SELF.deed_row_id := C;
						SELF          := L;
						SELF          := [];
	END;
	

deed_file := PROJECT(deed_file_accum(cust_name!=''), PhysicalAddress(LEFT,COUNTER));
deed_file_untouched := PROJECT(deed_file_accum(cust_name=''), PhysicalAddress(LEFT,COUNTER));
PRTE2.CleanFields(deed_file, deed_file_clean);

ut.MAC_Append_Rcid (deed_file_clean,deed_row_id,deed_file_seq);

alpha_tax_file:=Project(files.ln_propertyv2_alpha_tax,TRANSFORM(Layouts.prte__ln_propertyV2__base__tax,
													SELF := LEFT, 
													SELF := []));	
				
tax_file_accum:= dedup(alpha_tax_file + Files.ln_propertyv2_tax_in, record, all);			

Layouts.layout_property_common_model_base_ext PhysicalAddress2(layouts.prte__ln_propertyV2__base__tax L, INTEGER C) :=	TRANSFORM
						SELF.tax_row_id := C;
						SELF          := L;
						SELF          := [];
	END;
	
tax_file := PROJECT(tax_file_accum(cust_name!=''), PhysicalAddress2(LEFT,COUNTER));
tax_file_untouched := PROJECT(tax_file_accum(cust_name=''), PhysicalAddress2(LEFT,COUNTER));
PRTE2.CleanFields(tax_file, tax_file_clean);

ut.MAC_Append_Rcid (tax_file_clean,tax_row_id,tax_file_seq); 
						
deed_addr := PROJECT(deed_file_clean(cust_name <> ''), 
                             TRANSFORM(Layouts.temp_address_layout,
                             SELF.deed_row_id := LEFT.deed_row_id;
																			          SELF := LEFT; 
                             SELF := []
                                       )										
                                    );

tax_addr := PROJECT(tax_file_clean(cust_name <> ''), 
                    TRANSFORM(Layouts.temp_address_layout,
                    SELF.tax_row_id := LEFT.tax_row_id;
																			 SELF.tax_mailing_full_street_address :=LEFT.mailing_full_street_address;
																			 SELF. tax_mailing_city_state_zip :=LEFT.mailing_city_state_zip;
                    SELF.tax_property_full_street_address :=LEFT.property_full_street_address;
																			 SELF. tax_property_city_state_zip :=LEFT.property_city_state_zip;
																			 SElF := LEFT; 
                                       SELF := []
                                       )
                                     ); 
																		 
all_addr := deed_addr + tax_addr; 
														 
														 
 d_all_addr_cleaned := PRTE2.AddressCleaner(all_addr,  
 ['mailing_street', 'seller_mailing_full_street_address', 'property_full_street_address', 'lender_full_street_address','tax_mailing_full_street_address','tax_property_full_street_address'],
 ['mailing_csz', 'seller_mailing_address_citystatezip', 'property_address_citystatezip', 'lender_address_citystatezip','tax_mailing_city_state_zip','tax_property_city_state_zip'],
 [],
 [],
 [],
 ['mail_address', 'seller_address', 'property_address', 'lender_address', 'tax_mail_address','tax_property_address'],
 ['mail_address_rawaid', 'seller_address_rawaid', 'property_address_rawaid', 'lender_address_rawaid','tax_mail_address_rawaid','tax_property_address_rawaid']);
                                          
	
	deed_OldRecords := deed_file_seq(cust_name = '');
  deed_NewRecords	:= deed_file_seq(cust_name <> '');  
	
	deed_NewRecordsClean := JOIN(d_all_addr_cleaned,
                                 deed_NewRecords, 
                                 LEFT.deed_row_id = RIGHT.deed_row_id,
                                 TRANSFORM( Layouts.layout_deed_mortgage_common_model_base_ext,
                               	 self.deed_mail_prim_range := left.mail_address.prim_range;
                                 self.deed_mail_predir := left.mail_address.predir;
                                 self.deed_mail_prim_name := left.mail_address.prim_name;
                                 self.deed_mail_addr_suffix := left.mail_address.addr_suffix;
                                 self.deed_mail_postdir := left.mail_address.postdir;
                                 self.deed_mail_unit_desig := left.mail_address.unit_desig;
                                 self.deed_mail_sec_range := left.mail_address.sec_range;
                                 self.deed_mail_p_city_name := left.mail_address.p_city_name;
                                 self.deed_mail_v_city_name := left.mail_address.v_city_name;
                                 self.deed_mail_state := left.mail_address.st;
                                 self.deed_mail_zip5 := left.mail_address.zip;
                                 self.deed_mail_zip4 := left.mail_address.zip4;
                                 self.deed_mail_cart := left.mail_address.cart;
                                 self.deed_mail_cr_sort_sz := left.mail_address.cr_sort_sz;
                                 self.deed_mail_lot := left.mail_address.lot;
                                 self.deed_mail_lot_order := left.mail_address.lot_order;
                                 self.deed_mail_dpbc := left.mail_address.dbpc;
                                 self.deed_mail_chk_digit := left.mail_address.chk_digit;
                                 self.deed_mail_rec_type := left.mail_address.rec_type;
                                 self.deed_mail_fips_st := left.mail_address.fips_state;
                                 self.deed_mail_fips_county := left.mail_address.fips_county;
                                 self.deed_mail_geo_lat := left.mail_address.geo_lat;
                                 self.deed_mail_geo_long := left.mail_address.geo_long;
                                 self.deed_mail_msa := left.mail_address.msa;
                                 self.deed_mail_geo_blk := left.mail_address.geo_blk;
                                 self.deed_mail_geo_match := left.mail_address.geo_match;
                                 self.deed_mail_err_stat := left.mail_address.err_stat;
																 
																                 self.deed_seller_prim_range := left.seller_address.prim_range;
                                 self.deed_seller_predir := left.seller_address.predir;
                                 self.deed_seller_prim_name := left.seller_address.prim_name;
                                 self.deed_seller_addr_suffix := left.seller_address.addr_suffix;
                                 self.deed_seller_postdir := left.seller_address.postdir;
                                 self.deed_seller_unit_desig := left.seller_address.unit_desig;
                                 self.deed_seller_sec_range := left.seller_address.sec_range;
                                 self.deed_seller_p_city_name := left.seller_address.p_city_name;
                                 self.deed_seller_v_city_name := left.seller_address.v_city_name;
                                 self.deed_seller_state := left.seller_address.st;
                                 self.deed_seller_zip5 := left.seller_address.zip;
                                 self.deed_seller_zip4 := left.seller_address.zip4;
                                 self.deed_seller_cart := left.seller_address.cart;
                                 self.deed_seller_cr_sort_sz := left.seller_address.cr_sort_sz;
                                 self.deed_seller_lot := left.seller_address.lot;
                                 self.deed_seller_lot_order := left.seller_address.lot_order;
                                 self.deed_seller_dpbc := left.seller_address.dbpc;
                                 self.deed_seller_chk_digit := left.seller_address.chk_digit;
                                 self.deed_seller_rec_type := left.seller_address.rec_type;
                                 self.deed_seller_fips_st := left.seller_address.fips_state;
                                 self.deed_seller_fips_county := left.seller_address.fips_county;
                                 self.deed_seller_geo_lat := left.seller_address.geo_lat;
                                 self.deed_seller_geo_long := left.seller_address.geo_long;
                                 self.deed_seller_msa := left.seller_address.msa;
                                 self.deed_seller_geo_blk := left.seller_address.geo_blk;
                                 self.deed_seller_geo_match := left.seller_address.geo_match;
                                 self.deed_seller_err_stat := left.seller_address.err_stat;
																
															   self.owner_bdid := if(right.name1_link_fein !='' and right.name1 !='', prte2.fn_AppendFakeID.bdid(right.name1, self.deed_mail_prim_range, 
									               self.deed_mail_prim_name, self.deed_mail_v_city_name, self.deed_mail_state,self.deed_mail_zip5,'LN_PR'),0); 
                                 
																 
																 vLinkingIds :=  prte2.fn_AppendFakeID.LinkIds(right.name1, right.name1_link_fein, right.name1_link_inc_date, 
 									                          self.deed_mail_prim_range, self.deed_mail_prim_name, self.deed_mail_sec_range, self.deed_mail_v_city_name, self.deed_mail_state, self.deed_mail_zip5, 'LN_PR');
												 
											       self.owner_powid	:=  if (right.name1_link_fein !='' and right.name1 !='',vLinkingIds.powid, 0);
			               self.owner_proxid	:=  if (right.name1_link_fein !='' and right.name1 !='',vLinkingIds.proxid, 0) ;
			               self.owner_seleid	:=  if (right.name1_link_fein !='' and right.name1 !='',vLinkingIds.seleid, 0) ;
			               self.owner_orgid	:=  if (right.name1_link_fein !='' and right.name1 !='',vLinkingIds.orgid, 0) ;
		                self.owner_ultid	:=  if (right.name1_link_fein !='' and right.name1 !='',vLinkingIds.ultid, 0);
																														
																	 self.seller_bdid := if(right.seller1_link_fein !='' and right.seller1 !='', prte2.fn_AppendFakeID.bdid(right.seller1, self.deed_seller_prim_range, 
									              self.deed_seller_prim_name, self.deed_seller_v_city_name, self.deed_seller_state,self.deed_seller_zip5,'LN_PR'),0); 
                 
								         vLinkingIds_2 :=  prte2.fn_AppendFakeID.LinkIds(right.seller1, right.seller1_link_fein, right.seller1_link_inc_date, 
 									                          self.deed_seller_prim_range, self.deed_seller_prim_name, self.deed_seller_sec_range, self.deed_seller_v_city_name, self.deed_seller_state, self.deed_seller_zip5, 'LN_PR');																  
																	self.seller_powid	:=  if (right.seller1_link_fein !='' and right.seller1 !='',vLinkingIds_2.powid, 0);
			              self.seller_proxid	:=  if (right.seller1_link_fein !='' and right.seller1 !='',vLinkingIds_2.proxid, 0) ;
			              self.seller_seleid	:=  if (right.seller1_link_fein !=''  and right.seller1 !='',vLinkingIds_2.seleid, 0) ;
			              self.seller_orgid	:=  if (right.seller1_link_fein !='' and right.seller1 !='',vLinkingIds_2.orgid, 0) ;
		               self.seller_ultid	:=  if (right.seller1_link_fein != '' and right.seller1 !='',vLinkingIds_2.ultid, 0);
																 
																                 self.deed_property_prim_range := left.property_address.prim_range;
                                 self.deed_property_predir := left.property_address.predir;
                                 self.deed_property_prim_name := left.property_address.prim_name;
                                 self.deed_property_addr_suffix := left.property_address.addr_suffix;
                                 self.deed_property_postdir := left.property_address.postdir;
                                 self.deed_property_unit_desig := left.property_address.unit_desig;
                                 self.deed_property_sec_range := left.property_address.sec_range;
                                 self.deed_property_p_city_name := left.property_address.p_city_name;
                                 self.deed_property_v_city_name := left.property_address.v_city_name;
                                 self.deed_property_state := left.property_address.st;
                                 self.deed_property_zip5 := left.property_address.zip;
                                 self.deed_property_zip4 := left.property_address.zip4;
                                 self.deed_property_cart := left.property_address.cart;
                                 self.deed_property_cr_sort_sz := left.property_address.cr_sort_sz;
                                 self.deed_property_lot := left.property_address.lot;
                                 self.deed_property_lot_order := left.property_address.lot_order;
                                 self.deed_property_dpbc := left.property_address.dbpc;
                                 self.deed_property_chk_digit := left.property_address.chk_digit;
                                 self.deed_property_rec_type := left.property_address.rec_type;
                                 self.deed_property_fips_st := left.property_address.fips_state;
                                 self.deed_property_fips_county := left.property_address.fips_county;
                                 self.deed_property_geo_lat := left.property_address.geo_lat;
                                 self.deed_property_geo_long := left.property_address.geo_long;
                                 self.deed_property_msa := left.property_address.msa;
                                 self.deed_property_geo_blk := left.property_address.geo_blk;
                                 self.deed_property_geo_match := left.property_address.geo_match;
                                 self.deed_property_err_stat := left.property_address.err_stat;
																 
																                 self.deed_lender_prim_range := left.lender_address.prim_range;
                                 self.deed_lender_predir := left.lender_address.predir;
                                 self.deed_lender_prim_name := left.lender_address.prim_name;
                                 self.deed_lender_addr_suffix := left.lender_address.addr_suffix;
                                 self.deed_lender_postdir := left.lender_address.postdir;
                                 self.deed_lender_unit_desig := left.lender_address.unit_desig;
                                 self.deed_lender_sec_range := left.lender_address.sec_range;
                                 self.deed_lender_p_city_name := left.lender_address.p_city_name;
                                 self.deed_lender_v_city_name := left.lender_address.v_city_name;
                                 self.deed_lender_state := left.lender_address.st;
                                 self.deed_lender_zip5 := left.lender_address.zip;
                                 self.deed_lender_zip4 := left.lender_address.zip4;
                                 self.deed_lender_cart := left.lender_address.cart;
                                 self.deed_lender_cr_sort_sz := left.lender_address.cr_sort_sz;
                                 self.deed_lender_lot := left.lender_address.lot;
                                 self.deed_lender_lot_order := left.lender_address.lot_order;
                                 self.deed_lender_dpbc := left.lender_address.dbpc;
                                 self.deed_lender_chk_digit := left.lender_address.chk_digit;
                                 self.deed_lender_rec_type := left.lender_address.rec_type;
                                 self.deed_lender_fips_st := left.lender_address.fips_state;
                                 self.deed_lender_fips_county := left.lender_address.fips_county;
                                 self.deed_lender_geo_lat := left.lender_address.geo_lat;
                                 self.deed_lender_geo_long := left.lender_address.geo_long;
                                 self.deed_lender_msa := left.lender_address.msa;
                                 self.deed_lender_geo_blk := left.lender_address.geo_blk;
                                 self.deed_lender_geo_match := left.lender_address.geo_match;
                                 self.deed_lender_err_stat := left.lender_address.err_stat;
																 self.record_type := self.deed_property_rec_type;
																 self.fips_code := self.deed_property_fips_st + self.deed_property_fips_county;
																 self.county_name := Address.County_Names(state_code=self.deed_property_fips_st AND county_code=self.deed_property_fips_county)[1].county_name;
																 SELF := RIGHT;                                 
																 SELF := [];));                                  
                                    


 df_deed := deed_NewRecordsClean + deed_file_untouched;
   
 df_deed_out :=  Project(df_deed,layouts.deed_mortgage_common_model_base_out);//: persist('~prte2::deed::property'); 
 
 tax_OldRecords := tax_file_seq(cust_name = '');
 tax_NewRecords	:= tax_file_seq(cust_name <> '');  
 
 tax_NewRecordsClean := JOIN(d_all_addr_cleaned,
                                 tax_NewRecords, 
                                 LEFT.tax_row_id = RIGHT.tax_row_id,
                                 TRANSFORM( Layouts.layout_property_common_model_base_ext,
															                	 self.tax_mail_prim_range := left.tax_mail_address.prim_range;
                                 self.tax_mail_predir := left.tax_mail_address.predir;
                                 self.tax_mail_prim_name := left.tax_mail_address.prim_name;
                                 self.tax_mail_addr_suffix := left.tax_mail_address.addr_suffix;
                                 self.tax_mail_postdir := left.tax_mail_address.postdir;
                                 self.tax_mail_unit_desig := left.tax_mail_address.unit_desig;
                                 self.tax_mail_sec_range := left.tax_mail_address.sec_range;
                                 self.tax_mail_p_city_name := left.tax_mail_address.p_city_name;
                                 self.tax_mail_v_city_name := left.tax_mail_address.v_city_name;
                                 self.tax_mail_state := left.tax_mail_address.st;
                                 self.tax_mail_zip5 := left.tax_mail_address.zip;
                                 self.tax_mail_zip4 := left.tax_mail_address.zip4;
                                 self.tax_mail_cart := left.tax_mail_address.cart;
                                 self.tax_mail_cr_sort_sz := left.tax_mail_address.cr_sort_sz;
                                 self.tax_mail_lot := left.tax_mail_address.lot;
                                 self.tax_mail_lot_order := left.tax_mail_address.lot_order;
                                 self.tax_mail_dpbc := left.tax_mail_address.dbpc;
                                 self.tax_mail_chk_digit := left.tax_mail_address.chk_digit;
                                 self.tax_mail_rec_type := left.tax_mail_address.rec_type;
                                 self.tax_mail_fips_st := left.tax_mail_address.fips_state;
                                 self.tax_mail_fips_county := left.tax_mail_address.fips_county;
                                 self.tax_mail_geo_lat := left.tax_mail_address.geo_lat;
                                 self.tax_mail_geo_long := left.tax_mail_address.geo_long;
                                 self.tax_mail_msa := left.tax_mail_address.msa;
                                 self.tax_mail_geo_blk := left.tax_mail_address.geo_blk;
                                 self.tax_mail_geo_match := left.tax_mail_address.geo_match;
                                 self.tax_mail_err_stat := left.tax_mail_address.err_stat;
																 
																 self.owner_tax_bdid := if(right.assessee_name_link_fein !='' and right.assessee_name !='', prte2.fn_AppendFakeID.bdid(right.assessee_name, self.tax_mail_prim_range, 
									               self.tax_mail_prim_name, self.tax_mail_v_city_name, self.tax_mail_state,self.tax_mail_zip5,'LN_PR'),0); 
																
                 vLinkingIds_3 :=  prte2.fn_AppendFakeID.LinkIds(right.assessee_name, right.assessee_name_link_fein, right.assessee_name_link_inc_date, 
 									                          self.tax_mail_prim_range, self.tax_mail_prim_name, self.tax_mail_sec_range, self.tax_mail_v_city_name, self.tax_mail_state, self.tax_mail_zip5, 'LN_PR');
												 
											       self.owner_tax_powid	:=  if (right.assessee_name_link_fein !='' and right.assessee_name !='',vLinkingIds_3.powid, 0);
			               self.owner_tax_proxid	:=  if (right.assessee_name_link_fein !='' and right.assessee_name !='',vLinkingIds_3.proxid, 0) ;
			               self.owner_tax_seleid	:=  if (right.assessee_name_link_fein !='' and right.assessee_name !='',vLinkingIds_3.seleid, 0) ;
			               self.owner_tax_orgid	:=  if (right.assessee_name_link_fein !='' and right.assessee_name !='',vLinkingIds_3.orgid, 0) ;
		                self.owner_tax_ultid	:=  if (right.assessee_name_link_fein !='' and right.assessee_name !='',vLinkingIds_3.ultid, 0);																		
																		
																                 self.tax_property_prim_range := left.tax_property_address.prim_range;
                                 self.tax_property_predir := left.tax_property_address.predir;
                                 self.tax_property_prim_name := left.tax_property_address.prim_name;
                                 self.tax_property_addr_suffix := left.tax_property_address.addr_suffix;
                                 self.tax_property_postdir := left.tax_property_address.postdir;
                                 self.tax_property_unit_desig := left.tax_property_address.unit_desig;
                                 self.tax_property_sec_range := left.tax_property_address.sec_range;
                                 self.tax_property_p_city_name := left.tax_property_address.p_city_name;
                                 self.tax_property_v_city_name := left.tax_property_address.v_city_name;
                                 self.tax_property_state := left.tax_property_address.st;
                                 self.tax_property_zip5 := left.tax_property_address.zip;
                                 self.tax_property_zip4 := left.tax_property_address.zip4;
                                 self.tax_property_cart := left.tax_property_address.cart;
                                 self.tax_property_cr_sort_sz := left.tax_property_address.cr_sort_sz;
                                 self.tax_property_lot := left.tax_property_address.lot;
                                 self.tax_property_lot_order := left.tax_property_address.lot_order;
                                 self.tax_property_dpbc := left.tax_property_address.dbpc;
                                 self.tax_property_chk_digit := left.tax_property_address.chk_digit;
                                 self.tax_property_rec_type := left.tax_property_address.rec_type;
                                 self.tax_property_fips_st := left.tax_property_address.fips_state;
                                 self.tax_property_fips_county := left.tax_property_address.fips_county;
                                 self.tax_property_geo_lat := left.tax_property_address.geo_lat;
                                 self.tax_property_geo_long := left.tax_property_address.geo_long;
                                 self.tax_property_msa := left.tax_property_address.msa;
                                 self.tax_property_geo_blk := left.tax_property_address.geo_blk;
                                 self.tax_property_geo_match := left.tax_property_address.geo_match;
                                 self.tax_property_err_stat := left.tax_property_address.err_stat;
																 self.fips_code := self.tax_property_fips_st + self.tax_property_fips_county;
																 self.county_name := Address.County_Names(state_code=self.tax_property_fips_st AND county_code=self.tax_property_fips_county)[1].county_name;
																 SELF := RIGHT;
                                 SELF := [];));                
                                          



 df_tax := tax_NewRecordsClean +  tax_file_untouched;

 df_tax_out := project(df_tax,layouts.property_common_model_base_out);// : persist('~prte2::tax::property');  
 
  PromoteSupers.MAC_SF_BuildProcess(df_deed_out,'~PRTE::BASE::ln_propertyv2::deed', writefile_deed,,,,filedate);	
  PromoteSupers.MAC_SF_BuildProcess(df_tax_out,'~PRTE::BASE::ln_propertyv2::tax', writefile_tax,,,,filedate);	
	
	SEQUENTIAL(writefile_deed, writefile_tax);
	 
	return 'success';
end;


