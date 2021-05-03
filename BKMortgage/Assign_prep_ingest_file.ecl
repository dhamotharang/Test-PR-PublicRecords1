IMPORT $, MDR, PRTE2, ut, STD;

EXPORT Assign_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage.Files().Assignment_Infile(TRIM(assigdoc) <> 'Document Number');
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage.Layouts.AssignBase CleanTrimFields(ClnRawIn L) := TRANSFORM
		TempAssigRecDate								:= STD.Str.CleanSpaces(REGEXREPLACE('/',IF(TRIM(L.AssigRecDate) <> '', L.AssigRecDate,L.AssigEffecDate),''));
		TempOrigContractDate						:= STD.Str.CleanSpaces(REGEXREPLACE('/',IF(TRIM(L.OrigDOTContractDate) <> '', L.OrigDOTContractDate,L.OrigDOTRecDate),''));
		IsValidAssigDate								:= STD.DATE.IsValidDate((UNSIGNED4) TempAssigRecDate);
		IsValidContractDate							:= STD.DATE.IsValidDate((UNSIGNED4) TempOrigContractDate);
		SELF.DATE_FIRST_SEEN						:= IF(IsValidContractDate AND (UNSIGNED4)TempOrigContractDate[1..2] > 18 AND 
																					(UNSIGNED4)TempOrigContractDate <	STD.Date.Today( ), TempOrigContractDate,
																					IF(IsValidAssigDate AND (UNSIGNED4)TempAssigRecDate[1..2] > 18 AND 
																						(UNSIGNED4)TempAssigRecDate <	STD.Date.Today( ), TempAssigRecDate,
																						'')); //logic matches property search file logic
		
		SELF.DATE_LAST_SEEN							:= IF(IsValidAssigDate AND (UNSIGNED4)TempAssigRecDate[1..2] > 18 AND 
																						(UNSIGNED4)TempAssigRecDate <	STD.Date.Today( ), TempAssigRecDate,
																					IF(IsValidContractDate AND (UNSIGNED4)TempOrigContractDate[1..2] > 18 AND 
																						(UNSIGNED4)TempOrigContractDate <	STD.Date.Today( ), TempOrigContractDate,
																						''));
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Assignment;
		SELF.AssigDoc										:= STD.Str.FindReplace(L.AssigDoc, '#REF!','');
		SELF.OrigDOTPg									:= STD.Str.FindReplace(L.OrigDOTPg, '#VALUE!','');
		SELF.OrigLoanAmnt								:= (STRING)(unsigned)L.OrigLoanAmnt; //remove leading zeros causing duplicates
		CleanLenderBen									:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.Origlenderben),' ');
		SELF.Origlenderben							:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanLenderBen,' '));
		CleanAssignor										:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.AssignorName),' ');
		SELF.AssignorName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanAssignor,' '));
		CleanAssignee										:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.Assignee),' ');
		SELF.Assignee										:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanAssignee,' '));
		CleanBorrower										:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.BorrowerName),' ');
		SELF.BorrowerName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanBorrower,' '));
		CleanParen											:= REGEXREPLACE('\\([A-Z]+\\)',L.PropertyFullAdd,'');
		SELF.PropertyFullAdd						:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9/&#,;@\\- ]',L.PropertyFullAdd,' '));
		TempCity												:= REGEXREPLACE('\\([A-Z]+\\)',L.PropertyCity,'');
		SELF.PropertyCity								:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9 ]',TempCity,'')); //Kept numbers because that could be a field shift. Will clean up later
		SELF.PropertyState							:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z]',L.PropertyState,''));
		SELF.PropertyZip								:= STD.Str.Filter(L.PropertyZip,'0123456789');
		SELF.PropertyZip4								:= STD.Str.Filter(L.PropertyZip4,'0123456789');
		CleanParenAssessor							:= REGEXREPLACE('\\([A-Z]+\\)',L.AssessorPropertyFullAdd,'');
		SELF.APN												:= STD.Str.CleanSpaces(REGEXREPLACE('["~|\\${}><\\^\\+\\[\\]]',L.APN,''));
		SELF.TaxAcctID									:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9/,;:\\.\\(\\)\\- ]',L.TaxAcctID,''));
		SELF.AssessorPropertyFullAdd		:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9/&#,;@\\- ]',L.AssessorPropertyFullAdd,''));
		SELF.AssessorPropertyState			:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z]',L.AssessorPropertyState,''));
		SELF.AssessorPropertyZip				:= STD.Str.Filter(L.AssessorPropertyZip,'0123456789');
		SELF.AssessorPropertyZip4				:= STD.Str.Filter(L.AssessorPropertyZip4,'0123456789');
		
