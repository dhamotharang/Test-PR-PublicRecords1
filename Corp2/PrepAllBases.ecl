IMPORT Address, NID, Corp2_Mapping, Corp2, AID;

EXPORT PrepAllBases := module

	export fPreprocessInput(DATASET(Corp2_Mapping.LayoutsCommon.CorpBaseTemp)	inCorpBase,
													DATASET(Corp2_Mapping.LayoutsCommon.ContBaseTemp)	inContBase,
													DATASET(Corp2_Mapping.LayoutsCommon.main)					inMainUpdate) := function
		
		// map the current corporation base to the temporary layout. Transforming ra_name to ra_full_name, adding record origin & src_type
		Corp2_Mapping.LayoutsCommon.Temporary tPreProcess(Corp2_Mapping.LayoutsCommon.CorpBaseTemp l, unsigned4 cnt) :=	transform
			self.unique_id					:=	cnt;
			self.recordOrigin				:=	'P';
			self.Corp_ra_full_name	:=	l.corp_ra_name;	
			self.corp_src_type			:=	'SOS';
			self										:=	l;
			self										:=	[];
		end;
	
		dCorp := 	project(inCorpBase, tPreProcess(left,counter));

		//-------------------------------

		// map the current contact base to the temporary layout. Transforming cont_name to cont_full_name, adding record origin
		Corp2_Mapping.LayoutsCommon.Temporary tPreProcessCont(Corp2_Mapping.LayoutsCommon.ContBaseTemp l, unsigned4 cnt) :=	transform
			self.unique_id			:=	cnt;
			self.recordOrigin		:=	'N';
			self.Cont_full_name	:=	l.cont_name;
			self								:=	l;
			self								:=	[];
		end;
	
		dCont := 	project(inContBase, tPreProcessCont(left,counter));

		//-------------------------------
		Corp2_Mapping.LayoutsCommon.main tGetAllTitles(Corp2_Mapping.LayoutsCommon.main l, unsigned4 c) :=	transform,
							skip(c = 2 and corp2.t2u(l.cont_title2_desc) = '' or
									 c = 3 and corp2.t2u(l.cont_title3_desc) = '' or
									 c = 4 and corp2.t2u(l.cont_title4_desc) = '' or
									 c = 5 and corp2.t2u(l.cont_title5_desc) = '')
			self.cont_title1_desc					:=	choose(c,l.cont_title1_desc,l.cont_title2_desc,l.cont_title3_desc,l.cont_title4_desc,l.cont_title5_desc);
			self													:=	l;
		end;		
		
		dMainAllTitles	:=	normalize(inMainUpdate,5,tGetAllTitles(left, counter));

		Corp2_Mapping.LayoutsCommon.Temporary tPreProcessMain(Corp2_Mapping.LayoutsCommon.main l, unsigned4 cnt) :=	transform
			self.unique_id								:=	cnt;
			self.ProcessedState 					:= 	'Y';
			self.corp_src_type						:=	'SOS';
			self.cont_name								:=	l.cont_full_name;
			self.cont_title_desc					:=	l.cont_title1_desc;
			self													:=	l;
			self													:=	[];
		end;
	
		dMain := 	project(dMainAllTitles, tPreProcessMain(left,counter));

		combined	:=	distribute(dCorp + dCont + dMain,hash(corp_key));


		dedupCombined	:=	dedup(sort(combined,record,local),record,local) : independent;

		return dedupCombined;
		
	end;	
	
	export fStandardizeAddresses(DATASET(Corp2_Mapping.LayoutsCommon.Temporary)	inCombined) := function
	
		addresslayout :=	record
			unsigned8					unique_id;			//to tie back to original record
			string1						recordOrigin;
			unsigned4					address_type;		// contact or mailing
			string100					Append_Prep_Address1;
			string50					Append_Prep_AddressLast;
			AID.Common.xAID		Append_RawAID;		
			AID.Common.xAID		Append_AceAID;			
		end;

		addresslayout tNormalizeAddress(Corp2_Mapping.LayoutsCommon.Temporary l, unsigned4 cnt) := transform
			self.unique_id								:= 	l.unique_id;
			self.recordOrigin							:=	l.recordOrigin;
			self.address_type							:= 	cnt;
		
		
			self.Append_Prep_Address1			:= 	choose(cnt	,l.corp_prep_addr1_line1
																										,l.corp_prep_addr2_line1
																										,l.RA_prep_addr_line1
																										,l.cont_prep_addr_line1
																							);              
			self.Append_Prep_AddressLast	:= 	choose(cnt	,l.corp_prep_addr1_last_line
																										,l.corp_prep_addr2_last_line
																										,l.RA_prep_addr_last_line
																										,l.cont_prep_addr_last_line
																							);  
			self.Append_RawAID						:=	choose(cnt 	,l.Append_Addr1_RawAID
																										,l.Append_Addr2_RawAID
																										,l.Append_RA_RawAID
																										,l.Append_Cont_Addr_RawAID
																							);
			self.Append_ACEAID						:=	choose(cnt 	,l.Append_Addr1_ACEAID
																										,l.Append_Addr2_ACEAID
																										,l.Append_RA_ACEAID
																										,l.Append_Cont_Addr_ACEAID
																							);	
		end;
				
		dAddressPrep						:= 	normalize(inCombined, 4, tNormalizeAddress(left,counter),local);

		HasAddress							:= 	trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';	

		dWith_address						:= 	dAddressPrep(HasAddress);

		dWithout_address				:= 	dAddressPrep(not(HasAddress));
										
		dStandardizeInput_dist 	:= 	distribute(inCombined,hash(unique_id,recordOrigin));

		cleanedAddrLayout :=	record
			addresslayout;
			address.Layout_Clean182		Clean_Address;
		end;
						
		unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
		AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
		cleanedAddrLayout	tCleanAddressAppended(dAddressCleaned pInput)	:=	transform
			self.Append_RawAID			:=	pInput.AIDWork_RawAID;
			self.Append_ACEAID			:=	pInput.aidwork_acecache.aid;		
			self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
			self.clean_address			:=	pInput.AIDWork_ACECache;
			self										:=	pInput;
		end;
					
		dCleanAddressAppended				:=	project(dAddressCleaned,tCleanAddressAppended(left));	
																		
		dCleanAddressAppended_dist		:= distribute(dCleanAddressAppended	,hash(unique_id,recordOrigin));

		DedupAppended	:=	dedup(sort(dCleanAddressAppended_dist,record,local),record,local);
		
		Corp2_Mapping.LayoutsCommon.Temporary tGetStandardizedAddress(Corp2_Mapping.LayoutsCommon.Temporary l	,cleanedAddrLayout r) :=	transform
			self.Append_Addr1_RawAID		:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_Addr1_RawAID);
			self.Append_Addr1_ACEAID		:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_Addr1_ACEAID);
			self.corp_addr1_prim_range	:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.corp_addr1_prim_range);
			self.corp_addr1_predir			:= if(r.address_type = 1	,r.Clean_address.predir				,l.corp_addr1_predir);
			self.corp_addr1_prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.corp_addr1_prim_name);
			self.corp_addr1_addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.corp_addr1_addr_suffix);
			self.corp_addr1_postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.corp_addr1_postdir);
			self.corp_addr1_unit_desig	:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.corp_addr1_unit_desig);
			self.corp_addr1_sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.corp_addr1_sec_range);
			self.corp_addr1_p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.corp_addr1_p_city_name);
			self.corp_addr1_v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.corp_addr1_v_city_name);
			self.corp_addr1_state				:= if(r.address_type = 1	,r.Clean_address.st						,l.corp_addr1_state);
			self.corp_addr1_zip5				:= if(r.address_type = 1	,r.Clean_address.zip					,l.corp_addr1_zip5);
			self.corp_addr1_zip4				:= if(r.address_type = 1	,r.Clean_address.zip4					,l.corp_addr1_zip4);		
			self.corp_addr1_cart				:= if(r.address_type = 1	,r.Clean_address.cart					,l.corp_addr1_cart);
			self.corp_addr1_cr_sort_sz	:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.corp_addr1_cr_sort_sz);
			self.corp_addr1_lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.corp_addr1_lot);
			self.corp_addr1_lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.corp_addr1_lot_order);
			self.corp_addr1_dpbc				:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.corp_addr1_dpbc);
			self.corp_addr1_chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.corp_addr1_chk_digit);
			self.corp_addr1_rec_type		:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.corp_addr1_rec_type);
			self.corp_addr1_ace_fips_st	:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.corp_addr1_ace_fips_st);
			self.corp_addr1_county			:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.corp_addr1_county);
			self.corp_addr1_geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.corp_addr1_geo_lat);
			self.corp_addr1_geo_long		:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.corp_addr1_geo_long);
			self.corp_addr1_msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.corp_addr1_msa);
			self.corp_addr1_geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.corp_addr1_geo_blk);
			self.corp_addr1_geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.corp_addr1_geo_match);
			self.corp_addr1_err_stat		:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.corp_addr1_err_stat);
		
			self.Append_Addr2_RawAID		:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_Addr2_RawAID);
			self.Append_Addr2_ACEAID		:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_Addr2_ACEAID);
			self.corp_Addr2_prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.corp_Addr2_prim_range);
			self.corp_Addr2_predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.corp_Addr2_predir);
			self.corp_Addr2_prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.corp_Addr2_prim_name);
			self.corp_Addr2_addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.corp_Addr2_addr_suffix);
			self.corp_Addr2_postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.corp_Addr2_postdir);
			self.corp_Addr2_unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.corp_Addr2_unit_desig);
			self.corp_Addr2_sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.corp_Addr2_sec_range);
			self.corp_Addr2_p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.corp_Addr2_p_city_name);
			self.corp_Addr2_v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.corp_Addr2_v_city_name);
			self.corp_Addr2_state				:= if(r.address_type = 2	,r.Clean_address.st						,l.corp_Addr2_state);
			self.corp_Addr2_zip5				:= if(r.address_type = 2	,r.Clean_address.zip					,l.corp_Addr2_zip5);
			self.corp_Addr2_zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.corp_Addr2_zip4);		
			self.corp_Addr2_cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.corp_Addr2_cart);
			self.corp_Addr2_cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.corp_Addr2_cr_sort_sz);
			self.corp_Addr2_lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.corp_Addr2_lot);
			self.corp_Addr2_lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.corp_Addr2_lot_order);
			self.corp_Addr2_dpbc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.corp_Addr2_dpbc);
			self.corp_Addr2_chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.corp_Addr2_chk_digit);
			self.corp_Addr2_rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.corp_Addr2_rec_type);
			self.corp_Addr2_ace_fips_st	:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.corp_Addr2_ace_fips_st);
			self.corp_Addr2_county			:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.corp_Addr2_county);
			self.corp_Addr2_geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.corp_Addr2_geo_lat);
			self.corp_Addr2_geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.corp_Addr2_geo_long);
			self.corp_Addr2_msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.corp_Addr2_msa);
			self.corp_Addr2_geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.corp_Addr2_geo_blk);
			self.corp_Addr2_geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.corp_Addr2_geo_match);
			self.corp_Addr2_err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.corp_Addr2_err_stat);
		
			self.Append_RA_RawAID				:= if(r.address_type = 3	,r.Append_RawAID							,l.Append_RA_RawAID);
			self.Append_RA_ACEAID				:= if(r.address_type = 3	,r.Append_ACEAID							,l.Append_RA_ACEAID);
			self.corp_RA_prim_range			:= if(r.address_type = 3	,r.Clean_address.prim_range		,l.corp_RA_prim_range);
			self.corp_RA_predir					:= if(r.address_type = 3	,r.Clean_address.predir				,l.corp_RA_predir);
			self.corp_RA_prim_name			:= if(r.address_type = 3	,r.Clean_address.prim_name		,l.corp_RA_prim_name);
			self.corp_RA_addr_suffix		:= if(r.address_type = 3	,r.Clean_address.addr_suffix	,l.corp_RA_addr_suffix);
			self.corp_RA_postdir				:= if(r.address_type = 3	,r.Clean_address.postdir			,l.corp_RA_postdir);
			self.corp_RA_unit_desig			:= if(r.address_type = 3	,r.Clean_address.unit_desig		,l.corp_RA_unit_desig);
			self.corp_RA_sec_range			:= if(r.address_type = 3	,r.Clean_address.sec_range		,l.corp_RA_sec_range);
			self.corp_RA_p_city_name		:= if(r.address_type = 3	,r.Clean_address.p_city_name	,l.corp_RA_p_city_name);
			self.corp_RA_v_city_name		:= if(r.address_type = 3	,r.Clean_address.v_city_name	,l.corp_RA_v_city_name);
			self.corp_RA_state					:= if(r.address_type = 3	,r.Clean_address.st						,l.corp_RA_state);
			self.corp_RA_zip5						:= if(r.address_type = 3	,r.Clean_address.zip					,l.corp_RA_zip5);
			self.corp_RA_zip4						:= if(r.address_type = 3	,r.Clean_address.zip4					,l.corp_RA_zip4);		
			self.corp_RA_cart						:= if(r.address_type = 3	,r.Clean_address.cart					,l.corp_RA_cart);
			self.corp_RA_cr_sort_sz			:= if(r.address_type = 3	,r.Clean_address.cr_sort_sz		,l.corp_RA_cr_sort_sz);
			self.corp_RA_lot						:= if(r.address_type = 3	,r.Clean_address.lot					,l.corp_RA_lot);
			self.corp_RA_lot_order			:= if(r.address_type = 3	,r.Clean_address.lot_order		,l.corp_RA_lot_order);
			self.corp_RA_dpbc						:= if(r.address_type = 3	,r.Clean_address.dbpc					,l.corp_RA_dpbc);
			self.corp_RA_chk_digit			:= if(r.address_type = 3	,r.Clean_address.chk_digit		,l.corp_RA_chk_digit);
			self.corp_RA_rec_type				:= if(r.address_type = 3	,r.Clean_address.rec_type			,l.corp_RA_rec_type);
			self.corp_RA_ace_fips_st		:= if(r.address_type = 3	,r.Clean_address.county[1..2]	,l.corp_RA_ace_fips_st);
			self.corp_RA_county					:= if(r.address_type = 3	,r.Clean_address.county[3..5]	,l.corp_RA_county);
			self.corp_RA_geo_lat				:= if(r.address_type = 3	,r.Clean_address.geo_lat			,l.corp_RA_geo_lat);
			self.corp_RA_geo_long				:= if(r.address_type = 3	,r.Clean_address.geo_long			,l.corp_RA_geo_long);
			self.corp_RA_msa						:= if(r.address_type = 3	,r.Clean_address.msa					,l.corp_RA_msa);
			self.corp_RA_geo_blk				:= if(r.address_type = 3	,r.Clean_address.geo_blk			,l.corp_RA_geo_blk);
			self.corp_RA_geo_match			:= if(r.address_type = 3	,r.Clean_address.geo_match		,l.corp_RA_geo_match);
			self.corp_RA_err_stat				:= if(r.address_type = 3	,r.Clean_address.err_stat			,l.corp_RA_err_stat);
		
			self.Append_Cont_Addr_RawAID:= if(r.address_type = 4	,r.Append_RawAID							,l.Append_Cont_Addr_RawAID);
			self.Append_Cont_Addr_ACEAID:= if(r.address_type = 4	,r.Append_ACEAID							,l.Append_Cont_Addr_ACEAID);
			self.cont_prim_range				:= if(r.address_type = 4	,r.Clean_address.prim_range		,l.cont_prim_range);
			self.cont_predir						:= if(r.address_type = 4	,r.Clean_address.predir				,l.cont_predir);
			self.cont_prim_name					:= if(r.address_type = 4	,r.Clean_address.prim_name		,l.cont_prim_name);
			self.cont_addr_suffix				:= if(r.address_type = 4	,r.Clean_address.addr_suffix	,l.cont_addr_suffix);
			self.cont_postdir						:= if(r.address_type = 4	,r.Clean_address.postdir			,l.cont_postdir);
			self.cont_unit_desig				:= if(r.address_type = 4	,r.Clean_address.unit_desig		,l.cont_unit_desig);
			self.cont_sec_range					:= if(r.address_type = 4	,r.Clean_address.sec_range		,l.cont_sec_range);
			self.cont_p_city_name				:= if(r.address_type = 4	,r.Clean_address.p_city_name	,l.cont_p_city_name);
			self.cont_v_city_name				:= if(r.address_type = 4	,r.Clean_address.v_city_name	,l.cont_v_city_name);
			self.cont_state							:= if(r.address_type = 4	,r.Clean_address.st						,l.cont_state);
			self.cont_zip5							:= if(r.address_type = 4	,r.Clean_address.zip					,l.cont_zip5);
			self.cont_zip4							:= if(r.address_type = 4	,r.Clean_address.zip4					,l.cont_zip4);		
			self.cont_cart							:= if(r.address_type = 4	,r.Clean_address.cart					,l.cont_cart);
			self.cont_cr_sort_sz				:= if(r.address_type = 4	,r.Clean_address.cr_sort_sz		,l.cont_cr_sort_sz);
			self.cont_lot								:= if(r.address_type = 4	,r.Clean_address.lot					,l.cont_lot);
			self.cont_lot_order					:= if(r.address_type = 4	,r.Clean_address.lot_order		,l.cont_lot_order);
			self.cont_dpbc							:= if(r.address_type = 4	,r.Clean_address.dbpc					,l.cont_dpbc);
			self.cont_chk_digit					:= if(r.address_type = 4	,r.Clean_address.chk_digit		,l.cont_chk_digit);
			self.cont_rec_type					:= if(r.address_type = 4	,r.Clean_address.rec_type			,l.cont_rec_type);
			self.cont_ace_fips_st				:= if(r.address_type = 4	,r.Clean_address.county[1..2]	,l.cont_ace_fips_st);
			self.cont_county						:= if(r.address_type = 4	,r.Clean_address.county[3..5]	,l.cont_county);
			self.cont_geo_lat						:= if(r.address_type = 4	,r.Clean_address.geo_lat			,l.cont_geo_lat);
			self.cont_geo_long					:= if(r.address_type = 4	,r.Clean_address.geo_long			,l.cont_geo_long);
			self.cont_msa								:= if(r.address_type = 4	,r.Clean_address.msa					,l.cont_msa);
			self.cont_geo_blk						:= if(r.address_type = 4	,r.Clean_address.geo_blk			,l.cont_geo_blk);
			self.cont_geo_match					:= if(r.address_type = 4	,r.Clean_address.geo_match		,l.cont_geo_match);
			self.cont_err_stat					:= if(r.address_type = 4	,r.Clean_address.err_stat			,l.cont_err_stat);
			self												:= l;
			self												:= [];
		end;
				
		dCleanCorpAddress1Appended	:= join(
																				dStandardizeInput_dist
																				,dCleanAddressAppended_dist(address_type = 1)
																				,left.unique_id = right.unique_id and
																				 left.recordOrigin = right.recordOrigin
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
		
		dCleanCorpAddress2Appended	:= join(
																				dCleanCorpAddress1Appended
																				,dCleanAddressAppended_dist(address_type = 2)
																				,left.unique_id = right.unique_id and
																				 left.recordOrigin = right.recordOrigin
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
		dCleanRAAddress3Appended		:= join(
																				dCleanCorpAddress2Appended
																				,dCleanAddressAppended_dist(address_type = 3)
																				,left.unique_id = right.unique_id and
																				 left.recordOrigin = right.recordOrigin
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																			
		dCleanAddress4Appended			:= join(
																				dCleanRAAddress3Appended
																				,dCleanAddressAppended_dist(address_type = 4)
																				,left.unique_id = right.unique_id and
																				 left.recordOrigin = right.recordOrigin
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																			
		dedupCleanAppend	:=	dedup(sort(dCleanAddress4Appended,record,local),record,local);	
		
		return dedupCleanAppend;
		
	end;

	export fAll(DATASET(Corp2.Layout_Corporate_Direct_Corp_Base_expanded)	inCorpBase,
							DATASET(Corp2.Layout_Corporate_Direct_Cont_Base_expanded)	inContBase,
							DATASET(Corp2_Mapping.LayoutsCommon.main)									inMainUpdate,
							string pPersistname = corp2.persistnames.StandardAddrNameSlim) := function
							
	
		StateFile	:=	corp2.files().StateFile;
		
		Corp2_Mapping.LayoutsCommon.CorpBaseTemp trfJoinCorp(Corp2.Layout_Corporate_Direct_Corp_Base_expanded l, Corp2_Mapping.LayoutsCommon.ProcessedStates r)	:=	transform
			self.ProcessedState	:=	if (r.state <> '', 'Y', 'N');
			self								:=	l;
		end;
			
		
		JoinCorps	:=	join(	inCorpBase,
												StateFile,
												left.corp_state_origin = right.state,
												trfJoinCorp(left,right),
												left outer, lookup
											 );
											 
		Corp2_Mapping.LayoutsCommon.ContBaseTemp trfJoinCont(Corp2.Layout_Corporate_Direct_Cont_Base_expanded l, Corp2_Mapping.LayoutsCommon.ProcessedStates r)	:=	transform
			self.ProcessedState	:=	if (r.state <> '', 'Y', 'N');
			self								:=	l;
		end;
		
		JoinContact:=	join(	inContBase,
												StateFile,
												left.corp_state_origin = right.state,
												trfJoinCont(left,right),
												left outer, lookup
											 );	
										 
		dPreprocessInput	:= 	fPreprocessInput(JoinCorps, JoinContact, inMainUpdate);
		
		dToProcess				:=	dPreprocessInput(ProcessedState = 'Y');
		dRest							:=	dPreprocessInput(ProcessedState = 'N');
		
		dStandardizeAddr	:= 	fStandardizeAddresses(dToProcess);
		
		dStandardizeName	:=	corp2.Standardize_Names.fAll(dStandardizeAddr);
	
		dResult						:= 	dStandardizeName + dRest	: persist(pPersistname);
	
		return dResult;

	end;							
 
end;
