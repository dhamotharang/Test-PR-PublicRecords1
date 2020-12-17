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
	//Asset
	STRING8 BE_AstVehAutoCnt2Y;
	STRING8 BE_AstVehAutoCommCnt2Y;
	STRING8 BE_AstVehAutoPersCnt2Y;
	STRING8 BE_AstVehAutoOtherCnt2Y;
	STRING8 BE_AstVehAutoEmrgNewMsncEv;
	STRING8 BE_AstVehWtrCntEv;
	STRING8 BE_AstVehAirCntEv;
	//derog
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
	//b2b
	STRING8 BE_B2BActvCnt;
	STRING8 BE_B2BActvCarrCnt;
	STRING8 BE_B2BActvFltCnt;
	STRING8 BE_B2BActvMatCnt;
	STRING8 BE_B2BActvOpsCnt;
	STRING8 BE_B2BActvOthCnt;
	STRING11 BE_B2BActvBalTot;
	STRING11 BE_B2BActvCarrBalTot;
	STRING11 BE_B2BActvFltBalTot;
	STRING11 BE_B2BActvMatBalTot;
	STRING11 BE_B2BActvOpsBalTot;
	STRING11 BE_B2BActvOthBalTot;
	STRING6 BE_B2BActvBalTotRnge;
	STRING6 BE_B2BActvCarrBalTotRnge;
	STRING6 BE_B2BActvFltBalTotRnge;
	STRING6 BE_B2BActvMatBalTotRnge;
	STRING6 BE_B2BActvOpsBalTotRnge;
	STRING6 BE_B2BActvOthBalTotRnge;	
	STRING6 BE_B2BActvWorstPerfIndx;
	STRING6 BE_B2BWorstPerfIndx2Y;
	//verification
	STRING20 BE_VerSrcCntEv;
	STRING20 BE_VerSrcOldMsncEv;
	STRING20 BE_VerSrcNewMsncEv;
	STRING6 BE_VerSrcRptNewBusFlag;
	STRING20 BE_VerSrcCredCntEv;
	STRING6 BE_VerSrcBureauFlag;
	STRING20 BE_VerSrcBureauOldMsncEv;
	STRING6 BE_AddrPOBoxFlag;
	STRING6  BE_VerNameFlag;
	STRING6 BE_VerAddrFlag;
	STRING20 BE_VerAddrSrcOldMsncEv;
	STRING6 BE_VerTINFlag;
	STRING20 BE_VerTINSrcOldMsncEv;
	STRING6 BE_VerPhoneFlag;
	STRING20 BE_VerPhoneSrcOldMsncEv;	
			// Asset Property		
	STRING8 BE_AstPropCntEv;		
	STRING8 BE_AstPropCurrCnt;		
	STRING8 BE_AstPropOldMsncEv;		
	STRING8 BE_AstPropNewMsncEv; 		
	STRING11 BE_AstPropCurrValTot;		
	STRING11 BE_AstPropCurrLotSizeTot;		
	STRING11 BE_AstPropCurrBldgSizeTot;				
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
	STRING8 BE_BusEmplCountCurr;		
	STRING16 BE_BusAnnualSalesCurr;		
			//Flag Attributes		
	STRING6 BE_BusIsNonProfitFlag;		
	STRING6 BE_BusIsFranchiseFlag;		
	STRING6 BE_BusOffers401kFlag;		
	STRING6 BE_BusHasNewLocationFlag1Y;		
	STRING8 BE_BusLocActvCnt;		
			//Ownership Attributes		
	STRING6 BE_BusInferFemaleOwnedFlag;		
	STRING6 BE_BusInferFamilyOwnedFlag;		
	STRING6 BE_BusIsFemaleOwnedFlag;		
	STRING6 BE_BusIsMinorityOwnedFlag;	
	STRING6 BE_BusIsResidentialFlag;	
	STRING8 BE_DBANameCnt2Y;
			//assoc attributes		
	STRING8 BE_AssocCntEv;
	STRING8 BE_AssocCnt2Y;
	STRING8 BE_AssocExecCntEv;
	STRING8 BE_AssocExecCnt2Y;
	STRING8 BE_AssocNexecCntEv;
	STRING8 BE_AssocNexecCnt2Y;
	STRING8 BE_AssocAgeAvg2Y;        
	STRING8 BE_AssocExecAgeAvg2Y;		
	STRING8 BE_AssocNexecAgeAvg2Y;		
	STRING8 BE_AssocWEduCollCnt2Y;		
	STRING8 BE_AssocExecWEduCollCnt2Y;		
	STRING8 BE_AssocNexecWEduCollCnt2Y;				    		
	STRING8 BE_AssocWDrgCnt2Y;   		
	STRING8 BE_AssocExecWDrgCnt2Y;		
	STRING8 BE_AssocNexecWDrgCnt2Y;		
	STRING8 BE_AssocEmrgMsncAvg2Y;		
	STRING8 BE_AssocExecEmrgMsncAvg2Y;		
	STRING8 BE_AssocNexecEmrgMsncAvg2Y;		
	STRING8 BE_AssocBusCntAvg2Y;		
	STRING8 BE_AssocExecBusCntAvg2Y;		
	STRING8 BE_AssocNexecBusCntAvg2Y;	
	//BestAddress
	STRING8 BE_BestAddrSrcOldMsncEv;
	STRING6 BE_BestAddrBldgType;
	STRING6 BE_BestAddrIsOwnedFlag;
	STRING20 BE_BestAddrNewTaxValEv;
	STRING20 BE_BestAddrLotSize;
	STRING20 BE_BestAddrBldgSize;	
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
	STRING18 B_LexIDUlt;
	STRING18 B_LexIDOrg;
	STRING18 B_LexIDLegal;
	STRING18 B_LexIDSite;
	STRING18 B_LexIDLoc;
	STRING8 B_LexIDLegalScore;
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