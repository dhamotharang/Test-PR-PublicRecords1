#workunit('name','Profilebooster_Business');
#option ('hthorMemoryLimit', 1000);

IMPORT PublicRecords_KEL,BRM_Marketing_attributes,RiskWise,Data_Services; 

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 0;
eyeball      := 10;
threads      := 30;

RoxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;      // Production

inputFile := '~tfuerstenberg::in::profilebooster_bus_in.csv';
OutputFile := '~tfuerstenberg::out::profilebooster_bus_test_'+ ThorLib.wuid();

	// Configure options:
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT INTEGER ScoreThreshold := 80;
		EXPORT STRING100 Data_Restriction_Mask := '0000010001001100000000000';
		EXPORT STRING100 Data_Permission_Mask := '0000000000000'; //(non SBFE)
		EXPORT UNSIGNED GLBAPurpose := 0;
		EXPORT UNSIGNED DPPAPurpose := 0;
		EXPORT BOOLEAN IsFCRA := FALSE; //It is only non-fcra query.
		EXPORT BOOLEAN isMarketing := true; //always true for this query
		EXPORT STRING100 Allowed_Sources := '';
		EXPORT BOOLEAN Override_Experian_Restriction := false;
		EXPORT STRING5 IndustryClass := ''; // When set to UTILI or DRMKT this restricts Utility data
		EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
			Data_Restriction_Mask, 
			Data_Permission_Mask, 
			GLBAPurpose, 
			DPPAPurpose, 
			IsFCRA,//isfcra
			isMarketing, //ismarketing
			0, //Allow_DNBDMI
			Override_Experian_Restriction,//OverrideExperianRestriction
			'',//PermissiblePurpose - For FCRA Products Only
			IndustryClass,
			PublicRecords_KEL.CFG_Compile);
		
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold :=75;
		EXPORT UNSIGNED BIPAppendWeightThreshold :=0;
		EXPORT BOOLEAN BIPAppendPrimForce :=false;
		EXPORT BOOLEAN BIPAppendReAppend :=false;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep :=false;
		// CCPA Options
		EXPORT UNSIGNED1 LexIdSourceOptout := 1;
		EXPORT STRING100 TransactionID :='';                                
		EXPORT STRING100 BatchUID :='';
		EXPORT UNSIGNED6 GlobalCompanyId :=0;	
		END;	

prii_layout := RECORD
STRING  AccountNumber;
STRING  CompanyName;
STRING  AlternateCompanyName;
STRING  Addr1;
STRING  City1; 
STRING  State1;
STRING  Zip1;
STRING  BusinessPhone;
STRING  TaxIdNumber;
STRING  BusinessIPAddress;
STRING  Rep1firstname;
STRING  Rep1MiddleName;
STRING  Rep1lastname;
STRING  Rep1NameSuffix;
STRING  Rep1Addr;
STRING  Rep1City;
STRING  Rep1State;
STRING  Rep1Zip;
STRING  Rep1SSN;
STRING  Rep1DOB;
STRING  Rep1Age;
STRING  Rep1DLNumber;
STRING  Rep1DLState;
STRING  Rep1HomePhone;
STRING  Rep1EmailAddress;
STRING  Rep1FormerLastName;
STRING  ArchiveDate;
STRING  PowID;
STRING  ProxID;
STRING  SeleID;
STRING  OrgID;
STRING  UltID;
STRING  SIC_Code;
STRING  NAIC_Code;
STRING  BusinessEmailAddress;
END;
 
// load sample data
	p := IF(recordsToRun = 0,
	      DATASET(InputFile, prii_layout, CSV(QUOTE('"'))),
				CHOOSEN (DATASET(InputFile, prii_layout, CSV(QUOTE('"'))), recordsToRun));
 OUTPUT (choosen(p,eyeball), NAMED ('original_input'));
 
//append G_ProcBusUID to the input.
with_G_ProcBusUID_layout := RECORD
prii_layout;
string30 G_ProcBusUID;
END;

with_G_ProcBusUID_layout getUID(P le, INTEGER C) := TRANSFORM
	SELF.G_ProcBusUID  := le.accountnumber;
	SELF.AccountNumber := (string)c;
	SELF:=le;
	END;

with_G_ProcBusUID := Project(P,getUID(left,counter));

