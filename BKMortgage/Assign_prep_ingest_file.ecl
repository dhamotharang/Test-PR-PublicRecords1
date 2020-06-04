IMPORT $, MDR, PRTE2, ut, STD;

EXPORT Assign_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage.Files().Assignment_Infile;
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage.Layouts.AssignBase CleanTrimFields(ClnRawIn L) := TRANSFORM
		SELF.DATE_FIRST_SEEN						:= IF(TRIM(L.AssigRecDate) <> '', L.AssigRecDate, L.AssigEffecDate); //Use same logic as property search file
		SELF.DATE_LAST_SEEN							:= IF(TRIM(L.AssigRecDate) <> '', L.AssigRecDate, L.AssigEffecDate);
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Assignment;
		SELF.AssigDoc										:= STD.Str.FindReplace(L.AssigDoc, '#REF!','');
		SELF.OrigDOTPg									:= STD.Str.FindReplace(L.OrigDOTPg, '#VALUE!','');
		SELF.Origlenderben							:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.Origlenderben,''));
		SELF.AssignorName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.AssignorName,''));
		SELF.Assignee										:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.Assignee,''));
		SELF.BorrowerName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|`|%|\\|)',L.BorrowerName,''));
		SELF.PropertyState							:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z]',L.PropertyState,''));
		SELF.PropertyZip								:= STD.Str.CleanSpaces(REGEXREPLACE('[^0-9]',L.PropertyZip,''));
		SELF.PropertyZip4								:= STD.Str.CleanSpaces(REGEXREPLACE('[^0-9]',L.PropertyZip4,''));
		
//Clean name without extra information such as Trustee, AKA, DBA, Husband and Wife, etc. Only grabbing initial name
		TempOriglender									:= IF(STD.Str.Find(L.Origlenderben,';',1)>0, L.Origlenderben[1..STD.Str.Find(L.Origlenderben,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.Origlenderben));
		SELF.ClnOriglenderben						:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempOriglender,''));
		TempAssignor										:= IF(STD.Str.Find(L.AssignorName,';',1)>0, L.AssignorName[1..STD.Str.Find(L.AssignorName,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.AssignorName));
		SELF.ClnAssignorName						:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempAssignor,''));
		TempAssignee										:= IF(STD.Str.Find(L.Assignee,';',1)>0, L.Assignee[1..STD.Str.Find(L.Assignee,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.Assignee));
		SELF.ClnAssignee								:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempAssignee,''));
		TempBorrower										:= IF(STD.Str.Find(L.BorrowerName,';',1)>0, L.BorrowerName[1..STD.Str.Find(L.BorrowerName,';',1)-1],
																					BKMortgage.fGetName.CleanName(L.BorrowerName));
		SELF.ClnBorrowerName						:= STD.Str.CleanSpaces(REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$|(, HUSBAND AND WIFE)|WIFE|HUSBAND',TempBorrower,''));
		SELF.DBAOrigLenderBen						:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',BKMortgage.fGetName.DBAName(L.Origlenderben),''));
		SELF.DBAAssignor								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',BKMortgage.fGetName.DBAName(L.AssignorName),''));
		SELF.DBAAssignee								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',BKMortgage.fGetName.DBAName(L.Assignee),''));
		SELF := L;
		SELF := [];
 END;
 
  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out(TRIM(Origlenderben) <> '' OR TRIM(AssignorName) <> '' OR TRIM(Assignee) <> '' OR TRIM(BorrowerName) <> '');

END;