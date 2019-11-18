IMPORT DidVille, doxie, Gateway, iesp, MDR, Phones, std;

EXPORT GetAccuData_CallerName(DATASET(Phones.Layouts.PhoneAcctno) inPhones,
																DATASET(Gateway.Layouts.Config) gateways,doxie.IDataAccess mod_access) := FUNCTION
	uniquePhones := DEDUP(SORT(inPhones,phone,acctno),phone);
	gateway_cfg := gateways(Gateway.Configuration.IsAccuDataCNAM(servicename))[1];
	dsAccuDataCNAM := Gateway.SoapCall_AccuData_CallerID(uniquePhones,gateway_cfg,~doxie.compliance.isAccuDataRestricted(mod_access.DataRestrictionMask));

	Phones.Layouts.AccuDataCNAM resolveCallerID(iesp.accudata_accuname.t_AccudataCnamResponseEx l) := TRANSFORM
    // availabilityIndicator and presentationIndicator flags removed from gateway response
		callerName	:= STD.Str.ToUpperCase(l.response.AccudataReport.Reply.CallingName);
		isAvailable := l.response.AccudataReport.ErrorMessage='' AND callerName<>'';
		//RQ-16410: Added IsValidIdentity to distinguish 'City, State' names in Accudata ListingName
		isValidCallerName := IF(isAvailable, Phones.Functions.IsValidIdentity(callerName), FALSE);
		SELF.fname := IF(isValidCallerName, STD.Str.GetNthWord(callerName,1),'');
		SELF.lname := IF(isValidCallerName, STD.Str.GetNthWord(callerName,2),'');
		SELF.listingName := callerName;
		SELF.phone := l.response.AccudataReport.Phone;
		SELF.did   := 0;
		SELF.acctno := l.response.AccudataReport.RequestID;
		errorMessage := IF(l.response._header.Message<>'',l.response._header.Message,l.response.AccudataReport.ErrorMessage);
		SELF.error_desc := errorMessage;
		SELF.source := IF(errorMessage='',MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2,'')
	END;
	dsCallerIDs := PROJECT(dsAccuDataCNAM, resolveCallerID(LEFT));
	// need to send in additional info to get DID - future release
	dsPossibleIndividuals:=PROJECT(dsCallerIDs(fname<>'' AND lname<>''),TRANSFORM(DidVille.Layout_Did_OutBatch,SELF.seq:=(INTEGER)LEFT.acctno,SELF.phone10:=LEFT.phone,SELF:=LEFT,SELF:=[]));
	dsPhonewDIDs := Phones.Functions.GetDIDs(dsPossibleIndividuals,mod_access);
	CallerIDwDIDs			:= JOIN(dsCallerIDs, dsPhonewDIDs,
															LEFT.acctno = (STRING)RIGHT.seq,
															TRANSFORM(Phones.Layouts.AccuDataCNAM,
																SELF.did 	:= LEFT.did,
																SELF						:= LEFT),
															LEFT OUTER,ALL);

	#IF(Phones.Constants.Debug.AccuDataCNAM)
		OUTPUT(dsCallerIDs,NAMED('dsCallerIDs'));
	#END
	RETURN dsCallerIDs;
END;
