IMPORT govdata, Address, AID, ut, NID;

dsIASalesTx_pre_base := govdata.IA_Sales_Tax_Standardize_Input.fAll(govdata.File_IA_Sales_Tax_Sprayed);

combinedBase := dsIASalesTx_pre_base + govdata.File_IA_SalesTax_Base;

NID.Mac_CleanFullNames(combinedBase, combinedBase_clean_name_temp, Owner_Name);
		
combinedBase_clean_name := combinedBase_clean_name_temp;

govdata.Layout_IA_SalesTax_Base Populate_Owner(RECORDOF(combinedBase_clean_name) L, INTEGER C) := TRANSFORM,
SKIP(C = 2 AND L.nametype <> 'D') 
  SELF.ownerName.title        := CHOOSE(C, L.cln_title, L.cln_title2);
  SELF.ownerName.fname        := CHOOSE(C, L.cln_fname, L.cln_fname2);
  SELF.ownerName.mname        := CHOOSE(C, L.cln_mname, L.cln_mname2);
  SELF.ownerName.lname        := CHOOSE(C, L.cln_lname, L.cln_lname2);
  SELF.ownerName.name_suffix  := CHOOSE(C, L.cln_suffix, L.cln_suffix2);
  SELF.ownerName.name_score   := '';
  SELF.company_name_1         := IF(L.nametype='B', L.Owner_Name, '');
  SELF := L;
  SELF := [];
END;

combinedBase_norm_owner := NORMALIZE(combinedBase_clean_name, 2, Populate_Owner(LEFT,COUNTER));

NID.Mac_CleanFullNames(combinedBase_norm_owner, combinedBase_clean_bus_temp, Business_Name);
		
combinedBase_clean_bus := combinedBase_clean_bus_temp;

govdata.Layout_IA_SalesTax_Base Populate_Bus(RECORDOF(combinedBase_clean_bus) L, INTEGER C) := TRANSFORM,
SKIP(C = 2 AND L.nametype <> 'D') 
  SELF.tradeName.title        := CHOOSE(C, L.cln_title, L.cln_title2);
  SELF.tradeName.fname        := CHOOSE(C, L.cln_fname, L.cln_fname2);
  SELF.tradeName.mname        := CHOOSE(C, L.cln_mname, L.cln_mname2);
  SELF.tradeName.lname        := CHOOSE(C, L.cln_lname, L.cln_lname2);
  SELF.tradeName.name_suffix  := CHOOSE(C, L.cln_suffix, L.cln_suffix2);
  SELF.tradeName.name_score   := '';
  SELF.company_name_2         := IF(L.Business_Name <> '', L.Business_Name, IF(TRIM(L.company_name_1) <> '', '', L.Owner_Name));
  SELF := L;
  SELF := [];
END;

combinedBase_norm_bus := NORMALIZE(combinedBase_clean_bus, 2, Populate_Bus(LEFT,COUNTER)) : PERSIST('IA_Sales_Tax_NID_Temp');

Address_Layout := RECORD
  govdata.Layout_IA_SalesTax_Base;
  string1 address_type           := '';
	AID.Common.xAID	Raw_AID        := 0;
	AID.Common.xAID	ACE_AID        := 0;
	string100	prep_addr_line1      := '';
	string50	prep_addr_line_last  := '';
END;

