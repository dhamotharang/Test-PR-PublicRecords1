IMPORT AutokeyB2, Autokey_batch, Doxie, LN_PropertyV2, LN_PropertyV2_Services, Suppress, 
			BIPV2, BatchServices, FCRA, FFD, Gateway, D2C;

/* 
* The following module is really basic in that it just retrieves Property records, given an input batch
  dataset having the type Autokey_batch.Layouts.rec_inBatchMaster. Because of the variety of Property
	products that exist, which may have to be converted to the Boca system, this module is designed to be
	"wrapped" by any number of other modules, macros or functions to meet those potential needs. For an 
	example of how to consume this module, see BatchServices.Property_BatchService().
*/

//UNSIGNED2 PenaltThreshold    		:= 20  : STORED('PenaltThreshold');
STRING1		MISCELLANEOUS_LAND_USE	:= '0'; 
STRING1		PROPERTY	:= 'P';
STRING1		SELLER		:= 'S';
STRING1		OWNER			:= 'O';
STRING1		BORROWER	:= 'B';
STRING1		CARE_OF		:= 'C';

// 1. Define values for obtaining autokeys and payloads.
ak_keyname	:= LN_PropertyV2.Constants.ak_keyname;   //  ln_propertyv2.cluster + 'key::ln_propertyv2::autokey::'
ak_dataset	:= LN_PropertyV2.Constants.ak_dataset;   //  LN_PropertyV2.file_search_autokey
ak_typeStr	:= LN_PropertyV2.Constants.ak_typeStr;   //  '\'AK\''

// 2. Configure the autokey search.		
ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
	export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
	export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
	export isTestHarness   := FALSE;
	export PenaltThreshold := 10;
	export skip_set        := LN_PropertyV2.Constants.ak_skipSet + auto_skip + ['P'];
END;

