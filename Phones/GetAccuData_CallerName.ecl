IMPORT Autokey_batch,BatchServices,doxie, Gateway,iesp,MDR,std;
EXPORT GetAccuData_CallerName(DATASET(Phones.Layouts.PhoneAcctno) inPhones, 
																DATASET(Gateway.Layouts.Config) gateways) := FUNCTION
	uniquePhones := DEDUP(SORT(inPhones,phone,acctno),phone);		
	gateway_cfg := gateways(Gateway.Configuration.IsAccuDataCNAM(servicename))[1];
	dsAccuDataCNAM := Gateway.SoapCall_AccuData_CallerID(uniquePhones,gateway_cfg,~Doxie.DataRestriction.AccuData);

	Phones.Layouts.AccuDataCNAM resolveCallerID(iesp.accudata_accuname.t_AccudataCnamResponseEx l) := TRANSFORM
		isAvailable := l.response.AccudataReport.TransactionType<>'' AND 
									 l.response.AccudataReport.Reply.AvailabilityIndicator = 0 AND 
									 l.response.AccudataReport.Reply.PresentationIndicator = 0 AND 
									 l.response.AccudataReport.ErrorMessage=''; 
									 
		callerName	:= STD.Str.ToUpperCase(l.response.AccudataReport.Reply.CallingName);
		SELF.name_first := IF(isAvailable, STD.Str.GetNthWord(callerName,2),'');
		SELF.name_last := IF(isAvailable, STD.Str.GetNthWord(callerName,1),'');
		SELF.listingName := callerName;
		SELF.privateFlag := l.response.AccudataReport.Reply.PresentationIndicator;
		SELF.availabilityIndicator := l.response.AccudataReport.Reply.AvailabilityIndicator; //preserved for additional use
		SELF.phone := l.response.AccudataReport.Phone;
		SELF.did   := 0;
		SELF.acctno := l.response.AccudataReport.RequestID;
		errorMessage := IF(l.response._header.Message<>'',l.response._header.Message,l.response.AccudataReport.ErrorMessage);
		SELF.error_desc := errorMessage;
		SELF.source := IF(errorMessage='',MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2,'')
	END;
	dsCallerIDs := PROJECT(dsAccuDataCNAM, resolveCallerID(LEFT)); 
	// need to send in additional info to get DID - future release
/*	dsPossibleIndividuals:=PROJECT(dsCallerIDs(name_first<>'' AND name_last<>''),TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,SELF.acctno:=LEFT.acctno,SELF.homephone:=LEFT.phone,SELF:=LEFT,SELF:=[]));
	dsPhonewDIDs := BatchServices.Functions.fn_find_dids_and_append_to_acctno(dsPossibleIndividuals,2);
	dsCountDids := TABLE( dsPhonewDIDs, {dsPhonewDIDs.acctno,dsPhonewDIDs.did, did_count := COUNT(GROUP)}, acctno );//doxie.layout_references_acctno
	CallerIDwDIDs			:= JOIN(dsCallerIDs, dsCountDids(did_count=1),
														LEFT.acctno = (STRING)RIGHT.acctno,
														TRANSFORM(Phones.Layouts.AccuDataCNAM,
															SELF.did 				:= LEFT.did,
															SELF						:= LEFT),
														LEFT OUTER,ALL);*/
	#IF(Phones.Constants.Debug.AccuDataCNAM)															
		OUTPUT(dsCallerIDs,NAMED('dsCallerIDs'));
	#END	
	RETURN dsCallerIDs;
END;