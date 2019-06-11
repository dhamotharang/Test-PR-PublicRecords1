import FraudgovUIKEL;
import std;


EXPORT BWR_CalcAttrDistribution := MODULE
		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, STRING30 attribute_value := (STRING)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;

		SHARED ds_BusAcctUIDEcho := fn_macro(ds, 'BusAcctUIDEcho', Bus_Acct_U_I_D_Echo_);
		SHARED ds_BusAcctUltIDAppend := fn_macro(ds, 'BusAcctUltIDAppend', Bus_Acct_Ult_I_D_Append_);
		SHARED ds_BusAcctOrgIDAppend := fn_macro(ds, 'BusAcctOrgIDAppend', Bus_Acct_Org_I_D_Append_);
		SHARED ds_BusAcctSeleIDAppend := fn_macro(ds, 'BusAcctSeleIDAppend', Bus_Acct_Sele_I_D_Append_);
		SHARED ds_BusAcctProxIDAppend:= fn_macro(ds, 'BusAcctProxIDAppend', Bus_Acct_Prox_I_D_Append_);
		SHARED ds_BusAcctPowIDAppend := fn_macro(ds, 'BusAcctPowIDAppend', Bus_Acct_Pow_I_D_Append_);


		// OUTPUT(ds_BusAcctUIDEcho, NAMED('ds_BusAcctUIDEcho'));
		// OUTPUT(ds_BusAcctUltIDAppend, NAMED('ds_BusAcctUltIDAppend'));
		// OUTPUT(ds_BusAcctOrgIDAppend, NAMED('ds_BusAcctOrgIDAppend'));
		// OUTPUT(ds_BusAcctSeleIDAppend, NAMED('ds_BusAcctSeleIDAppend'));
		// OUTPUT(ds_BusAcctProxIDAppend, NAMED('ds_BusAcctProxIDAppend'));
		// OUTPUT(ds_BusAcctPowIDAppend, NAMED('ds_BusAcctPowIDAppend'));

		// Nate Attributes
		SHARED ds_BusAcctNewestUpdateMasterDt := fn_macro(ds, 'BusAcctNewestUpdateMasterDt', Bus_Acct_Newest_Update_Master_Dt_);
		SHARED ds_BusNewestRecordDt:= fn_macro(ds, 'BusNewestRecordDt', Bus_Newest_Record_Dt_);
		SHARED ds_BusAcctDtEmployerBeganEcho := fn_macro(ds, 'BusAcctDtEmployerBeganEcho', Bus_Acct_Dt_Employer_Began_Echo_);
		SHARED ds_BusAcctTaxLiabEndDtEcho := fn_macro(ds, 'BusAcctTaxLiabEndDtEcho', Bus_Acct_Tax_Liab_End_Dt_Echo_);
		SHARED ds_BusNewestTaxLiabStartDt := fn_macro(ds, 'BusNewestTaxLiabStartDt', Bus_Newest_Tax_Liab_Start_Dt_);

		SHARED ds_BusNewestTaxLiabEndDt := fn_macro(ds, 'BusNewestTaxLiabEndDt', Bus_Newest_Tax_Liab_End_Dt_);
		SHARED ds_BusAcctTaxLiabStartMsince := fn_macro(ds, 'BusAcctTaxLiabStartMsince', Bus_Acct_Tax_Liab_Start_Msince_);
		SHARED ds_BusOldestTaxLiabStartMsince := fn_macro(ds, 'BusOldestTaxLiabStartMsince', Bus_Oldest_Tax_Liab_Start_Msince_);
		SHARED ds_BusAcctOldestUnemClmDt := fn_macro(ds, 'BusAcctOldestUnemClmDt', Bus_Acct_Oldest_Unem_Clm_Dt_);
		SHARED ds_BusOldestUnemClmDt := fn_macro(ds, 'BusOldestUnemClmDt', Bus_Oldest_Unem_Clm_Dt_);

		SHARED ds_BusIncorpDt := fn_macro(ds, 'BusIncorpDt', Bus_Incorp_Dt_);
		SHARED ds_BusIncorpMSince := fn_macro(ds, 'BusIncorpMSince', Bus_Incorp_M_Since_);

		// Claim attributes
		// Business Account attributes
		shared ds_BusAcctUnemClmAcctCurActiveCnt := fn_macro(ds, 'BusAcctUnemClmAcctCurActiveCnt', Bus_Acct_Unem_Clm_Acct_Cur_Active_Cnt_);
		shared ds_BusAcctUnemClmAcctFiledCntEv := fn_macro(ds, 'BusAcctUnemClmAcctFiledCntEv', Bus_Acct_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared ds_BusAcctUnemClmAcctFiledCnt1Y := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt1Y', Bus_Acct_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared ds_BusAcctUnemClmAcctFiledCnt120D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt120D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared ds_BusAcctUnemClmAcctFiledCnt90D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt90D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared ds_BusAcctUnemClmAcctFiledCnt30D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt30D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		//shared ds_BusAcctUnemClmLexIDFiledCntEv := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCntEv', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		//shared ds_BusAcctUnemClmLexIDFiledCnt1Y := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt1Y', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		//shared ds_BusAcctUnemClmLexIDFiledCnt120D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt120D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		//shared ds_BusAcctUnemClmLexIDFiledCnt90D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt90D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		//shared ds_BusAcctUnemClmLexIDFiledCnt30D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt30D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		//shared ds_BusAcctLexIDMultiUnemClmCntEv := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCntEv', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		//shared ds_BusAcctLexIDMultiUnemClmCnt1Y := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt1Y', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		//shared ds_BusAcctLexIDMultiUnemClmCnt120D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt120D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		//shared ds_BusAcctLexIDMultiUnemClmCnt90D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt90D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		//shared ds_BusAcctLexIDMultiUnemClmCnt30D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt30D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);
		
		// Legal business attributes
		shared ds_BusUnemClmAcctCurActiveCnt := fn_macro(ds, 'BusUnemClmAcctCurActiveCnt', Bus_Unem_Clm_Acct_Cur_Active_Cnt_);
		shared ds_BusUnemClmAcctFiledCntEv := fn_macro(ds, 'BusUnemClmAcctFiledCntEv', Bus_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared ds_BusUnemClmAcctFiledCnt1Y := fn_macro(ds, 'BusUnemClmAcctFiledCnt1Y', Bus_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared ds_BusUnemClmAcctFiledCnt120D := fn_macro(ds, 'BusUnemClmAcctFiledCnt120D', Bus_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared ds_BusUnemClmAcctFiledCnt90D := fn_macro(ds, 'BusUnemClmAcctFiledCnt90D', Bus_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared ds_BusUnemClmAcctFiledCnt30D := fn_macro(ds, 'BusUnemClmAcctFiledCnt30D', Bus_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		// shared ds_BusUnemClmLexIDFiledCntEv := fn_macro(ds, 'BusUnemClmLexIDFiledCntEv', Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		// shared ds_BusUnemClmLexIDFiledCnt1Y := fn_macro(ds, 'BusUnemClmLexIDFiledCnt1Y', Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		// shared ds_BusUnemClmLexIDFiledCnt120D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt120D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		// shared ds_BusUnemClmLexIDFiledCnt90D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt90D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		// shared ds_BusUnemClmLexIDFiledCnt30D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt30D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		// shared ds_BusLexIDMultiUnemClmCntEv := fn_macro(ds, 'BusLexIDMultiUnemClmCntEv', Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		// shared ds_BusLexIDMultiUnemClmCnt1Y := fn_macro(ds, 'BusLexIDMultiUnemClmCnt1Y', Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		// shared ds_BusLexIDMultiUnemClmCnt120D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt120D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		// shared ds_BusLexIDMultiUnemClmCnt90D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt90D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		// shared ds_BusLexIDMultiUnemClmCnt30D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt30D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);

		// Nicole Attributes
		SHARED ds_BusAcctNewestRecordDt := fn_macro(ds, 'BusAcctNewestRecordDt', Bus_Acct_Newest_Record_Dt_);
		SHARED ds_BusAcctStatusTypeEcho := fn_macro(ds, 'BusAcctStatusTypeEcho', Bus_Acct_Status_Type_Echo_);
		SHARED ds_BusAcctTaxLiabStartDtEcho := fn_macro(ds, 'BusAcctTaxLiabStartDtEcho', Bus_Acct_Tax_Liab_Start_Dt_Echo_);
		SHARED ds_BusOldestTaxLiabStartDt := fn_macro(ds, 'BusOldestTaxLiabStartDt', Bus_Oldest_Tax_Liab_Start_Dt_);
		SHARED ds_BusOldestTaxLiabEndDt := fn_macro(ds, 'BusOldestTaxLiabEndDt', Bus_Oldest_Tax_Liab_End_Dt_);

		SHARED ds_BusTaxLiabOngoingFlag := fn_macro(ds, 'BusTaxLiabOngoingFlag', Bus_Tax_Liab_Ongoing_Flag_);
		SHARED ds_BusAcctTaxLiabEndMsince := fn_macro(ds, 'BusAcctTaxLiabEndMsince', Bus_Acct_Tax_Liab_End_Msince_);
		SHARED ds_BusNewestTaxLiabEndMsince := fn_macro(ds, 'BusNewestTaxLiabEndMsince', Bus_Newest_Tax_Liab_End_Msince_);
		SHARED ds_BusAcctNewestUnemClmDt := fn_macro(ds, 'BusAcctNewestUnemClmDt', Bus_Acct_Newest_Unem_Clm_Dt_);
		SHARED ds_BusNewestUnemClmDt := fn_macro(ds, 'BusNewestUnemClmDt', Bus_Newest_Unem_Clm_Dt_);

		SHARED ds_BusIncorpStatusType:= fn_macro(ds, 'BusIncorpStatusType', Bus_Incorp_Status_Type_);

		// OUTPUT(ds_BusAcctNewestRecordDt, NAMED('ds_BusAcctNewestRecordDt'));
		// OUTPUT(ds_BusAcctStatusTypeEcho, NAMED('ds_BusAcctStatusTypeEcho'));
		// OUTPUT(ds_BusAcctTaxLiabStartDtEcho, NAMED('ds_BusAcctTaxLiabStartDtEcho'));
		// OUTPUT(ds_BusOldestTaxLiabStartDt, NAMED('ds_BusOldestTaxLiabStartDt'));
		// OUTPUT(ds_BusOldestTaxLiabEndDt, NAMED('ds_BusOldestTaxLiabEndDt'));

		// OUTPUT(ds_BusTaxLiabOngoingFlag, NAMED('ds_BusTaxLiabOngoingFlag'));
		// OUTPUT(ds_BusAcctTaxLiabEndMsince, NAMED('ds_BusAcctTaxLiabEndMsince'));
		// OUTPUT(ds_BusNewestTaxLiabEndMsince, NAMED('ds_BusNewestTaxLiabEndMsince'));
		// OUTPUT(ds_BusAcctNewestUnemClmDt, NAMED('ds_BusAcctNewestUnemClmDt'));
		// OUTPUT(ds_BusNewestUnemClmDt, NAMED('ds_BusNewestUnemClmDt'));

		// OUTPUT(ds_BusIncorpStatusType, NAMED('ds_BusIncorpStatusType'));

		SHARED ds_All := ds_BusAcctUIDEcho + ds_BusAcctUltIDAppend + ds_BusAcctOrgIDAppend + ds_BusAcctSeleIDAppend + ds_BusAcctProxIDAppend +
							ds_BusAcctPowIDAppend + 
							// Nate attributes
							ds_BusAcctNewestUpdateMasterDt + ds_BusNewestRecordDt + ds_BusAcctDtEmployerBeganEcho + ds_BusAcctTaxLiabEndDtEcho +
							ds_BusNewestTaxLiabStartDt + ds_BusNewestTaxLiabEndDt + ds_BusAcctTaxLiabStartMsince + ds_BusOldestTaxLiabStartMsince + 
							ds_BusAcctOldestUnemClmDt + ds_BusOldestUnemClmDt + ds_BusIncorpDt + ds_BusIncorpMSince +
							// Claim attributes
							ds_BusAcctUnemClmAcctCurActiveCnt + ds_BusAcctUnemClmAcctFiledCntEv + ds_BusAcctUnemClmAcctFiledCnt1Y + ds_BusAcctUnemClmAcctFiledCnt120D + ds_BusAcctUnemClmAcctFiledCnt90D + ds_BusAcctUnemClmAcctFiledCnt30D + 
							// ds_BusAcctUnemClmLexIDFiledCntEv + ds_BusAcctUnemClmLexIDFiledCnt1Y + ds_BusAcctUnemClmLexIDFiledCnt120D + ds_BusAcctUnemClmLexIDFiledCnt90D + ds_BusAcctUnemClmLexIDFiledCnt30D + 
							// ds_BusAcctLexIDMultiUnemClmCntEv + ds_BusAcctLexIDMultiUnemClmCnt1Y + ds_BusAcctLexIDMultiUnemClmCnt120D + ds_BusAcctLexIDMultiUnemClmCnt90D + ds_BusAcctLexIDMultiUnemClmCnt30D + 
							ds_BusUnemClmAcctCurActiveCnt + ds_BusUnemClmAcctFiledCntEv + ds_BusUnemClmAcctFiledCnt1Y + ds_BusUnemClmAcctFiledCnt120D + ds_BusUnemClmAcctFiledCnt90D + ds_BusUnemClmAcctFiledCnt30D + 
							// ds_BusUnemClmLexIDFiledCntEv + ds_BusUnemClmLexIDFiledCnt1Y + ds_BusUnemClmLexIDFiledCnt120D + ds_BusUnemClmLexIDFiledCnt90D + ds_BusUnemClmLexIDFiledCnt30D + 
							// ds_BusLexIDMultiUnemClmCntEv + ds_BusLexIDMultiUnemClmCnt1Y + ds_BusLexIDMultiUnemClmCnt120D + ds_BusLexIDMultiUnemClmCnt90D + ds_BusLexIDMultiUnemClmCnt30D + 

							// Nicole attributes
							ds_BusAcctNewestRecordDt + ds_BusAcctStatusTypeEcho + ds_BusAcctTaxLiabStartDtEcho + ds_BusOldestTaxLiabStartDt +
							ds_BusOldestTaxLiabEndDt + ds_BusTaxLiabOngoingFlag + ds_BusAcctTaxLiabEndMsince + ds_BusNewestTaxLiabEndMsince +
							ds_BusAcctNewestUnemClmDt + ds_BusNewestUnemClmDt + ds_BusIncorpStatusType;
							
							
		// Show tables that verify for SeleID level variables that every record with the same SeleID receives the same attribute value
		/*
				BusNewestRecordDt
				BusOldestTaxLiabStartDt
				BusNewestTaxLiabStartDt

				BusOldestTaxLiabEndDt
				BusNewestTaxLiabEndDt
				BusTaxLiabOngoingFlag

				BusOldestTaxLiabStartMsince
				BusNewestTaxLiabEndMsince
				BusOldestUnemClmDt

				BusNewestUnemClmDt
				BusIncorpDt
				BusIncorpStatusType
				BusIncorpMsince
		*/
		
		EXPORT fn_seleCheck(dsMac, attr_str, attr_name) := FUNCTIONMACRO	
				// Check that every employer with the same seleid shares the same sele attributes			
				// First table rolls up by seleid and attribute name. Gets number of counts
				xt1 := TABLE(dsMac, {STRING30 sele:=(STRING30)Bus_Acct_Sele_I_D_Append_, STRING30 atr:=(STRING30)attr_name, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_, attr_name);
				// Second table rolls up by seleid to find out how many seleis multiple attributes - failing the test
				xt2 := TABLE(xt1, {sele, cntt:=COUNT(GROUP)}, sele);
				
				// Return a PASS/FAIL 
				// RETURN xt2;
				pass_cnt := COUNT(xt2(cntt=1));
				RETURN ROW({attr_str, pass_cnt, COUNT(xt2)-pass_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;
		
		
		SHARED dsSeleBusNewestRecordDt := fn_seleCheck(ds, 'BusNewestRecordDt', Bus_Newest_Record_Dt_);
		SHARED dsSeleBusOldestTaxLiabStartDt := fn_seleCheck(ds, 'BusOldestTaxLiabStartDt', Bus_Oldest_Tax_Liab_Start_Dt_);
		SHARED dsSeleBusNewestTaxLiabStartDt := fn_seleCheck(ds, 'BusNewestTaxLiabStartDt', Bus_Newest_Tax_Liab_Start_Dt_);
		SHARED dsSeleBusOldestTaxLiabEndDt := fn_seleCheck(ds, 'BusOldestTaxLiabEndDt', Bus_Oldest_Tax_Liab_End_Dt_);
		SHARED dsSeleBusNewestTaxLiabEndDt := fn_seleCheck(ds, 'BusNewestTaxLiabEndDt', Bus_Newest_Tax_Liab_End_Dt_);
		SHARED dsSeleBusTaxLiabOngoingFlag := fn_seleCheck(ds, 'BusTaxLiabOngoingFlag', Bus_Tax_Liab_Ongoing_Flag_);
		SHARED dsSeleBusOldestTaxLiabStartMsince := fn_seleCheck(ds, 'BusOldestTaxLiabStartMsince', Bus_Oldest_Tax_Liab_Start_Msince_);
		SHARED dsSeleBusNewestTaxLiabEndMsince := fn_seleCheck(ds, 'BusNewestTaxLiabEndMsince', Bus_Newest_Tax_Liab_End_Msince_);
		SHARED dsSeleBusOldestUnemClmDt := fn_seleCheck(ds, 'BusOldestUnemClmDt', Bus_Oldest_Unem_Clm_Dt_);
		SHARED dsSeleBusNewestUnemClmDt := fn_seleCheck(ds, 'BusNewestUnemClmDt', Bus_Newest_Unem_Clm_Dt_);
		SHARED dsSeleBusIncorpDt := fn_seleCheck(ds, 'BusIncorpDt', Bus_Incorp_Dt_);
		SHARED dsSeleBusIncorpStatusType := fn_seleCheck(ds, 'BusIncorpStatusType', Bus_Incorp_Status_Type_);
		SHARED dsSeleBusIncorpMSince := fn_seleCheck(ds, 'BusIncorpMSince', Bus_Incorp_M_Since_);
		
		shared dsSeleBusUnemClmAcctCurActiveCnt := fn_seleCheck(ds, 'BusUnemClmAcctCurActiveCnt', Bus_Unem_Clm_Acct_Cur_Active_Cnt_);
		shared dsSeleBusUnemClmAcctFiledCntEv := fn_seleCheck(ds, 'BusUnemClmAcctFiledCntEv', Bus_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared dsSeleBusUnemClmAcctFiledCnt1Y := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt1Y', Bus_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared dsSeleBusUnemClmAcctFiledCnt120D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt120D', Bus_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared dsSeleBusUnemClmAcctFiledCnt90D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt90D', Bus_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared dsSeleBusUnemClmAcctFiledCnt30D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt30D', Bus_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		// shared dsSeleBusUnemClmLexIDFiledCntEv := fn_macro(ds, 'BusUnemClmLexIDFiledCntEv', Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		// shared dsSeleBusUnemClmLexIDFiledCnt1Y := fn_macro(ds, 'BusUnemClmLexIDFiledCnt1Y', Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		// shared dsSeleBusUnemClmLexIDFiledCnt120D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt120D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		// shared dsSeleBusUnemClmLexIDFiledCnt90D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt90D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		// shared dsSeleBusUnemClmLexIDFiledCnt30D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt30D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		// shared dsSeleBusLexIDMultiUnemClmCntEv := fn_macro(ds, 'BusLexIDMultiUnemClmCntEv', Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		// shared dsSeleBusLexIDMultiUnemClmCnt1Y := fn_macro(ds, 'BusLexIDMultiUnemClmCnt1Y', Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		// shared dsSeleBusLexIDMultiUnemClmCnt120D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt120D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		// shared dsSeleBusLexIDMultiUnemClmCnt90D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt90D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		// shared dsSeleBusLexIDMultiUnemClmCnt30D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt30D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);
		
		
		SHARED dsSeleChecks := dsSeleBusNewestRecordDt + dsSeleBusOldestTaxLiabStartDt + dsSeleBusNewestTaxLiabStartDt + 
													 dsSeleBusOldestTaxLiabEndDt + dsSeleBusNewestTaxLiabEndDt + dsSeleBusTaxLiabOngoingFlag + 
													 dsSeleBusOldestTaxLiabStartMsince + dsSeleBusNewestTaxLiabEndMsince + dsSeleBusOldestUnemClmDt + 
													 dsSeleBusNewestUnemClmDt + dsSeleBusIncorpDt + dsSeleBusIncorpStatusType + dsSeleBusIncorpMSince + 
													 dsSeleBusUnemClmAcctCurActiveCnt + dsSeleBusUnemClmAcctFiledCntEv + dsSeleBusUnemClmAcctFiledCnt1Y + dsSeleBusUnemClmAcctFiledCnt120D + dsSeleBusUnemClmAcctFiledCnt90D + dsSeleBusUnemClmAcctFiledCnt30D;
													 // dsSeleBusUnemClmLexIDFiledCntEv + dsSeleBusUnemClmLexIDFiledCnt1Y + dsSeleBusUnemClmLexIDFiledCnt120D + dsSeleBusUnemClmLexIDFiledCnt90D + dsSeleBusUnemClmLexIDFiledCnt30D + 
													 // dsSeleBusLexIDMultiUnemClmCntEv + dsSeleBusLexIDMultiUnemClmCnt1Y + dsSeleBusLexIDMultiUnemClmCnt120D + dsSeleBusLexIDMultiUnemClmCnt90D + dsSeleBusLexIDMultiUnemClmCnt30D

		EXPORT writeFile(dsMac, reportName) := FUNCTIONMACRO
			// If landing zone is on the same server as the Dali
			daliserver := std.system.Thorlib.DaliServer();
			cpos := std.Str.Find(daliserver, ':', 1)-1;
			lzip := daliserver[1..cpos];
			lz_dir := '/var/lib/HPCCSystems/mydropzone/fraudgov/kelattributes/';
			file_path := '~hrude::fraudgov::kelattributes::';
			thor_file := file_path + reportName;
			lz_path := lz_dir + reportName + '.csv';
			thor_out := OUTPUT(dsMac,, thor_file, CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')), OVERWRITE);
			RETURN SEQUENTIAL(std.file.CreateExternalDirectory(lzip, lz_dir), thor_out, std.file.Despray(thor_file, lzip,lz_path,,,,true));
		ENDMACRO;

		// EXPORT main := OUTPUT(dsSeleChecks, NAMED('dsSeleChecks'));
		EXPORT main := OUTPUT(SORT(ds_All(attribute_name='BusAcctUnemClmAcctCurActiveCnt'), -cnt));
		// EXPORT main := SEQUENTIAL(writeFile(ds_All, 'AttributesDistribution'),
															// writeFile(dsSeleChecks, 'SelePassFailTests'));
END;