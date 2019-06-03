import FraudgovUIKEL;
import std;


EXPORT BWR_CalcAttrDistribution := MODULE
		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		// TODO - create macro for this

		// fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				// RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, STRING30 attribute_value := (STRING)attribute, cnt:=COUNT(GROUP)}, attribute), -cnt);
		// ENDMACRO;

		// ds_BusAcctUIDEcho := fn_macro(ds, 'BusAcctUIDEcho', Bus_Acct_U_I_D_Echo_);
		SHARED ds_BusAcctUIDEcho := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctUIDEcho', STRING30 attribute_value:=(string)Bus_Acct_U_I_D_Echo_, cnt:=COUNT(GROUP)}, Bus_Acct_U_I_D_Echo_), -cnt);
		SHARED ds_BusAcctUltIDAppend := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctUltIDAppend', STRING30 attribute_value:=(string)Bus_Acct_Ult_I_D_Append_, cnt:=COUNT(GROUP)}, Bus_Acct_Ult_I_D_Append_), -cnt);
		SHARED ds_BusAcctOrgIDAppend := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctOrgIDAppend', STRING30 attribute_value:=(string)Bus_Acct_Org_I_D_Append_, cnt:=COUNT(GROUP)}, Bus_Acct_Org_I_D_Append_), -cnt);
		SHARED ds_BusAcctSeleIDAppend := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctSeleIDAppend', STRING30 attribute_value:=(string)Bus_Acct_Sele_I_D_Append_, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_), -cnt);
		SHARED ds_BusAcctProxIDAppend:= SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctProxIDAppend', STRING30 attribute_value:=(string)Bus_Acct_Prox_I_D_Append_, cnt:=COUNT(GROUP)}, Bus_Acct_Prox_I_D_Append_), -cnt);
		SHARED ds_BusAcctPowIDAppend := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctPowIDAppend', STRING30 attribute_value:=(string)Bus_Acct_Pow_I_D_Append_, cnt:=COUNT(GROUP)}, Bus_Acct_Pow_I_D_Append_), -cnt);


		// OUTPUT(ds_BusAcctUIDEcho, NAMED('ds_BusAcctUIDEcho'));
		// OUTPUT(ds_BusAcctUltIDAppend, NAMED('ds_BusAcctUltIDAppend'));
		// OUTPUT(ds_BusAcctOrgIDAppend, NAMED('ds_BusAcctOrgIDAppend'));
		// OUTPUT(ds_BusAcctSeleIDAppend, NAMED('ds_BusAcctSeleIDAppend'));
		// OUTPUT(ds_BusAcctProxIDAppend, NAMED('ds_BusAcctProxIDAppend'));
		// OUTPUT(ds_BusAcctPowIDAppend, NAMED('ds_BusAcctPowIDAppend'));

		// Nate Attributes
		SHARED ds_BusAcctNewestUpdateMasterDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctNewestUpdateMasterDt', STRING30 attribute_value:=(string)Bus_Acct_Newest_Update_Master_Dt_, cnt:=COUNT(GROUP)}, Bus_Acct_Newest_Update_Master_Dt_), -cnt);
		SHARED ds_BusNewestRecordDt:= SORT(TABLE(ds, {STRING30 attribute_name:= 'BusNewestRecordDt', STRING30 attribute_value:=(string)Bus_Newest_Record_Dt_, cnt:=COUNT(GROUP)}, Bus_Newest_Record_Dt_), -cnt);
		SHARED ds_BusAcctDtEmployerBeganEcho := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctDtEmployerBeganEcho', STRING30 attribute_value:=(string)Bus_Acct_Dt_Employer_Began_Echo_, cnt:=COUNT(GROUP)}, Bus_Acct_Dt_Employer_Began_Echo_), -cnt);
		SHARED ds_BusAcctTaxLiabEndDtEcho := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctTaxLiabEndDtEcho', STRING30 attribute_value:=(string)Bus_Acct_Tax_Liab_End_Dt_Echo_, cnt:=COUNT(GROUP)}, Bus_Acct_Tax_Liab_End_Dt_Echo_), -cnt);
		SHARED ds_BusNewestTaxLiabStartDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusNewestTaxLiabStartDt', STRING30 attribute_value:=(string)Bus_Newest_Tax_Liab_Start_Dt_, cnt:=COUNT(GROUP)}, Bus_Newest_Tax_Liab_Start_Dt_), -cnt);

		SHARED ds_BusNewestTaxLiabEndDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusNewestTaxLiabEndDt', STRING30 attribute_value:=(string)Bus_Newest_Tax_Liab_End_Dt_, cnt:=COUNT(GROUP)}, Bus_Newest_Tax_Liab_End_Dt_), -cnt);
		SHARED ds_BusAcctTaxLiabStartMsince := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctTaxLiabStartMsince', STRING30 attribute_value:=(string)Bus_Acct_Tax_Liab_Start_Msince_, cnt:=COUNT(GROUP)}, Bus_Acct_Tax_Liab_Start_Msince_), -cnt);
		SHARED ds_BusOldestTaxLiabStartMsince := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusOldestTaxLiabStartMsince', STRING30 attribute_value:=(string)Bus_Oldest_Tax_Liab_Start_Msince_, cnt:=COUNT(GROUP)}, Bus_Oldest_Tax_Liab_Start_Msince_), -cnt);
		SHARED ds_BusAcctOldestUnemClmDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctOldestUnemClmDt', STRING30 attribute_value:=(string)Bus_Acct_Oldest_Unem_Clm_Dt_, cnt:=COUNT(GROUP)}, Bus_Acct_Oldest_Unem_Clm_Dt_), -cnt);
		SHARED ds_BusOldestUnemClmDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusOldestUnemClmDt', STRING30 attribute_value:=(string)Bus_Oldest_Unem_Clm_Dt_, cnt:=COUNT(GROUP)}, Bus_Oldest_Unem_Clm_Dt_), -cnt);

		SHARED ds_BusIncorpDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusIncorpDt', STRING30 attribute_value:=(string)Bus_Incorp_Dt_, cnt:=COUNT(GROUP)}, Bus_Incorp_Dt_), -cnt);
		SHARED ds_BisIncorpMSince := SORT(TABLE(ds, {STRING30 attribute_name:= 'BisIncorpMSince', STRING30 attribute_value:=(string)Bis_Incorp_M_Since_, cnt:=COUNT(GROUP)}, Bis_Incorp_M_Since_), -cnt);


		// OUTPUT(ds_BusAcctNewestUpdateMasterDt, NAMED('ds_BusAcctNewestUpdateMasterDt'));
		// OUTPUT(ds_BusNewestRecordDt, NAMED('ds_BusNewestRecordDt'));
		// OUTPUT(ds_BusAcctDtEmployerBeganEcho, NAMED('ds_BusAcctDtEmployerBeganEcho'));
		// OUTPUT(ds_BusAcctTaxLiabEndDtEcho, NAMED('ds_BusAcctTaxLiabEndDtEcho'));
		// OUTPUT(ds_BusNewestTaxLiabStartDt, NAMED('ds_BusNewestTaxLiabStartDt'));

		// OUTPUT(ds_BusNewestTaxLiabEndDt, NAMED('ds_BusNewestTaxLiabEndDt'));
		// OUTPUT(ds_BusAcctTaxLiabStartMsince, NAMED('ds_BusAcctTaxLiabStartMsince'));
		// OUTPUT(ds_BusOldestTaxLiabStartMsince, NAMED('ds_BusOldestTaxLiabStartMsince'));
		// OUTPUT(ds_BusAcctOldestUnemClmDt, NAMED('ds_BusAcctOldestUnemClmDt'));
		// OUTPUT(ds_BusOldestUnemClmDt, NAMED('ds_BusOldestUnemClmDt'));

		// OUTPUT(ds_BusIncorpDt, NAMED('ds_BusIncorpDt'));
		// OUTPUT(ds_BisIncorpMSince, NAMED('ds_BisIncorpMSince'));

		// Nicole Attributes
		SHARED ds_BusAcctNewestRecordDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctNewestRecordDt', STRING30 attribute_value:=(string)Bus_Acct_Newest_Record_Dt_, cnt:=COUNT(GROUP)}, Bus_Acct_Newest_Record_Dt_), -cnt);
		SHARED ds_BusAcctStatusTypeEcho := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctStatusTypeEcho', STRING30 attribute_value:=(string)Bus_Acct_Status_Type_Echo_, cnt:=COUNT(GROUP)}, Bus_Acct_Status_Type_Echo_), -cnt);
		SHARED ds_BusAcctTaxLiabStartDtEcho := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctTaxLiabStartDtEcho', STRING30 attribute_value:=(string)Bus_Acct_Tax_Liab_Start_Dt_Echo_, cnt:=COUNT(GROUP)}, Bus_Acct_Tax_Liab_Start_Dt_Echo_), -cnt);
		SHARED ds_BusOldestTaxLiabStartDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusOldestTaxLiabStartDt', STRING30 attribute_value:=(string)Bus_Oldest_Tax_Liab_Start_Dt_, cnt:=COUNT(GROUP)}, Bus_Oldest_Tax_Liab_Start_Dt_), -cnt);
		SHARED ds_BusOldestTaxLiabEndDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusOldestTaxLiabEndDt', STRING30 attribute_value:=(string)Bus_Oldest_Tax_Liab_End_Dt_, cnt:=COUNT(GROUP)}, Bus_Oldest_Tax_Liab_End_Dt_), -cnt);

		SHARED ds_BusTaxLiabOngoingFlag := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusTaxLiabOngoingFlag', STRING30 attribute_value:=(string)Bus_Tax_Liab_Ongoing_Flag_, cnt:=COUNT(GROUP)}, Bus_Tax_Liab_Ongoing_Flag_), -cnt);
		SHARED ds_BusAcctTaxLiabEndMsince := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctTaxLiabEndMsince', STRING30 attribute_value:=(string)Bus_Acct_Tax_Liab_End_Msince_, cnt:=COUNT(GROUP)}, Bus_Acct_Tax_Liab_End_Msince_), -cnt);
		SHARED ds_BusNewestTaxLiabEndMsince := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusNewestTaxLiabEndMsince', STRING30 attribute_value:=(string)Bus_Newest_Tax_Liab_End_Msince_, cnt:=COUNT(GROUP)}, Bus_Newest_Tax_Liab_End_Msince_), -cnt);
		SHARED ds_BusAcctNewestUnemClmDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusAcctNewestUnemClmDt', STRING30 attribute_value:=(string)Bus_Acct_Newest_Unem_Clm_Dt_, cnt:=COUNT(GROUP)}, Bus_Acct_Newest_Unem_Clm_Dt_), -cnt);
		SHARED ds_BusNewestUnemClmDt := SORT(TABLE(ds, {STRING30 attribute_name:= 'BusNewestUnemClmDt', STRING30 attribute_value:=(string)Bus_Newest_Unem_Clm_Dt_, cnt:=COUNT(GROUP)}, Bus_Newest_Unem_Clm_Dt_), -cnt);

		SHARED ds_BusIncorpStatusType:= SORT(TABLE(ds, {STRING30 attribute_name:= 'BusIncorpStatusType', STRING30 attribute_value:=(string)Bus_Incorp_Status_Type_, cnt:=COUNT(GROUP)}, Bus_Incorp_Status_Type_), -cnt);

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

							ds_BusAcctNewestUpdateMasterDt + ds_BusNewestRecordDt + ds_BusAcctDtEmployerBeganEcho + ds_BusAcctTaxLiabEndDtEcho +
							ds_BusNewestTaxLiabStartDt + ds_BusNewestTaxLiabEndDt + ds_BusAcctTaxLiabStartMsince + ds_BusOldestTaxLiabStartMsince + 
							ds_BusAcctOldestUnemClmDt + ds_BusOldestUnemClmDt + ds_BusIncorpDt + ds_BisIncorpMSince +

							ds_BusAcctNewestRecordDt + ds_BusAcctStatusTypeEcho + ds_BusAcctTaxLiabStartDtEcho + ds_BusOldestTaxLiabStartDt +
							ds_BusOldestTaxLiabEndDt + ds_BusTaxLiabOngoingFlag + ds_BusAcctTaxLiabEndMsince + ds_BusNewestTaxLiabEndMsince +
							ds_BusAcctNewestUnemClmDt + ds_BusNewestUnemClmDt + ds_BusIncorpStatusType;
							

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

		EXPORT main := writeFile(SORT(ds_All, attribute_name, -cnt), 'AttributesDistribution');
END;