EXPORT MAC_AppendDidVilleDID (batch_in, batch_out, in_mod, did_score_threshold=BatchShare.Constants.Defaults.didScoreThreshold) := MACRO
IMPORT Address, AutoKeyI, BatchShare, DidVille, Gateway, Standard, Suppress;

	// do soap call for remote DidVille dids using Gateway.SoapCall_DidVille()
	// replicate the functionality input and output of BatchShare.MAC_AppendPicklistDID()

	// ERROR RETURN LOGIC
	// did provided in input:                 err_search=16  error_code=0
	// did not found:                         err_search=1   error_code=10
	// did score below threshold:             err_search=1   error_code=10
	// multiple dids and all below threshold: err_search=8   error_code=203
	// multiple dids and one above threshold: err_search=0   error_code=0

	// MINIMUM INPUT LAYOUT REQUIRED
	// BatchShare.Layouts.ShareAcct -- acctno MUST be unique numeric sequence
	// BatchShare.Layouts.ShareName
	// BatchShare.Layouts.ShareAddress
	// BatchShare.Layouts.SharePII
	// BatchShare.Layouts.ShareErrors
	// OPTIONAL OUTPUT
	// UNSIGNED score -- did score 0-100

	// in_mod -- module containing general batch settings
	// did_score_threshold -- minimum score to return did

	// fetch BatchShare params set values from input mod
	#UNIQUENAME(dv_mod);
	%dv_mod%:=MODULE(PROJECT(in_mod,Gateway.IParam.DidVilleParams,OPT))
		EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
	END;

	#UNIQUENAME(batchInRec);
	%batchInRec%:=RECORDOF(batch_in);

	// transform input batch record to didville batch input
	#UNIQUENAME(didVilleReq);
	DidVille.Layout_Did_InBatchRaw %didVilleReq%(%batchInRec% L) := TRANSFORM
		hasFullAddr:=L.prim_name='' AND L.addr!='';
		CLN:=Address.CleanFields(Address.GetCleanAddress(L.addr,
			Address.Addr2FromComponents(L.p_city_name,L.st,L.z5),
			Address.Components.Country.US).str_addr);
		SELF.did:=(STRING)L.did;
		SELF.phoneno:='';
		SELF.title:='';
		SELF.prim_range :=IF(hasFullAddr,CLN.prim_range ,L.prim_range);
		SELF.predir     :=IF(hasFullAddr,CLN.predir     ,L.predir);
		SELF.prim_name  :=IF(hasFullAddr,CLN.prim_name  ,L.prim_name);
		SELF.suffix     :=IF(hasFullAddr,CLN.addr_suffix,L.addr_suffix);
		SELF.postdir    :=IF(hasFullAddr,CLN.postdir    ,L.postdir);
		SELF.unit_desig :=IF(hasFullAddr,CLN.unit_desig ,L.unit_desig);
		SELF.sec_range  :=IF(hasFullAddr,CLN.sec_range  ,L.sec_range);
		SELF.p_city_name:=IF(hasFullAddr,CLN.p_city_name,L.p_city_name);
		SELF.st         :=IF(hasFullAddr,CLN.st         ,L.st);
		SELF.z5         :=IF(hasFullAddr,CLN.zip        ,L.z5);
		SELF.zip4       :=IF(hasFullAddr,CLN.zip4       ,L.zip4);
		SELF:=L;
	END;

	#UNIQUENAME(ds_didville_out);
	%ds_didville_out%:=Gateway.SoapCall_DidVille(PROJECT(batch_in,%didVilleReq%(LEFT)),%dv_mod%);

	#UNIQUENAME(resultRec);
	%resultRec%:=RECORDOF(%ds_didville_out%.result);

	#UNIQUENAME(ds_parents);
	%ds_parents%:=DEDUP(SORT(PROJECT(%ds_didville_out%.result,TRANSFORM({UNSIGNED acctno},
		SELF.acctno:=(UNSIGNED)LEFT.acctno)),acctno),acctno);

	// join result to input to set did provided records
	#UNIQUENAME(ds_children);
	%ds_children%:=JOIN(%ds_didville_out%.result,batch_in,
		(UNSIGNED)LEFT.acctno=(UNSIGNED)RIGHT.acctno,
		TRANSFORM({UNSIGNED err_search,%resultRec%},
			DID_PROVIDED:=RIGHT.did!=0 AND RIGHT.did=(UNSIGNED)LEFT.did;
			SELF.did:=IF(DID_PROVIDED,(STRING)RIGHT.did,LEFT.did),
			SELF.score:=IF(DID_PROVIDED,INTFORMAT(did_score_threshold,3,1),LEFT.score),
			SELF.err_search:=IF(DID_PROVIDED,Standard.errors.SEARCH.DID_INPUT_DID,0),
			SELF:=LEFT),LEFT OUTER,LIMIT(0));

	#UNIQUENAME(denormRec);
	%denormRec% := RECORD
		BatchShare.Layouts.ShareAcct.acctno;
		UNSIGNED score;
		BatchShare.Layouts.ShareDid.did;
		BatchShare.Layouts.ShareErrors.err_search;
		BatchShare.Layouts.ShareErrors.error_code;
	END;

	#UNIQUENAME(SOAPCALL_STATUS);
	%SOAPCALL_STATUS%:=%ds_didville_out%[1].Status>0;

	// denormalize and set errors
	#UNIQUENAME(denormRecs);
	%denormRec% %denormRecs%({UNSIGNED acctno} L,DATASET({UNSIGNED err_search,%resultRec%}) R) := TRANSFORM
		didScoreRec:={UNSIGNED err_search,UNSIGNED score,UNSIGNED did};
		ds_did_score:=PROJECT(R,TRANSFORM(didScoreRec,SELF.score:=(UNSIGNED)LEFT.score,SELF.did:=(UNSIGNED)LEFT.did,SELF.err_search:=LEFT.err_search));
		Suppress.MAC_Suppress(ds_did_score,ds_recs,%dv_mod%.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		rec:=SORT(ds_recs,-score,did)[1];
		DID_PROVIDED:=rec.err_search>0;
		DID_NOT_FOUND:=rec.did=0;
		DIDS_BELOW_THRESHOLD:=COUNT(R)>1 AND rec.score<did_score_threshold;
		DID_BELOW_THRESHOLD:=rec.score<did_score_threshold;
		errSrch:=MAP(
			DID_PROVIDED         => rec.err_search,
			%SOAPCALL_STATUS%    => Standard.errors.SEARCH.TIMEOUT,
			DIDS_BELOW_THRESHOLD => Standard.errors.SEARCH.DID_MULTIPLE,
			DID_NOT_FOUND OR
			DID_BELOW_THRESHOLD  => Standard.errors.SEARCH.DID_NOT_FOUND,
			0);
		errCode:=MAP(
			DID_PROVIDED         => 0,
			DIDS_BELOW_THRESHOLD => AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS,
			DID_NOT_FOUND OR
			DID_BELOW_THRESHOLD  => AutoKeyI.errorcodes._codes.NO_RECORDS,
			0);
		SELF.acctno:=(STRING)(UNSIGNED)L.acctno;
		SELF.score:=IF(errSrch>0,0,rec.score);
		SELF.did:=IF(errCode=0,rec.did,0);
		SELF.err_search:=errSrch;
		SELF.error_code:=errCode;
	END;

	// denormalize and set errors
	#UNIQUENAME(ds_denormalized);
	%ds_denormalized%:=DENORMALIZE(%ds_parents%,%ds_children%,
		(UNSIGNED)LEFT.acctno=(UNSIGNED)RIGHT.acctno,GROUP,%denormRecs%(LEFT,ROWS(RIGHT)));

	batch_out:=JOIN(%ds_denormalized%,batch_in,LEFT.acctno=RIGHT.acctno,
		TRANSFORM(%batchInRec%,SELF:=LEFT,SELF:=RIGHT),LEFT OUTER,KEEP(1),LIMIT(0));

ENDMACRO;