Address_Layout Norm_Addr(RECORDOF(combinedBase_norm_bus) L, INTEGER C) := TRANSFORM,
SKIP((C = 1 AND (TRIM(L.city_mailing_address) + TRIM(L.state_mailing_address) + TRIM(L.mailing_zip_code)) = '') OR
     (C = 2 AND (TRIM(L.city_of_location) + TRIM(L.state_of_location) + TRIM(L.location_zip_code)) = ''))
  //If the business_name is blank, move the owner_name to the business_name
  SELF.owner_name          := IF(TRIM(L.business_name) = '', '', TRIM(L.owner_name));
  SELF.business_name       := IF(TRIM(L.business_name) = '', TRIM(L.owner_name), TRIM(L.business_name));
  SELF.address_type        := CHOOSE(C, 'M', 'L');
  SELF.prep_addr_line1     := CHOOSE(C, ut.CleanSpacesAndUpper(L.mailing_address), ut.CleanSpacesAndUpper(L.location_address));
  SELF.prep_addr_line_last := CHOOSE(C,
                                     ut.CleanSpacesAndUpper(L.city_mailing_address)
                                        + IF(ut.CleanSpacesAndUpper(L.city_mailing_address) <> '', ', ', '')
                                        + ut.CleanSpacesAndUpper(L.state_mailing_address)
                                        + IF(ut.CleanSpacesAndUpper(L.city_mailing_address) + ut.CleanSpacesAndUpper(L.state_mailing_address) <> '', ' ', '')
                                        + ut.CleanSpacesAndUpper(L.mailing_zip_code),
                                     ut.CleanSpacesAndUpper(L.city_of_location)
                                        + IF(ut.CleanSpacesAndUpper(L.city_of_location) <> '', ', ', '')
                                        + ut.CleanSpacesAndUpper(L.state_of_location)
                                        + IF(ut.CleanSpacesAndUpper(L.city_of_location) + ut.CleanSpacesAndUpper(L.state_of_location) <> '', ' ', '')
                                        + ut.CleanSpacesAndUpper(L.location_zip_code));
  SELF := L;
  SELF := [];
END;

dsIASalesTx_norm_addr := NORMALIZE(combinedBase_norm_bus, 2, Norm_Addr(LEFT,COUNTER));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
AID.MacAppendFromRaw_2Line(dsIASalesTx_norm_addr, prep_addr_line1, prep_addr_line_last, Raw_AID, dsIASalesTx_AID, lFlags);

