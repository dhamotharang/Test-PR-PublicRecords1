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
			
							// Nicole attributes
							ds_BusAcctNewestRecordDt + ds_BusAcctStatusTypeEcho + ds_BusAcctTaxLiabStartDtEcho + ds_BusOldestTaxLiabStartDt +
							ds_BusOldestTaxLiabEndDt + ds_BusTaxLiabOngoingFlag + ds_BusAcctTaxLiabEndMsince + ds_BusNewestTaxLiabEndMsince +
							ds_BusAcctNewestUnemClmDt + ds_BusNewestUnemClmDt + ds_BusIncorpStatusType;
							
							
		// Show tables that verify for SeleID level variables that every record with the same SeleID receives the same attribute value
		EXPORT fn_seleCheck(dsMac, attr_str, attr_name) := FUNCTIONMACRO	
				// Check that every employer with the same seleid shares the same sele attributes			
				// First table rolls up by seleid and attribute name. Gets number of counts
				xt1 := TABLE(dsMac, {STRING30 sele:=(STRING30)Bus_Acct_Sele_I_D_Append_, STRING30 atr:=(STRING30)attr_name, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_, attr_name);
				// Second table rolls up by seleid to find out how many seleis multiple attributes - failing the test
				xt2 := TABLE(xt1, {sele, cntt:=COUNT(GROUP)}, sele);
				
				// Return a PASS/FAIL 
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
		
		SHARED dsSeleChecks := dsSeleBusNewestRecordDt + dsSeleBusOldestTaxLiabStartDt + dsSeleBusNewestTaxLiabStartDt + 
													 dsSeleBusOldestTaxLiabEndDt + dsSeleBusNewestTaxLiabEndDt + dsSeleBusTaxLiabOngoingFlag + 
													 dsSeleBusOldestTaxLiabStartMsince + dsSeleBusNewestTaxLiabEndMsince + dsSeleBusOldestUnemClmDt + 
													 dsSeleBusNewestUnemClmDt + dsSeleBusIncorpDt + dsSeleBusIncorpStatusType + dsSeleBusIncorpMSince;
	
		EXPORT writeFile(dsMac, reportName) := FUNCTIONMACRO
			// If landing zone is on the same server as the Dali
			daliserver := std.system.Thorlib.DaliServer();
			cpos := std.Str.Find(daliserver, ':', 1)-1;
			lzip := daliserver[1..cpos];
			lz_dir := '/var/lib/HPCCSystems/mydropzone/fraudgov/kelattributes/20190701/';
			file_path := '~nnavarro::fraudgov::kelattributes::20190701::';
			thor_file := file_path + reportName;
			lz_path := lz_dir + reportName + '.csv';
			thor_out := OUTPUT(dsMac,, thor_file, CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')), OVERWRITE);
			RETURN SEQUENTIAL(std.file.CreateExternalDirectory(lzip, lz_dir), thor_out, std.file.Despray(thor_file, lzip,lz_path,,,,true));
		ENDMACRO;

		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'BaseAttributesDistribution'),
															writeFile(dsSeleChecks, 'BaseSelePassFailTests'));
											
END;