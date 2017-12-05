Import ut, aid, data_services,AID_Support,PromoteSupers,RoxieKeyBuild,prte2,address,header, prte2, std, PRTE2_LNProperty, NID;

EXPORT Build_Search (String filedate) := FUNCTION

boca_search := PROJECT(Files.ln_propertyv2_search_in, transform(
						layouts.layout_search_building,
						self.dt_last_seen := map(left.dt_last_seen <> 0 => left.dt_last_seen, 
																left.dt_vendor_last_reported <> 0 => left.dt_vendor_last_reported,
																(integer)left.process_date),
						self.dt_first_seen := map(left.dt_first_seen <> 0 => left.dt_first_seen, 
																left.dt_vendor_first_reported <> 0 => left.dt_vendor_first_reported,
																(integer)left.process_date),
						self := left));

df_search := dedup(Files.ln_propertyv2_alpha_search + boca_search, record, all);


ln_propertyv2_deed_base := DATASET('~PRTE::BASE::ln_propertyv2::deed', PRTE2_LNProperty.layouts.deed_mortgage_common_model_base_out, THOR );
ln_propertyv2_deed := Project(ln_propertyv2_deed_base(cust_name!=''), PRTE2_LNProperty.layouts.deed_mortgage_common_model_base_out);

PRTE2_LNProperty.Layouts.Layout_Norm_Search 	tNormalized(ln_propertyv2_deed L, INTEGER cnt) :=	TRANSFORM

self.name := choose(cnt, L.name1, L.name1, L.seller1, L.seller1, L.name2,L.name2,L.seller2,L.seller2);

self.source_code:=	choose(cnt,'OO','OP','SS','SP','OO','OP','SS','SP');

self.prim_range := choose(cnt, L.deed_mail_prim_range, L.deed_property_prim_range,L.deed_seller_prim_range,L.deed_property_prim_range,
                               L.deed_mail_prim_range, L.deed_property_prim_range,L.deed_seller_prim_range,L.deed_property_prim_range);
    
self.predir := choose(cnt, L.deed_mail_predir, L.deed_property_predir, L.deed_seller_predir, L.deed_property_predir,
                           L.deed_mail_predir, L.deed_property_predir,L.deed_seller_predir,L.deed_property_predir);		

self.prim_name := choose(cnt, L.deed_mail_prim_name, L.deed_property_prim_name, L.deed_seller_prim_name,L.deed_property_prim_name,
                              L.deed_mail_prim_name, L.deed_property_prim_name,L.deed_seller_prim_name,L.deed_property_prim_name);

self.suffix := choose(cnt, L.deed_mail_addr_suffix, L.deed_property_addr_suffix,L.deed_seller_addr_suffix,L.deed_property_addr_suffix,
                                L.deed_mail_addr_suffix, L.deed_property_addr_suffix,L.deed_seller_addr_suffix,L.deed_property_addr_suffix);

self.postdir := choose(cnt, L.deed_mail_postdir, L.deed_property_postdir,L.deed_seller_postdir,L.deed_property_postdir,
                            L.deed_mail_postdir, L.deed_property_postdir,L.deed_seller_postdir,L.deed_property_postdir);
														
self.unit_desig := choose(cnt, L.deed_mail_unit_desig, L.deed_property_unit_desig, L.deed_seller_unit_desig, L.deed_property_unit_desig,
                               L.deed_mail_unit_desig, L.deed_property_unit_desig, L.deed_seller_unit_desig, L.deed_property_unit_desig);
														                            													
self.sec_range := choose(cnt, L.deed_mail_sec_range, L.deed_property_sec_range, L.deed_seller_sec_range, L.deed_property_sec_range,
                              L.deed_mail_sec_range, L.deed_property_sec_range, L.deed_seller_sec_range, L.deed_property_sec_range);

self.p_city_name := choose(cnt, L.deed_mail_p_city_name, L.deed_property_p_city_name, L.deed_seller_p_city_name, L.deed_property_p_city_name,
                                L.deed_mail_p_city_name, L.deed_property_p_city_name, L.deed_seller_p_city_name, L.deed_property_p_city_name);
                                                           
self.v_city_name := choose(cnt, L.deed_mail_v_city_name, L.deed_property_v_city_name, L.deed_seller_v_city_name, L.deed_property_v_city_name,
                                L.deed_mail_v_city_name, L.deed_property_v_city_name, L.deed_seller_v_city_name, L.deed_property_v_city_name);
																