soapLayout := RECORD
  DATASET(BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input) batch_in;
	UNSIGNED BIPAppendScoreThreshold;
	UNSIGNED BIPAppendWeightThreshold;
	BOOLEAN BIPAppendPrimForce;
	BOOLEAN BIPAppendIncludeAuthRep;
	BOOLEAN BIPAppendReAppend;
	STRING100 DataRestrictionMask;
	STRING100 DataPermissionMask;
	UNSIGNED1 glbpurpose;
	UNSIGNED1 dppapurpose;
	STRING AttributeVer1;
	STRING AttributeVer2;
	STRING100 AllowedSources;
	STRING5 IndustryClass;
	BOOLEAN OverrideExperianRestriction;
	INTEGER Score_threshold;
	UNSIGNED1 LexIdSourceOptout;
end;

soapLayout into_input (with_G_ProcBusUID le) := TRANSFORM
SELF.batch_in := DATASET([TRANSFORM( BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input, 
SELF.AcctNo :=le.accountnumber;
SELF.StreetAddressLine1 :=le.addr1;
SELF.BusinessTIN := le.TaxIdNumber;

	 // self.historydateyyyymm := 999999; //query will populate it with the current date  
  // self.historyDate := '';  // leave date blank, query will populate it with the current date  
  // self.historyDate := 0;  // query will populate it with the current date  
SELF.historydateyyyymm := (unsigned)(le.ArchiveDate[1..6]);
SELF.historyDate := (unsigned)(le.ArchiveDate[1..8]);

SELF.G_ProcBusUID:= (INTEGER)le.G_ProcBusUID;	
SELF := le;
SELF := [])]); 

    SELF.Score_threshold := Options.ScoreThreshold;
    SELF.BIPAppendScoreThreshold := Options.BIPAppendScoreThreshold;
    SELF.BIPAppendWeightThreshold := Options.BIPAppendWeightThreshold;
    SELF.BIPAppendPrimForce := Options.BIPAppendPrimForce;
    SELF.BIPAppendIncludeAuthRep := Options.BIPAppendIncludeAuthRep;
    SELF.BIPAppendReAppend := Options.BIPAppendReAppend;
    SELF.DataRestrictionMask :=Options.Data_Restriction_Mask;
    SELF.DataPermissionMask :=Options.Data_Permission_Mask;
    SELF.GLBpurpose := Options.GLBApurpose;
    SELF.DPPApurpose := Options.DPPApurpose;
    self.AttributeVer1 :='MA';
    self.AttributeVer2 := '';
    self.AllowedSources := Options.Allowed_Sources;
    self.IndustryClass := Options.IndustryClass;
    self.OverrideExperianRestriction := Options.Override_Experian_Restriction;
    //CCPA fields
    self.LexIdSourceOptout := Options.LexIdSourceOptout;
    self := [];
		END;
    
soap_in := Distribute(Project(with_G_ProcBusUID, into_input(LEFT)),RANDOM());
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