govdata.Layout_IA_SalesTax_Base MakeBase(RECORDOF(dsIASalesTx_AID) L) := TRANSFORM
  SELF.mailingAddress.prim_range			:= IF(L.address_type = 'M', L.aidwork_acecache.prim_range, '');
  SELF.mailingAddress.predir					:= IF(L.address_type = 'M', L.aidwork_acecache.predir, '');
  SELF.mailingAddress.prim_name			  := IF(L.address_type = 'M', L.aidwork_acecache.prim_name, '');
  SELF.mailingAddress.addr_suffix		  := IF(L.address_type = 'M', L.aidwork_acecache.addr_suffix, '');
  SELF.mailingAddress.postdir				  := IF(L.address_type = 'M', L.aidwork_acecache.postdir, '');
  SELF.mailingAddress.unit_desig			:= IF(L.address_type = 'M', L.aidwork_acecache.unit_desig, '');
  SELF.mailingAddress.sec_range			  := IF(L.address_type = 'M', L.aidwork_acecache.sec_range, '');
  SELF.mailingAddress.p_city_name		  := IF(L.address_type = 'M', L.aidwork_acecache.p_city_name, '');
  SELF.mailingAddress.v_city_name		  := IF(L.address_type = 'M', L.aidwork_acecache.v_city_name, '');
  SELF.mailingAddress.st							:= IF(L.address_type = 'M', L.aidwork_acecache.st, '');
  SELF.mailingAddress.zip						  := IF(L.address_type = 'M', L.aidwork_acecache.zip5, '');
  SELF.mailingAddress.zip4						:= IF(L.address_type = 'M', L.aidwork_acecache.zip4, '');
  SELF.mailingAddress.cart						:= IF(L.address_type = 'M', L.aidwork_acecache.cart, '');
  SELF.mailingAddress.cr_sort_sz			:= IF(L.address_type = 'M', L.aidwork_acecache.cr_sort_sz, '');
  SELF.mailingAddress.lot						  := IF(L.address_type = 'M', L.aidwork_acecache.lot, '');
  SELF.mailingAddress.lot_order			  := IF(L.address_type = 'M', L.aidwork_acecache.lot_order, '');
  SELF.mailingAddress.dbpc						:= IF(L.address_type = 'M', L.aidwork_acecache.dbpc, '');
  SELF.mailingAddress.chk_digit			  := IF(L.address_type = 'M', L.aidwork_acecache.chk_digit, '');
  SELF.mailingAddress.rec_type				:= IF(L.address_type = 'M', L.aidwork_acecache.rec_type, '');
  SELF.mailingAddress.fips_state 		  := IF(L.address_type = 'M', L.aidwork_acecache.county[1..2], '');
  SELF.mailingAddress.fips_county		  := IF(L.address_type = 'M', L.aidwork_acecache.county[3..], '');
  SELF.mailingAddress.geo_lat				  := IF(L.address_type = 'M', L.aidwork_acecache.geo_lat, '');
  SELF.mailingAddress.geo_long				:= IF(L.address_type = 'M', L.aidwork_acecache.geo_long, '');
  SELF.mailingAddress.msa						  := IF(L.address_type = 'M', L.aidwork_acecache.msa, '');
  SELF.mailingAddress.geo_blk				  := IF(L.address_type = 'M', L.aidwork_acecache.geo_blk, '');
  SELF.mailingAddress.geo_match			  := IF(L.address_type = 'M', L.aidwork_acecache.geo_match, '');
  SELF.mailingAddress.err_stat				:= IF(L.address_type = 'M', L.aidwork_acecache.err_stat, '');              
  SELF.locationAddress.prim_range		  := IF(L.address_type = 'L', L.aidwork_acecache.prim_range, '');
  SELF.locationAddress.predir				  := IF(L.address_type = 'L', L.aidwork_acecache.predir, '');
  SELF.locationAddress.prim_name			:= IF(L.address_type = 'L', L.aidwork_acecache.prim_name, '');
  SELF.locationAddress.addr_suffix		:= IF(L.address_type = 'L', L.aidwork_acecache.addr_suffix, '');
  SELF.locationAddress.postdir				:= IF(L.address_type = 'L', L.aidwork_acecache.postdir, '');
  SELF.locationAddress.unit_desig		  := IF(L.address_type = 'L', L.aidwork_acecache.unit_desig, '');
  SELF.locationAddress.sec_range			:= IF(L.address_type = 'L', L.aidwork_acecache.sec_range, '');
  SELF.locationAddress.p_city_name		:= IF(L.address_type = 'L', L.aidwork_acecache.p_city_name, '');
  SELF.locationAddress.v_city_name		:= IF(L.address_type = 'L', L.aidwork_acecache.v_city_name, '');
  SELF.locationAddress.st						  := IF(L.address_type = 'L', L.aidwork_acecache.st, '');
  SELF.locationAddress.zip						:= IF(L.address_type = 'L', L.aidwork_acecache.zip5, '');
  SELF.locationAddress.zip4					  := IF(L.address_type = 'L', L.aidwork_acecache.zip4, '');
  SELF.locationAddress.cart					  := IF(L.address_type = 'L', L.aidwork_acecache.cart, '');
  SELF.locationAddress.cr_sort_sz		  := IF(L.address_type = 'L', L.aidwork_acecache.cr_sort_sz, '');
  SELF.locationAddress.lot						:= IF(L.address_type = 'L', L.aidwork_acecache.lot, '');
  SELF.locationAddress.lot_order			:= IF(L.address_type = 'L', L.aidwork_acecache.lot_order, '');
  SELF.locationAddress.dbpc					  := IF(L.address_type = 'L', L.aidwork_acecache.dbpc, '');
  SELF.locationAddress.chk_digit			:= IF(L.address_type = 'L', L.aidwork_acecache.chk_digit, '');
  SELF.locationAddress.rec_type			  := IF(L.address_type = 'L', L.aidwork_acecache.rec_type, '');
  SELF.locationAddress.fips_state 		:= IF(L.address_type = 'L', L.aidwork_acecache.county[1..2], '');
  SELF.locationAddress.fips_county		:= IF(L.address_type = 'L', L.aidwork_acecache.county[3..], '');
  SELF.locationAddress.geo_lat				:= IF(L.address_type = 'L', L.aidwork_acecache.geo_lat, '');
  SELF.locationAddress.geo_long			  := IF(L.address_type = 'L', L.aidwork_acecache.geo_long, '');
  SELF.locationAddress.msa					  := IF(L.address_type = 'L', L.aidwork_acecache.msa, '');
  SELF.locationAddress.geo_blk			  := IF(L.address_type = 'L', L.aidwork_acecache.geo_blk, '');
  SELF.locationAddress.geo_match			:= IF(L.address_type = 'L', L.aidwork_acecache.geo_match, '');
  SELF.locationAddress.err_stat			  := IF(L.address_type = 'L', L.aidwork_acecache.err_stat, '');              
  SELF.Raw_AID_mailing				        := IF(L.address_type = 'M', L.aidwork_rawaid, 0);
  SELF.ACE_AID_mailing				        := IF(L.address_type = 'M', L.aidwork_acecache.aid, 0);
  SELF.prep_mailing_addr_line1        := IF(L.address_type = 'M', L.prep_addr_line1, '');
  SELF.prep_mailing_addr_line_last    := IF(L.address_type = 'M', L.prep_addr_line_last, '');
  SELF.Raw_AID_location				        := IF(L.address_type = 'L', L.aidwork_rawaid, 0);
  SELF.ACE_AID_location				        := IF(L.address_type = 'L', L.aidwork_acecache.aid, 0);        
  SELF.prep_location_addr_line1       := IF(L.address_type = 'L', L.prep_addr_line1, '');
  SELF.prep_location_addr_line_last   := IF(L.address_type = 'L', L.prep_addr_line_last, '');
  SELF								                := L;
  SELF								                := [];
