// PRTE2_Liens_Ins_DataPrep.U_GatherFix_BocaPRCT_Cases_TransformMain

IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins_DataPrep, address, ut;

PrimDrivers := PRTE2_X_Ins_DataCleanse.Files_Alpha.primDriverCleanDS(BocaDID <> 0);
Main1DS := PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files.Main_1_DS(DIDNew<>'0');

BocaSignificant(STRING S1) := S1[7..];
tmsIDSignificant(STRING S1) := S1[1..2];
anyNonBlank(STRING S1, STRING S2) := IF(TRIM(S1)='',S2,S1);
bestFilingString(STRING S1, STRING S2,STRING S3) := AnyNonBlank(AnyNonBlank(S1,S2),S3);
dobSignificant(STRING S1) := S1[1..6];

// Prior to despray transfer the final values replacing the old existing values.
EXPORT Main1DS U_GatherFix_BocaPRCT_Cases_TransformMain(Main1DS L, PrimDrivers R) := TRANSFORM
		origFilingNum 					:= bestFilingString(L.filing_number,L.case_number,L.orig_filing_number);	// do I need this?
		// really only need the above if we need to examine the old (IE: a state expects a specific layout for filingnumber)
		BocaDIDSig 							:= BocaSignificant((STRING)R.BocaDID);
		tmsSig 									:= tmsIDSignificant(L.tmsid);
		dobSig 									:= dobSignificant(R.dob);
		filingString 						:= BocaDIDSig+dobSig+'ICT16';
		SELF.orig_filing_number := filingString;   	// generate first  "16INSCT"+Counter
		SELF.case_number 				:= filingString;						// fill from above if not blank
		SELF.filing_number 			:= filingString;					// fill from above if not blank (or if both this and case_number is blank)
		SELF.tmsid_New					:= tmsSig+filingString;										// string50 tmsid - recalc after altering fields
		SELF.rmsid 							:= tmsSig+'R'+filingString;										// string50 rmsid - recalc after altering fields
		//TODO - Jan 2017 - noticed that CA records use CR in the rmsid, not CAR ... so we're not perfect with what we created in Dec 2016
		SELF := L;
END;
/*
*********************************** MAIN ********************************************************** 
//KEEP THESE AS-IS  (with standard date fixes as needed)
*********************************** MAIN ********************************************************** 
date_vendor_removed
record_code
filing_jurisdiction := '';
filing_state := '';
orig_filing_type := '';
orig_filing_date := '';
orig_filing_time := '';
filing_type_desc := '';
filing_date := '';
filing_time := '';
vendor_entry_date := '';
judge := '';
case_title := '';
filing_book := '';
filing_page := '';
release_date := '';
amount := '';
eviction := '';
satisifaction_type := '';
judg_satisfied_date := '';
judg_vacated_date := '';
tax_code := '';
irs_serial_number := '';
effective_date := '';
lapse_date := '';
accident_date := '';
sherrif_indc := '';
expiration_date := '';
agency :='';
agency_city :='';
agency_state :='';
agency_county :='';
legal_lot := '';
legal_block := '';
legal_borough := '';
certificate_number := '';
unsigned8 persistent_record_id :=0 ; 
dataset(layout_filing_status) filing_status;
*/