//we are stripping off some attributes from the layout as per Product Manager. 
//By commenting out the attributes, instead of removing them, will allow in the future for the attributes to be easily added back in to the script
	layout_SOAP_out := RECORD
	BRM_Marketing_attributes.Layout_BRM_NonFCRA.Batch_Input;
	BRM_Marketing_attributes.Layout_BRM_NonFCRA.Layout_BII;
	STRING120 BE_BestName;
	STRING120 BE_BestAddrSt;
	STRING50 BE_BestAddrCity;
	STRING25 BE_BestAddrState;
	STRING10 BE_BestAddrZip;
	STRING10 BE_BestTIN;
	STRING16 BE_BestPhone;
	STRING6 BE_URLFlag;		
	BRM_Marketing_attributes.Layout_BRM_NonFCRA.Layout_BusinessProx;
	STRING20 BE_VerSrcCntEv;
	STRING20 BE_VerSrcOldMsncEv;
	STRING20 BE_VerSrcNewMsncEv;
	STRING20 BE_VerSrcCredCntEv;
	STRING6  BE_VerNameFlag;
	STRING6 BE_VerAddrFlag;
	STRING20 BE_VerAddrSrcOldMsncEv;
	STRING6 BE_AddrPOBoxFlag;
	STRING6 BE_VerTINFlag;
	STRING20 BE_VerTINSrcOldMsncEv;
	STRING6 BE_VerPhoneFlag;
	STRING20 BE_VerPhoneSrcOldMsncEv;
	STRING6 BE_VerSrcRptNewBusFlag;
	STRING6 BE_VerSrcBureauFlag;
	STRING20 BE_VerSrcBureauOldMsncEv;
	STRING6 	BE_BusSICCode1; 
	STRING150	BE_BusSICCode1Desc; 
	STRING6	BE_BusSICCode2; 
	STRING150	BE_BusSICCode2Desc; 
	STRING6	BE_BusSICCode3; 
	STRING150	BE_BusSICCode3Desc; 
	STRING6	BE_BusSICCode4; 
	STRING150	BE_BusSICCode4Desc; 
	STRING6   BE_BusNAICSCode1;
	STRING150 BE_BusNAICSCode1Desc;
	STRING6   BE_BusNAICSCode2;
	STRING150 BE_BusNAICSCode2Desc;
	STRING6   BE_BusNAICSCode3;
	STRING150 BE_BusNAICSCode3Desc;
	STRING6   BE_BusNAICSCode4;
	STRING150 BE_BusNAICSCode4Desc;
	STRING8 BE_BusEmplCountCurr;		
	STRING16 BE_BusAnnualSalesCurr;
	STRING6 BE_BusIsNonProfitFlag;	
	STRING6 BE_BusIsFranchiseFlag;
	STRING6 BE_BusInferFemaleOwnedFlag;	
	STRING6 BE_BusIsFemaleOwnedFlag;	
	STRING6 BE_BusIsMinorityOwnedFlag;	
	STRING6 BE_BusOffers401kFlag;		
	STRING6 BE_BusHasNewLocationFlag1Y;		
	STRING8 BE_BusLocActvCnt;		
	STRING8 BE_DBANameCnt2Y;
	STRING8 BE_AstPropCntEv;		
	STRING8 BE_AstPropCurrCnt;		
	STRING8 BE_AstPropOldMsncEv;		
	STRING8 BE_AstPropNewMsncEv; 		
	STRING11 BE_AstPropCurrValTot;		
	STRING11 BE_AstPropCurrLotSizeTot;		
	STRING11 BE_AstPropCurrBldgSizeTot;	
	STRING8 BE_AstVehWtrCntEv;
	STRING8 BE_AstVehAirCntEv;
	STRING6 BE_BestAddrBldgType;
	STRING20 BE_BestAddrNewTaxValEv;
	STRING20 BE_BestAddrLotSize;
	STRING20 BE_BestAddrBldgSize;
	STRING6 BE_BestAddrIsOwnedFlag;
	STRING8 BE_BestAddrSrcOldMsncEv;
	STRING6 BE_DrgFlag7Y;
	STRING6 BE_DrgGovDebarredFlagEv;
	STRING8 BE_DrgBkCnt10Y;
	STRING8 BE_DrgBkNewMsnc10Y;
	STRING6 BE_DrgBkNewChType10Y;
	STRING8 BE_DrgLienCnt7Y;
	STRING8 BE_DrgLienNewMsnc7Y;
	STRING8 BE_DrgJudgCnt7Y;
	STRING8 BE_DrgJudgNewMsnc7Y;
	STRING8  BE_DrgLTDCnt7Y;
	STRING8  BE_DrgLTDNewMsnc7Y;
	STRING8 BE_SOSOldMsncEv;
	STRING16 BE_SOSDomStatusIndxEv;
	STRING8 BE_SOSStateCntEv;		
	STRING8 BE_UCCCntEv;
	STRING8 BE_UCCActvCnt;
	STRING8 BE_UCCDebtorTermCntEv;
	STRING8 BE_UCCDebtorOtherCntEv;
	STRING8 BE_UCCDebtorOldMsncEv;
	STRING8 BE_UCCDebtorNewMsncEv;
	STRING8 BE_UCCDebtorTermNewMsncEv;
	STRING8 BE_UCCDebtorCntEv;
	STRING8 BE_UCCCreditorCntEv;	
	STRING8 BE_AssocCntEv;
	STRING8 BE_AssocExecCntEv;
	STRING8 BE_AssocNexecCntEv;
	STRING8 BE_B2BActvCnt;
	STRING8 BE_B2BActvFltCnt;
	STRING8 BE_B2BActvCarrCnt;
	STRING8 BE_B2BActvMatCnt;
	STRING8 BE_B2BActvOpsCnt;
	STRING8 BE_B2BActvOthCnt;
	STRING11 BE_B2BActvBalTot;
	STRING11 BE_B2BActvFltBalTot;
	STRING11 BE_B2BActvCarrBalTot;
	STRING11 BE_B2BActvMatBalTot;
	STRING11 BE_B2BActvOpsBalTot;
	STRING11 BE_B2BActvOthBalTot;
	STRING6 BE_B2BActvBalTotRnge;
	STRING6 BE_B2BActvFltBalTotRnge;
	STRING6 BE_B2BActvCarrBalTotRnge;
	STRING6 BE_B2BActvMatBalTotRnge;
	STRING6 BE_B2BActvOpsBalTotRnge;
	STRING6 BE_B2BActvOthBalTotRnge;	
	STRING6 BE_B2BActvWorstPerfIndx;
	STRING6 BE_B2BWorstPerfIndx2Y;
	STRING error_msg:='';
	STRING ErrorCode;