END;

dsIASalesTx_AID_base := PROJECT(dsIASalesTx_AID, MakeBase(LEFT));

govdata.Layout_IA_SalesTax_Base RollupAddress(RECORDOF(dsIASalesTx_AID_base) L, RECORDOF(dsIASalesTx_AID_base) R) := TRANSFORM
  SELF.bdid             			        := IF(L.bdid != 0, L.bdid, R.bdid);
  SELF.mailingAddress.prim_range			:= IF(L.mailingAddress.prim_range <> '', L.mailingAddress.prim_range, R.mailingAddress.prim_range);
  SELF.mailingAddress.predir					:= IF(L.mailingAddress.predir <> '', L.mailingAddress.predir, R.mailingAddress.predir);
  SELF.mailingAddress.prim_name			  := IF(L.mailingAddress.prim_name <> '', L.mailingAddress.prim_name, R.mailingAddress.prim_name);
  SELF.mailingAddress.addr_suffix		  := IF(L.mailingAddress.addr_suffix <> '', L.mailingAddress.addr_suffix, R.mailingAddress.addr_suffix);
  SELF.mailingAddress.postdir				  := IF(L.mailingAddress.postdir <> '', L.mailingAddress.postdir, R.mailingAddress.postdir);
  SELF.mailingAddress.unit_desig			:= IF(L.mailingAddress.unit_desig <> '', L.mailingAddress.unit_desig, R.mailingAddress.unit_desig);
  SELF.mailingAddress.sec_range			  := IF(L.mailingAddress.sec_range <> '', L.mailingAddress.sec_range, R.mailingAddress.sec_range);
  SELF.mailingAddress.p_city_name		  := IF(L.mailingAddress.p_city_name <> '', L.mailingAddress.p_city_name, R.mailingAddress.p_city_name);
  SELF.mailingAddress.v_city_name		  := IF(L.mailingAddress.v_city_name <> '', L.mailingAddress.v_city_name, R.mailingAddress.v_city_name);
  SELF.mailingAddress.st							:= IF(L.mailingAddress.st <> '', L.mailingAddress.st, R.mailingAddress.st);
  SELF.mailingAddress.zip						  := IF(L.mailingAddress.zip <> '', L.mailingAddress.zip, R.mailingAddress.zip);
  SELF.mailingAddress.zip4						:= IF(L.mailingAddress.zip4 <> '', L.mailingAddress.zip4, R.mailingAddress.zip4);
  SELF.mailingAddress.cart						:= IF(L.mailingAddress.cart <> '', L.mailingAddress.cart, R.mailingAddress.cart);
  SELF.mailingAddress.cr_sort_sz			:= IF(L.mailingAddress.cr_sort_sz <> '', L.mailingAddress.cr_sort_sz, R.mailingAddress.cr_sort_sz);
  SELF.mailingAddress.lot						  := IF(L.mailingAddress.lot <> '', L.mailingAddress.lot, R.mailingAddress.lot);
  SELF.mailingAddress.lot_order			  := IF(L.mailingAddress.lot_order <> '', L.mailingAddress.lot_order, R.mailingAddress.lot_order);
  SELF.mailingAddress.dbpc						:= IF(L.mailingAddress.dbpc <> '', L.mailingAddress.dbpc, R.mailingAddress.dbpc);
  SELF.mailingAddress.chk_digit			  := IF(L.mailingAddress.chk_digit <> '', L.mailingAddress.chk_digit, R.mailingAddress.chk_digit);
  SELF.mailingAddress.rec_type				:= IF(L.mailingAddress.rec_type <> '', L.mailingAddress.rec_type, R.mailingAddress.rec_type);
  SELF.mailingAddress.fips_state 		  := IF(L.mailingAddress.fips_state <> '', L.mailingAddress.fips_state, R.mailingAddress.fips_state);
  SELF.mailingAddress.fips_county		  := IF(L.mailingAddress.fips_county <> '', L.mailingAddress.fips_county, R.mailingAddress.fips_county);
  SELF.mailingAddress.geo_lat				  := IF(L.mailingAddress.geo_lat <> '', L.mailingAddress.geo_lat, R.mailingAddress.geo_lat);
  SELF.mailingAddress.geo_long				:= IF(L.mailingAddress.geo_long <> '', L.mailingAddress.geo_long, R.mailingAddress.geo_long);
  SELF.mailingAddress.msa						  := IF(L.mailingAddress.msa <> '', L.mailingAddress.msa, R.mailingAddress.msa);
  SELF.mailingAddress.geo_blk				  := IF(L.mailingAddress.geo_blk <> '', L.mailingAddress.geo_blk, R.mailingAddress.geo_blk);
  SELF.mailingAddress.geo_match			  := IF(L.mailingAddress.geo_match <> '', L.mailingAddress.geo_match, R.mailingAddress.geo_match);
  SELF.mailingAddress.err_stat				:= IF(L.mailingAddress.err_stat <> '', L.mailingAddress.err_stat, R.mailingAddress.err_stat);              
  SELF.locationAddress.prim_range		  := IF(L.locationAddress.prim_range <> '', L.locationAddress.prim_range, R.locationAddress.prim_range);
  SELF.locationAddress.predir				  := IF(L.locationAddress.predir <> '', L.locationAddress.predir, R.locationAddress.predir);
  SELF.locationAddress.prim_name			:= IF(L.locationAddress.prim_name <> '', L.locationAddress.prim_name, R.locationAddress.prim_name);
  SELF.locationAddress.addr_suffix		:= IF(L.locationAddress.addr_suffix <> '', L.locationAddress.addr_suffix, R.locationAddress.addr_suffix);
  SELF.locationAddress.postdir				:= IF(L.locationAddress.postdir <> '', L.locationAddress.postdir, R.locationAddress.postdir);
  SELF.locationAddress.unit_desig		  := IF(L.locationAddress.unit_desig <> '', L.locationAddress.unit_desig, R.locationAddress.unit_desig);
  SELF.locationAddress.sec_range			:= IF(L.locationAddress.sec_range <> '', L.locationAddress.sec_range, R.locationAddress.sec_range);
  SELF.locationAddress.p_city_name		:= IF(L.locationAddress.p_city_name <> '', L.locationAddress.p_city_name, R.locationAddress.p_city_name);
  SELF.locationAddress.v_city_name		:= IF(L.locationAddress.v_city_name <> '', L.locationAddress.v_city_name, R.locationAddress.v_city_name);
  SELF.locationAddress.st						  := IF(L.locationAddress.st <> '', L.locationAddress.st, R.locationAddress.st);
  SELF.locationAddress.zip						:= IF(L.locationAddress.zip <> '', L.locationAddress.zip, R.locationAddress.zip);
  SELF.locationAddress.zip4					  := IF(L.locationAddress.zip4 <> '', L.locationAddress.zip4, R.locationAddress.zip4);
  SELF.locationAddress.cart					  := IF(L.locationAddress.cart <> '', L.locationAddress.cart, R.locationAddress.cart);
  SELF.locationAddress.cr_sort_sz		  := IF(L.locationAddress.cr_sort_sz <> '', L.locationAddress.cr_sort_sz, R.locationAddress.cr_sort_sz);
  SELF.locationAddress.lot						:= IF(L.locationAddress.lot <> '', L.locationAddress.lot, R.locationAddress.lot);
  SELF.locationAddress.lot_order			:= IF(L.locationAddress.lot_order <> '', L.locationAddress.lot_order, R.locationAddress.lot_order);
  SELF.locationAddress.dbpc					  := IF(L.locationAddress.dbpc <> '', L.locationAddress.dbpc, R.locationAddress.dbpc);
  SELF.locationAddress.chk_digit			:= IF(L.locationAddress.chk_digit <> '', L.locationAddress.chk_digit, R.locationAddress.chk_digit);
  SELF.locationAddress.rec_type			  := IF(L.locationAddress.rec_type <> '', L.locationAddress.rec_type, R.locationAddress.rec_type);
  SELF.locationAddress.fips_state 		:= IF(L.locationAddress.fips_state <> '', L.locationAddress.fips_state, R.locationAddress.fips_state);
  SELF.locationAddress.fips_county		:= IF(L.locationAddress.fips_county <> '', L.locationAddress.fips_county, R.locationAddress.fips_county);
  SELF.locationAddress.geo_lat				:= IF(L.locationAddress.geo_lat <> '', L.locationAddress.geo_lat, R.locationAddress.geo_lat);
  SELF.locationAddress.geo_long			  := IF(L.locationAddress.geo_long <> '', L.locationAddress.geo_long, R.locationAddress.geo_long);
  SELF.locationAddress.msa					  := IF(L.locationAddress.msa <> '', L.locationAddress.msa, R.locationAddress.msa);
  SELF.locationAddress.geo_blk			  := IF(L.locationAddress.geo_blk <> '', L.locationAddress.geo_blk, R.locationAddress.geo_blk);
  SELF.locationAddress.geo_match			:= IF(L.locationAddress.geo_match <> '', L.locationAddress.geo_match, R.locationAddress.geo_match);
  SELF.locationAddress.err_stat			  := IF(L.locationAddress.err_stat <> '', L.locationAddress.err_stat, R.locationAddress.err_stat);              
  SELF.Raw_AID_mailing				        := IF(L.Raw_AID_mailing != 0, L.Raw_AID_mailing, R.Raw_AID_mailing);
  SELF.ACE_AID_mailing				        := IF(L.ACE_AID_mailing != 0, L.ACE_AID_mailing, R.ACE_AID_mailing);
  SELF.prep_mailing_addr_line1        := IF(L.prep_mailing_addr_line1 <> '', L.prep_mailing_addr_line1, R.prep_mailing_addr_line1);
  SELF.prep_mailing_addr_line_last    := IF(L.prep_mailing_addr_line_last <> '', L.prep_mailing_addr_line_last, R.prep_mailing_addr_line_last);
  SELF.Raw_AID_location				        := IF(L.Raw_AID_location != 0, L.Raw_AID_location, R.Raw_AID_location);
  SELF.ACE_AID_location				        := IF(L.ACE_AID_location != 0, L.ACE_AID_location, R.ACE_AID_location);        
  SELF.prep_location_addr_line1       := IF(L.prep_location_addr_line1 <> '', L.prep_location_addr_line1, R.prep_location_addr_line1);
  SELF.prep_location_addr_line_last   := IF(L.prep_location_addr_line_last <> '', L.prep_location_addr_line_last, R.prep_location_addr_line_last);
  SELF								                := L;
  SELF								                := [];
