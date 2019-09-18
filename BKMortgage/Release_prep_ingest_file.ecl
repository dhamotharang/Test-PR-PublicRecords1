IMPORT $, MDR, PRTE2, ut, STD;

EXPORT Release_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage.Files().Release_Infile;
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage.Layouts.ReleaseBase CleanTrimFields(ClnRawIn L) := TRANSFORM
		SELF.DATE_FIRST_SEEN						:= IF(TRIM(L.ReleaseRecDate) <> '', L.ReleaseRecDate, L.ReleaseEffecDate); //logic matches property search file logic
		SELF.DATE_LAST_SEEN							:= IF(TRIM(L.ReleaseRecDate) <> '', L.ReleaseRecDate, L.ReleaseEffecDate);
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Release;
		SELF.OrigLenderBen							:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.OrigLenderBen,''));
		SELF.CurrentLenderBen						:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.CurrentLenderBen,''));
		SELF.BorrowerName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.BorrowerName,''));
//Clean name without extra information such as Trustee, AKA, DBA, Husband and Wife, etc. Only grabbing initial name
		TempOriglender									:= IF(STD.Str.Find(L.OrigLenderBen,';',1)>0, L.OrigLenderBen[1..STD.Str.Find(L.OrigLenderBen,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.OrigLenderBen));
		SELF.ClnLenderBen								:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempOriglender,''));
		TempCurrLender									:= IF(STD.Str.Find(L.CurrentLenderBen,';',1)>0, L.CurrentLenderBen[1..STD.Str.Find(L.CurrentLenderBen,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.CurrentLenderBen));
		SELF.ClnCurrentLenderBen				:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempCurrLender,''));
		TempBorrower										:= IF(STD.Str.Find(L.BorrowerName,';',1)>0, L.BorrowerName[1..STD.Str.Find(L.BorrowerName,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.BorrowerName));
		SELF.ClnBorrowerName						:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$|(, HUSBAND AND WIFE)|WIFE|HUSBAND',TempBorrower,''));
		SELF.DBALenderBen								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',BKMortgage.fGetName.DBAName(L.OrigLenderBen),''));
		SELF.DBACurrentLenderBen				:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',BKMortgage.fGetName.DBAName(L.CurrentLenderBen),''));
		SELF	:= L;
		SELF	:= [];
	END;
	
	  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out(TRIM(OrigLenderBen) <> '' OR TRIM(CurrentLenderBen) <> '' OR TRIM(BorrowerName) <> '');

END;