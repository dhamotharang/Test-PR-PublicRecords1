/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep.U_GatherFix_Analytics_Functions
This should happen as a phase 2 to remove any PII values
********************************************************************************************* */
IMPORT PRTE2_Liens_Ins;
IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins_DataPrep, address, ut, STD;

EXPORT U_GatherFix_Analytics_Functions := MODULE

			SHARED anyNonBlank(STRING S1, STRING S2) := IF(TRIM(S1)='',S2,S1);
			SHARED bothIf(STRING S1, STRING S2) := IF(TRIM(S1)='','',S1+S2);

// --- MAIN FILE ACTIONS --------------------------------------------------------------------------------------------------------------
			Analy_DS := U_Gather_PRCT_Files.AnalyMain1_DS;
			Main_Prod_Mini	:=	DEDUP(SORT(U_Production_Files.Tmp_Prod_SF_Main_DS_Raw,filing_number),filing_number);

			// Prior to despray transfer the final values replacing the old existing values.
			EXPORT Main_Prod_Mini transformMain(Analy_DS L, Main_Prod_Mini R) := TRANSFORM
					TmpFilingNum 						:= bothIf(L.filing_number[1..4],'')+bothIf(L.certificate_number,'')+TRIM(L.orig_filing_date)+TRIM(L.filing_number[5..])+TRIM(L.amount);
					// really only need the above if we need to examine the old (IE: a state expects a specific layout for filingnumber)
					tmsSig 									:= R.tmsid[1..2];
					filingString 						:= TRIM(TmpFilingNum[1..10])+'ICT16';
					filTypeCode 						:= PRTE2_Liens_Ins_DataPrep.U_Production_Files.HG_FTCode(L.filing_type_desc);
					SELF.orig_filing_number := IF((INTEGER)R.process_date[8] in [1,3,5,7],filingString,'');   	// generate first  "16INSCT"+Counter
					SELF.case_number 				:= IF((INTEGER)R.process_date[8] in [2,4,6],filingString,'');						// fill from above if not blank
					SELF.filing_number 			:= filingString;					// fill from above if not blank (or if both this and case_number is blank)
					SELF.tmsid							:= tmsSig+':EST:'+filingString;										// string50 tmsid - recalc after altering fields
					SELF.rmsid 							:= tmsSig+'R'+filingString+filTypeCode;						// string50 rmsid - recalc after altering fields
					SELF.filing_status 			:= R.filing_status;
					SELF.filing_status_desc := R.filing_status_desc;
					SELF.process_date				:= L.orig_filing_date;
					SELF.filing_date				:= L.orig_filing_date;			// ???????????
					SELF.judge							:= 'Will Hangem High';
					// SELF.record_code 				:= ??
					// SELF.filing_jurisdiction := ??
					// SELF.filing_state 				:= ??
					// SELF.eviction 						:= ??
					// SELF.satisfaction_type		:= ??
					// SELF.satisfaction_type		:= ??
					// SELF.judg_satisfied_date := ??
					// SELF.judg_vacated_date 	:= ??
					// SELF.tax_code 						:= ??
					// SELF.effective_date			:= ??
					// SELF.lapse_date					:= ??
					// SELF.accident_date				:= ??
					// SELF.expiration_date			:= ??
					// TMSID: <source code> + <case number> + <amount> + <courtID>
					// RMSID: <source code> + <case number> + <amount> + <courtID> + <filing_type_code>
					// SatisfactionType: FULL, PARTIAL, YES, NO or VACATE
					SELF := L;
			END;


// --- PARTY FILE JOIN WITH MAIN FILE AND tmsid's, ETC ----------------------------------------------------------------------------------


END;