END;

dsIASalesTx_AID_dist := DISTRIBUTE(dsIASalesTx_AID_base, HASH32(permit_nbr));
dsIASalesTx_AID_sort := SORT(dsIASalesTx_AID_dist, permit_nbr,
                                                   owner_name,
                                                   business_name,
                                                   city_mailing_address,
                                                   mailing_address,
                                                   state_mailing_address,
                                                   mailing_zip_code,
                                                   location_address,
                                                   city_of_location,
                                                   state_of_location,
                                                   location_zip_code,
                                                   -issue_date, LOCAL);
dsIASalesTx_AID_rolled := ROLLUP(dsIASalesTx_AID_sort, 
                                 LEFT.permit_nbr                    = RIGHT.permit_nbr AND
                                 LEFT.owner_name                    = RIGHT.owner_name AND
                                 LEFT.business_name                 = RIGHT.business_name AND
                                 LEFT.city_mailing_address          = RIGHT.city_mailing_address AND
                                 LEFT.mailing_address               = RIGHT.mailing_address AND
                                 LEFT.state_mailing_address         = RIGHT.state_mailing_address AND
                                 LEFT.mailing_zip_code              = RIGHT.mailing_zip_code AND
                                 LEFT.location_address              = RIGHT.location_address AND
                                 LEFT.city_of_location              = RIGHT.city_of_location AND
                                 LEFT.business_name                 = RIGHT.business_name AND
                                 LEFT.city_mailing_address          = RIGHT.city_mailing_address AND
                                 LEFT.state_of_location             = RIGHT.state_of_location AND
                                 LEFT.location_zip_code             = RIGHT.location_zip_code AND
																 LEFT.prep_mailing_addr_line1       = RIGHT.prep_mailing_addr_line1 AND
																 LEFT.prep_mailing_addr_line_last   = RIGHT.prep_mailing_addr_line_last AND
																 LEFT.prep_location_addr_line1      = RIGHT.prep_location_addr_line1 AND
																 LEFT.prep_location_addr_line_last  = RIGHT.prep_location_addr_line_last,
                                 RollupAddress(LEFT, RIGHT),
                                 LOCAL);