//Clean name without extra information such as AKA, DBA, etc. Only grabbing initial name if names can be parsed with semicolon
		set of string MultiLender			  := STD.STr.SplitWords(SELF.Origlenderben, ';');
		TempOrigLender									:= IF(STD.Str.FindCount(SELF.Origlenderben,';')>0, MultiLender[1],SELF.Origlenderben);
		TempOrigLender2									:= BKMortgage.fGetName.NoDBAName(TempOrigLender); //parse from DBA name if available
		TempOrigDBA											:= BKMortgage.fGetName.DBAName(SELF.Origlenderben);
		TempClnOriglenderben						:= STD.Str.CleanSpaces(IF(TRIM(TempOrigLender2) = TRIM(TempOrigDBA) AND STD.Str.FindCount(SELF.Origlenderben,';')>0,
																															MultiLender[2],TempOrigLender2));
		SELF.ClnOriglenderben						:=  MAP(STD.Str.Find(TempClnOriglenderben, '(DOCUMENT ALSO )',1) > 0 => STD.Str.FindReplace(TempClnOriglenderben, '(DOCUMENT ALSO)','')
																					,STD.Str.Find(TempClnOriglenderben, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempClnOriglenderben, 'NOT PROVIDED','')
																					,STD.Str.Find(TempClnOriglenderben, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempClnOriglenderben, 'NOT AVAILABLE','')
																					,LENGTH(TRIM(TempClnOriglenderben)) = 3 AND STD.Str.Find(TempClnOriglenderben, 'N/A',1) > 0 => STD.Str.FindReplace(TempClnOriglenderben, 'N/A','')
																					,TempClnOriglenderben);

		set of string MultiAssignor		  := STD.STr.SplitWords(SELF.AssignorName, ';');
		TempAssignor										:= IF(STD.Str.FindCount(SELF.AssignorName,';')>0, MultiAssignor[1],SELF.AssignorName);
		TempAssignor2										:= BKMortgage.fGetName.NoDBAName(TempAssignor); //parse from DBA name if available
		TempAssignorDBA									:= BKMortgage.fGetName.DBAName(SELF.AssignorName);
		TempClnAssignorName							:= STD.Str.CleanSpaces(IF(TRIM(TempAssignor2) = TRIM(TempAssignorDBA) AND STD.Str.FindCount(SELF.AssignorName,';')>0,
																															MultiAssignor[2],TempAssignor2));
		SELF.ClnAssignorName						:= MAP(STD.Str.Find(TempClnAssignorName, '(DOCUMENT ALSO)',1) > 0 => STD.Str.FindReplace(TempClnAssignorName, '(DOCUMENT ALSO)','')
																					,STD.Str.Find(TempClnAssignorName, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempClnAssignorName, 'NOT PROVIDED','')
																					,STD.Str.Find(TempClnAssignorName, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempClnAssignorName, 'AVAILABLE','')
																					,LENGTH(TRIM(TempClnAssignorName)) = 3 AND STD.Str.Find(TempClnAssignorName, 'N/A',1) > 0 => STD.Str.FindReplace(TempClnAssignorName, 'N/A','')
																					,TempClnAssignorName);
																															
		set of string MultiAssignee		  := STD.STr.SplitWords(SELF.Assignee, ';');																													
		TempAssignee										:= IF(STD.Str.FindCount(SELF.Assignee,';')>0, MultiAssignor[1],SELF.Assignee);
		TempAssignee2										:= BKMortgage.fGetName.NoDBAName(TempAssignee); //parse from DBA name if available
		TempAssigneeDBA									:= BKMortgage.fGetName.DBAName(SELF.Assignee);
		TempClnAssignee									:= STD.Str.CleanSpaces(IF(TRIM(TempAssignee2) = TRIM(TempAssigneeDBA) AND STD.Str.FindCount(SELF.Assignee,';')>0,
																															MultiAssignee[2],TempAssignee2));
		SELF.ClnAssignee								:= MAP(STD.Str.Find(TempClnAssignee, '(DOCUMENT ALSO )',1) > 0 => STD.Str.FindReplace(TempClnAssignee, '(DOCUMENT ALSO)','')
																					,STD.Str.Find(TempClnAssignee, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempClnAssignee, 'NOT PROVIDED','')
																					,STD.Str.Find(TempClnAssignee, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempClnAssignee, 'NOT AVAILABLE','')
																					,LENGTH(TRIM(TempClnAssignee)) = 3 AND STD.Str.Find(TempClnAssignee, 'N/A',1) > 0 => STD.Str.FindReplace(TempClnAssignee, 'N/A','')
																					,TempClnAssignee);
		SELF.DBAOrigLenderBen						:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',TempOrigDBA,''));
		SELF.DBAAssignor								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',TempAssignorDBA,''));
		SELF.DBAAssignee								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',TempAssigneeDBA,''));
		SELF := L;
		SELF := [];
 END;
 
  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out(TRIM(Origlenderben) <> '' OR TRIM(AssignorName) <> '' OR TRIM(Assignee) <> '' OR TRIM(BorrowerName) <> '');

END;