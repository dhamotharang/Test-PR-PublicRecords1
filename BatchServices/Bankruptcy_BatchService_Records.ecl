IMPORT AutokeyB2, AutokeyB2_batch, Autokey_batch, BatchServices, BankruptcyV2, BankruptcyV3,
       BankruptcyV3_Services, AutoStandardI, doxie_cbrs, doxie, BIPV2, ut, STD;

string todays_date := (string) STD.Date.Today ();

EXPORT Bankruptcy_BatchService_Records := MODULE
	EXPORT search(	DATASET(BatchServices.layout_BankruptcyV3_Batch_in) ds_batch_in_preREFilter
										= DATASET([],	BatchServices.layout_BankruptcyV3_Batch_in),
					SET OF STRING party_types = ['A','C','D',''],
					BOOLEAN isFCRA 		= FALSE,
					BOOLEAN isDeepDive 	= TRUE,
					STRING in_ssn_mask 	= 'NONE',
					boolean use_namelast4ak = true,
					STRING BIPFetchLevel = 'S',
					BOOLEAN BIPSkipMatch = true,
					BOOLEAN suppress_withdrawn_bankruptcy = FALSE
				 ) := FUNCTION

		// remove possible chars which would interfere with the regular expression keywords
		// which are performed on various fields in the layout
		// Null out uneeded bipids based on bip fetch level
		ds_batch_in := project(ds_batch_in_preREFilter, transform(BatchServices.layout_BankruptcyV3_Batch_in,
		                 self.name_first  := stringlib.stringfilterout(left.name_first, '*?');
										 self.name_middle := stringlib.stringfilterout(left.name_middle, '*?');
										 self.name_last   := stringlib.stringfilterout(left.name_last, '*?');
										 self.comp_name := stringlib.stringfilterout(left.comp_name, '*?');
										 self.UltID := left.ultid,
										 self.OrgID := if(BIPFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  left.OrgID, 0),
										 self.SeleID := if(BIPFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, left.SeleID, 0),
										 self.ProxID := if(BIPFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, left.ProxID, 0),
										 self.EmpID := 0,  // Not used/needed
										 self.POWID := 0,  // Not used/needed
										 self := left));

		UNSIGNED4 Max_Results   := 10000 : STORED('MaxResults');

		/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber  := TRUE;
		STRING  in_filing_jurisdiction 		:= '';
		BOOLEAN in_isSearch					:= false;

		// filtering lists
		STRING mc_include_str 		:= MatchCodes.default_includes : STORED('MatchCode_Includes');
		STRING chap_include_str 	:= '' 	: STORED('Chapter_Includes');
		STRING dcode_include_str 	:= '' 	: STORED('DCode_Includes');
		UNSIGNED2 days_back			:= 0	: STORED('DaysBack');
		string32 appType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));



		//  ************************** TMSIDS BY HEADER LOOKUP **************************

		// ...go look for tmsids via dids.

		ds_acctnos_and_dids := if(isdeepdive and not isFCRA, BatchServices.Functions.fn_find_dids_and_append_to_acctno(PROJECT(ds_batch_in,transform(Autokey_batch.Layouts.rec_inBatchMaster,SELF:=LEFT))));

		/* look for presence of did in input as a source of did lookups */
		ds_dids_via_input := ds_batch_in(did != 0);
		ds_dids_via_input_slim := project(ds_dids_via_input, transform(doxie.layout_references_acctno, self := left));

		ds_dids := ds_acctnos_and_dids + ds_dids_via_input_slim;

		res_did_pre := JOIN(ds_dids(did != 0),
								 bankruptcyv3.key_bankruptcyV3_did(isFCRA),
						 KEYED(LEFT.did = RIGHT.did),
						 transform( { bankruptcyv3_services.layouts.layout_tmsid_ext, UNSIGNED6 did },
								SELF.isDeepDive := TRUE,
								SELF            := RIGHT,
								SELF            := LEFT),
							 LIMIT(20000,SKIP),
						 KEEP(1000));

		res_did :=
			JOIN(
				res_did_pre,
				bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
				KEYED(LEFT.tmsid = RIGHT.tmsid) AND
				LEFT.did = (UNSIGNED) RIGHT.did AND
				RIGHT.name_type[1] IN party_types,
				TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext, SELF := LEFT),
				INNER,
				LIMIT(20000,SKIP),
				KEEP(1000)
			);

		ds_acctnos_and_tmsids_by_did := DEDUP(SORT(res_did, tmsid, acctno), tmsid, acctno);

		// ...and then go look for tmsids via bdids.
		ds_bdids_via_input := ds_batch_in(bdid != 0);

		res_bdid_pre := JOIN(ds_bdids_via_input,
								bankruptcyv3.key_bankruptcyV3_bdid(isFCRA),
							KEYED(LEFT.bdid = RIGHT.p_bdid),
							TRANSFORM( { bankruptcyv3_services.layouts.layout_tmsid_ext, UNSIGNED6 bdid },
								SELF.isDeepDive := TRUE,
								SELF            := RIGHT,
								SELF            := LEFT),
								LIMIT(20000, SKIP),
							KEEP(1000));

		res_bdid :=
			JOIN(
				res_bdid_pre,
				bankruptcyV3.key_bankruptcyV3_search_full_bip(isFCRA),
				KEYED(LEFT.tmsid = RIGHT.tmsid) AND
				LEFT.bdid = (UNSIGNED) RIGHT.bdid AND
				RIGHT.name_type[1] IN party_types,
				TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext, SELF := LEFT),
				INNER,
				LIMIT(20000,SKIP),
				KEEP(1000)
			);

		ds_acctnos_and_tmsids_by_bdid := DEDUP(SORT(res_bdid, tmsid, acctno), tmsid, acctno);

		// tmsids on BIP ids at the seleid level
		// Fetch BK data but only pull debtor companies thus filter on 'D'
		ds_linkIds := PROJECT(ds_batch_in(ultid !=0),BIPV2.IDlayouts.l_xlink_ids2);
		res_bip_pre := PROJECT(bankruptcyV3.key_bankruptcyV3_linkids.kFetch2(ds_linkIds,
														bipFetchLevel)(name_type[1] = 'D'),
														TRANSFORM(bankruptcyv3_services.layouts.layout_bip_ext,
																			SELF.UltID := LEFT.ultid,
																			SELF.OrgID := if(bipFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  LEFT.OrgID, 0),
																		  SELF.SeleID := if(bipFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SeleID, 0),
																			SELF.ProxID := if(bipFetchLevel in BIPV2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
																			SELF.EmpID := 0,  // Not used/needed
																			SELF.POWID := 0,  // Not used/needed
																			SELF := LEFT));

		// Add back acctno and set matchcode
		res_bip := JOIN(res_bip_pre,ds_batch_in,
											LEFT.UltID = RIGHT.UltID AND
											LEFT.OrgID = RIGHT.OrgID AND
											LEFT.SeleID = RIGHT.SeleID AND
											LEFT.ProxID = RIGHT.ProxID,
											TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext,
																		SELF.isdeepdive := TRUE,
																		SELF.matchcode := IF(BIPSkipMatch,'NONE',''),
																		SELF.acctno := RIGHT.acctno,
																		SELF := LEFT));

		ds_acctnos_and_tmsids_by_bip := DEDUP(SORT(res_bip, tmsid, acctno), tmsid, acctno);

		// All tmsids by header lookup.
		ds_header_slim := ds_acctnos_and_tmsids_by_did  + ds_acctnos_and_tmsids_by_bdid + IF(~isFCRA,ds_acctnos_and_tmsids_by_bip);


		// ************************** TMSIDS BY AUTOKEY LOOKUP for Header 'misses' **************************

		// B1. Define values for obtaining autokeys and payloads.
		ak_keyname := BankruptcyV2.Constants('', isFCRA).ak_keyname;
		ak_dataset := BankruptcyV3.file_search_autokey(isFCRA);
		ak_typeStr := 'AK';

		// Configure the autokey search.
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export PenaltThreshold := 20;
			export skip_set        := auto_skip + ['P'];
		END;

		ds_ak_input_needing_autokeys := JOIN(ds_batch_in, ds_header_slim,
												LEFT.acctno = RIGHT.acctno,
												TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,SELF := LEFT),
												LEFT OUTER
												/*LEFT ONLY*/);

		// Get autokeys and payloads based on batch input. Filter autokey records by party_type. Slim to
		// just acctnos and tmsids.
		ds_ak_fids := Autokey_batch.get_fids(ds_ak_input_needing_autokeys, ak_keyname, ak_config_data);

		/*
			now get some more tmsids with redacted ssn / name 'custom autokey':
			not using traditional fetch to avoid conflicts with current work to reconfigure batch autokey fetches
		*/
		ds_akc_cleaned := project(ds_ak_input_needing_autokeys, Autokey_batch.Transforms.xfm_to_Cleaned_Input_Record(left));

		/* convert to rec_DID_InBatch for fetch */
		ds_did_inbatch := project(ds_akc_cleaned, Autokey_batch.Transforms.xfm_convert_for_getting_DIDs(left));

		ds_ak_rn := autokey_batch.Fetch_SSNLast4Name_Batch(group(sort(ds_did_inbatch, acctno), acctno),
																														ak_keyname,
																														ak_config_data.workhard,
																														ak_config_data.nofail);
		/*
			project from Autokey_batch.Layouts.rec_DID_InBatch
			to AutokeyB2_batch.Layouts.rec_output_IDs_batch to union to ds_ak_fids
			the project on the ds_out_ids step is necessary for the rollup
			(rather than just eliminating that project to use the rec of ds_ak_rn in the rollup xfm)
		*/
		ds_out_ids := project(ds_ak_rn, transform(AutokeyB2_batch.Layouts.rec_output_IDs_batch,
																								self.id := (unsigned6) left.did,
																								self := left;));

		AutokeyB2_batch.Layouts.rec_output_IDs_batch xfm_rollup_final_results(ds_out_ids l, ds_out_ids r) :=
			transform
				self := l;
			end;

		ds_akcust1 := rollup(ds_out_ids,
												xfm_rollup_final_results(left, right),
												acctno,
												search_status,
												ID);

		ds_akcust_fids := if(use_namelast4ak, ds_akcust1);

		ds_fids := ds_ak_fids + ds_akcust_fids;

		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outPLfat, intdid, intbdid, ak_typeStr )

		autokey_payload := outPLfat(name_type[1] in party_types);
			bankruptcyv3_services.layouts.layout_tmsid_ext xfm_slim_ak_to_acctno_tmsid(RECORDOF(autokey_payload) L) := TRANSFORM
			SELF := L;
			SELF := [];//isdeepdive
		END;

		ds_autokey_slim := PROJECT(autokey_payload, xfm_slim_ak_to_acctno_tmsid(LEFT));

		// ************************************* TMSIDS BY SSNMATCH ********************************

		SSNMatchJoinCond() := MACRO
			left.ssn != '' AND
			keyed(left.ssn = right.ssnmatch)
		ENDMACRO;

		// only need this for nonFCRA because ssnmatch is already built into autokeys for FCRA
		ds_ssnmatch_tmsids1 := JOIN(ds_batch_in, BankruptcyV3.key_bankruptcyV3_ssnmatch(false),
									SSNMatchJoinCond(),
									TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext,
														SELF := LEFT,
														SELF := RIGHT,
														SELF := []),
									LIMIT(ut.limits.default,SKIP)); //isdeepdive

		ds_ssnmatch_tmsids := if(~isFCRA, ds_ssnmatch_tmsids1, dataset([], bankruptcyv3_services.layouts.layout_tmsid_ext));


		//  ************************************ GET BK RECORDS ************************************

		// Union, sort, dedup all acctnos and tmsids.
		ds_acctno_tmsid_all := ds_autokey_slim + ds_header_slim + ds_ssnmatch_tmsids;

		/* sort on -isdeepdive to give higher precedence to isdeepdive=true if a did is included with the search info */
		ds_acctno_tmsid_ddp := dedup(sort(ds_acctno_tmsid_all, acctno, tmsid, -isdeepdive), acctno, tmsid);

		/* join on 'main' record process_date to filter out according to days_back*/
		ds_acctno_tmsid_daysback_filt := join(ds_acctno_tmsid_ddp,
												bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
												KEYED(LEFT.tmsid = RIGHT.tmsid)
													AND ((ut.DaysApart(right.process_date, todays_date) <= days_back) OR (days_back = 0)),
												TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext, SELF := LEFT),
												KEEP(1),LIMIT(0));

		// Get the BK records and join back to their respective acctnos.

		// get DEBTORS ONLY from fn_rollup
		temp_rollup := bankruptcyv3_services.fn_rollup(
								dataset([],doxie.layout_references),
								dataset([],doxie_cbrs.layout_references),
								ds_acctno_tmsid_daysback_filt,
								0,in_ssn_mask,in_isSearch,,,in_filing_jurisdiction, isFCRA,,,,,appType);


		// fcra overrides, corrections
		temp_rollup_corr := bankruptcyv3_services.fn_fcra_correct(temp_rollup, in_ssn_mask);
		rollup_results := if (isFCRA, temp_rollup_corr, temp_rollup);

		temp_results :=  BankruptcyV3_Services.fn_add_withdrawn_status(rollup_results, isFCRA, suppress_withdrawn_bankruptcy);

		key_court := bankruptcyv3.key_bankruptcyv3_courts;

		BankruptcyV3_Services.layout_bkv3_rollup_ext addCourtInfo(bankruptcyv3_services.layouts.layout_rollup L,
																						recordof(key_court) R) := transform
			self.court.moxie_court := L.court_code;
			self.court.address1 := 		R.address1;
			self.court.city := 				R.city;
			self.court.state := 			R.state;
			self.court.zip := 				R.zip;
			self.court.phone := 			R.phone;
			self.court.district := 		R.district;
			self.court.cfiled := 			R.cfiled;
			self.court.boca_court := 	R.boca_court;
			self.court.c3courtid := 	R.c3courtid;

			self.court.address2		:= 	R.address2;
			self.court.fax			:= 	R.fax;
			self.court.courtID		:= 	R.courtID;
			self.court.div			:= 	R.div;
			self.court.hoganID		:= 	R.hoganID;
			self.court.court		:=	R.court;
			self.court.active		:=	R.active;

			self := L;
		end;

		// append missing court data
		ds_rollup_ext_court := join(temp_results,
									key_court,
									keyed(left.court_code = right.moxie_court),
									addCourtInfo(left, right), LEFT OUTER,
									LIMIT(ut.limits.default,SKIP));

		ds_rollup_court_ddp := dedup(sort(ds_rollup_ext_court,tmsid,record), tmsid);

		layout_rollup_batch_court_ext := record
			bankruptcyv3_services.layouts.layout_rollup;
			bankruptcyv3.layout_courts court;
			string30 acctno;
			string30 matchcode;
		end;

		// join tmsids back to acctnos
		temp_rollup_add_acctno :=
			join(
				ds_rollup_court_ddp,
				ds_acctno_tmsid_ddp,
				left.tmsid = right.tmsid,
				transform(
					layout_rollup_batch_court_ext,
					self.acctno := right.acctno,
					self.isdeepdive := right.isdeepdive,
					self.matchcode := right.matchcode,
					self := left
					));

		// Flatten, sort and return.

		// separate debtors into individual records
		BatchServices.Layouts.bankruptcy.caserec_single_debtor xfm_tosingledebtor(layout_rollup_batch_court_ext L, BankruptcyV3_Services.layouts.layout_party R) := transform
			self := R;
			self := L;
		end;

		ds_single_debtor_per_record := normalize(temp_rollup_add_acctno, left.debtors, xfm_tosingledebtor(LEFT, RIGHT));

		/* flatten */
		ds_flat := project(ds_single_debtor_per_record, BatchServices.xfm_BankruptcyV3_make_flat(LEFT));

		/* add supplemental fields */
		k_supp := bankruptcyv3.key_bankruptcy_main_supp(isFCRA);
		ds_supp := JOIN(ds_flat, k_supp,
						LEFT.tmsid = RIGHT.tmsid,
						TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
							case_status_trim := TRIM(RIGHT.case_status, LEFT, RIGHT);

							SELF.method_dismiss := MAP(	RIGHT.method_dismiss = 'Y' => 'V',
														RIGHT.method_dismiss = 'N' => 'I',
														RIGHT.method_dismiss = 'U' => ' ',
														RIGHT.method_dismiss),
							SELF.case_status	:= MAP(	case_status_trim	 = '1' => BatchServices.Constants.Bankruptcy.CASE_STATUS[1],
														case_status_trim	 = '2' => BatchServices.Constants.Bankruptcy.CASE_STATUS[2],
														case_status_trim	 = '3' => BatchServices.Constants.Bankruptcy.CASE_STATUS[3],
														case_status_trim	 = '4' => BatchServices.Constants.Bankruptcy.CASE_STATUS[4],
														case_status_trim),
							SELF := LEFT,
							SELF := RIGHT),
						LEFT OUTER,
						ATMOST(ut.limits.default));

		/* join tmsids back to match code */
		ds_flat_w_matchcode := batchservices.fn_add_xtra_bk_matchcodes(ds_supp(matchcode != 'NONE'), ds_batch_in);

		/* filter match codes, exclude records marked with matchcode of NONE */
		BatchServices.mac_filter_matchcodes(ds_flat_w_matchcode, ds_mc_filtered, matchcode, mc_include_str, MatchCodes.delim);

		ds_chap_filtered := ds_mc_filtered(chap_include_str = ''
											OR (debtor_chapter IN Std.Str.SplitWords(TRIM(chap_include_str, ALL), ',')));

		ds_dcode_filtered := ds_chap_filtered(dcode_include_str = ''
											OR (debtor_dcode IN Std.Str.SplitWords(TRIM(dcode_include_str, ALL), ',')));

		// Add back in records with matchcode of NONE */
		ds_match_final := ds_dcode_filtered + ds_supp(matchcode = 'NONE');

		// A tmsid can have several linkids associated with it, because of debtor name variations. for tmsids retrieved via
		// input linkids stamp them as the output linkids to avoid confusion.
		res_bip_tmsid_dedup := IF(~isFCRA,DEDUP(SORT(res_bip_pre,tmsid,RECORD),tmsid));
		ds_match_final_bip := JOIN(ds_match_final,res_bip_tmsid_dedup,
														LEFT.tmsid = RIGHT.tmsid,
														TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
																	// Overwrite ids if match on right (tmsid not blank)
																	SELF.ultid := IF(RIGHT.tmsid != '',RIGHT.ultid,LEFT.ultid),
																	SELF.orgid := IF(RIGHT.tmsid != '',RIGHT.orgid,LEFT.orgid),
																	SELF.seleid := IF(RIGHT.tmsid != '',RIGHT.seleid,LEFT.seleid),
																	SELF.proxid := IF(RIGHT.tmsid != '',RIGHT.proxid,LEFT.proxid),
																	SELF.empid := IF(RIGHT.tmsid != '',RIGHT.empid,LEFT.empid),
																	SELF.powid := IF(RIGHT.tmsid != '',RIGHT.powid,LEFT.powid),
																	SELF := LEFT),
																	LEFT OUTER);

		ds_bky_out := if (isFCRA, BatchServices.Functions.ApplySSNStateFilter(ds_match_final_bip, ds_batch_in), ds_match_final_bip);

		ds_out := sort(ds_bky_out, acctno);

		// DEBUGs:
		// output( use_namelast4ak, named('use_namelast4ak'));
		// OUTPUT( ds_batch_in, 					NAMED('ds_batch_in') );
		// OUTPUT( in_bdids, 						NAMED('in_bdids'));
		// OUTPUT( res_bdid, 						NAMED('res_bdid'));
		// OUTPUT( ds_dids_via_input, NAMED('ds_dids_via_input'));
		// OUTPUT( ds_acctnos_and_dids, NAMED('ds_acctnos_and_dids') );
		// OUTPUT( ds_dids, NAMED('ds_dids'));
		// OUTPUT( ds_acctnos_and_bdids, NAMED('ds_acctnos_and_bdids') );
		// OUTPUT( ds_acctnos_and_tmsids_by_did, NAMED('ds_acctnos_and_tmsids_by_did') );
		// OUTPUT( ds_header_slim, 				NAMED('ds_header_slim'));
		// output( ds_akc_cleaned, 		named('ds_akc_cleaned'));
		// output( ds_akc_grouped, 		named('ds_akc_grouped'));
		// output( ds_did_inbatch, 		named('ds_did_inbatch'));
		// output( ds_ak_rn	, 					named('ds_ak_rn'));
		// output(ds_intermed, named('ds_intermed'));
		// output(ds_akcust1, named('ds_akcust1'));
		// output( ds_ak_fids, 				named('ds_ak_fids'));
		// output( ds_akcust_fids, 				named('ds_akcust_fids'));
		// OUTPUT( ds_fids, 						NAMED('ds_fids'));
		// OUTPUT( autokey_payload, 		NAMED('autokey_payload'));
		// OUTPUT( ds_autokey_slim, NAMED('autokey_slim'));
		// OUTPUT( ds_ssnmatch_tmsids, NAMED('ds_ssnmatch_tmsids'));
		// OUTPUT( ds_acctno_tmsid_ddp, named('ds_acctno_tmsid_ddp'));
		// OUTPUT( ds_acctno_tmsid_daysback_filt, NAMED('ds_acctno_tmsid_daysback_filt'));
		// OUTPUT( temp_rollup, named('temp_test_rollup'));
		// OUTPUT( ds_rollup_court_ddp, named('ds_rollup_court_ddp'));
		// OUTPUT( temp_rollup_add_acctno, 		NAMED('temp_rollup_add_acctno'));
		// OUTPUT( ds_single_debtor_per_record, 	NAMED('ds_single_debtor_per_record'));
		// OUTPUT( ds_flat, 						NAMED('ds_flat'));
		// OUTPUT( ds_supp,						NAMED('ds_supp'));
		// OUTPUT( ds_flat_w_matchcode, 			NAMED('ds_flat_w_matchcode'));
		// OUTPUT( ds_mc_filtered, 				NAMED('ds_mc_filtered'));
		// OUTPUT( ds_chap_filtered, NAMED('ds_chap_filtered'));
		// OUTPUT( ds_dcode_filtered, NAMED('ds_dcode_filtered'));
		// output(ds_match_final,named('ds_match_final'));

		RETURN ds_out;

	END; // end search function

	/* report function, essentially the same as search,
		but only accepts TMSID/ACCTNO rather than FLAPSD input */
	EXPORT report(DATASET(BankruptcyV3_Services.layouts.layout_tmsid_ext) ds_batch_in = DATASET([],BankruptcyV3_Services.layouts.layout_tmsid_ext),
								SET OF STRING party_types = ['A','C','D',''],
								boolean isFCRA = false,
								boolean isDeepDive = false,
								STRING in_ssn_mask = 'NONE',
								BOOLEAN suppress_withdrawn_bankruptcy = FALSE) := FUNCTION
				UNSIGNED4 Max_Results   := 10000 : STORED('MaxResults');

		/* ***** System flags and values ***** */
		BOOLEAN forceSeqNumber  := TRUE;
		STRING  in_filing_jurisdiction 		:= '';
		BOOLEAN in_isSearch					:= false;

		// filtering lists
		STRING chap_include_str 	:= ''	: STORED('Chapter_Includes');
		STRING dcode_include_str 	:= '' 	: STORED('DCode_Includes');
		UNSIGNED2 days_back			:= 0	: STORED('DaysBack');
		string32 appType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

		// same as above, just go right to the acctno/tmsids
		ds_acctno_tmsid_ddp := dedup(sort(ds_batch_in, tmsid, acctno), tmsid, acctno);

		/* join on 'main' record process_date to filter out according to days_back*/
		ds_acctno_tmsid_daysback_filt := join(ds_acctno_tmsid_ddp,
												bankruptcyv3.key_bankruptcyV3_main_full(isFCRA),
												KEYED(LEFT.tmsid = RIGHT.tmsid)
													AND ((ut.DaysApart(right.process_date, todays_date) <= days_back) OR (days_back = 0)),
												TRANSFORM(BankruptcyV3_Services.layouts.layout_tmsid_ext, SELF := LEFT),
												KEEP(1), LIMIT(0));

		// Get BK records and join back to their respective acctnos.

		// get DEBTORS ONLY from fn_rollup
		temp_rollup := bankruptcyv3_services.fn_rollup(
								dataset([],doxie.layout_references),
								dataset([],doxie_cbrs.layout_references),
								ds_acctno_tmsid_daysback_filt,
								0,in_ssn_mask,in_isSearch,,,in_filing_jurisdiction, isFCRA,,,,,appType);


		// fcra overrides, corrections
		temp_rollup_corr := bankruptcyv3_services.fn_fcra_correct(temp_rollup, in_ssn_mask);
		rollup_results := if (isFCRA, temp_rollup_corr, temp_rollup);

		// add withdrawn status + its override
		temp_results :=  BankruptcyV3_Services.fn_add_withdrawn_status(rollup_results, isFCRA, suppress_withdrawn_bankruptcy);

		key_court := bankruptcyv3.key_bankruptcyv3_courts;

		BankruptcyV3_Services.layout_bkv3_rollup_ext addCourtInfo(bankruptcyv3_services.layouts.layout_rollup L,
																						recordof(key_court) R) := transform
			self.court.moxie_court := L.court_code;
			self.court.address1 := 		R.address1;
			self.court.city := 				R.city;
			self.court.state := 			R.state;
			self.court.zip := 				R.zip;
			self.court.phone := 			R.phone;
			self.court.district := 		R.district;
			self.court.cfiled := 			R.cfiled;
			self.court.boca_court := 	R.boca_court;
			self.court.c3courtid := 	R.c3courtid;

			self.court.address2		:= 	R.address2;
			self.court.fax			:= 	R.fax;
			self.court.courtID		:= 	R.courtID;
			self.court.div			:= 	R.div;
			self.court.hoganID		:= 	R.hoganID;
			self.court.court		:=	R.court;
			self.court.active		:=	R.active;

			self := L;
		end;

		// append court data from lookup table
		ds_rollup_ext_court := join(temp_results,
									key_court,
									keyed(left.court_code = right.moxie_court),
									addCourtInfo(left, right), LEFT OUTER,
									LIMIT(0));

		ds_rollup_court_ddp := dedup(sort(ds_rollup_ext_court, tmsid, record), tmsid);

		layout_rollup_batch_court_ext := record
			bankruptcyv3_services.layouts.layout_rollup;
			bankruptcyv3.layout_courts court;
			string30 acctno;
			string30 matchcode;
		end;

		// join tmsids back to acctnos
		temp_rollup_add_acctno :=
			join(
				ds_rollup_court_ddp,
				ds_acctno_tmsid_ddp,
				left.tmsid = right.tmsid,
				transform(
					layout_rollup_batch_court_ext,
					self.acctno := right.acctno,
					self.matchcode := right.matchcode,
					self := left));

		// Flatten, sort and return.

		// separate debtors into individual records
		BatchServices.Layouts.bankruptcy.caserec_single_debtor xfm_tosingledebtor(layout_rollup_batch_court_ext L, BankruptcyV3_Services.layouts.layout_party R) := transform
			self := R;
			self := L;
		end;

		ds_single_debtor_per_record := normalize(temp_rollup_add_acctno, left.debtors, xfm_tosingledebtor(LEFT, RIGHT));

		/* flatten */
		ds_flat := project(ds_single_debtor_per_record, BatchServices.xfm_BankruptcyV3_make_flat(LEFT));

		/* add supplemental fields */
		k_supp := bankruptcyv3.key_bankruptcy_main_supp(isFCRA);

		ds_supp := JOIN(ds_flat, k_supp,
						LEFT.tmsid = RIGHT.tmsid,
						TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
							case_status_trim := TRIM(RIGHT.case_status, LEFT, RIGHT);

							SELF.method_dismiss := MAP(	RIGHT.method_dismiss = 'Y' => 'V',
														RIGHT.method_dismiss = 'N' => 'I',
														RIGHT.method_dismiss = 'U' => ' ',
														RIGHT.method_dismiss),
							SELF.case_status	:= MAP(	case_status_trim	 = '1' => BatchServices.Constants.Bankruptcy.CASE_STATUS[1],
														case_status_trim	 = '2' => BatchServices.Constants.Bankruptcy.CASE_STATUS[2],
														case_status_trim	 = '3' => BatchServices.Constants.Bankruptcy.CASE_STATUS[3],
														case_status_trim	 = '4' => BatchServices.Constants.Bankruptcy.CASE_STATUS[4],
														case_status_trim),
							SELF := LEFT,
							SELF := RIGHT),
						LEFT OUTER,
						ATMOST(ut.limits.default));

		ds_chap_filtered := ds_supp(chap_include_str = ''
									OR (debtor_chapter IN Std.Str.SplitWords(TRIM(chap_include_str, ALL), ',')));

		ds_dcode_filtered := ds_chap_filtered(dcode_include_str = ''
									OR (debtor_dcode IN Std.Str.SplitWords(TRIM(dcode_include_str, ALL), ',')));

		ds_out := sort(ds_dcode_filtered, acctno);

		// DEBUGs:
		// OUTPUT( ds_batch_in, NAMED('ds_batch_in_recs') );
		// OUTPUT( ds_acctno_tmsid_ddp, named('ds_acctno_tmsid_ddp'));
		// OUTPUT( temp_rollup, named('temp_test_rollup'));
		// OUTPUT( ds_rollup_court_ddp, named('ds_rollup_court_ddp'));
		// OUTPUT( temp_rollup_add_acctno, named('temp_top_add_acctno'));
		// OUTPUT( ds_single_debtor_per_record, named('ds_single_debtor_per_record'));
		// OUTPUT( ds_flat, named('ds_flat'));

		RETURN ds_out;

	END; // end report function

	/* trustee function, essentially the same as search,
		but only accepts TrusteeID/TrusteeName/ACCTNO rather than FLAPSD input */
	EXPORT trustee(DATASET(BatchServices.layout_Trustee_Batch_in) ds_batch_in = DATASET([],BatchServices.layout_Trustee_Batch_in),
								 BOOLEAN isFCRA = FALSE) := FUNCTION

		UNSIGNED2 days_back			:= 0	: STORED('DaysBack');

		k_trust := BankruptcyV3.key_bankruptcyv3_trusteeidname(isFCRA);

		layout_trustee_tmsid := RECORD
			BatchServices.layout_Trustee_Batch_in;
			bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp.tmsid;
			bankruptcyv3_services.layouts.layout_tmsid_ext.isdeepdive;
		END;

		layout_trustee_tmsid GetTMSID(ds_batch_in L,
																	k_trust R) := TRANSFORM
			SELF.TMSID := R.TMSID;
			SELF.isdeepdive := false;
			SELF := L;
		END;

		trustee_join := JOIN(ds_batch_in,
												 k_trust,
												 keyed(left.trusteeid = right.trusteeid),
												 GetTMSID(left,right),
												 LIMIT(BatchServices.Constants.Trustee.JOIN_LIMIT,SKIP));

		k_main := BankruptcyV3.key_bankruptcyV3_main_full(isFCRA);

		TrusteeJoin() := MACRO
			keyed(LEFT.tmsid = RIGHT.tmsid)
			AND ((ut.DaysApart(right.process_date, todays_date) <= days_back) OR (days_back = 0))
			AND ((right.meeting_date != '' AND right.meeting_date >= todays_date)
					OR
					(right.meeting_date = '' AND ut.DaysApart(right.process_date, todays_date) >= left.hold_days))
		ENDMACRO;

		bkreport_batch_tmsid_in := JOIN(trustee_join,
																		k_main,
																		TrusteeJoin(),
																		TRANSFORM(bankruptcyv3_services.layouts.layout_tmsid_ext, self := left),
																		LIMIT(BatchServices.Constants.Trustee.JOIN_LIMIT,SKIP));

		/* 	Send records through the bankruptcy batchservice report function. */
		SET OF STRING1 party_types   := ['A','C','D',''];
		boolean isDeepDive := false;
		STRING7 in_ssn_mask := 'NONE';

		ds_recs := report(bkreport_batch_tmsid_in,
											party_types,
											isFCRA,
											isDeepDive,
											in_ssn_mask);

		return ds_recs;

	END; // end trustee function

END;
