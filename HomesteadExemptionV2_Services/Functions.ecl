IMPORT AddrBest, Address, BatchShare, DeathV2_Services, DidVille, Std, Suppress, ut;

EXPORT Functions := MODULE

		EXPORT seqLinkInput(DATASET(HomesteadExemptionV2_Services.Layouts.inputRec) ds_input_recs) := FUNCTION

			workRec:=RECORD
				HomesteadExemptionV2_Services.Layouts.workRecSlim;
				STRING20 clientID;
				BOOLEAN hasLink;
			END;

			workLinkRec:=RECORD
				HomesteadExemptionV2_Services.Layouts.workRecSlim.link_acctno;
				DATASET(workRec) work_records;
			END;

			workRec seqInput(ds_input_recs L,INTEGER C) := TRANSFORM
				SELF.acctno:=(STRING)C;
				SELF.orig_acctno:=L.acctno;
				clientID:=REGEXFIND('^([^a-z]+)',L.acctno,1);
				hasLink:=LENGTH(TRIM(L.acctno))=(LENGTH(TRIM(clientID))+1);
				SELF.clientID:=IF(hasLink,clientID,L.acctno);
				SELF.hasLink:=hasLink;
				SELF:=L;
				SELF:=[];
			END;

			// IDENTIFY LINKED ACCOUNT NUMBERS - EXAMPLE (200 200a 200b)
			workLinkRec linkRecords(workRec L, DATASET(workRec) R) := TRANSFORM
				all_recs:=DATASET([L],workRec)+R;
				roll_recs:=ROLLUP(PROJECT(all_recs,TRANSFORM({STRING s},SELF.s:=LEFT.acctno)),
					TRUE,TRANSFORM({STRING s},SELF.s:=TRIM(LEFT.s)+'.'+TRIM(RIGHT.s)));
				link_acctno:=roll_recs[1].s;
				SELF.link_acctno:=link_acctno;
				SELF.work_records:=PROJECT(all_recs,TRANSFORM(workRec,SELF.link_acctno:=link_acctno,SELF:=LEFT));
			END;

			ds_sequenced:=PROJECT(ds_input_recs,seqInput(LEFT,COUNTER));

			// CHECK FOR ORPHANS
			ds_verifyCnt:=PROJECT(ds_sequenced,TRANSFORM(workRec,
				SELF.hasLink:=IF(NOT LEFT.hasLink,LEFT.hasLink,COUNT(ds_sequenced(clientID=LEFT.clientID))>1),
				SELF:=LEFT));

			ds_linked:=DENORMALIZE(ds_verifyCnt(NOT haslink),ds_verifyCnt(hasLink),
				LEFT.orig_acctno=RIGHT.clientID,GROUP,linkRecords(LEFT,ROWS(RIGHT)));

			ds_normalized:=NORMALIZE(ds_linked,LEFT.work_records,TRANSFORM(workRec,
				SELF.link_acctno:=IF(RIGHT.link_acctno!='',RIGHT.link_acctno,RIGHT.acctno),SELF:=RIGHT));

			// OUTPUT(ds_sequenced,NAMED('ds_sequenced'));
			// OUTPUT(ds_verifyCnt,NAMED('ds_verifyCnt'));
			// OUTPUT(ds_linked,NAMED('ds_linked'));
			// OUTPUT(ds_normalized,NAMED('ds_normalized'));

			RETURN PROJECT(SORT(ds_normalized,(UNSIGNED)acctno),HomesteadExemptionV2_Services.Layouts.workRecSlim);
		END;

	/************************************************/
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

	/************************************************/
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

	/************************************************/
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

	/************************************************/
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
		Suppress.MAC_Suppress(ds_didville_out,ds_dids,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);

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

	/************************************************/
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
				dobMasked:=Suppress.date_mask((UNSIGNED4)LEFT.DOB,Suppress.date_mask_math.MaskIndicator(in_mod.DOBMask));
				SELF.DOB_masked:=IF(LEFT.DOB!='',dobMasked.Year+dobMasked.Month+dobMasked.day,''),
				SELF.SSN_masked:=Suppress.ssn_mask(LEFT.SSN,in_mod.SSNMask),
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

	/************************************************/
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
				dobMasked:=Suppress.date_mask((UNSIGNED4)LEFT.DOB8,Suppress.date_mask_math.MaskIndicator(in_mod.DOBMask));
				SELF.DOB_masked:=IF(LEFT.DOB8!='',dobMasked.Year+dobMasked.Month+dobMasked.day,''),
				SELF.SSN_masked:=Suppress.ssn_mask(LEFT.SSN,in_mod.SSNMask),
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

	/************************************************/
	EXPORT getPropertyID(HomesteadExemptionV2_Services.Layouts.addrMin addr, STRING APN) := FUNCTION
		smashedAddr:=TRIM(addr.prim_range+addr.prim_name+addr.st+addr.z5,ALL);
		hasMinAddr:=(addr.prim_range!='' OR ut.isPOBox(addr.prim_name) OR ut.isRR(addr.prim_name))
			 AND addr.prim_name!='' AND ((addr.p_city_name!='' AND addr.st!='') OR addr.z5!='');
		RETURN IF(hasMinAddr,smashedAddr,APN);
	END;

	/************************************************/
	EXPORT compare2Addresses(HomesteadExemptionV2_Services.Layouts.addrMin addr1, HomesteadExemptionV2_Services.Layouts.addrMin addr2, BOOLEAN includeSecondaryRange=TRUE) := FUNCTION
		RETURN addr1.prim_range=addr2.prim_range AND addr1.prim_name=addr2.prim_name AND
			((addr1.p_city_name=addr2.p_city_name AND addr1.st=addr2.st) OR addr1.z5=addr2.z5) AND
			IF(includeSecondaryRange,addr1.sec_range=addr2.sec_range,TRUE);
	END;

	/************************************************/
	EXPORT previousYears(STRING4 year, INTEGER cnt) := FUNCTION
		rec:=RECORD
			STRING4 year;
		END;
		rec norm(rec L,INTEGER C):=TRANSFORM
			SELF.year:=(STRING4)((UNSIGNED)L.year-(C-1));
		END;
		RETURN NORMALIZE(DATASET([{year}],rec),cnt,norm(LEFT,COUNTER));
	END;

END;
