IMPORT iesp;

EXPORT Layout_BRM_NonFCRA := Module

	EXPORT Layout_BusinessSele := RECORD	
	//best
	STRING120 BE_BestName;
	STRING120 BE_BestAddrSt;
	STRING50 BE_BestAddrCity;
	STRING25 BE_BestAddrState;
	STRING10 BE_BestAddrZip;
	STRING10 BE_BestTIN;
	STRING16 BE_BestPhone;
	STRING6 BE_URLFlag;		
	STRING6 BE_AssocExecEmailFlag2Y;
	//sos & ucc
	INTEGER3 BE_SOSOldMsncEv;
	INTEGER6 BE_SOSDomStatusIndxEv;
	INTEGER3 BE_SOSStateCntEv;		
	INTEGER3 BE_UCCCntEv;
	INTEGER3 BE_UCCActvCnt;
	INTEGER3 BE_UCCDebtorTermCntEv;
	INTEGER3 BE_UCCDebtorOtherCntEv;
	INTEGER3 BE_UCCDebtorOldMsncEv;
	INTEGER3 BE_UCCDebtorNewMsncEv;
	INTEGER3 BE_UCCDebtorTermNewMsncEv;
	INTEGER3 BE_UCCDebtorCntEv;
	INTEGER3 BE_UCCCreditorCntEv;	
	//Asset
	INTEGER3 BE_AstVehAutoCnt2Y;
	INTEGER3 BE_AstVehAutoCommCnt2Y;
	INTEGER3 BE_AstVehAutoPersCnt2Y;
	INTEGER3 BE_AstVehAutoOtherCnt2Y;
	INTEGER3 BE_AstVehAutoEmrgNewMsncEv;
	INTEGER3 BE_AstVehWtrCntEv;
	INTEGER3 BE_AstVehAirCntEv;
	//derog
	STRING6 BE_DrgFlag7Y;
	STRING6 BE_DrgGovDebarredFlagEv;
	INTEGER3 BE_DrgBkCnt10Y;
	INTEGER3 BE_DrgBkNewMsnc10Y;
	STRING6 BE_DrgBkNewChType10Y;
	INTEGER3 BE_DrgLienCnt7Y;
	INTEGER3 BE_DrgLienNewMsnc7Y;
	INTEGER3 BE_DrgJudgCnt7Y;
	INTEGER3 BE_DrgJudgNewMsnc7Y;
	INTEGER3  BE_DrgLTDCnt7Y;
	INTEGER3  BE_DrgLTDNewMsnc7Y;
	//b2b
	INTEGER3 BE_B2BActvCnt;
	INTEGER3 BE_B2BActvCarrCnt;
	INTEGER3 BE_B2BActvFltCnt;
	INTEGER3 BE_B2BActvMatCnt;
	INTEGER3 BE_B2BActvOpsCnt;
	INTEGER3 BE_B2BActvOthCnt;
	INTEGER4 BE_B2BActvBalTot;
	INTEGER4 BE_B2BActvCarrBalTot;
	INTEGER4 BE_B2BActvFltBalTot;
	INTEGER4 BE_B2BActvMatBalTot;
	INTEGER4 BE_B2BActvOpsBalTot;
	INTEGER4 BE_B2BActvOthBalTot;
	STRING6 BE_B2BActvBalTotRnge;
	STRING6 BE_B2BActvCarrBalTotRnge;
	STRING6 BE_B2BActvFltBalTotRnge;
	STRING6 BE_B2BActvMatBalTotRnge;
	STRING6 BE_B2BActvOpsBalTotRnge;
	STRING6 BE_B2BActvOthBalTotRnge;	
	STRING6 BE_B2BActvWorstPerfIndx;
	STRING6 BE_B2BWorstPerfIndx2Y;
	//verification
	INTEGER BE_VerSrcCntEv;
	INTEGER BE_VerSrcOldMsncEv;
	INTEGER BE_VerSrcNewMsncEv;
	STRING6 BE_VerSrcRptNewBusFlag;
	INTEGER BE_VerSrcCredCntEv;
	STRING6 BE_VerSrcBureauFlag;
	INTEGER BE_VerSrcBureauOldMsncEv;
	STRING6 BE_AddrPOBoxFlag;
	STRING6  BE_VerNameFlag;
	STRING6 BE_VerAddrFlag;
	INTEGER BE_VerAddrSrcOldMsncEv;
	STRING6 BE_VerTINFlag;
	INTEGER BE_VerTINSrcOldMsncEv;
	STRING6 BE_VerPhoneFlag;
	INTEGER BE_VerPhoneSrcOldMsncEv;	
			// Asset Property		
	INTEGER3 BE_AstPropCntEv;		
	INTEGER3 BE_AstPropCurrCnt;		
	INTEGER3 BE_AstPropOldMsncEv;		
	INTEGER3 BE_AstPropNewMsncEv; 		
	INTEGER4 BE_AstPropCurrValTot;		
	INTEGER4 BE_AstPropCurrLotSizeTot;		
	INTEGER4 BE_AstPropCurrBldgSizeTot;				
			//Firmographics
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
	INTEGER3 BE_BusEmplCountCurr;		
	INTEGER6 BE_BusAnnualSalesCurr;		
			//Flag Attributes		
	STRING6 BE_BusIsNonProfitFlag;		
	STRING6 BE_BusIsFranchiseFlag;		
	STRING6 BE_BusOffers401kFlag;		
	STRING6 BE_BusHasNewLocationFlag1Y;		
	INTEGER3 BE_BusLocActvCnt;		
			//Ownership Attributes		
	STRING6 BE_BusInferFemaleOwnedFlag;		
	STRING6 BE_BusInferFamilyOwnedFlag;		
	STRING6 BE_BusIsFemaleOwnedFlag;		
	STRING6 BE_BusIsMinorityOwnedFlag;	
	STRING6 BE_BusIsResidentialFlag;	
	INTEGER3 BE_DBANameCnt2Y;
			//assoc attributes		
	INTEGER3 BE_AssocCntEv;
	INTEGER3 BE_AssocCnt2Y;
	INTEGER3 BE_AssocExecCntEv;
	INTEGER3 BE_AssocExecCnt2Y;
	INTEGER3 BE_AssocNexecCntEv;
	INTEGER3 BE_AssocNexecCnt2Y;
	INTEGER3 BE_AssocAgeAvg2Y;        
	INTEGER3 BE_AssocExecAgeAvg2Y;		
	INTEGER3 BE_AssocNexecAgeAvg2Y;		
	INTEGER3 BE_AssocWEduCollCnt2Y;		
	INTEGER3 BE_AssocExecWEduCollCnt2Y;		
	INTEGER3 BE_AssocNexecWEduCollCnt2Y;				    		
	INTEGER3 BE_AssocWDrgCnt2Y;   		
	INTEGER3 BE_AssocExecWDrgCnt2Y;		
	INTEGER3 BE_AssocNexecWDrgCnt2Y;		
	INTEGER3 BE_AssocEmrgMsncAvg2Y;		
	INTEGER3 BE_AssocExecEmrgMsncAvg2Y;		
	INTEGER3 BE_AssocNexecEmrgMsncAvg2Y;		
	INTEGER3 BE_AssocBusCntAvg2Y;		
	INTEGER3 BE_AssocExecBusCntAvg2Y;		
	INTEGER3 BE_AssocNexecBusCntAvg2Y;	
	//BestAddress
	INTEGER3 BE_BestAddrSrcOldMsncEv;
	STRING6 BE_BestAddrBldgType;
	STRING6 BE_BestAddrIsOwnedFlag;
	INTEGER BE_BestAddrNewTaxValEv;
	INTEGER BE_BestAddrLotSize;
	INTEGER BE_BestAddrBldgSize;	
	END;
	
	EXPORT Layout_BII := RECORD	
 STRING65 B_InpAcct;
 STRING120 B_InpClnName;
 STRING120 B_InpClnAltName;
 STRING B_InpClnAddrSt;
 STRING25 B_InpClnAddrCity;
 STRING6	B_InpClnAddrState;
 STRING6	B_InpClnAddrZip5;
 STRING6	B_InpClnAddrZip4;
 STRING10 B_InpClnTIN;
 STRING10 B_InpClnPhone;
 STRING54 B_InpClnEmail;
 INTEGER7 B_LexIDUlt;
 INTEGER7 B_LexIDOrg;
 INTEGER7 B_LexIDLegal;
 INTEGER7 B_LexIDSite;
 INTEGER7 B_LexIDLoc;
 INTEGER3 B_LexIDLegalScore;
 END;
	
	EXPORT Layout_BusinessProx := RECORD	
	STRING120 BP_BestName;
	STRING120 BP_BestAddrSt;
	STRING50 BP_BestAddrCity;
	STRING25 BP_BestAddrState;
	STRING10 BP_BestAddrZip;
	STRING10 BP_BestTIN;
	STRING16 BP_BestPhone;
	END;
		
	EXPORT Batch_In_Layout := RECORD
	STRING AcctNo;
	UNSIGNED3 HistoryDateYYYYMM;
	UNSIGNED6 HistoryDate;
	STRING CompanyName;
	STRING AlternateCompanyName;
	STRING StreetAddressLine1;
	STRING StreetAddressLine2;
	STRING City1;
	STRING State1;
	STRING Zip1;
	STRING9 BusinessTIN;
	STRING10 BusinessPhone;
	STRING BusinessURL;
	STRING BusinessEmailAddress;
	STRING PowID;
	STRING ProxID;
	STRING SeleID;
	STRING OrgID;
	STRING UltID;
	STRING custom_input1 := '';
	STRING custom_input2 := '';
	STRING custom_input3 := '';
	STRING custom_input4 := '';
	STRING custom_input5 := '';
	END;

	EXPORT Batch_Input := RECORD
	INTEGER G_ProcBusUID;
	Batch_In_Layout;
	END;
	
	EXPORT BatchScoreData := RECORD
		STRING20 Model_1_Name;
		STRING3 Model_1_Score;
		STRING5 Model_1_RC1;  
		STRING5 Model_1_RC2;
		STRING5 Model_1_RC3;
		STRING5 Model_1_RC4;
		STRING5 Model_1_RC5;
		STRING20 Model_2_Name;
		STRING3 Model_2_Score;
		STRING5 Model_2_RC1;
		STRING5 Model_2_RC2;
		STRING5 Model_2_RC3;
		STRING5 Model_2_RC4;
		STRING5 Model_2_RC5;
		STRING20 Model_3_Name;
		STRING3 Model_3_Score;
		STRING5 Model_3_RC1;
		STRING5 Model_3_RC2;
		STRING5 Model_3_RC3;
		STRING5 Model_3_RC4;
		STRING5 Model_3_RC5;
		STRING20 Model_4_Name;
		STRING3 Model_4_Score;
		STRING5 Model_4_RC1;
		STRING5 Model_4_RC2;
		STRING5 Model_4_RC3;
		STRING5 Model_4_RC4;
		STRING5 Model_4_RC5;
		STRING20 Model_5_Name;
		STRING3 Model_5_Score;
		STRING5 Model_5_RC1;
		STRING5 Model_5_RC2;
		STRING5 Model_5_RC3;
		STRING5 Model_5_RC4;
		STRING5 Model_5_RC5;	
		END;
	
	EXPORT Intermediate_Layout := RECORD
	Batch_Input;
	DATASET(iesp.business_marketing.t_BRMModelHRI) ModelResults {MAXCOUNT(1)};
	Layout_BII;
	Layout_BusinessSele;	
	Layout_BusinessProx;
	END;
	
	EXPORT BatchOutput := RECORD
	Batch_Input;
	Layout_BII;
	Layout_BusinessSele;	
	Layout_BusinessProx;
	BatchScoreData;
	STRING error_msg:='';

	END;
	
	EXPORT ModelNameRec :=RECORD
	STRING ModelName;
	END;
	
	EXPORT ModelOptionsRec :=RECORD
	STRING OptionName; 
	STRING OptionValue;
	END;
	
	EXPORT AttributeGroupRec := RECORD
	STRING AttributeGroup;
	END;
	
	Export Layout_master := RECORD
	INTEGER G_ProcUID;
	INTEGER G_ProcBusUID;
	Layout_BII;
	Layout_BusinessSele;	
	Layout_BusinessProx;			
	END;
	
	EXPORT LayoutBusinessSeleID := RECORD
	INTEGER G_ProcBusUID;
	Layout_BusinessSele;
	END;
	
	EXPORT LayoutBusinessProxID := RECORD
	INTEGER G_ProcBusUID;
	Layout_BusinessProx;
	END;

END;