self.st := choose(cnt, L.deed_mail_state, L.deed_property_state, L.deed_seller_state, L.deed_property_state,
                                L.deed_mail_state, L.deed_property_state, L.deed_seller_state, L.deed_property_state);

self.zip := choose(cnt, L.deed_mail_zip5, L.deed_property_zip5, L.deed_seller_zip5, L.deed_property_zip5,
                        L.deed_mail_zip5, L.deed_property_zip5, L.deed_seller_zip5, L.deed_property_zip5);
 
self.zip4 := choose(cnt, L.deed_mail_zip4, L.deed_property_zip4, L.deed_seller_zip4, L.deed_property_zip4,
                        L.deed_mail_zip4, L.deed_property_zip4, L.deed_seller_zip4, L.deed_property_zip4);
												
self.cart := choose(cnt, L.deed_mail_cart, L.deed_property_cart, L.deed_seller_cart, L.deed_property_cart,
                         L.deed_mail_cart, L.deed_property_cart, L.deed_seller_cart, L.deed_property_cart);                       

self.cr_sort_sz := choose(cnt, L.deed_mail_cr_sort_sz, L.deed_property_cr_sort_sz, L.deed_seller_cr_sort_sz, L.deed_property_cr_sort_sz,
                               L.deed_mail_cr_sort_sz, L.deed_property_cr_sort_sz, L.deed_seller_cr_sort_sz, L.deed_property_cr_sort_sz);

self.lot := choose(cnt, L.deed_mail_lot, L.deed_property_lot, L.deed_seller_lot, L.deed_property_lot,	
                        L.deed_mail_lot, L.deed_property_lot, L.deed_seller_lot, L.deed_property_lot);	
												
self.lot_order := choose(cnt, L.deed_mail_lot_order, L.deed_property_lot_order, L.deed_seller_lot_order, L.deed_property_lot_order,	
                        L.deed_mail_lot_order, L.deed_property_lot_order, L.deed_seller_lot_order, L.deed_property_lot_order);	
												
self.dbpc := choose(cnt, L.deed_mail_dpbc, L.deed_property_dpbc, L.deed_seller_dpbc, L.deed_property_dpbc,	
                         L.deed_mail_dpbc, L.deed_property_dpbc, L.deed_seller_dpbc, L.deed_property_dpbc);	
												 
self.chk_digit := choose(cnt, L.deed_mail_chk_digit, L.deed_property_chk_digit, L.deed_seller_chk_digit, L.deed_property_chk_digit,	
                              L.deed_mail_chk_digit, L.deed_property_chk_digit, L.deed_seller_chk_digit, L.deed_property_chk_digit);	

self.rec_type := choose(cnt, L.deed_mail_rec_type, L.deed_property_rec_type, L.deed_seller_rec_type, L.deed_property_rec_type,	
                             L.deed_mail_rec_type, L.deed_property_rec_type, L.deed_seller_rec_type, L.deed_property_rec_type);	


self.county := choose(cnt, L.deed_mail_fips_county, L.deed_property_fips_county, L.deed_seller_fips_county, L.deed_property_fips_county,
                           L.deed_mail_fips_county, L.deed_property_fips_county, L.deed_seller_fips_county, L.deed_property_fips_county);

self.geo_lat := choose(cnt, L.deed_mail_geo_lat, L.deed_property_geo_lat, L.deed_seller_geo_lat, L.deed_property_geo_lat,
                            L.deed_mail_geo_lat, L.deed_property_geo_lat, L.deed_seller_geo_lat, L.deed_property_geo_lat);

self.geo_long := choose(cnt, L.deed_mail_geo_long, L.deed_property_geo_long, L.deed_seller_geo_long, L.deed_property_geo_long,
                            L.deed_mail_geo_long, L.deed_property_geo_long, L.deed_seller_geo_long, L.deed_property_geo_long);

self.msa := choose(cnt, L.deed_mail_msa, L.deed_property_msa, L.deed_seller_msa, L.deed_property_msa,
                        L.deed_mail_msa, L.deed_property_msa, L.deed_seller_msa, L.deed_property_msa);

self.geo_blk := choose(cnt, L.deed_mail_geo_blk, L.deed_property_geo_blk, L.deed_seller_geo_blk, L.deed_property_geo_blk,
                            L.deed_mail_geo_blk, L.deed_property_geo_blk, L.deed_seller_geo_blk, L.deed_property_geo_blk);
														
self.geo_match := choose(cnt, L.deed_mail_geo_match, L.deed_property_geo_match, L.deed_seller_geo_match, L.deed_property_geo_match,
                              L.deed_mail_geo_match, L.deed_property_geo_match, L.deed_seller_geo_match, L.deed_property_geo_match);
                            
