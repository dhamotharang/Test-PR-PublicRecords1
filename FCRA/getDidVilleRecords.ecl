IMPORT Address, AutoKeyI, DidVille, Gateway, iesp, Suppress;

EXPORT getDidVilleRecords(iesp.person_picklist.t_PersonPickListRequest srchReq,
	UNSIGNED did_score_threshold=80) := FUNCTION

	// do soap call for remote DidVille dids using Gateway.SoapCall_DidVille()

	// ERROR RETURN LOGIC
	// did provided in input:                 Status=0   Return did with highest score
	// did not found:                         Status=10  Message=No records found
	// did score below threshold:             Status=10  Message=No records found
	// multiple dids and all below threshold: Status=203 Message=Too many subjects found
	// multiple dids and one above threshold: Status=0   Return did with highest score

	// fetch DidVille params set values from picklist user request
	dv_mod:=MODULE(PROJECT(Gateway.IParam.getDidVilleParams(),Gateway.IParam.DidVilleParams,OPT))
		EXPORT STRING32 ApplicationType := srchReq.User.ApplicationType;
		EXPORT STRING DataPermissionMask := srchReq.User.DataPermissionMask;
		EXPORT STRING DataRestrictionMask := srchReq.User.DataRestrictionMask;
		EXPORT UNSIGNED1 DPPAPurpose := (UNSIGNED)srchReq.User.DLPurpose;
		EXPORT UNSIGNED1 GLBPurpose := (UNSIGNED)srchReq.User.GLBPurpose;
		EXPORT STRING5 IndustryClass := srchReq.User.IndustryClass;
		EXPORT STRING6 SSN_Mask := srchReq.User.SSNMask;
		EXPORT DATASET(Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
	END;

	// transform picklist search record to didville batch input
	DidVille.Layout_Did_InBatchRaw didVilleReq(iesp.person_picklist.t_PersonPickListRequest L,INTEGER seq) := TRANSFORM
		hasFullAddr:=L.SearchBy.Address.StreetName='' AND L.SearchBy.Address.StreetAddress1!='';
		CLN:=Address.CleanFields(Address.GetCleanAddress(L.SearchBy.Address.StreetAddress1,
			Address.Addr2FromComponents(L.SearchBy.Address.City,L.SearchBy.Address.State,L.SearchBy.Address.Zip5),
			Address.Components.Country.US).str_addr);
		SELF.acctno:=(STRING)seq;
		SELF.did:=L.SearchBy.UniqueID;
		SELF.ssn:=L.SearchBy.SSN;
		dob:=iesp.ECL2ESP.DateToString(L.SearchBy.DOB);
		SELF.dob:=IF((UNSIGNED)dob=0,'',dob);
		SELF.phoneno:=L.SearchBy.Phone10;
		SELF.title:=L.SearchBy.Name.Prefix;
		SELF.name_first:=L.SearchBy.Name.First;
		SELF.name_middle:=L.SearchBy.Name.Middle;
		SELF.name_last:=L.SearchBy.Name.Last;
		SELF.name_suffix:=L.SearchBy.Name.Suffix;
		SELF.prim_range :=IF(hasFullAddr,CLN.prim_range ,L.SearchBy.Address.StreetNumber);
		SELF.predir     :=IF(hasFullAddr,CLN.predir     ,L.SearchBy.Address.StreetPreDirection);
		SELF.prim_name  :=IF(hasFullAddr,CLN.prim_name  ,L.SearchBy.Address.StreetName);
		SELF.suffix     :=IF(hasFullAddr,CLN.addr_suffix,L.SearchBy.Address.StreetSuffix);
		SELF.postdir    :=IF(hasFullAddr,CLN.postdir    ,L.SearchBy.Address.StreetPostDirection);
		SELF.unit_desig :=IF(hasFullAddr,CLN.unit_desig ,L.SearchBy.Address.UnitDesignation);
		SELF.sec_range  :=IF(hasFullAddr,CLN.sec_range  ,L.SearchBy.Address.UnitNumber);
		SELF.p_city_name:=IF(hasFullAddr,CLN.p_city_name,L.SearchBy.Address.City);
		SELF.st         :=IF(hasFullAddr,CLN.st         ,L.SearchBy.Address.State);
		SELF.z5         :=IF(hasFullAddr,CLN.zip        ,L.SearchBy.Address.Zip5);
		SELF.zip4       :=IF(hasFullAddr,CLN.zip4       ,L.SearchBy.Address.Zip4);
	END;

	ds_didville_in:=PROJECT(DATASET([srchReq],iesp.person_picklist.t_PersonPickListRequest),didVilleReq(LEFT,COUNTER));
	ds_didville_out:=Gateway.SoapCall_DidVille(ds_didville_in,dv_mod);

	iesp.share.t_ResponseHeader setRespHdr(INTEGER status) := TRANSFORM
		SELF.Status:=status;
		SELF.Message:=AutoKeyI.errorcodes._msgs(status);
		SELF:=[];
	END;

	iesp.share.t_ResponseHeader setExceptions(DATASET(iesp.share.t_WsException) exceptions, INTEGER status) := TRANSFORM
		SELF.Status:=status;
		SELF.Message:=AutoKeyI.errorcodes._msgs(status);
		SELF.Exceptions:=exceptions;
		SELF:=[];
	END;

	// transform didville batch output to picklist output
	srchResp:=PROJECT(ds_didville_out,TRANSFORM(iesp.person_picklist.t_PersonPickListResponse,
		didScoreRec:={UNSIGNED score,UNSIGNED did};
		ds_did_score:=PROJECT(LEFT.result,TRANSFORM(didScoreRec,SELF.score:=(UNSIGNED)LEFT.score,SELF.did:=(UNSIGNED)LEFT.did));
		Suppress.MAC_Suppress(ds_did_score,ds_recs,dv_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		rec:=SORT(ds_recs,-score,did)[1];
		DID_NOT_FOUND:=rec.did=0;
		DIDS_BELOW_THRESHOLD:=COUNT(ds_recs)>1 AND rec.score<did_score_threshold;
		DID_BELOW_THRESHOLD:=rec.score<did_score_threshold;
		SELF._Header:=MAP(
			LEFT.Status>0        => ROW(setExceptions(LEFT.Exceptions,AutoKeyI.errorcodes._codes.NO_RECORDS)),
			DID_NOT_FOUND        => ROW(setRespHdr(AutoKeyI.errorcodes._codes.NO_RECORDS)),
			DIDS_BELOW_THRESHOLD => ROW(setRespHdr(AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS)),
			DID_BELOW_THRESHOLD  => ROW(setRespHdr(AutoKeyI.errorcodes._codes.NO_RECORDS)),
			ROW(setRespHdr(0))),
		SELF.SubjectTotalCount:=MAP(
			DID_NOT_FOUND        => 0,
			DIDS_BELOW_THRESHOLD => COUNT(ds_recs),
			DID_BELOW_THRESHOLD  => 0,
			1),
		SELF.Records:=MAP(
			DID_NOT_FOUND        => DATASET([],iesp.person_picklist.t_PersonPickListRecord),
			DIDS_BELOW_THRESHOLD => PROJECT(ds_recs,TRANSFORM(iesp.person_picklist.t_PersonPickListRecord,SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[])),
			DID_BELOW_THRESHOLD  => DATASET([],iesp.person_picklist.t_PersonPickListRecord),
			// DEFAULT TOP RECORD
			PROJECT(DATASET([rec],didScoreRec),TRANSFORM(iesp.person_picklist.t_PersonPickListRecord,SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]))),
		SELF:=LEFT,
		SELF:=[]
	));

// OUTPUT(srchReq,NAMED('srchReq'));
// OUTPUT(ds_didville_in,NAMED('ds_didville_in'));
// OUTPUT(ds_didville_out,NAMED('ds_didville_out'));
// OUTPUT(srchResp,NAMED('srchResp'));

	RETURN srchResp;

END;
