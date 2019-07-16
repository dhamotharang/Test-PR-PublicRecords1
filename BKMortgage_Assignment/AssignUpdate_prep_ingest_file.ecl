IMPORT $, MDR, PRTE2, ut, STD;

EXPORT AssignUpdate_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage_Assignment.Files().Assignment_Update;
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage_Assignment.Layouts.base CleanTrimFields(ClnRawIn L) := TRANSFORM
		SELF.DATE_FIRST_SEEN						:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN							:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Assignment_Update;
		SELF.AssigDoc										:= STD.Str.FindReplace(L.AssigDoc, '#REF!','');
		SELF.OrigDOTPg									:= STD.Str.FindReplace(L.OrigDOTPg, '#VALUE!','');
		SELF.Origlenderben							:= REGEXREPLACE('^(""|`|%|\\|)',L.Origlenderben,'');
		SELF.AssignorName								:= REGEXREPLACE('^(""|`|%|\\|)',L.AssignorName,'');
		SELF.Assignee										:= REGEXREPLACE('^(""|`|%|\\|)',L.Assignee,'');
		SELF.BorrowerName								:= REGEXREPLACE('^(""|`|%|\\|)',L.BorrowerName,'');
		SELF.PropertyState							:= REGEXREPLACE('[^A-Z]',L.PropertyState,'');
		SELF.PropertyZip								:= REGEXREPLACE('[^0-9]',L.PropertyZip,'');
		SELF.PropertyZip4								:= REGEXREPLACE('[^0-9]',L.PropertyZip4,'');
		
//Clean name without extra information such as Trustee, AKA, DBA, Husband and Wife, etc. Only grabbing initial name
		TempOriglender									:= IF(STD.Str.Find(L.Origlenderben,';',1)>0, L.Origlenderben[1..STD.Str.Find(L.Origlenderben,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.Origlenderben));
		SELF.ClnOriglenderben						:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempOriglender,'');
		TempAssignor										:= IF(STD.Str.Find(L.AssignorName,';',1)>0, L.AssignorName[1..STD.Str.Find(L.AssignorName,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.AssignorName));
		SELF.ClnAssignorName						:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempAssignor,'');
		TempAssignee										:= IF(STD.Str.Find(L.Assignee,';',1)>0, L.Assignee[1..STD.Str.Find(L.Assignee,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.Assignee));
		SELF.ClnAssignee								:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempAssignee,'');
		TempBorrower										:= IF(STD.Str.Find(L.BorrowerName,';',1)>0, L.BorrowerName[1..STD.Str.Find(L.BorrowerName,';',1)-1],
																					BKMortgage_Assignment.fGetName.CleanName(L.BorrowerName));
		SELF.ClnBorrowerName						:= REGEXREPLACE('( AS)$|(, AND)$|(, AS)$|(, NOT)$|(, ([\\(]*)SOLELY)$|( SOLELY)$|( SOLOELY)$',TempBorrower,'');
		SELF := L;
		SELF := [];
 END;
 
  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out;

END;