EXPORT Property_BatchService_Records(DATASET(LN_PropertyV2_Services.layouts.batch_in) ds_batch_in = DATASET([],LN_PropertyV2_Services.layouts.batch_in),
                                     SET OF STRING record_types = ['A','D','M'],
																							UNSIGNED1 party_type=LN_PropertyV2.Constants.PARTY_TYPE.ALL_PARTY_TYPES,
																							integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
																							boolean isFCRA=false,
																							STRING BIPFetchLevel = 'S',
																							dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
																							integer8 inFFDOptionsMask = 0,
																							dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile,
																							Boolean isCNSMR = false) := 
	MODULE

		// Below Exports used by BatchServices.Property_BatchCommon
		EXPORT nameMatch_value := ak_config_data.MatchName;
		EXPORT streetAddressMatch_value := ak_config_data.MatchStrAddr;
		EXPORT cityMatch_value := ak_config_data.MatchCity;
		EXPORT stateMatch_value := ak_config_data.MatchState;
		EXPORT zipMatch_value := ak_config_data.MatchZip;
		EXPORT dobMatch_value := ak_config_data.MatchDOB;
		EXPORT didMatch_value := ak_config_data.MatchDid;
		EXPORT ssnMatch_value := ak_config_data.MatchSSN;

		/* ================ GET FARES IDS VIA AUTOKEYS ================ */
			
		// 3. Get autokeys based on batch input.
		SHARED ak_batch_in := PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster);
		
		EXPORT ds_fids := Autokey_batch.get_fids(ak_batch_in, ak_keyname, ak_config_data);
																			
		// 4. Get autokey payloads (the real DIDs/BDIDs, record ids, and other goodies).		
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr )

		// 5. Slim the autokey payload (outpl) to just what's needed for matching (acctno and fid). 
		// Then sort and dedup.
		ds_fares_ids_by_autokey := DEDUP(SORT( PROJECT(outpl, BatchServices.Layouts.LN_Property.rec_acctnos_fids), acctno, ln_fares_id ), acctno, ln_fares_id);

	/* ================ GET FARES IDS VIA THE LINKIDs key ================ */

	
	
		ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
		ds_from_linkids := IF(~isFCRA,PROJECT(LN_PropertyV2.Key_LinkIds.kFetch2(ds_linkIds,BIPFetchLevel,,,BatchServices.Constants.PROPERTY_MAX_KFETCH_LIMIT),
															 TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids_plus_linkids,
																					SELF := LEFT,
																					SELF.acctno := '')));
		
		// Add back acctno 
		ds_fares_linkids := JOIN(ds_from_linkids,ds_batch_in,
																LEFT.UltID = RIGHT.UltID AND
																(LEFT.OrgID = RIGHT.OrgID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_OrgID) AND
																(LEFT.SeleID = RIGHT.SeleID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_SELEID) AND
																(LEFT.ProxID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_ProxID) AND
																(LEFT.PowID = RIGHT.PowID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_PowID) AND
																(LEFT.EmpID = RIGHT.EmpID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_EmpID) AND
																(LEFT.DotID = RIGHT.ProxID OR BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_DotID),	
																TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids,
																							SELF.acctno := RIGHT.acctno,
																							SELF := LEFT));
	
	/* ================ GET FARES IDS VIA THE HEADER for more complete coverage ================ */
		ds_acctnos_and_dids := if(~isFCRA,BatchServices.Functions.fn_find_dids_and_append_to_acctno(ak_batch_in),project(ak_batch_in,doxie.layout_references_acctno));
		
		// .. go look for fares ids via dids.
		ds_fares_ids_via_did    := JOIN(ds_acctnos_and_dids, LN_PropertyV2.key_Property_did(isFCRA),
		                                       KEYED(LEFT.did = RIGHT.s_did) and
		                                       (~IsFCRA or right.source_code[1] <> 'C'),
		                                       TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids,
		                                                 SELF.acctno      := LEFT.acctno;
		                                                 SELF.ln_fares_id := RIGHT.ln_fares_id;
																										 self.search_did  := if(nonSS=suppress.constants.NonSubjectSuppression.doNothing
																																						,0,left.did);
		                                                 SELF             := LEFT;),
		                                       INNER, keep(BatchServices.Constants.PROPERTY_MAX_RESULTS_PER_QUERY));		
		
	/* ================ GET FARES IDS VIA APN/DEED AND APN/ASSESSOR ================ */

	  ds_fares_ids_by_deed_apn := JOIN(ds_batch_in, LN_PropertyV2.key_deed_parcelnum,
		                                        KEYED(RIGHT.fares_unformatted_apn = LN_PropertyV2.fn_strip_pnum(LEFT.apn)),
																		        TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids,
		                                                  SELF.acctno      := LEFT.acctno;
		                                                  SELF.ln_fares_id := RIGHT.ln_fares_id;
		                                                  SELF             := LEFT;),
		                                        INNER, keep(BatchServices.Constants.PROPERTY_MAX_RESULTS_PER_QUERY));

		ds_fares_ids_by_assessor_apn := JOIN(ds_batch_in, LN_PropertyV2.key_assessor_parcelnum,
		                                            KEYED(RIGHT.fares_unformatted_apn = LN_PropertyV2.fn_strip_pnum(LEFT.apn)),
		                                            TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids,
		                                                      SELF.acctno      := LEFT.acctno;
		                                                      SELF.ln_fares_id := RIGHT.ln_fares_id;
		                                                      SELF             := LEFT;),
		                                            INNER, keep(BatchServices.Constants.PROPERTY_MAX_RESULTS_PER_QUERY));
 
		ds_ak_plus_hdr := IF( ak_config_data.RunDeepDive, ds_fares_ids_by_autokey + ds_fares_ids_via_did , ds_fares_ids_by_autokey);
		 
    non_fcra_fares_ids0	:= DEDUP(SORT(( ds_ak_plus_hdr + ds_fares_ids_by_deed_apn + ds_fares_ids_by_assessor_apn + ds_fares_linkids), acctno, ln_fares_id),acctno, ln_fares_id);
	  fcra_fares_ids0 := 	DEDUP(SORT(ds_fares_ids_via_did,acctno, ln_fares_id), acctno, ln_fares_id);
	  ds_all_fares_ids0 := if (isFCRA,fcra_fares_ids0,non_fcra_fares_ids0);

		// Add back in -- temporarily -- the fips_code from input.
		ds_all_fares_ids_plus_input_fips := JOIN(ds_all_fares_ids0,ds_batch_in,
																										LEFT.acctno = RIGHT.acctno,
																										TRANSFORM(BatchServices.Layouts.LN_Property.rec_acctnos_fids_plus_fips,
																											SELF.fips_code := RIGHT.fips_code,
																											SELF := LEFT));
																											
		// Now, filter based on FIPS code match.
		ds_deeds_filt_by_fips := JOIN(ds_all_fares_ids_plus_input_fips(ln_fares_id[2] in ['M','D']),LN_PropertyV2.key_deed_fid(isFCRA),
																				 KEYED(RIGHT.ln_fares_id = LEFT.ln_fares_id) AND
																				 (LEFT.fips_code = '' OR RIGHT.fips_code = LEFT.fips_code) AND
																				 (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
																				 TRANSFORM(LEFT),
																				 LIMIT(BatchServices.Constants.PROPERTY_MAX_FIPS_LIMIT,SKIP));
    ds_assessors_filt_by_fips := JOIN(ds_all_fares_ids_plus_input_fips(ln_fares_id[2] in ['A']),LN_PropertyV2.key_assessor_fid(isFCRA),
																				 KEYED(RIGHT.ln_fares_id = LEFT.ln_fares_id) AND
																				 (LEFT.fips_code = '' OR RIGHT.fips_code = LEFT.fips_code) AND
																				 (~isCNSMR or right.vendor_source_flag not in D2C.Constants.LNPropertyV2RestrictedSources ),
																				 TRANSFORM(LEFT),
																				 LIMIT(BatchServices.Constants.PROPERTY_MAX_FIPS_LIMIT,SKIP));
																				 
																				 
		EXPORT ds_all_fares_ids := ds_assessors_filt_by_fips + ds_deeds_filt_by_fips;
		
		//  ..And filter based on the formal parameter 'record_types'. The second character in the ln_fares_id denotes
		//  what sort of record it is: 'A' = Assessment; 'D' = Deed; 'M' = Mortgage.
		// rollup, dedup - what exactly to dedup and what data to preserve. 
	
		/* ================ GET PROPERTY RECORDS ================ */
    EXPORT ds_outpl_slim_filtered := ds_all_fares_ids(ln_fares_id[2] IN record_types);
			
			// 6. Obtain matching domain-specific records via a ready-made function. Note: this returns a very fat layout.
		ds_prep_fids_for_raw := DEDUP(SORT(PROJECT(ds_outpl_slim_filtered, LN_PropertyV2_Services.layouts.fid),ln_fares_id,search_did),ln_fares_id,search_did);
		
		//at this step we need for FCRA to get all statemetIds disregarding input inFFDOptionsMask 1st bit 
		// filtering of Dempsey hits if needed is addressed later in the code
		FFDOptionsMask_adj := if(isFCRA,inFFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS, inFFDOptionsMask);
		_ds_property_output := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(ds_prep_fids_for_raw,,,nonss,isFCRA,slim_pc_recs,FFDOptionsMask_adj,ds_flags)(fid_type != '');

		//Apply Party Type filter (return only parties requested by subscriber) and 
		//tax data filter (return only records where assessment.standardized_land_use_code[1] is not misc. category of 0.
		PT := LN_PropertyV2.Constants.PARTY_TYPE;
		RT := LN_PropertyV2.Constants.RECORD_TYPE;
		
		BOOLEAN is_owner 		:= (party_type & PT.OWNER = PT.OWNER);
		BOOLEAN is_borrower := (party_type & PT.BORROWER = PT.BORROWER);
		BOOLEAN is_seller 	:= (party_type & PT.SELLER  = PT.SELLER);
		BOOLEAN is_care_of 	:= (party_type & PT.CARE_OF = PT.CARE_OF);
		BOOLEAN is_property := (party_type & PT.PROPERTY = PT.PROPERTY);
		
		output_rec := LN_PropertyV2_Services.layouts.combined.widest;

		filterParties (output_rec l) := function
						ds_filter_parties := L.PARTIES(is_owner    and party_type = OWNER OR
																						is_borrower and party_type = BORROWER OR
																						is_seller   and party_type = SELLER OR
																						is_property and party_type = PROPERTY OR
																						is_care_of  and party_type = CARE_OF);
						boolean ds_skip := ~exists(ds_filter_parties);

						output_rec my_transform (output_rec l) := TRANSFORM, SKIP (ds_skip)
								SELF.PARTIES := ds_filter_parties;
								SELF := L;
					END;
			return my_transform (L);
		end;
		
		ds_property_output := _ds_property_output((fid_type != '' AND (fid_type != RT.ASSESSMENT or exists(ASSESSMENTS(standardized_land_use_code[1]!=MISCELLANEOUS_LAND_USE)))));
		ds_property_out := project (ds_property_output, filterParties (Left));
		
	//Apply the penalty
/*------------------------------------------------------------------------------- */
		/*Project input records to input layout needed for penalty functions*/	
		BatchServices.Layouts.LN_Property.rec_input_and_matchcodes xform_input(ds_batch_in L, ds_outpl_slim_filtered R) :=
		TRANSFORM	
			SELF.search_did   := R.search_did;
			SELF := L;
			SELF.LN_FARES_ID 	:= R.LN_FARES_ID;
			SELF._prim_name 	:= 	L.prim_name;   
			SELF._prim_range 	:=	L.prim_range; 
			SELF._postdir 		:=	L.postdir;    
			SELF._addr_suffix :=	L.addr_suffix; 
			SELF._predir 			:=	L.predir;	 
			SELF._sec_range 	:= 	L.sec_range;   
			SELF._p_city_name :=	L.p_city_name;
			SELF._st 					:=	L.st;    
			SELF._z5 					:=	L.z5;
			SELF := [];
		END;
		
		tmp_ds_input := JOIN(ds_batch_in,ds_outpl_slim_filtered,
																LEFT.ACCTNO = RIGHT.ACCTNO,
																xform_input(LEFT,RIGHT));

		output_rec applyPenalty(tmp_ds_input L, ds_property_out R) := transform 
				// Penalty Calculations -----------------------------------------------------------
				entities := NORMALIZE(R.parties(exists(entity)),LEFT.entity,TRANSFORM(RIGHT));
				pen_name	:= BatchServices.Functions.LN_Property.penalize_fullname(L,entities,isFCRA);
				pen_cname	:= BatchServices.Functions.LN_Property.penalize_business_name(L,entities);
				pen_addr	:= BatchServices.Functions.LN_Property.penalize_address(L,R.parties(party_type=PROPERTY)[1]);
				pen_ssn		:= BatchServices.Functions.LN_Property.penalize_ssn(L,entities);
				self.penalt := pen_name + pen_cname + pen_addr + pen_ssn;
				self := R;
		end;
		
		ds_property_pre_penalty := join(tmp_ds_input,ds_property_out,
															LEFT.ln_fares_id = RIGHT.ln_fares_id and left.search_did = right.search_did,
		                     applyPenalty(LEFT,RIGHT));
												 
		ds_property_recs_pnlt := ds_property_pre_penalty(penalt <= ak_config_data.PenaltThreshold);

		// output(ds_property_pre_penalty,named('ds_property_pre_penalty'));
		// output(ds_property_recs_pnlt,named('ds_property_recs_pnlt'));
		// Apply yet another sort-dedup, since it's happened that, in an input batch, the customer will
		// provide many identical records, save for the acctno. Since ds_propoerty_recs doesn't contain
		// an acctno, its only unique identifier is ln_fares_id.
			
		EXPORT ds_property_recs := DEDUP(SORT(ds_property_recs_pnlt, ln_fares_id, search_did), ln_fares_id, search_did);
	END;