self.err_stat := choose(cnt, L.deed_mail_err_stat, L.deed_property_err_stat, L.deed_seller_err_stat, L.deed_property_err_stat,
                             L.deed_mail_err_stat, L.deed_property_err_stat, L.deed_seller_err_stat, L.deed_property_err_stat);

self.app_SSN := choose(cnt,L.name1_link_ssn, L.name1_link_ssn,L.seller1_link_ssn,L.seller1_link_ssn,
                           L.name2_link_ssn, L.name2_link_ssn,L.seller2_link_ssn,L.seller2_link_ssn);
													 
self.app_DOB := choose(cnt,L.name1_link_dob, L.name1_link_dob,L.seller1_link_dob,L.seller1_link_dob,
                           L.name2_link_dob, L.name2_link_dob,L.seller2_link_dob,L.seller2_link_dob);
													
self.app_tax_id := choose(cnt,L.name1_link_fein, L.name1_link_fein,L.seller1_link_fein,L.seller1_link_fein,
                           L.name2_link_fein, L.name2_link_fein,L.seller2_link_fein,L.seller2_link_fein);
													 
self.link_inc_date := choose(cnt,L.name1_link_inc_date, L.name1_link_inc_date,L.seller1_link_inc_date,L.seller1_link_inc_date,
                           L.name2_link_inc_date, L.name2_link_inc_date,L.seller2_link_inc_date,L.seller2_link_inc_date);

self.bdid := choose(cnt,L.owner_bdid, L.owner_bdid,L.seller_bdid,L.seller_bdid,
                           L.owner_bdid, L.owner_bdid,L.seller_bdid,L.seller_bdid);

self.powid := choose(cnt,L.owner_powid, L.owner_powid,L.seller_powid,L.seller_powid,
                           L.owner_powid, L.owner_powid,L.seller_powid,L.seller_powid);
													 
self.proxid := choose(cnt,L.owner_proxid, L.owner_proxid,L.seller_proxid,L.seller_proxid,
                           L.owner_proxid, L.owner_proxid,L.seller_proxid,L.seller_proxid);
													 
self.seleid := choose(cnt,L.owner_seleid, L.owner_seleid,L.seller_seleid,L.seller_seleid,
                           L.owner_seleid, L.owner_seleid,L.seller_seleid,L.seller_seleid);

self.orgid := choose(cnt,L.owner_orgid, L.owner_orgid,L.seller_orgid,L.seller_orgid,
                           L.owner_orgid, L.owner_orgid,L.seller_orgid,L.seller_orgid);
		
self.ultid := choose(cnt,L.owner_ultid, L.owner_ultid,L.seller_ultid,L.seller_ultid,
                           L.owner_ultid, L.owner_ultid,L.seller_ultid,L.seller_ultid);
													 
self.nameasis := choose(cnt,L.name1,L.name1,L.seller1, L.seller1,
                            L.name2,L.name2,L.seller2,L.seller2);

self.which_orig := choose(cnt,'1','1','1','1','2','2','2','2');
self.phone_number := L.phone_number;
self.persistent_record_id := 0;

self.dt_first_seen            			:=	(unsigned3)filedate[1..6];
self.dt_last_seen           		 		:=	(unsigned3)filedate[1..6];

self.dt_vendor_first_reported				:= (unsigned3)filedate[1..6];
self.dt_vendor_last_reported			 	:= (unsigned3)filedate[1..6];

self.ln_fares_id            			  :=  L.ln_fares_id;
self.process_date                :=  filedate;
self.vendor_source_flag :=L.vendor_Source_flag;
self.cust_name :=L.cust_name;

END;


ln_propertyv2_tax_base := DATASET('~PRTE::BASE::ln_propertyv2::tax', PRTE2_LNProperty.layouts.property_common_model_base_out, THOR );
ln_propertyv2_tax := Project(ln_propertyv2_tax_base(cust_name!=''), PRTE2_LNProperty.layouts.property_common_model_base_out);

PRTE2_LNProperty.Layouts.Layout_Norm_Search 	tNormalized_tax(ln_propertyv2_tax L, INTEGER cnt) :=	TRANSFORM
self.name := choose(cnt, L.assessee_name, L.assessee_name, L.second_assessee_name,L.second_assessee_name);
self.source_code:=	choose(cnt,'OO','OP','OO','OP');

self.prim_range := choose(cnt, L.tax_mail_prim_range, L.tax_property_prim_range,L.tax_mail_prim_range,L.tax_property_prim_range);

