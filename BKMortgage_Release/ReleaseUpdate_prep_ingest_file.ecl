IMPORT $, BKMortgage_Assignment, MDR, PRTE2, ut, STD;

EXPORT ReleaseUpdate_prep_ingest_file	:= FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage_Release.Files().Release_Update;
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage_Release.Layouts.base CleanTrimFields(ClnRawIn L) := TRANSFORM
		SELF.DATE_FIRST_SEEN						:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN							:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Release_Update;
		SELF.OrigLenderBen							:= REGEXREPLACE('^(""|`|%|\\|)',L.OrigLenderBen,'');
		SELF.CurrentLenderBen						:= REGEXREPLACE('^(""|`|%|\\|)',L.CurrentLenderBen,'');
		SELF.BorrowerName								:= REGEXREPLACE('^(""|`|%|\\|)',L.BorrowerName,'');
//Clean name without extra information such as Trustee, AKA, DBA, Husband and Wife, etc. Only grabbing initial name
		TempOriglender									:= IF(STD.Str.Find(L.OrigLenderBen,';',1)>0, L.OrigLenderBen[1..STD.Str.Find(L.OrigLenderBen,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.OrigLenderBen));
		SELF.ClnLenderBen								:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempOriglender,'');
		TempCurrLender									:= IF(STD.Str.Find(L.CurrentLenderBen,';',1)>0, L.CurrentLenderBen[1..STD.Str.Find(L.CurrentLenderBen,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.CurrentLenderBen));
		SELF.ClnCurrentLenderBen				:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempCurrLender,'');
		TempBorrower										:= IF(STD.Str.Find(L.BorrowerName,';',1)>0, L.BorrowerName[1..STD.Str.Find(L.BorrowerName,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.BorrowerName));
		SELF.ClnBorrowerName						:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempBorrower,'');
		SELF	:= L;
		SELF	:= [];
	END;
	
	  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out;

END;