END;

layout_SOAP_out myFail(soap_in le) := TRANSFORM
	SELF.ErrorCode := StringLib.StringFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE),'\n');
	SELF := le;
	SELF := [];
END;

result_SOAPCALL := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'brm_marketing_attributes.brm_marketing_attr_batch_services',
				{soap_in}, 
				DATASET(layout_SOAP_out),
				XPATH('brm_marketing_attributes.brm_marketing_attr_batch_servicesResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
				RETRY(5), TIMEOUT(500),
				PARALLEL(threads), onFail(myFail(LEFT)));

OUTPUT(count(result_SOAPCALL), named('count_result_SOAPCALL'));							
OUTPUT( CHOOSEN(result_SOAPCALL,eyeball), NAMED('result_SOAPCALL') );


finalLayout := RECORD
 layout_SOAP_out;
END;

finalLayout getFile_Ind(result_SOAPCALL le, with_G_ProcBusUID ri) := TRANSFORM
		SELF.G_ProcBusUID := (integer)ri.accountnumber;
		SELF.AcctNo := ri.G_ProcBusUID;
		SELF	 := le;
END;
										 
finalResults := sort(join(result_SOAPCALL, with_G_ProcBusUID,
										 LEFT.AcctNo = RIGHT.accountnumber,
										 getFile_Ind(LEFT, RIGHT), LEFT OUTER),G_ProcBusUID,AcctNo);										 

// ----------[ PASSED RECORDS ]----------

// Records that completed having a MinInputErrorCode shall be kept in the "Passed"
// dataset. However, we still need to display them.
Passed := finalResults(TRIM(ErrorCode) = '' AND TRIM(Acctno)<> '');
  
records_having_MinInputErrorCode := Passed(Error_msg='minimum input criteria not met'); 
OUTPUT( records_having_MinInputErrorCode, NAMED('MinimumInputErrorCode_recs') );

// ----------[ FAILED RECORDS ]----------
// Records that have an ErrorCode besides MinInputErrorCode will be put 
// in the "Failed" dataset. Display these too. Transform them into original input
// ("_as_input") so they can be rerun.

records_having_other_ErrorCode := finalResults(TRIM(ErrorCode)<>''OR TRIM(Acctno) = '');
OUTPUT( records_having_other_ErrorCode, NAMED('OtherErrorCode_recs') );

ds_input_dist := DISTRIBUTE(with_G_ProcBusUID, HASH32(AccountNumber)) : INDEPENDENT;

records_having_other_ErrorCode_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(records_having_other_ErrorCode, HASH32(AcctNo)),
		LEFT.AccountNumber = RIGHT.AcctNo,
		TRANSFORM(LEFT),
		KEEP(1),
		INNER, LOCAL);
	
// Grab any dropped records, i.e. those records not returned by the Roxie. These
// get tossed into the "Failed" dataset also.
dropped_records_as_input :=
	JOIN(
		ds_input_dist, DISTRIBUTE(result_SOAPCALL, HASH32(AcctNo)),
		LEFT.AccountNumber = RIGHT.AcctNo,
		TRANSFORM(LEFT),
		LEFT ONLY, LOCAL);

OUTPUT( COUNT(dropped_records_as_input), NAMED('COUNT_dropped_records') );

Failed := records_having_other_ErrorCode_as_input + dropped_records_as_input;
					
with_G_ProcBusUID_layout UID_Acc_switch (Failed le):= TRANSFORM
SELF.G_ProcBusUID := le.accountnumber;
SELF.accountnumber := le.G_ProcBusUID;
SELF	 := le;
END; 

failedRecords := Project(Failed, UID_Acc_switch(LEFT));       
Failed_Inputs := SORT(PROJECT(failedRecords, TRANSFORM({RECORDOF(LEFT) - G_ProcBusUID}, SELF := LEFT)),AccountNumber);
										 										 
OUTPUT(COUNT(Passed), NAMED('countPassedResults'));
OUTPUT(CHOOSEN(Passed, eyeball), NAMED('PassedResults'));
output(Passed,, outputFile + '_' + thorlib.wuid(),CSV(heading(single), quote('"')), overwrite);
OUTPUT(Failed_Inputs, , outputFile + '_Failed_Inputs.csv', CSV(HEADING(0), QUOTE('"')), EXPIRE(30), OVERWRITE);
