IMPORT PublicRecords_KEL;

EXPORT Join_Interface_Options(PublicRecords_KEL.Join_Interface_Options OptionsRaw) := MODULE(PublicRecords_KEL.Join_Interface_Options)
		//Turn on keys you need for attributes
		//keep unneeded keys off for better perfoamnce
		//keys indented might be needed later for additional attributes
		//if you want header useingestdate you need to turn on that key (DoFDCJoin_Doxie__Key_Header_ingest_date) with header and quick header
		//if you want best/prev contact address you need header, QH and address rank
		//is FCRA options are handled in PublicRecords_KEL.ECL_Functions.Common, all other permissions are in FDC

					// EXPORT BOOLEAN DoFDCJoin_ADVO__Key_Addr1_History := FALSE;//not allowed for marketing  BE_BusIsResidentialFlag
					EXPORT BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_AlloyMedia_student_list__key_DID := FALSE;//education BE_AssocExecWEduCollCnt2Y, BE_AssocNexecWEduCollCnt2Y, BE_AssocWEduCollCnt2Y 
					// EXPORT BOOLEAN DoFDCJoin_American_student_list__key_DID := FALSE; //education BE_AssocExecWEduCollCnt2Y, BE_AssocNexecWEduCollCnt2Y, BE_AssocWEduCollCnt2Y 
					EXPORT BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Address := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did := FALSE;//bank, derog BE_AssocExecWDrgCnt2Y,  BE_AssocNexecWDrgCnt2Y,  BE_AssocWDrgCnt2Y 
					EXPORT BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_LinkIds := TRUE; 
					EXPORT BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog := FALSE; //best BE_AssocAgeAvg2Y, BE_AssocExecAgeAvg2Y, BE_AssocNexecAgeAvg2Y
					EXPORT BOOLEAN DoFDCJoin_BIPV2_Best__Key_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids := TRUE;
					EXPORT BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim   := TRUE; //BE_AssocBusCntAvg2Y BE_AssocExecBusCntAvg2Y BE_AssocNexecBusCntAvg2Y 
					EXPORT BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids := TRUE;
					EXPORT BOOLEAN DoFDCJoin_BusReg__kfetch_busreg_company_linkids := TRUE;
					EXPORT BOOLEAN DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Corp2__Key_LinkIDs_Corp := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Cortera__kfetch_LinkID := TRUE;
					EXPORT BOOLEAN DoFDCJoin_DCAV2__kfetch_LinkIds := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Header := FALSE;//will probably need header back on to support be_assoc attributes for derog, crim, bank, email, lien and education
					// EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Header_ingest_date := FALSE;//this is to minic boca shell useingestdate, might want this on when you turn on header
					// EXPORT BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders := FALSE;//crim, derog BE_AssocExecWDrgCnt2Y,  BE_AssocNexecWDrgCnt2Y,  BE_AssocWDrgCnt2Y 
					// EXPORT BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders_Risk := FALSE;//crim, derog BE_AssocExecWDrgCnt2Y,  BE_AssocNexecWDrgCnt2Y,  BE_AssocWDrgCnt2Y 
					EXPORT BOOLEAN DoFDCJoin_dx_DataBridge__Key_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Email_Data__Key_did := FALSE;//email BE_AssocExecEmailFlag2Y
					EXPORT BOOLEAN DoFDCJoin_Email_Data__Key_Email_Address := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Experian_CRDB__Key_LinkIDs := TRUE;
					EXPORT BOOLEAN DoFDCJoin_FBNv2__kfetch_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs := true;
					EXPORT BOOLEAN DoFDCJoin_HighRiskAddress := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Infutor__NARB_kfetch_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_IRS5500__kfetch_LinkIDs := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_LiensV2_key_liens := FALSE; //liens, evictions, derog BE_AssocExecWDrgCnt2Y  BE_AssocNexecWDrgCnt2Y  BE_AssocWDrgCnt2Y 
					EXPORT BOOLEAN DoFDCJoin_LiensV2_Key_party_Linkids_Records := TRUE;
					EXPORT BOOLEAN DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Addr_Fid := TRUE;
					EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Assessor_Fid   := TRUE;
					EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Deed_Fid := TRUE;
					EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Linkids_Key := TRUE;
					EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Property_Did := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Relatives__Key_Relatives_v3 := FALSE;// BE_BusInferFamilyOwnedFlag, need realtives and 2yr contacts returning
					EXPORT BOOLEAN DoFDCJoin_SAM__kfetch_linkID := TRUE;
					EXPORT BOOLEAN DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := TRUE;
					EXPORT BOOLEAN DoFDCJoin_UCC_Files__Key_Linkids := TRUE;
					EXPORT BOOLEAN DoFDCJoin_USPIS_HotList__key_addr_search_zip := TRUE;
					EXPORT BOOLEAN DoFDCJoin_UtilFile__Key_LinkIds := TRUE;
					// EXPORT BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID := FALSE;//vehicles BE_AstVehAutoCnt2Y BE_AstVehAutoCommCnt2Y BE_AstVehAutoPersCnt2Y  BE_AstVehAutoOtherCnt2Y BE_AstVehAutoEmrgNewMsncEv
					EXPORT BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft_LinkId := TRUE;
					EXPORT BOOLEAN DoFDCJoin_YellowPages__kfetch_yellowpages_linkids := TRUE;
					EXPORT BOOLEAN DoFDCJoinfn_IndexedSearchForXLinkIDs := TRUE;//BE_AssocBusCntAvg2Y BE_AssocExecBusCntAvg2Y BE_AssocNexecBusCntAvg2Y 



END;