self.predir := choose(cnt, L.tax_mail_predir,L.tax_property_predir,L.tax_mail_predir,L.tax_property_predir);

self.prim_name := choose(cnt,L.tax_mail_prim_name,L.tax_property_prim_name,L.tax_mail_prim_name,L.tax_property_prim_name);

self.suffix := choose(cnt,L.tax_mail_addr_suffix,L.tax_property_addr_suffix,L.tax_mail_addr_suffix, L.tax_property_addr_suffix);

self.postdir := choose(cnt,L.tax_mail_postdir,L.tax_property_postdir,L.tax_mail_postdir, L.tax_property_postdir);

self.unit_desig := choose(cnt,L.tax_mail_unit_desig,L.tax_property_unit_desig,L.tax_mail_unit_desig,L.tax_property_unit_desig);

self.sec_range := choose(cnt,L.tax_mail_sec_range,L.tax_property_sec_range,L.tax_mail_sec_range,L.tax_property_sec_range);

self.p_city_name := choose(cnt,L.tax_mail_p_city_name,L.tax_property_p_city_name,L.tax_mail_p_city_name,L.tax_property_p_city_name);

self.v_city_name := choose(cnt,L.tax_mail_v_city_name,L.tax_property_v_city_name,L.tax_mail_v_city_name,L.tax_property_v_city_name);

self.st := choose(cnt,L.tax_mail_state,L.tax_property_state,L.tax_mail_state,L.tax_property_state);

self.zip := choose(cnt,L.tax_mail_zip5,L.tax_property_zip5,L.tax_mail_zip5,L.tax_property_zip5);

self.zip4 := choose(cnt,L.tax_mail_zip4,L.tax_property_zip4,L.tax_mail_zip4,L.tax_property_zip4);

self.cart := choose(cnt,L.tax_mail_cart,L.tax_property_cart,L.tax_mail_cart,L.tax_property_cart);

self.cr_sort_sz := choose(cnt,L.tax_mail_cr_sort_sz,L.tax_property_cr_sort_sz,L.tax_mail_cr_sort_sz,L.tax_property_cr_sort_sz);

self.lot := choose(cnt,L.tax_mail_lot,L.tax_property_lot,L.tax_mail_lot,L.tax_property_lot);

self.lot_order := choose(cnt,L.tax_mail_lot_order,L.tax_property_lot_order,L.tax_mail_lot_order,L.tax_property_lot_order);

self.dbpc := choose(cnt,L.tax_mail_dpbc,L.tax_property_dpbc,L.tax_mail_dpbc,L.tax_property_dpbc);

self.chk_digit := choose(cnt,L.tax_mail_chk_digit,L.tax_property_chk_digit,L.tax_mail_chk_digit,L.tax_property_chk_digit);

self.rec_type := choose(cnt,L.tax_mail_rec_type,L.tax_property_rec_type,L.tax_mail_rec_type,L.tax_property_rec_type);

self.county := choose(cnt,L.tax_mail_fips_county,L.tax_property_fips_county,L.tax_mail_fips_county,L.tax_property_fips_county);

self.geo_lat := choose(cnt,L.tax_mail_geo_lat,L.tax_property_geo_lat,L.tax_mail_geo_lat,L.tax_property_geo_lat);

self.geo_long := choose(cnt,L.tax_mail_geo_long,L.tax_property_geo_long,L.tax_mail_geo_long,L.tax_property_geo_long);

self.msa := choose(cnt,L.tax_mail_msa,L.tax_property_msa,L.tax_mail_msa,L.tax_property_msa);

self.geo_blk := choose(cnt,L.tax_mail_geo_blk,L.tax_property_geo_blk,L.tax_mail_geo_blk,L.tax_property_geo_blk);

self.geo_match := choose(cnt,L.tax_mail_geo_match,L.tax_property_geo_match,L.tax_mail_geo_match,L.tax_property_geo_blk);

self.err_stat := choose(cnt,L.tax_mail_err_stat,L.tax_property_err_stat,L.tax_mail_err_stat,L.tax_property_err_stat);

self.app_SSN := choose(cnt,L.assessee_name_link_ssn, L.assessee_name_link_ssn, L.second_assessee_name_link_ssn, L.second_assessee_name_link_ssn);

self.app_DOB := choose(cnt,L.assessee_name_link_dob, L.assessee_name_link_dob, L.second_assessee_name_link_dob, L.second_assessee_name_link_dob);

self.app_tax_id := choose(cnt,L.assessee_name_link_fein, L.assessee_name_link_fein, L.second_assessee_name_link_fein, L.second_assessee_name_link_fein);