govdata.Layout_IA_SalesTax_Base into_norm(RECORDOF(dsIASalesTx_AID_rolled) L, INTEGER C) := TRANSFORM

	SELF.mailingAddress.prim_range      := CHOOSE(C, L.mailingAddress.prim_range, L.mailingAddress.prim_range,
                                                L.locationAddress.prim_Range, L.locationAddress.prim_Range);
	SELF.mailingAddress.predir          := CHOOSE(C, L.mailingAddress.predir, L.mailingAddress.predir,
                                                L.locationAddress.predir, L.locationAddress.predir);
	SELF.mailingAddress.prim_name 	    := CHOOSE(C, L.mailingAddress.prim_name, L.mailingAddress.prim_name,
                                                L.locationAddress.prim_name, L.locationAddress.prim_name);
	SELF.mailingAddress.addr_suffix	    := CHOOSE(C, L.mailingAddress.addr_suffix, L.mailingAddress.addr_suffix,
                                                L.locationAddress.addr_suffix, L.locationAddress.addr_suffix);
	SELF.mailingAddress.postdir   	    := CHOOSE(C, L.mailingAddress.postdir, L.mailingAddress.postdir,
                                                L.locationAddress.postdir, L.locationAddress.postdir);
	SELF.mailingAddress.unit_desig 	    := CHOOSE(C, L.mailingAddress.unit_desig, L.mailingAddress.unit_desig,
                                                L.locationAddress.unit_desig, L.locationAddress.unit_desig);
	SELF.mailingAddress.sec_range	      := CHOOSE(C, L.mailingAddress.sec_range, L.mailingAddress.sec_range,
                                                L.locationAddress.sec_Range, L.locationAddress.sec_Range);
	SELF.mailingAddress.p_city_name     := CHOOSE(C, L.mailingAddress.p_city_name, L.mailingAddress.p_city_name,
                                                L.locationAddress.p_city_name, L.locationAddress.p_city_name);
	SELF.mailingAddress.v_city_name     := CHOOSE(C, L.mailingAddress.v_city_name, L.mailingAddress.v_city_name,
                                                L.locationAddress.v_city_name, L.locationAddress.v_city_name);
	SELF.mailingAddress.st 				      := CHOOSE(C, L.mailingAddress.st, L.mailingAddress.st, L.locationAddress.st, L.locationAddress.st);
	SELF.mailingAddress.zip 				    := CHOOSE(C, L.mailingAddress.zip, L.mailingAddress.zip, L.locationAddress.zip, L.locationAddress.zip);
	SELF.mailingAddress.zip4 				    := CHOOSE(C, L.mailingAddress.zip4, L.mailingAddress.zip4, L.locationAddress.zip4, L.locationAddress.zip4);
	SELF.mailingAddress.cart 				    := CHOOSE(C, L.mailingAddress.cart, L.mailingAddress.cart, L.locationAddress.cart, L.locationAddress.cart);
	SELF.mailingAddress.cr_sort_sz      := CHOOSE(C, L.mailingAddress.cr_sort_sz, L.mailingAddress.cr_sort_sz,
                                                L.locationAddress.cr_sort_sz, L.locationAddress.cr_sort_sz);
	SELF.mailingAddress.lot 				    := CHOOSE(C, L.mailingAddress.lot, L.mailingAddress.lot, L.locationAddress.lot, L.locationAddress.lot);
	SELF.mailingAddress.lot_order       := CHOOSE(C, L.mailingAddress.lot_order, L.mailingAddress.lot_order,
                                                L.locationAddress.lot_order, L.locationAddress.lot_order);
	SELF.mailingAddress.dbpc 				    := CHOOSE(C, L.mailingAddress.dbpc, L.mailingAddress.dbpc, L.locationAddress.dbpc, L.locationAddress.dbpc);
	SELF.mailingAddress.chk_digit       := CHOOSE(C, L.mailingAddress.chk_digit, L.mailingAddress.chk_digit,
                                                L.locationAddress.chk_digit, L.locationAddress.chk_digit);
	SELF.mailingAddress.rec_type        := CHOOSE(C, L.mailingAddress.rec_type, L.mailingAddress.rec_type,
                                                L.locationAddress.rec_type, L.locationAddress.rec_type);
	SELF.mailingAddress.fips_state      := CHOOSE(C, L.mailingAddress.fips_state, L.mailingAddress.fips_state,
                                                L.locationAddress.fips_state, L.locationAddress.fips_state);
	SELF.mailingAddress.fips_county     := CHOOSE(C, L.mailingAddress.fips_county, L.mailingAddress.fips_county,
                                                L.locationAddress.fips_county, L.locationAddress.fips_county);
	SELF.mailingAddress.geo_lat         := CHOOSE(C, L.mailingAddress.geo_lat, L.mailingAddress.geo_lat,
                                                L.locationAddress.geo_lat, L.locationAddress.geo_lat);
	SELF.mailingAddress.geo_long        := CHOOSE(C, L.mailingAddress.geo_long, L.mailingAddress.geo_long,
                                                L.locationAddress.geo_long, L.locationAddress.geo_long);
	SELF.mailingAddress.msa 				    := CHOOSE(C, L.mailingAddress.msa, L.mailingAddress.msa, L.locationAddress.msa, L.locationAddress.msa);
	SELF.mailingAddress.geo_blk         := CHOOSE(C, L.mailingAddress.geo_blk, L.mailingAddress.geo_blk,
                                                L.locationAddress.geo_blk, L.locationAddress.geo_blk);
	SELF.mailingAddress.geo_match       := CHOOSE(C, L.mailingAddress.geo_match, L.mailingAddress.geo_match,
                                                L.locationAddress.geo_match, L.locationAddress.geo_match);
	SELF.mailingAddress.err_stat        := CHOOSE(C, L.mailingAddress.err_stat, L.mailingAddress.err_stat,
                                                L.locationAddress.err_stat, L.locationAddress.err_stat);
	SELF.company_name_1 		            := CHOOSE(C, L.company_name_1, L.company_name_2, L.company_name_1, L.company_name_2);
	SELF                                := L;
