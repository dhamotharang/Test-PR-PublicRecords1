IMPORT STD;
IMPORT FraudGovUIKEL;

ds := FraudgovUIKel.Q__show_Employers.Res0;

dsOut := PROJECT(ds, TRANSFORM(FraudGovUIKEL.Layouts.EmployerOutput,
				// Program Info
				self.ProgramStateEcho := (STRING)left.Program_State_Echo_;
				// Business IDs
				self.BusAcctUIDEcho := (STRING)left.Bus_Acct_U_I_D_Echo_;
				self.BusAcctUltIDAppend := (STRING)left.Bus_Acct_Ult_I_D_Append_;
				self.BusAcctOrgIDAppend := (STRING)left.Bus_Acct_Org_I_D_Append_;
				self.BusAcctSeleIDAppend := (STRING)left.Bus_Acct_Sele_I_D_Append_;
				self.BusAcctProxIDAppend := (STRING)left.Bus_Acct_Prox_I_D_Append_;
				self.BusAcctPowIDAppend := (STRING)left.Bus_Acct_Pow_I_D_Append_;
				// Record Dts
				self.BusAcctNewestUpdateMasterDt := (STRING)left.Bus_Acct_Newest_Update_Master_Dt_;
				self.BusAcctNewestRecordDt := (STRING)left.Bus_Acct_Newest_Record_Dt_;
				self.BusNewestRecordDt := (STRING)left.Bus_Newest_Record_Dt_;
				// Program Business Input Echo
				self.BusAcctStateClean := (STRING)left.Bus_Acct_State_Clean_;
				self.BusAcctAddressTypeClean := (STRING)left.Bus_Acct_Address_Type_Clean_;
				// Program Business Input Pop Flags
				self.BusAcctOwnerName1Pop := (STRING)left.Bus_Acct_Owner_Name1_Pop_;
				self.BusAcctOwnerSSN1Pop := (STRING)left.Bus_Acct_Owner_S_S_N1_Pop_;
				self.BusAcctOwnerName2Pop := (STRING)left.Bus_Acct_Owner_Name2_Pop_;
				self.BusAcctOwnerSSN2Pop := (STRING)left.Bus_Acct_Owner_S_S_N2_Pop_;
				self.BusAcctOwnerName3Pop := (STRING)left.Bus_Acct_Owner_Name3_Pop_;
				self.BusAcctOwnerSSN3Pop := (STRING)left.Bus_Acct_Owner_S_S_N3_Pop_;
				self.BusAcctFullAddressCleanPop := (STRING)left.Bus_Acct_Full_Address_Clean_Pop_;
				// Program Contributed Data Echo
				self.BusAcctOpenDtEcho := (STRING)left.Bus_Acct_Open_Dt_Echo_;
				self.BusOldestAcctOpenDt := (STRING)left.Bus_Oldest_Acct_Open_Dt_;
				self.BusNewestAcctOpenDt := (STRING)left.Bus_Newest_Acct_Open_Dt_;
				self.BusAcctStatusTypeEcho := (STRING)left.Bus_Acct_Status_Type_Echo_;
				self.BusAcctDtEmployerBeganEcho := (STRING)left.Bus_Acct_Dt_Employer_Began_Echo_;
				self.BusOldestEmployerBeganDt := (STRING)left.Bus_Oldest_Employer_Began_Dt_;
				self.BusNewestEmployerBeganDt := (STRING)left.Bus_Newest_Employer_Began_Dt_;
				self.BusAcctTaxLiabStartDtEcho := (STRING)left.Bus_Acct_Tax_Liab_Start_Dt_Echo_;
				self.BusAcctTaxLiabEndDtEcho := (STRING)left.Bus_Acct_Tax_Liab_End_Dt_Echo_;
				self.BusOldestTaxLiabStartDt := (STRING)left.Bus_Oldest_Tax_Liab_Start_Dt_;
				self.BusNewestTaxLiabStartDt := (STRING)left.Bus_Newest_Tax_Liab_Start_Dt_;
				self.BusOldestTaxLiabEndDt := (STRING)left.Bus_Oldest_Tax_Liab_End_Dt_;
				self.BusNewestTaxLiabEndDt := (STRING)left.Bus_Newest_Tax_Liab_End_Dt_;
				self.BusAcctOldestUnemClmDt := (STRING)left.Bus_Acct_Oldest_Unem_Clm_Dt_;
				self.BusAcctNewestUnemClmDt := (STRING)left.Bus_Acct_Newest_Unem_Clm_Dt_;
				self.BusOldestUnemClmDt := (STRING)left.Bus_Oldest_Unem_Clm_Dt_;
				self.BusNewestUnemClmDt := (STRING)left.Bus_Newest_Unem_Clm_Dt_;
				self.BusAcctOwnerCntEcho := (STRING)left.Bus_Acct_Owner_Cnt_Echo_;
				self.BusAcctLegalActionTypeEcho := (STRING)left.Bus_Acct_Legal_Action_Type_Echo_;
				self.BusAcctWarrantIssuedCntEcho := (STRING)left.Bus_Acct_Warrant_Issued_Cnt_Echo_;
				self.BusAcctWarrantIssuedDtEcho := (STRING)left.Bus_Acct_Warrant_Issued_Dt_Echo_;
				self.BusAcctTaxLiabBlceStatusEcho := (STRING)left.Bus_Acct_Tax_Liab_Blce_Status_Echo_;
				// Business Incorporation
				self.BusIncorpDt := (STRING)left.Bus_Incorp_Dt_;
				self.BusIncorpStatusType := (STRING)left.Bus_Incorp_Status_Type_;
				self.BusIncorpMSince := (STRING)left.Bus_Incorp_M_Since_;
				// Business Program History
				self.BusAcctOpenDtMsince := (STRING)left.Bus_Acct_Open_Dt_Msince_;
				self.BusOldestAcctOpenDtMsince := (STRING)left.Bus_Oldest_Acct_Open_Dt_Msince_;
				self.BusAcctEmpBeganToOpenDtSpan := (STRING)left.Bus_Acct_Emp_Began_To_Open_Dt_Span_;
				self.BusOldestEmpBeganToAcctOpenSpan := (STRING)left.Bus_Oldest_Emp_Began_To_Acct_Open_Span_;
				self.BusEmpBeganToAcctOpenLT12MCnt := (STRING)left.Bus_Emp_Began_To_Acct_Open_L_T12_M_Cnt_;
				self.BusEmpBeganToAcctOpenLT6MCnt := (STRING)left.Bus_Emp_Began_To_Acct_Open_L_T6_M_Cnt_;
				self.BusEmpBeganToAcctOpenGT12MCnt := (STRING)left.Bus_Emp_Began_To_Acct_Open_G_T12_M_Cnt_;
				self.BusAcctLiabStartToOpenDtSpan := (STRING)left.Bus_Acct_Liab_Start_To_Open_Dt_Span_;
				self.BusOldestLiabStartToAcctOpenSpan := (STRING)left.Bus_Oldest_Liab_Start_To_Acct_Open_Span_;
				self.BusIncorpToOldestAcctOpenSpan := (STRING)left.Bus_Incorp_To_Oldest_Acct_Open_Span_;
				// Tax Liability History
				self.BusAcctTaxLiabStartMsince := (STRING)left.Bus_Acct_Tax_Liab_Start_Msince_;
				self.BusAcctTaxLiabEndMsince := (STRING)left.Bus_Acct_Tax_Liab_End_Msince_;
				self.BusTaxLiabOngoingFlag := (STRING)left.Bus_Tax_Liab_Ongoing_Flag_;
				self.BusOldestTaxLiabStartMsince := (STRING)left.Bus_Oldest_Tax_Liab_Start_Msince_;
				self.BusNewestTaxLiabEndMsince := (STRING)left.Bus_Newest_Tax_Liab_End_Msince_;
				self.BusIncorpToLiabSpan := (STRING)left.Bus_Incorp_To_Liab_Span_;
				// Unemployment Claim Event History
				self.BusAcctLiabToOldestUnemClmSpan := (STRING)left.Bus_Acct_Liab_To_Oldest_Unem_Clm_Span_;
				self.BusAcctLiabToNewestUnemClmSpan := (STRING)left.Bus_Acct_Liab_To_Newest_Unem_Clm_Span_;
				self.BusIncorpToOldestUnemClmSpan := (STRING)left.Bus_Incorp_To_Oldest_Unem_Clm_Span_;
				self.BusIncorpToNewestUnemClmSpan := (STRING)left.Bus_Incorp_To_Newest_Unem_Clm_Span_;
				self.BusLiabToOldestUnemClmSpan := (STRING)left.Bus_Liab_To_Oldest_Unem_Clm_Span_;
				self.BusLiabToNewestUnemClmSpan := (STRING)left.Bus_Liab_To_Newest_Unem_Clm_Span_;
				self.BusAcctUnemClaimCurrActiveCnt := (STRING)left.Bus_Acct_Unem_Claim_Curr_Active_Cnt_;
				self.BusAcctUnemClaimFiledCntEv := (STRING)left.Bus_Acct_Unem_Claim_Filed_Cnt_Ev_;
				self.BusAcctUnemClaimFiledCnt1Y := (STRING)left.Bus_Acct_Unem_Claim_Filed_Cnt1_Y_;
				self.BusAcctUnemClaimFiledCnt120D := (STRING)left.Bus_Acct_Unem_Claim_Filed_Cnt120_D_;
				self.BusAcctUnemClaimFiledCnt90D := (STRING)left.Bus_Acct_Unem_Claim_Filed_Cnt90_D_;
				self.BusAcctUnemClaimFiledCnt30D := (STRING)left.Bus_Acct_Unem_Claim_Filed_Cnt30_D_;
				self.BusAcctUnemClaimApprvCntEv := (STRING)left.Bus_Acct_Unem_Claim_Apprv_Cnt_Ev_;
				self.BusAcctUnemClaimApprvCnt1Y := (STRING)left.Bus_Acct_Unem_Claim_Apprv_Cnt1_Y_;
				self.BusAcctUnemClaimApprvCnt120D := (STRING)left.Bus_Acct_Unem_Claim_Apprv_Cnt120_D_;
				self.BusAcctUnemClaimApprvCnt90D := (STRING)left.Bus_Acct_Unem_Claim_Apprv_Cnt90_D_;
				self.BusAcctUnemClaimApprvCnt30D := (STRING)left.Bus_Acct_Unem_Claim_Apprv_Cnt30_D_;
				self.BusUnemClaimCurrActiveCnt := (STRING)left.Bus_Unem_Claim_Curr_Active_Cnt_;
				self.BusUnemClaimFiledCntEv := (STRING)left.Bus_Unem_Claim_Filed_Cnt_Ev_;
				self.BusUnemClaimFiledCnt1Y := (STRING)left.Bus_Unem_Claim_Filed_Cnt1_Y_;
				self.BusUnemClaimFiledCnt120D := (STRING)left.Bus_Unem_Claim_Filed_Cnt120_D_;
				self.BusUnemClaimFiledCnt90D := (STRING)left.Bus_Unem_Claim_Filed_Cnt90_D_;
				self.BusUnemClaimFiledCnt30D := (STRING)left.Bus_Unem_Claim_Filed_Cnt30_D_;
				self.BusUnemClaimApprvCntEv := (STRING)left.Bus_Unem_Claim_Apprv_Cnt_Ev_;
				self.BusUnemClaimApprvCnt1Y := (STRING)left.Bus_Unem_Claim_Apprv_Cnt1_Y_;
				self.BusUnemClaimApprvCnt120D := (STRING)left.Bus_Unem_Claim_Apprv_Cnt120_D_;
				self.BusUnemClaimApprvCnt90D := (STRING)left.Bus_Unem_Claim_Apprv_Cnt90_D_;
				self.BusUnemClaimApprvCnt30D := (STRING)left.Bus_Unem_Claim_Apprv_Cnt30_D_;
				self.BusAcctUnemClmAfterOpenCnt30D := (STRING)left.Bus_Acct_Unem_Clm_After_Open_Cnt30_D_;
				self.BusAcctUnemClmAfterOpenCnt60D := (STRING)left.Bus_Acct_Unem_Clm_After_Open_Cnt60_D_;
				self.BusAcctUnemClmAfterOpenCnt90D := (STRING)left.Bus_Acct_Unem_Clm_After_Open_Cnt90_D_;
				self.BusAcctUnemClmAfterOpenCnt120D  := (STRING)left.Bus_Acct_Unem_Clm_After_Open_Cnt120_D_;
				self.BusUnemClmAfterOldestOpenCnt30D := (STRING)left.Bus_Unem_Clm_After_Oldest_Open_Cnt30_D_;
				self.BusUnemClmAfterOldestOpenCnt60D := (STRING)left.Bus_Unem_Clm_After_Oldest_Open_Cnt60_D_;
				self.BusUnemClmAfterOldestOpenCnt90D := (STRING)left.Bus_Unem_Clm_After_Oldest_Open_Cnt90_D_;
				self.BusUnemClmAfterOldestOpenCnt120D := (STRING)left.Bus_Unem_Clm_After_Oldest_Open_Cnt120_D_;
				// Unemployment Claim Event History - Claimant Velocity
				self.BusAcctUnemClmAcctCurrActiveCnt := (STRING)left.Bus_Acct_Unem_Clm_Acct_Curr_Active_Cnt_;
				self.BusAcctUnemClmAcctFiledCntEv := (STRING)left.Bus_Acct_Unem_Clm_Acct_Filed_Cnt_Ev_;
				self.BusAcctUnemClmAcctFiledCnt1Y := (STRING)left.Bus_Acct_Unem_Clm_Acct_Filed_Cnt1_Y_;
				self.BusAcctUnemClmAcctFiledCnt120D := (STRING)left.Bus_Acct_Unem_Clm_Acct_Filed_Cnt120_D_;
				self.BusAcctUnemClmAcctFiledCnt90D := (STRING)left.Bus_Acct_Unem_Clm_Acct_Filed_Cnt90_D_;
				self.BusAcctUnemClmAcctFiledCnt30D := (STRING)left.Bus_Acct_Unem_Clm_Acct_Filed_Cnt30_D_;
				self.BusAcctUnemClmLexIDFiledCntEv := (STRING)left.Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_;
				self.BusAcctUnemClmLexIDFiledCnt1Y := (STRING)left.Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_;
				self.BusAcctUnemClmLexIDFiledCnt120D := (STRING)left.Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt120_D_;
				self.BusAcctUnemClmLexIDFiledCnt90D := (STRING)left.Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt90_D_;
				self.BusAcctUnemClmLexIDFiledCnt30D := (STRING)left.Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt30_D_;
				self.BusAcctLexIDMultiUnemClmCntEv := (STRING)left.Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_;
				self.BusAcctLexIDMultiUnemClmCnt1Y := (STRING)left.Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_;
				self.BusAcctLexIDMultiUnemClmCnt120D := (STRING)left.Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt120_D_;
				self.BusAcctLexIDMultiUnemClmCnt90D := (STRING)left.Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt90_D_;
				self.BusAcctLexIDMultiUnemClmCnt30D := (STRING)left.Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt30_D_;
				self.BusUnemClmAcctCurrActiveCnt := (STRING)left.Bus_Unem_Clm_Acct_Curr_Active_Cnt_;
				self.BusUnemClmAcctFiledCntEv := (STRING)left.Bus_Unem_Clm_Acct_Filed_Cnt_Ev_;
				self.BusUnemClmAcctFiledCnt1Y := (STRING)left.Bus_Unem_Clm_Acct_Filed_Cnt1_Y_;
				self.BusUnemClmAcctFiledCnt120D := (STRING)left.Bus_Unem_Clm_Acct_Filed_Cnt120_D_;
				self.BusUnemClmAcctFiledCnt90D := (STRING)left.Bus_Unem_Clm_Acct_Filed_Cnt90_D_;
				self.BusUnemClmAcctFiledCnt30D := (STRING)left.Bus_Unem_Clm_Acct_Filed_Cnt30_D_;
				self.BusUnemClmLexIDFiledCntEv := (STRING)left.Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_;
				self.BusUnemClmLexIDFiledCnt1Y := (STRING)left.Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_;
				self.BusUnemClmLexIDFiledCnt120D := (STRING)left.Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_;
				self.BusUnemClmLexIDFiledCnt90D := (STRING)left.Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_;
				self.BusUnemClmLexIDFiledCnt30D := (STRING)left.Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_;
				self.BusLexIDMultiUnemClmCntEv := (STRING)left.Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_;
				self.BusLexIDMultiUnemClmCnt1Y := (STRING)left.Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_;
				self.BusLexIDMultiUnemClmCnt120D := (STRING)left.Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_;
				self.BusLexIDMultiUnemClmCnt90D := (STRING)left.Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_;
				self.BusLexIDMultiUnemClmCnt30D := (STRING)left.Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_;
				// Business Structure
				self.BusAcctPerBusLegalEntCnt := (STRING)left.Bus_Acct_Per_Bus_Legal_Ent_Cnt_;
				// Business Address Velocity
				self.VelBusAcctPerAddrInProgCnt := (STRING)left.Vel_Bus_Acct_Per_Addr_In_Prog_Cnt_;
				self.VelBusAcctPerAddrInBusLegEntCnt := (STRING)left.Vel_Bus_Acct_Per_Addr_In_Bus_Leg_Ent_Cnt_;
				// High Risk Flags
				self.BusAcctUnemClmLT60DAfterOpenFlag := (STRING)left.Bus_Acct_Unem_Clm_L_T60_D_After_Open_Flag_;
				self.BusAcctUnemClm60To120DAftOpFlag := (STRING)left.Bus_Acct_Unem_Clm60_To120_D_Aft_Op_Flag_;
				self.BusUnemClmLT60DAfterOpenFlag := (STRING)left.Bus_Unem_Clm_L_T60_D_After_Open_Flag_;
				self.BusUnemClm60To120DAfterOpenFlag := (STRING)left.Bus_Unem_Clm60_To120_D_After_Open_Flag_;
				self.BusAcctLiabStartToOpenGT5MFlag := (STRING)left.Bus_Acct_Liab_Start_To_Open_G_T5_M_Flag_;
				self.BusOldestLiabStartToOpenGT5MFlag := (STRING)left.Bus_Oldest_Liab_Start_To_Open_G_T5_M_Flag_;
				self.BusAcctOwnerNotPopFlag := (STRING)left.Bus_Acct_Owner_Not_Pop_Flag_;
				self.BusAcctPerBusOwnerNotPopCnt := (STRING)left.Bus_Acct_Per_Bus_Owner_Not_Pop_Cnt_;
				self.BusOwnerNotPopFlag := (STRING)left.Bus_Owner_Not_Pop_Flag_;
				self.BusAcctStateNotInProgAreaFlag := (STRING)left.Bus_Acct_State_Not_In_Prog_Area_Flag_;
				self.BusAcctPerBusNotInProgAreaCnt := (STRING)left.Bus_Acct_Per_Bus_Not_In_Prog_Area_Cnt_;
				self.BusAcctPerBusNotInProgAreaFlag := (STRING)left.Bus_Acct_Per_Bus_Not_In_Prog_Area_Flag_;
				self.BusAcctAddressPOBoxFlag := (STRING)left.Bus_Acct_Address_P_O_Box_Flag_;
				self.BusAcctPerBusAddressPOBoxCnt := (STRING)left.Bus_Acct_Per_Bus_Address_P_O_Box_Cnt_;
				self.BusAcctPerBusAddressPOBoxFlag := (STRING)left.Bus_Acct_Per_Bus_Address_P_O_Box_Flag_;
				self.BusAcctLegalActionFlag := (STRING)left.Bus_Acct_Legal_Action_Flag_;
				self.BusAcctPerBusLegActLienCnt := (STRING)left.Bus_Acct_Per_Bus_Leg_Act_Lien_Cnt_;
				self.BusAcctPerBusLegalActOtherCnt := (STRING)left.Bus_Acct_Per_Bus_Legal_Act_Other_Cnt_;
				self.BusAcctPerBusLegalActPaymCnt := (STRING)left.Bus_Acct_Per_Bus_Legal_Act_Paym_Cnt_;
				self.BusLegalActionFlag := (STRING)left.Bus_Legal_Action_Flag_;
				self.BusAcctWarrantIssuedFlag := (STRING)left.Bus_Acct_Warrant_Issued_Flag_;
				self.BusWarrantIssuedSum := (STRING)left.Bus_Warrant_Issued_Sum_;
				self.BusAcctPerBusWithWarrantCnt := (STRING)left.Bus_Acct_Per_Bus_With_Warrant_Cnt_;
				self.BusWarrantIssuedFlag := (STRING)left.Bus_Warrant_Issued_Flag_;
				self.BusAcctTaxLiabBlceDebitFlag := (STRING)left.Bus_Warrant_Issued_Flag_;
				self.BusAcctPerBusTaxLiabBlceDebCnt := (STRING)left.Bus_Acct_Per_Bus_Tax_Liab_Blce_Deb_Cnt_;
				self.BusAcctPerBusTaxLiabBlceCredCnt := (STRING)left.Bus_Acct_Per_Bus_Tax_Liab_Blce_Cred_Cnt_;
				self.BusAcctPerBusTaxLiabBlceOthCnt := (STRING)left.Bus_Acct_Per_Bus_Tax_Liab_Blce_Oth_Cnt_;
				self.BusTaxLiabBlceDebitFlag := (STRING)left.Bus_Tax_Liab_Blce_Debit_Flag_;

));

writeFile(dsMac, reportName) := FUNCTIONMACRO
	// If landing zone is on the same server as the Dali
	daliserver := std.system.Thorlib.DaliServer();
	cpos := std.Str.Find(daliserver, ':', 1)-1;
	lzip := daliserver[1..cpos];
	lz_dir := '/var/lib/HPCCSystems/mydropzone/fraudgov/kelattributes/20190701/';
	file_path := '~hrude::fraudgov::kelattributes::20190701::';
	thor_file := file_path + reportName;
	lz_path := lz_dir + reportName + '.csv';
	thor_out := OUTPUT(dsMac,, thor_file, CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')), OVERWRITE);
	RETURN SEQUENTIAL(std.file.CreateExternalDirectory(lzip, lz_dir), thor_out, std.file.Despray(thor_file, lzip,lz_path,,,,true));
ENDMACRO;

writeFile(dsOut, 'EmployerOutput');