IMPORT AddrBest, Address, Autokey_batch, AutokeyB2, BatchServices, 
	   BatchShare, DeathV2_Services, DidVille, LN_PropertyV2, 
	   LN_PropertyV2_Services, Std, Suppress, ut, iesp;

EXPORT Functions := MODULE

		EXPORT seqLinkInput(DATASET(HomesteadExemptionV2_Services.Layouts.inputRec) ds_input_recs) := FUNCTION

			workRec:=RECORD
				HomesteadExemptionV2_Services.Layouts.workRecSlim;
				STRING20 tmpID;
				BOOLEAN hasLink;
			END;

			workLinkRec:=RECORD
				HomesteadExemptionV2_Services.Layouts.workRecSlim.link_clientid;
				DATASET(workRec) work_records;
			END;

			workRec seqInput(ds_input_recs L,INTEGER C) := TRANSFORM
				SELF.acctno:=(STRING)C;
				SELF.orig_acctno:=L.acctno;
				SELF.clientid:=(STRING)C;
				SELF.orig_clientid:=L.clientid;
				tmpID:=REGEXFIND('^([^a-z]+)',L.clientid,1);
				hasLink:=LENGTH(TRIM(L.clientid))=(LENGTH(TRIM(tmpID))+1);
				SELF.tmpID:=IF(hasLink,tmpID,L.clientid);
				SELF.hasLink:=hasLink;
				SELF:=L;
				SELF:=[];
			END;

			// IDENTIFY LINKED CLIENT NUMBERS - EXAMPLE (200 200a 200b)
			workLinkRec linkRecords(workRec L, DATASET(workRec) R) := TRANSFORM
				all_recs:=DATASET([L],workRec)+R;
				roll_recs:=ROLLUP(PROJECT(all_recs,TRANSFORM({STRING s},SELF.s:=LEFT.clientid)),
					TRUE,TRANSFORM({STRING s},SELF.s:=TRIM(LEFT.s)+'.'+TRIM(RIGHT.s)));
				link_clientid:=roll_recs[1].s;
				SELF.link_clientid:=link_clientid;
				SELF.work_records:=PROJECT(all_recs,TRANSFORM(workRec,SELF.link_clientid:=link_clientid,SELF:=LEFT));
			END;

			ds_sequenced:=PROJECT(ds_input_recs,seqInput(LEFT,COUNTER));

			// CHECK FOR ORPHANS
			ds_verifyCnt:=PROJECT(ds_sequenced,TRANSFORM(workRec,
				SELF.hasLink:=IF(NOT LEFT.hasLink,LEFT.hasLink,COUNT(ds_sequenced(tmpID=LEFT.tmpID))>1),
				SELF:=LEFT));

			ds_linked:=DENORMALIZE(ds_verifyCnt(NOT haslink),ds_verifyCnt(hasLink),
				LEFT.orig_clientid=RIGHT.tmpID,GROUP,linkRecords(LEFT,ROWS(RIGHT)));

			ds_normalized:=NORMALIZE(ds_linked,LEFT.work_records,TRANSFORM(workRec,
				SELF.link_clientid:=IF(RIGHT.link_clientid!='',RIGHT.link_clientid,RIGHT.acctno),SELF:=RIGHT));

			// OUTPUT(ds_sequenced,NAMED('ds_sequenced'));
			// OUTPUT(ds_verifyCnt,NAMED('ds_verifyCnt'));
			// OUTPUT(ds_linked,NAMED('ds_linked'));
			// OUTPUT(ds_normalized,NAMED('ds_normalized'));

			RETURN PROJECT(SORT(ds_normalized,(UNSIGNED)acctno),HomesteadExemptionV2_Services.Layouts.workRecSlim);
		END;

	//************************************************/
	EXPORT clean_Names (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_work_in) := FUNCTION

		HomesteadExemptionV2_Services.Layouts.workRecSlim cleanName(ds_work_in L) := TRANSFORM
			hasFullName:=L.name_full!='' AND (L.name_first='' AND L.name_last='');
			cln:=Address.CleanNameFields(Address.CleanPerson73(L.name_full));
			SELF.name_full  := Std.Str.ToUpperCase(L.name_full);
			SELF.name_first := IF(hasFullName,cln.fname,L.name_first);
			SELF.name_middle:= IF(hasFullName,cln.mname,L.name_middle);
			SELF.name_last  := IF(hasFullName,cln.lname,L.name_last);
			SELF.name_suffix:= IF(hasFullName,cln.name_suffix,L.name_suffix);
			SELF:=L;
		END;

		RETURN PROJECT(ds_work_in,cleanName(LEFT));
	END;

	//************************************************/
	EXPORT validate_Input (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_work_in,
					HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

		BatchShare.MAC_CapitalizeInput(ds_work_in,ds_cap_recs);
		BatchShare.MAC_CleanAddresses(ds_cap_recs,ds_cln_recs); // does not fill addr,zip4 or county_name
		
		ds_validate_name_addr:=PROJECT(ds_cln_recs,
			TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRecSlim,
				SELF.error_code:=IF(BatchShare.MAC_IsInputValid(LEFT,BatchShare.Constants.Valid_Min_Cri.DID_OR_Name_Address),
														BatchShare.Constants.ValidInput,
														HomesteadExemptionV2_Services.Constants.INSUFFICIENT_INPUT_CODE),
				SELF:=LEFT));

		HomesteadExemptionV2_Services.Layouts.workRecSlim validateYear(ds_validate_name_addr L) := TRANSFORM
			taxYear:=IF(L.tax_year='',in_mod.TaxYear,L.tax_year);
			hasValidYear:=LENGTH(stringlib.stringfilter(taxYear,'0123456789'))=4;
			taxState:=IF(L.tax_state='',in_mod.TaxState,L.tax_state);
			hasValidState:=taxState IN ut.Set_State_Abbrev;
			SELF.tax_year:=taxYear;
			SELF.tax_state:=taxState;
			SELF.error_code:=IF(hasValidYear AND hasValidState,L.error_code,HomesteadExemptionV2_Services.Constants.INSUFFICIENT_INPUT_CODE);
			SELF:=L;
		END;

		RETURN PROJECT(ds_validate_name_addr,validateYear(LEFT));
	END;

	//************************************************/
	SHARED do_Didville (DATASET(DidVille.Layout_Did_OutBatch) ds_didville_in, UNSIGNED1 ScoreThreshold) := FUNCTION

		didRollRec := RECORD
			UNSIGNED4 seq;
			UNSIGNED6 did;
			UNSIGNED2 score;
			UNSIGNED2 cnt:=1;
		END;

		didRollRec countDids(didRollRec L,didRollRec R) := TRANSFORM
			SELF.seq:=L.seq;
			SELF.did:=L.did;
			SELF.score:=L.score;
			SELF.cnt:=L.cnt+1;
		END;

		didville.MAC_DidAppend(ds_didville_in,ds_didville_out,FALSE,'');
		ds_didville_sort:=PROJECT(SORT(ds_didville_out,seq,-score),TRANSFORM(didRollRec,SELF:=LEFT));

		// OUTPUT(ds_didville_out,NAMED('ds_didville_out'));
		// OUTPUT(ds_didville_sort,NAMED('ds_didville_sort'));

		RETURN ROLLUP(ds_didville_sort,LEFT.seq=RIGHT.seq,countDids(LEFT,RIGHT));
	END;

	//************************************************/
	EXPORT append_Dids (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_work_in,
					HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

		DidVille.Layout_Did_OutBatch didvilleReq(ds_work_in L) := TRANSFORM
			SELF.seq:=(UNSIGNED)L.acctno,
			SELF.fname:=L.name_first;
			SELF.mname:=L.name_middle;
			SELF.lname:=L.name_last;
			SELF.suffix:=L.name_suffix;
			SELF:=L;
			SELF:=[];
		END;

		ds_didville_in:=PROJECT(ds_work_in(error_code=0),didvilleReq(LEFT));
		ds_didville_out:=do_Didville(ds_didville_in,in_mod.didScoreThreshold);

		Constants:=HomesteadExemptionV2_Services.Constants;
		Suppress.MAC_Suppress(ds_didville_out,ds_dids,in_mod.application_type,Suppress.Constants.LinkTypes.DID,did);
		
		HomesteadExemptionV2_Services.Layouts.workRecSlim appendDids(ds_work_in L, ds_didville_out R) := TRANSFORM
			lowLexIdScore:=R.score<in_mod.didScoreThreshold;
			tooManySubjects:=lowLexIdScore AND R.cnt>1;
			SELF.did:=IF(tooManySubjects,L.did,R.did);
			SELF.score:=IF(tooManySubjects,L.score,R.score);
			// LOGIC IS TO IGNORE tooManySubjects WHEN AT LEAST 1 DID IS ABOVE THE THRESHOLD
			SELF.error_code:=MAP(
				L.error_code>0 => L.error_code, // keep any existing error code
				R.did=0 => Constants.NO_LEXID_FOUND_CODE,
				lowLexIdScore => Constants.LOW_LEXID_SCORE_CODE,
				0);
			SELF.exception_code:=MAP(
				L.error_code=Constants.INSUFFICIENT_INPUT_CODE => Constants.INSUFFICIENT_INPUT,
				R.did=0 => Constants.NO_LEXID_FOUND,
				tooManySubjects => Constants.LOW_LEXID_SCORE+';'+Constants.TOO_MANY_SUBJECTS,
				lowLexIdScore => Constants.LOW_LEXID_SCORE,
				'');
			SELF:=L;
		END;

		// OUTPUT(ds_didville_in,NAMED('ds_didville_in'));
		// OUTPUT(ds_didville_out,NAMED('ds_didville_roll'));

		RETURN JOIN(ds_work_in,ds_dids,
			LEFT.acctno=(STRING)RIGHT.seq,
			appendDids(LEFT,RIGHT),
			LEFT OUTER,KEEP(1));
	END;

	//************************************************/
	EXPORT append_LexIdsByProperty (
				DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_work_in,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

		ak_batch_in := PROJECT(ds_work_in, Autokey_batch.Layouts.rec_inBatchMaster);

		// 1. Define values for obtaining autokeys and payloads.
		ak_keyname	:= LN_PropertyV2.Constants.ak_keyname;   //  ln_propertyv2.cluster + 'key::ln_propertyv2::autokey::'
		ak_dataset	:= LN_PropertyV2.Constants.ak_dataset;   //  LN_PropertyV2.file_search_autokey
		ak_typeStr	:= LN_PropertyV2.Constants.ak_typeStr;   //  '\'AK\''
			
		// 2. Configure the autokey search.	
		ak_config := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := TRUE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export isTestHarness   := FALSE;
			export skip_set        := LN_PropertyV2.Constants.ak_skipSet + auto_skip + ['P'];
		END;

		ds_fids := Autokey_batch.get_fids(ak_batch_in, ak_keyname, ak_config);
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, outpl, did, zero, ak_typeStr )
		ds_fares_ids_by_autokey := DEDUP(SORT( PROJECT(outpl, 
										BatchServices.Layouts.LN_Property.rec_acctnos_fids), 
											acctno, ln_fares_id ), 
									acctno, ln_fares_id);

		prop_match_rec := RECORD
			BatchShare.Layouts.ShareAcct;
			BatchShare.Layouts.ShareDid;
			BatchShare.Layouts.ShareName;
			BatchShare.Layouts.ShareAddress;	
			STRING8 process_date;
			BOOLEAN isExactNameMatch := FALSE;
			BOOLEAN isFuzzyNameMatch := FALSE;
			BOOLEAN isAddrMatch := FALSE;
			BOOLEAN isSecRangeIgnored := FALSE;
		END;

		prop_match_rec xform_with_prop(BatchServices.Layouts.LN_Property.rec_acctnos_fids l,
									   RECORDOF(LN_PropertyV2.key_search_fid) r) := TRANSFORM
			SELF.acctno := l.acctno,
			SELF.name_first := r.fname,
			SELF.name_middle := r.mname,
			SELF.name_last := r.lname,
			SELF.name_suffix := r.name_suffix,
			SELF.addr_suffix := r.suffix,
			SELF.z5 := r.zip,
			SELF := r,
		END;
	
		ds_props := JOIN(ds_fares_ids_by_autokey, LN_PropertyV2.key_search_fid(),
						KEYED(LEFT.ln_fares_id = RIGHT.ln_fares_id) AND
						(RIGHT.source_code_1 = HomesteadExemptionV2_Services.Constants.OWNER OR 
						RIGHT.source_code_1 = HomesteadExemptionV2_Services.Constants.BORROWER) AND
						RIGHT.source_code_2 = HomesteadExemptionV2_Services.Constants.PROPERTY, //Property
						xform_with_prop(LEFT, RIGHT), ATMOST(LN_PropertyV2_Services.consts.max_raw));

		// Compare name & address of the property records with the name & address of the input
		// records to set match criteria for determining DID.
		prop_match_rec xform_prop_matches(prop_match_rec l, HomesteadExemptionV2_Services.Layouts.workRecSlim r ) := TRANSFORM
			isAddrMatch := l.prim_range = r.prim_range AND 
						   l.predir = r.predir AND 
						   l.prim_name = r.prim_name AND
						   l.addr_suffix = r.addr_suffix AND 
						   l.postdir = r.postdir AND 
						   l.st = r.st AND 
						   l.z5 = r.z5;

			isNameSuffixMatch := l.name_suffix = '' OR r.name_suffix = '' OR l.name_suffix = r.name_suffix;

			isExactNameMatch := l.name_first = r.name_first AND 
								l.name_last = r.name_last AND 
								isNameSuffixMatch;

			isFuzzyNameMatch := metaphonelib.DMetaPhone1(trim(l.name_first,all)) =  metaphonelib.DMetaPhone1(trim(r.name_first,all)) AND 
								metaphonelib.DMetaPhone1(trim(l.name_last,all)) =  metaphonelib.DMetaPhone1(trim(r.name_last,all)) AND 
								isNameSuffixMatch;
											
			SELF.isAddrMatch := isAddrMatch;
			SELF.isSecRangeIgnored := NOT(l.sec_range = r.sec_range);

			SELF.isExactNameMatch := isExactNameMatch;
			SELF.isFuzzyNameMatch := isFuzzyNameMatch;
			SELF := l;
		END;
		
		ds_props_matches := JOIN(ds_props, ds_work_in,
								LEFT.acctno = RIGHT.acctno,
								xform_prop_matches(LEFT, RIGHT), LEFT OUTER);

		ds_props_good_lexid := ds_props_matches(did <> 0 AND 
												isAddrMatch AND 
												isFuzzyNameMatch);	

		prop_match_rec xdenorm_props(HomesteadExemptionV2_Services.Layouts.workRecSlim l, 
								  	 DATASET(prop_match_rec) r) := TRANSFORM

			// If the property records contain more than one DID, use the input tax_year 
			// to select one.							
			num_prop_dids := COUNT(DEDUP(SORT(r, did), did));
			prop_recs := IF(num_prop_dids = 1, r, r(process_date[1..4] = l.tax_year));
			// Sort so the best match is on top.  isSecRangeIgnored=false ranks higher
			// than isSecRangeIgnored=true.
			prop_recs_sorted := SORT(prop_recs, -isAddrMatch, -isExactNameMatch, -isFuzzyNameMatch, isSecRangeIgnored);
			SELF.did := prop_recs_sorted[1].did;
			SELF.process_date := prop_recs_sorted[1].process_date;
			SELF.isAddrMatch := prop_recs_sorted[1].isAddrMatch;
			SELF.isSecRangeIgnored := prop_recs_sorted[1].isSecRangeIgnored;
			SELF.isExactNameMatch := prop_recs_sorted[1].isExactNameMatch;
			SELF.isFuzzyNameMatch := prop_recs_sorted[1].isFuzzyNameMatch;
			SELF := l;
		END;

		// Get the best match.
		ds_props_denorm := DENORMALIZE(ds_work_in, ds_props_good_lexid,
								LEFT.acctno = RIGHT.acctno,
								GROUP,
									xdenorm_props(LEFT, ROWS(RIGHT)));

		ds_with_LexIdByProperty := JOIN(ds_work_in, ds_props_denorm,
									LEFT.acctno = RIGHT.acctno,
									TRANSFORM(HomesteadExemptionV2_Services.Layouts.workRecSlim,
										SELF.did := IF(RIGHT.did <> 0, RIGHT.did, LEFT.did);
										// If a LexId was found from Property, replace the 
										// Didville score with 100.  Otherwise, use the 
										// Didville score.
										SELF.score := IF(RIGHT.did <> 0, 100, LEFT.score);
										SELF := LEFT));

		RETURN ds_with_LexIdByProperty;

	END;

	//************************************************/
	EXPORT append_Best (DATASET(HomesteadExemptionV2_Services.Layouts.workRecSlim) ds_work_in,
					HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

		best_mod:=MODULE(AddrBest.Iparams.SearchParams)
			EXPORT BOOLEAN ReturnAddrPhone:=TRUE;
			EXPORT BOOLEAN ReturnCountyName:=TRUE;
			EXPORT BOOLEAN ReturnConfidenceFlag:=TRUE;
			EXPORT BOOLEAN ReturnPhoneNumber:=TRUE;
			EXPORT BOOLEAN ReturnConfirmedMatchCode:=TRUE;
			EXPORT BOOLEAN HistoricMatchCodes:=TRUE;
			EXPORT BOOLEAN IncludeRanking:=FALSE; //automatically applied to GOV applications to always get best ranked addr
		END;

		ds_addrBest_in:=PROJECT(ds_work_in,TRANSFORM(AddrBest.Layout_BestAddr.Batch_in,SELF:=LEFT,SELF:=[]));
		ds_addrBest_out:=AddrBest.Records(ds_addrBest_in,best_mod).best_records;

		HomesteadExemptionV2_Services.Layouts.workRec addChildRecs(ds_work_in L, DATASET(AddrBest.Layout_BestAddr.batch_out_final) R) := TRANSFORM
			SELF.Best_Records:=PROJECT(R,TRANSFORM(HomesteadExemptionV2_Services.Layouts.bestRec,
				dobMasked:=Suppress.date_mask((UNSIGNED4)LEFT.DOB,in_mod.dob_mask);
				SELF.DOB_masked:=IF(LEFT.DOB!='',dobMasked.Year+dobMasked.Month+dobMasked.day,''),
				SELF.SSN_masked:=Suppress.ssn_mask(LEFT.SSN,in_mod.ssn_mask),
				SELF.phoneno:=IF(LEFT.phone10!='',LEFT.phone10,LEFT.phone_address),
				SELF.addr:=Address.Addr1FromComponents
					(LEFT.prim_range,LEFT.predir,LEFT.prim_name,LEFT.suffix,LEFT.postdir,LEFT.unit_desig,LEFT.sec_range),
				SELF.addr_suffix:=LEFT.suffix,
				SELF.age:=ut.Age((UNSIGNED4)IF(LEFT.DOB!='',LEFT.DOB,L.DOB)),
				SELF:=LEFT));
			SELF:=L;
			SELF:=[];
		END;

		ds_with_best:=DENORMALIZE(ds_work_in,ds_addrBest_out,LEFT.acctno=RIGHT.acctno,GROUP,addChildRecs(LEFT,ROWS(RIGHT)));

		// OUTPUT(ds_addrBest_in,NAMED('ds_addrBest_in'));
		// OUTPUT(ds_addrBest_out,NAMED('ds_addrBest_out'));

		RETURN ds_with_best;
	END;

	//************************************************/
	EXPORT append_deceased (DATASET(HomesteadExemptionV2_Services.Layouts.workRec) ds_work_in,
					HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

		deceased_mod := MODULE(PROJECT(in_mod,DeathV2_Services.IParam.BatchParams,OPT))
			EXPORT UNSIGNED3 DidScoreThreshold:=HomesteadExemptionV2_Services.Constants.SCORE_THRESHOLD;
		END;

		ds_best_recs:=NORMALIZE(ds_work_in,LEFT.best_records,TRANSFORM(HomesteadExemptionV2_Services.Layouts.bestRec,SELF:=RIGHT));
		ds_deceased_in:=PROJECT(ds_best_recs,DeathV2_Services.Layouts.BatchIn);
		ds_deceased_out:=DeathV2_Services.BatchRecords(ds_deceased_in,deceased_mod);

		HomesteadExemptionV2_Services.Layouts.workRec addChildRecs(ds_work_in L, DATASET(DeathV2_Services.Layouts.BatchOut) R) := TRANSFORM
			SELF.Deceased_Records:=PROJECT(R,TRANSFORM(HomesteadExemptionV2_Services.Layouts.deceasedRec,
				dobMasked:=Suppress.date_mask((UNSIGNED4)LEFT.DOB8,in_mod.dob_mask);
				SELF.DOB_masked:=IF(LEFT.DOB8!='',dobMasked.Year+dobMasked.Month+dobMasked.day,''),
				SELF.SSN_masked:=Suppress.ssn_mask(LEFT.SSN,in_mod.ssn_mask),
				SELF.did:=(UNSIGNED)LEFT.did,
				SELF.name_first:=LEFT.fname,
				SELF.name_middle:=LEFT.mname,
				SELF.name_last:=LEFT.lname,
				SELF.DOB:=LEFT.DOB8,
				SELF.DOD:=LEFT.DOD8,
				SELF.source:=LEFT.death_rec_src,
				SELF:=LEFT));
			SELF:=L;
		END;

		ds_with_death:=DENORMALIZE(ds_work_in,ds_deceased_out,LEFT.acctno=RIGHT.acctno,GROUP,addChildRecs(LEFT,ROWS(RIGHT)));

		// OUTPUT(ds_best_recs,NAMED('ds_best_recs'));
		// OUTPUT(ds_deceased_in,NAMED('ds_deceased_in'));
		// OUTPUT(ds_deceased_out,NAMED('ds_deceased_out'));

		RETURN ds_with_death;
	END;

	//************************************************/
	EXPORT getPropertyID(HomesteadExemptionV2_Services.Layouts.addrMin addr, STRING APN) := FUNCTION
		smashedAddr:=TRIM(addr.prim_range+addr.prim_name+addr.st+addr.z5,ALL);
		hasMinAddr:=(addr.prim_range!='' OR ut.isPOBox(addr.prim_name) OR ut.isRR(addr.prim_name))
			 AND addr.prim_name!='' AND ((addr.p_city_name!='' AND addr.st!='') OR addr.z5!='');
		RETURN IF(hasMinAddr,smashedAddr,APN);
	END;

	//************************************************/
	EXPORT compare2Addresses(HomesteadExemptionV2_Services.Layouts.addrMin addr1, HomesteadExemptionV2_Services.Layouts.addrMin addr2, BOOLEAN includeSecondaryRange=TRUE) := FUNCTION
		RETURN addr1.prim_range=addr2.prim_range AND addr1.prim_name=addr2.prim_name AND
			((addr1.p_city_name=addr2.p_city_name AND addr1.st=addr2.st) OR addr1.z5=addr2.z5) AND
			IF(includeSecondaryRange,addr1.sec_range=addr2.sec_range,TRUE);
	END;

	//************************************************/
	EXPORT previousYears(STRING4 year, INTEGER cnt) := FUNCTION
		rec:=RECORD
			STRING4 year;
		END;
		rec norm(rec L,INTEGER C):=TRANSFORM
			SELF.year:=(STRING4)((UNSIGNED)L.year-(C-1));
		END;
		RETURN NORMALIZE(DATASET([{year}],rec),cnt,norm(LEFT,COUNTER));
	END;

	//************************************************/
	EXPORT getExceptions(DATASET(iesp.Homestead_Exemption_Search.t_HomesteadExemptionRecord) srch_recs) := FUNCTION

		ndxCode:=RECORD
			INTEGER ndx;
			STRING2 code;
		END;

		{DATASET(ndxCode) ds} getCodes(iesp.Homestead_Exemption_Search.t_HomesteadExemptionRecord L, INTEGER ndx) := TRANSFORM
			codes:=DATASET(Std.Str.SplitWords(L.ExceptionCode,';'),iesp.share.t_StringArrayItem);
			SELF.ds:=PROJECT(codes,TRANSFORM(ndxCode,SELF.ndx:=ndx,SELF.code:=LEFT.value));
		END;

		ds_parent:=PROJECT(srch_recs,getCodes(LEFT,COUNTER));
		ds_children:=NORMALIZE(ds_parent,LEFT.ds,TRANSFORM(ndxCode,SELF:=RIGHT));

		CNST:=HomesteadExemptionV2_Services.Constants;
		iesp.share.t_WsException exceptions(ndxCode L) := TRANSFORM
			SELF.source:='Roxie';
			SELF.code:=CASE(L.Code,
				CNST.NO_LEXID_FOUND => CNST.NO_LEXID_FOUND_CODE,
				CNST.LOW_LEXID_SCORE => CNST.LOW_LEXID_SCORE_CODE,
				CNST.TOO_MANY_SUBJECTS => CNST.TOO_MANY_SUBJECTS_CODE,
				CNST.INSUFFICIENT_INPUT => CNST.INSUFFICIENT_INPUT_CODE,
				0);
			SELF.location:=(STRING)L.ndx;
			SELF.message:=CASE(L.Code,
				CNST.NO_LEXID_FOUND => CNST.NO_LEXID_FOUND_MSG,
				CNST.LOW_LEXID_SCORE => CNST.LOW_LEXID_SCORE_MSG,
				CNST.TOO_MANY_SUBJECTS => CNST.TOO_MANY_SUBJECTS_MSG,
				CNST.INSUFFICIENT_INPUT => CNST.INSUFFICIENT_INPUT_MSG,
				'');
			END;
		ds_exceptions:=PROJECT(ds_children,exceptions(LEFT));

		// Return standard FAIL message ESP is expecting if ALL of the names submitted cause exceptions
		BOOLEAN allFailed:=COUNT(srch_recs)=COUNT(srch_recs(ExceptionCode!=''));

		BOOLEAN notFound:=EXISTS(ds_exceptions(Code=CNST.NO_LEXID_FOUND_CODE));
		IF(allFailed AND notFound,FAIL(CNST.NO_LEXID_FOUND_CODE,CNST.NO_LEXID_FOUND_MSG));

		BOOLEAN lowScore:=EXISTS(ds_exceptions(Code=CNST.LOW_LEXID_SCORE_CODE));
		IF(allFailed AND lowScore,FAIL(CNST.LOW_LEXID_SCORE_CODE,CNST.LOW_LEXID_SCORE_MSG));

		BOOLEAN tooMany:=EXISTS(ds_exceptions(Code=CNST.TOO_MANY_SUBJECTS_CODE));
		IF(allFailed AND tooMany,FAIL(CNST.TOO_MANY_SUBJECTS_CODE,CNST.TOO_MANY_SUBJECTS_MSG));

		BOOLEAN insufficient:=EXISTS(ds_exceptions(Code=CNST.INSUFFICIENT_INPUT_CODE));
		IF(allFailed AND insufficient,FAIL(CNST.INSUFFICIENT_INPUT_CODE,CNST.INSUFFICIENT_INPUT_MSG));

		RETURN ds_exceptions(code>0);
	END;

END;