self.link_inc_date := choose(cnt,L.assessee_name_link_inc_date, L.assessee_name_link_inc_date, L.second_assessee_name_link_inc_date, L.second_assessee_name_link_inc_date);

self.bdid := choose(cnt,L.owner_tax_bdid, L.owner_tax_bdid, L.owner_tax_bdid,L.owner_tax_bdid);

self.powid := choose(cnt,L.owner_tax_powid, L.owner_tax_powid, L.owner_tax_powid,L.owner_tax_powid);

self.proxid := choose(cnt,L.owner_tax_proxid, L.owner_tax_proxid, L.owner_tax_proxid,L.owner_tax_proxid);

self.seleid := choose(cnt,L.owner_tax_seleid, L.owner_tax_seleid, L.owner_tax_seleid,L.owner_tax_seleid);

self.orgid := choose(cnt,L.owner_tax_orgid, L.owner_tax_orgid, L.owner_tax_orgid,L.owner_tax_orgid);

self.ultid := choose(cnt,L.owner_tax_ultid, L.owner_tax_ultid, L.owner_tax_ultid,L.owner_tax_ultid);
self.nameasis := choose(cnt,L.assessee_name,L.assessee_name,L.second_assessee_name,L.second_assessee_name);
self.which_orig := choose(cnt,'1','1','2','2');                          

self.phone_number := L.assessee_phone_number;
self.persistent_record_id := 0;
self.dt_first_seen            			:=	(unsigned3)filedate[1..6];
self.dt_last_seen           		 		:=	(unsigned3)filedate[1..6];
self.dt_vendor_first_reported				:=	(unsigned3)filedate[1..6];
self.dt_vendor_last_reported			 	:=	(unsigned3)filedate[1..6];
self.ln_fares_id            				 :=L.ln_fares_id;
self.process_date :=             filedate;
self.vendor_source_flag :=L.vendor_Source_flag;
self.cust_name :=L.cust_name;

END;

nameNormalized_deed := 	normalize(ln_propertyv2_deed, 8, tNormalized(LEFT,counter));
nameNormalized_deed_2:=nameNormalized_deed(name!='');
nameNormalized_tax := 	normalize(ln_propertyv2_tax, 4, tNormalized_tax(LEFT,counter));
nameNormalized_tax_2:=nameNormalized_tax(name!='');

nameNormalizedAll:=nameNormalized_deed_2 + nameNormalized_tax_2;

NID.Mac_CleanFullNames(nameNormalizedAll, VerifyBusRecs, name,_nameorder := 'L',
                       ,includeInRepository:=false, normalizeDualNames:=false);

		person_flags  		:= ['P', 'D'];
		business_flags 	:= ['B', 'U', 'I'];

   
	  PRTE2_LNProperty.Layouts.New_Search_Layout Trans_cleanBusName(VerifyBusRecs L) := TRANSFORM
			SELF.title        := IF(L.nametype IN person_flags, L.cln_title, '');
			SELF.fname        := IF(L.nametype IN person_flags, L.cln_fname, '');
			SELF.mname        := IF(L.nametype IN person_flags, L.cln_mname, '');
			SELF.lname        := IF(L.nametype IN person_flags, L.cln_lname, '');
			SELF.name_suffix  := IF(L.nametype IN person_flags, L.cln_suffix, '');
			SELF.cname        := IF(L.nametype IN business_flags, StringLib.StringToUpperCase(L.Name), '');
			SELF  							     := L;
			SELF              := [];
	  END;
		 
		   d_CleanFullNames      := PROJECT(VerifyBusRecs, Trans_cleanBusName(LEFT));
			 
			  dBase := project(d_CleanFullNames,
			                  transform(Prte2_LNProperty.Layouts.New_Search_Layout,
												         SELF.did :=     if (left.cname = '',prte2.fn_AppendFakeID.did(left.fname, left.lname, left.app_ssn, 
												                            left.app_dob, left.cust_name),0);
										  	        self	  		:= left));
														
   dbase2:=dedup(dbase,RECORD,ALL);// : persist('~prte::search::property');
		 
		 df_search2:=project(df_search,transform(Layouts.New_Search_Layout,
		             Self:=left;
								       self:=[]));
		 dbase3:=dbase2 + df_search2;
		 PromoteSupers.MAC_SF_BuildProcess(dbase3,'~PRTE::BASE::ln_propertyv2::search', writefile_search,,,,filedate);	
		 SEQUENTIAL(writefile_search);
		 return 'success';
		
end;

	
	
	