import FraudgovUIKEL;
import std;


EXPORT BWR_CalcSasFlagsPt2Distribution := MODULE

		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, STRING attribute_value := (STRING)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;

		// Nate Attributes 
		// Claim attributes
		// Business Account attributes
		shared ds_BusAcctOpenDtMsince := fn_macro(ds, 'BusAcctOpenDtMsince', Bus_Acct_Open_Dt_Msince_);
		shared ds_BusOldestAcctOpenDtMsince	:= fn_macro(ds, 'BusOldestAcctOpenDtMsince', Bus_Oldest_Acct_Open_Dt_Msince_);					
		shared ds_BusAcctLiabStartToOpenGT5MFlag := fn_macro(ds, 'BusAcctLiabStartToOpenGT5MFlag', Bus_Acct_Liab_Start_To_Open_G_T5_M_Flag_);
		shared ds_BusOldestLiabStartToOpenGT5MFlag := fn_macro(ds, 'BusOldestLiabStartToOpenGT5MFlag', Bus_Oldest_Liab_Start_To_Open_G_T5_M_Flag_);
		shared ds_BusAcctOwnerCntEcho := fn_macro(ds, 'BusAcctOwnerCntEcho', Bus_Acct_Owner_Cnt_Echo_);
		
		shared ds_BusAcctOwnerName1Pop := fn_macro(ds, 'BusAcctOwnerName1Pop', Bus_Acct_Owner_Name1_Pop_);
		shared ds_BusAcctOwnerSSN1Pop := fn_macro(ds, 'BusAcctOwnerSSN1Pop', Bus_Acct_Owner_S_S_N1_Pop_);
		shared ds_BusAcctOwnerName2Pop := fn_macro(ds, 'BusAcctOwnerName2Pop', Bus_Acct_Owner_Name2_Pop_);
		shared ds_BusAcctOwnerSSN2Pop := fn_macro(ds, 'BusAcctOwnerSSN2Pop', Bus_Acct_Owner_S_S_N2_Pop_);
		shared ds_BusAcctOwnerName3Pop := fn_macro(ds, 'BusAcctOwnerName3Pop', Bus_Acct_Owner_Name3_Pop_);

		shared ds_BusAcctOwnerSSN3Pop := fn_macro(ds, 'BusAcctOwnerSSN3Pop', Bus_Acct_Owner_S_S_N3_Pop_);
		shared ds_BusAcctOwnerNotPopFlag := fn_macro(ds, 'BusAcctOwnerNotPopFlag', Bus_Acct_Owner_Not_Pop_Flag_);
		shared ds_BusAcctPerBusOwnerNotPopCnt := fn_macro(ds, 'BusAcctPerBusOwnerNotPopCnt', Bus_Acct_Per_Bus_Owner_Not_Pop_Cnt_);
		shared ds_BusOwnerNotPopFlag := fn_macro(ds, 'BusOwnerNotPopFlag', Bus_Owner_Not_Pop_Flag_);
		shared ds_BusAcctFullAddressCleanPop := fn_macro(ds, 'BusAcctFullAddressCleanPop', Bus_Acct_Full_Address_Clean_Pop_);

		shared ds_BusAcctStateClean := fn_macro(ds, 'BusAcctStateClean', Bus_Acct_State_Clean_);
		shared ds_ProgramStateEcho := fn_macro(ds, 'ProgramStateEcho', Program_State_Echo_);
		shared ds_BusAcctStateNotInProgAreaFlag := fn_macro(ds, 'BusAcctStateNotInProgAreaFlag', Bus_Acct_State_Not_In_Prog_Area_Flag_);
		shared ds_BusAcctPerBusNotInProgAreaCnt := fn_macro(ds, 'BusAcctPerBusNotInProgAreaCnt', Bus_Acct_Per_Bus_Not_In_Prog_Area_Cnt_);
		shared ds_BusAcctPerBusNotInProgAreaFlag := fn_macro(ds, 'BusAcctPerBusNotInProgAreaFlag', Bus_Acct_Per_Bus_Not_In_Prog_Area_Flag_);

		shared ds_BusAcctAddressTypeClean	:= fn_macro(ds, 'BusAcctAddressTypeClean', Bus_Acct_Address_Type_Clean_);																						 
		shared ds_BusAcctAddressPOBoxFlag := fn_macro(ds, 'BusAcctAddressPOBoxFlag', Bus_Acct_Address_P_O_Box_Flag_);
		shared ds_BusAcctPerBusAddressPOBoxCnt := fn_macro(ds, 'BusAcctPerBusAddressPOBoxCnt', Bus_Acct_Per_Bus_Address_P_O_Box_Cnt_);																						
		shared ds_BusAcctPerBusAddressPOBoxFlag := fn_macro(ds, 'BusAcctPerBusAddressPOBoxFlag', Bus_Acct_Per_Bus_Address_P_O_Box_Flag_);
		// shared ds_VelBusAcctPerAddrInProgCnt := fn_macro(ds, 'VelBusAcctPerAddrInProgCnt', Vel_Bus_Acct_Per_Addr_In_Prog_Cnt_);

		// shared ds_VelBusAcctPerAddrInBusLegEntCnt := fn_macro(ds, 'VelBusAcctPerAddrInBusLegEntCnt', Vel_Bus_Acct_Per_Addr_In_Bus_Leg_Ent_Cnt_);
		shared ds_BusAcctLegalActionTypeEcho := fn_macro(ds, 'BusAcctLegalActionTypeEcho', Bus_Acct_Legal_Action_Type_Echo_);
		shared ds_BusAcctLegalActionFlag := fn_macro(ds, 'BusAcctLegalActionFlag', Bus_Acct_Legal_Action_Flag_);
		shared ds_BusAcctPerBusLegActLienCnt := fn_macro(ds, 'BusAcctPerBusLegActLienCnt', Bus_Acct_Per_Bus_Leg_Act_Lien_Cnt_);
		shared ds_BusAcctPerBusLegalActOtherCnt := fn_macro(ds, 'BusAcctPerBusLegalActOtherCnt', Bus_Acct_Per_Bus_Legal_Act_Other_Cnt_);
		
		shared ds_BusAcctPerBusLegalActPaymCnt := fn_macro(ds, 'BusAcctPerBusLegalActPaymCnt', Bus_Acct_Per_Bus_Legal_Act_Paym_Cnt_);
		shared ds_BusLegalActionFlag := fn_macro(ds, 'BusLegalActionFlag', Bus_Legal_Action_Flag_);
		shared ds_BusAcctWarrantIssuedCntEcho := fn_macro(ds, 'BusAcctWarrantIssuedCntEcho', Bus_Acct_Warrant_Issued_Cnt_Echo_);
		shared ds_BusAcctWarrantIssuedDtEcho := fn_macro(ds, 'BusAcctWarrantIssuedDtEcho', Bus_Acct_Warrant_Issued_Dt_Echo_);
		shared ds_BusAcctWarrantIssuedFlag := fn_macro(ds, 'BusAcctWarrantIssuedFlag', Bus_Acct_Warrant_Issued_Flag_);

		shared ds_BusWarrantIssuedSum := fn_macro(ds, 'BusWarrantIssuedSum', Bus_Warrant_Issued_Sum_);														 
		shared ds_BusAcctPerBusWithWarrantCnt	:= fn_macro(ds, 'BusAcctPerBusWithWarrantCnt', Bus_Acct_Per_Bus_With_Warrant_Cnt_);																				 
		shared ds_BusWarrantIssuedFlag := fn_macro(ds, 'BusWarrantIssuedFlag', Bus_Warrant_Issued_Flag_);																			 
		shared ds_BusAcctTaxLiabBlceStatusEcho := fn_macro(ds, 'BusAcctTaxLiabBlceStatusEcho', Bus_Acct_Tax_Liab_Blce_Status_Echo_);
		shared ds_BusAcctTaxLiabBlceDebitFlag := fn_macro(ds, 'BusAcctTaxLiabBlceDebitFlag', Bus_Acct_Tax_Liab_Blce_Debit_Flag_);

		shared ds_BusAcctPerBusTaxLiabBlceDebCnt := fn_macro(ds, 'BusAcctPerBusTaxLiabBlceDebCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Deb_Cnt_);
		shared ds_BusAcctPerBusTaxLiabBlceCredCnt := fn_macro(ds, 'BusAcctPerBusTaxLiabBlceCredCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Cred_Cnt_);
		shared ds_BusAcctPerBusTaxLiabBlceOthCnt := fn_macro(ds, 'BusAcctPerBusTaxLiabBlceOthCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Oth_Cnt_);
		shared ds_BusTaxLiabBlceDebitFlag := fn_macro(ds, 'BusTaxLiabBlceDebitFlag', Bus_Tax_Liab_Blce_Debit_Flag_);
			


		SHARED ds_All := 	ds_BusAcctOpenDtMsince + ds_BusOldestAcctOpenDtMsince	+ ds_BusAcctLiabStartToOpenGT5MFlag + ds_BusOldestLiabStartToOpenGT5MFlag +ds_BusAcctOwnerCntEcho + 
											ds_BusAcctOwnerName1Pop + ds_BusAcctOwnerSSN1Pop + ds_BusAcctOwnerName2Pop + ds_BusAcctOwnerSSN2Pop + ds_BusAcctOwnerName3Pop + 
											ds_BusAcctOwnerSSN3Pop + ds_BusAcctOwnerNotPopFlag + ds_BusAcctPerBusOwnerNotPopCnt + ds_BusOwnerNotPopFlag + ds_BusAcctFullAddressCleanPop + 
											ds_BusAcctStateClean + ds_ProgramStateEcho + ds_BusAcctStateNotInProgAreaFlag + ds_BusAcctPerBusNotInProgAreaCnt + ds_BusAcctPerBusNotInProgAreaFlag + 
											ds_BusAcctAddressTypeClean + ds_BusAcctAddressPOBoxFlag + ds_BusAcctPerBusAddressPOBoxCnt + ds_BusAcctPerBusAddressPOBoxFlag + 
											// ds_VelBusAcctPerAddrInProgCnt + ds_VelBusAcctPerAddrInBusLegEntCnt + 
											ds_BusAcctLegalActionTypeEcho + ds_BusAcctLegalActionFlag + ds_BusAcctPerBusLegActLienCnt + ds_BusAcctPerBusLegalActOtherCnt + 
											ds_BusAcctPerBusLegalActPaymCnt + ds_BusLegalActionFlag + ds_BusAcctWarrantIssuedCntEcho + ds_BusAcctWarrantIssuedDtEcho + ds_BusAcctWarrantIssuedFlag + 
											ds_BusWarrantIssuedSum + ds_BusAcctPerBusWithWarrantCnt + ds_BusWarrantIssuedFlag + ds_BusAcctTaxLiabBlceStatusEcho + ds_BusAcctTaxLiabBlceDebitFlag + 
											ds_BusAcctPerBusTaxLiabBlceDebCnt + ds_BusAcctPerBusTaxLiabBlceCredCnt + ds_BusAcctPerBusTaxLiabBlceOthCnt + ds_BusTaxLiabBlceDebitFlag;
			
			
		// Show tables that verify for SeleID level variables that every record with the same SeleID receives the same attribute value
		EXPORT fn_seleCheck(dsMac, attr_str, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				// First table rolls up by seleid and attribute name. Gets number of counts
				xt1 := TABLE(dsMac, {STRING30 sele:=(STRING30)Bus_Acct_Sele_I_D_Append_, STRING30 atr:=(STRING30)attr_name, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_, attr_name);
				// Second table rolls up by seleid to find out how many seleis multiple attributes - failing the test
				xt2 := TABLE(xt1, {sele, cntt:=COUNT(GROUP)}, sele);
				
				// Return a PASS/FAIL 
				// RETURN xt2;
				pass_cnt := COUNT(xt2(cntt=1));
				RETURN ROW({attr_str, pass_cnt, COUNT(xt2)-pass_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;
		
		
		shared dsSeleBusUnemClmAcctCurActiveCnt := fn_seleCheck(ds, 'BusUnemClmAcctCurActiveCnt', Bus_Unem_Clm_Acct_Cur_Active_Cnt_);
		
		


		shared ds_SeleBusOldestAcctOpenDtMsince	:= fn_seleCheck(ds, 'BusOldestAcctOpenDtMsince', Bus_Oldest_Acct_Open_Dt_Msince_);					
		shared ds_SeleBusOldestLiabStartToOpenGT5MFlag := fn_seleCheck(ds, 'BusOldestLiabStartToOpenGT5MFlag', Bus_Oldest_Liab_Start_To_Open_G_T5_M_Flag_);
		shared ds_SeleBusAcctPerBusOwnerNotPopCnt := fn_seleCheck(ds, 'BusAcctPerBusOwnerNotPopCnt', Bus_Acct_Per_Bus_Owner_Not_Pop_Cnt_);
		shared ds_SeleBusOwnerNotPopFlag := fn_seleCheck(ds, 'BusOwnerNotPopFlag', Bus_Owner_Not_Pop_Flag_);
		shared ds_SeleBusAcctPerBusNotInProgAreaCnt := fn_seleCheck(ds, 'BusAcctPerBusNotInProgAreaCnt', Bus_Acct_Per_Bus_Not_In_Prog_Area_Cnt_);
		
		shared ds_SeleBusAcctPerBusNotInProgAreaFlag := fn_seleCheck(ds, 'BusAcctPerBusNotInProgAreaFlag', Bus_Acct_Per_Bus_Not_In_Prog_Area_Flag_);
		shared ds_SeleBusAcctPerBusAddressPOBoxCnt := fn_seleCheck(ds, 'BusAcctPerBusAddressPOBoxCnt', Bus_Acct_Per_Bus_Address_P_O_Box_Cnt_);																						
		shared ds_SeleBusAcctPerBusAddressPOBoxFlag := fn_seleCheck(ds, 'BusAcctPerBusAddressPOBoxFlag', Bus_Acct_Per_Bus_Address_P_O_Box_Flag_);
		shared ds_SeleBusAcctPerBusLegActLienCnt := fn_seleCheck(ds, 'BusAcctPerBusLegActLienCnt', Bus_Acct_Per_Bus_Leg_Act_Lien_Cnt_);
		shared ds_SeleBusAcctPerBusLegalActOtherCnt := fn_seleCheck(ds, 'BusAcctPerBusLegalActOtherCnt', Bus_Acct_Per_Bus_Legal_Act_Other_Cnt_);
		
		shared ds_SeleBusAcctPerBusLegalActPaymCnt := fn_seleCheck(ds, 'BusAcctPerBusLegalActPaymCnt', Bus_Acct_Per_Bus_Legal_Act_Paym_Cnt_);
		shared ds_SeleBusLegalActionFlag := fn_seleCheck(ds, 'BusLegalActionFlag', Bus_Legal_Action_Flag_);
		shared ds_SeleBusWarrantIssuedSum := fn_seleCheck(ds, 'BusWarrantIssuedSum', Bus_Warrant_Issued_Sum_);														 
		shared ds_SeleBusAcctPerBusWithWarrantCnt	:= fn_seleCheck(ds, 'BusAcctPerBusWithWarrantCnt', Bus_Acct_Per_Bus_With_Warrant_Cnt_);																				 
		shared ds_SeleBusWarrantIssuedFlag := fn_seleCheck(ds, 'BusWarrantIssuedFlag', Bus_Warrant_Issued_Flag_);																			 
	
		shared ds_SeleBusAcctPerBusTaxLiabBlceDebCnt := fn_seleCheck(ds, 'BusAcctPerBusTaxLiabBlceDebCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Deb_Cnt_);
		shared ds_SeleBusAcctPerBusTaxLiabBlceCredCnt := fn_seleCheck(ds, 'BusAcctPerBusTaxLiabBlceCredCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Cred_Cnt_);
		shared ds_SeleBusAcctPerBusTaxLiabBlceOthCnt := fn_seleCheck(ds, 'BusAcctPerBusTaxLiabBlceOthCnt', Bus_Acct_Per_Bus_Tax_Liab_Blce_Oth_Cnt_);
		shared ds_SeleBusTaxLiabBlceDebitFlag := fn_seleCheck(ds, 'BusTaxLiabBlceDebitFlag', Bus_Tax_Liab_Blce_Debit_Flag_);
		
		
		SHARED dsSeleChecks := ds_SeleBusOldestAcctOpenDtMsince + ds_SeleBusOldestLiabStartToOpenGT5MFlag + ds_SeleBusAcctPerBusOwnerNotPopCnt + ds_SeleBusOwnerNotPopFlag + ds_SeleBusAcctPerBusNotInProgAreaCnt + 
													 ds_SeleBusAcctPerBusNotInProgAreaCnt + ds_SeleBusAcctPerBusAddressPOBoxCnt + ds_SeleBusAcctPerBusAddressPOBoxFlag + ds_SeleBusAcctPerBusLegActLienCnt + ds_SeleBusAcctPerBusLegalActOtherCnt + 
													 ds_SeleBusAcctPerBusLegalActPaymCnt + ds_SeleBusLegalActionFlag + ds_SeleBusWarrantIssuedSum + ds_SeleBusAcctPerBusWithWarrantCnt + ds_SeleBusWarrantIssuedFlag +
													 ds_SeleBusAcctPerBusTaxLiabBlceDebCnt + ds_SeleBusAcctPerBusTaxLiabBlceCredCnt + ds_SeleBusAcctPerBusTaxLiabBlceOthCnt + ds_SeleBusTaxLiabBlceDebitFlag;
			
							/*
		EXPORT fn_dateCheck(dsMac, attr_ev, attr_1y, attr_120d, attr_90d, attr_30d, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				xt1 := TABLE(dsMac, {INTEGER Check := IF(attr_30d <= attr_90d AND attr_90d <= attr_120d AND attr_120d <= attr_1y AND attr_1y <= attr_ev, 1,0)});
				// Return a PASS/FAIL  
				pass_cnt := COUNT(xt1(Check=1));
				fail_cnt := COUNT(xt1(Check=0));
				RETURN ROW({attr_name, pass_cnt, fail_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;

    SHARED ds_BusAcctUnemClmAcctFiledCnt := fn_dateCheck(ds, Bus_Acct_Unem_Clm_Acct_Filed_Cnt_Ev_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt1_Y_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt120_D_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt90_D_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt30_D_, 'BusAcctUnemClmAcctFiledCnt');
		SHARED ds_BusAcctUnemClmLexIDFiled := fn_dateCheck(ds, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt120_D_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt90_D_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt30_D_, 'BusAcctUnemClmLexIDFiled');
		SHARED ds_BusAcctLexIDMultiUnemClm := fn_dateCheck(ds, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt120_D_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt90_D_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt30_D_, 'BusAcctLexIDMultiUnemClm');
	  SHARED ds_BusUnemClmAcctFiledCnt := fn_dateCheck(ds, Bus_Unem_Clm_Acct_Filed_Cnt_Ev_, Bus_Unem_Clm_Acct_Filed_Cnt1_Y_, Bus_Unem_Clm_Acct_Filed_Cnt120_D_, Bus_Unem_Clm_Acct_Filed_Cnt90_D_, Bus_Unem_Clm_Acct_Filed_Cnt30_D_, 'BusUnemClmAcctFiledCnt');
		SHARED ds_BusUnemClmLexIDFiled := fn_dateCheck(ds, Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_, 'BusUnemClmLexIDFiled');
		SHARED ds_BusLexIDMultiUnemClm := fn_dateCheck(ds, Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_, 'BusLexIDMultiUnemClm');
	
    SHARED dsDateChecks := ds_BusAcctUnemClmAcctFiledCnt + ds_BusAcctUnemClmLexIDFiled + ds_BusAcctLexIDMultiUnemClm + ds_BusUnemClmAcctFiledCnt + ds_BusUnemClmLexIDFiled + ds_BusLexIDMultiUnemClm;
*/
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
		
		// EXPORT main := dsSeleChecks;
		// EXPORT main := OUTPUT(dsDateChecks, NAMED('dsDateChecks'));
		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'SasFlagPt2_AttributesDistribution'),
															writeFile(dsSeleChecks, 'SasFlagPt2_SelePassFailTests'));
															//writeFile(dsDateChecks, 'UnemClaimPt2_DatePassFailTests'));

END;