END;

dsIASalesTx_AID_base_norm := NORMALIZE(dsIASalesTx_AID_rolled,4,into_norm(LEFT,COUNTER));

dsIASalesTx_AID_base_norm_sort := SORT(dsIASalesTx_AID_base_norm, 
                                       permit_nbr, 
																			 owner_name, 
																			 business_name, 
																			 company_name_1, 
																			 mailingAddress.prim_range, 
																			 mailingAddress.predir, 
																			 mailingAddress.prim_name,
																			 mailingAddress.addr_suffix,
																			 mailingAddress.postdir,
																			 mailingAddress.unit_desig,
																			 mailingAddress.sec_range,
																			 mailingAddress.p_city_name,
																			 mailingAddress.v_city_name,
																			 mailingAddress.st,
																			 mailingAddress.zip,
																			 -issue_date, 
																			 LOCAL);
																			 
dsIASalesTx_AID_base_dedup := DEDUP(dsIASalesTx_AID_base_norm_sort, 
                                    permit_nbr, 
																		owner_name, 
																		business_name, 
																		company_name_1, 
																		mailingAddress.prim_range, 
																		mailingAddress.predir, 
																		mailingAddress.prim_name,
																		mailingAddress.addr_suffix,
																		mailingAddress.postdir,
																		mailingAddress.unit_desig,
																		mailingAddress.sec_range,
																		mailingAddress.p_city_name,
																		mailingAddress.v_city_name,
																		mailingAddress.st,
																		mailingAddress.zip,
																		LOCAL);

EXPORT IA_Sales_Tax_Build_Base := dsIASalesTx_AID_base_dedup;
