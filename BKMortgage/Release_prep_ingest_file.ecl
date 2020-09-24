IMPORT $, MDR, PRTE2, ut, STD;

EXPORT Release_prep_ingest_file := FUNCTION

  //Project to base layout for ingest
	fIn_Raw   := BKMortgage.Files().Release_Infile;
	
	prte2.CleanFields(fIn_Raw, ClnRawIn); //using PRTE2 clean function as it cleans unprintable characters and uppercases output
	
	BKMortgage.Layouts.ReleaseBase CleanTrimFields(ClnRawIn L) := TRANSFORM
		TempReleaseRecDate							:= STD.Str.CleanSpaces(REGEXREPLACE('/',IF(TRIM(L.ReleaseRecDate) <> '', L.ReleaseRecDate,L.ReleaseRecDate),''));
		TempOrigContractDate						:= STD.Str.CleanSpaces(REGEXREPLACE('/',IF(TRIM(L.OrigDOTContractDate) <> '', L.OrigDOTContractDate,L.OrigDOTRecDate),''));
		IsValidReleaseDate							:= STD.DATE.IsValidDate((UNSIGNED4) TempReleaseRecDate);
		IsValidContractDate							:= STD.DATE.IsValidDate((UNSIGNED4) TempOrigContractDate);
		SELF.DATE_FIRST_SEEN						:= IF(IsValidContractDate AND (UNSIGNED4)TempOrigContractDate[1..2] > 18 AND 
																					(UNSIGNED4)TempOrigContractDate <	STD.Date.Today( ), TempOrigContractDate,
																					IF(IsValidReleaseDate AND (UNSIGNED4)TempReleaseRecDate[1..2] > 18 AND 
																						(UNSIGNED4)TempReleaseRecDate <	STD.Date.Today( ), TempReleaseRecDate,
																						'')); //logic matches property search file logic

		SELF.DATE_LAST_SEEN							:= IF(IsValidReleaseDate AND (UNSIGNED4)TempReleaseRecDate[1..2] > 18 AND 
																						(UNSIGNED4)TempReleaseRecDate <	STD.Date.Today( ), TempReleaseRecDate,
																					IF(IsValidContractDate AND (UNSIGNED4)TempOrigContractDate[1..2] > 18 AND 
																						(UNSIGNED4)TempOrigContractDate <	STD.Date.Today( ), TempOrigContractDate,
																						''));
		SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
		SELF.PROCESS_DATE						 		:= thorlib.wuid()[2..9];
		SELF.SOURCE  									 	:= mdr.sourceTools.src_BKFS_Release;
		SELF.OrigLoanAmnt								:= (STRING)(unsigned)L.OrigLoanAmnt; //remove leading zeros causing duplicates
		CleanOrigLenderBen							:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.OrigLenderBen),' ');
		SELF.OrigLenderBen							:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanOrigLenderBen,' '));
		CleanCurrLenderBen							:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.CurrentLenderBen),' ');
		SELF.CurrentLenderBen						:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanCurrLenderBen,' '));
		CleanBorrower										:= REGEXREPLACE('(~|\\^|\\{|\\}|\\|)',BKMortgage.fGetName.RmvBracket(L.BorrowerName),' ');
		SELF.BorrowerName								:= STD.Str.CleanSpaces(REGEXREPLACE('^(""|[`]+|%|\\||!|_|&)',CleanBorrower,' '));
		TempBorrowAddr									:= REGEXREPLACE('\\([A-Z]+\\)',L.BorrMailFullAddress,'');
		SELF.BorrMailFullAddress				:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9&/#,;@\\- ]',L.BorrMailFullAddress,''));
		SELF.BorrMailUnit								:= STD.Str.CleanSpaces(REGEXREPLACE('[!~\\|\\$\\[\\]@"]',L.BorrMailUnit,''));
		SELF.BorrMailCity								:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9 ]',L.BorrMailCity,'')); //Kept numbers because that could be a field shift. Will clean up later
		SELF.BorrMailState							:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9 ]',L.BorrMailState,'')); //Contains foreign addresses
		SELF.BorrMailZip								:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9]',L.BorrMailZip,''));
		SELF.BorrMailZip4								:= STD.Str.Filter(L.BorrMailZip4,'0123456789');
		SELF.APN												:= STD.Str.CleanSpaces(REGEXREPLACE('["~|\\${}><\\^\\+\\[\\]]',L.APN,''));
		SELF.TaxAcctID									:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9/,;:\\.\\(\\)\\- ]',L.TaxAcctID,''));
		TempPropertyAddr								:= REGEXREPLACE('\\([A-Z]+\\)',L.PropertyFullAdd,'');
		SELF.PropertyFullAdd						:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9&#,;-@/ ]',L.PropertyFullAdd,''));
		SELF.PropertyUnit								:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9/#\\.\\- ]',L.PropertyUnit,''));
		SELF.PropertyCity								:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9 ]',L.PropertyCity,''));
		SELF.PropertyState							:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z]',L.PropertyState,''));
		SELF.PropertyZip								:= STD.Str.Filter(L.PropertyZip,'0123456789');
		SELF.PropertyZip4								:= STD.Str.Filter(L.PropertyZip4,'0123456789');
		TempAssessorAddr								:= REGEXREPLACE('\\([A-Z]+\\)',L.AssessorPropertyFullAdd,'');
		SELF.AssessorPropertyFullAdd		:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9& ]',L.AssessorPropertyFullAdd,''));
		SELF.AssessorPropertyCity				:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z0-9 ]',L.AssessorPropertyCity,''));
		SELF.AssessorPropertyState			:= STD.Str.CleanSpaces(REGEXREPLACE('[^A-Z]',L.AssessorPropertyState,''));
		SELF.AssessorPropertyZip				:= STD.Str.Filter(L.AssessorPropertyZip,'0123456789');
		SELF.AssessorPropertyZip4				:= STD.Str.Filter(L.AssessorPropertyZip4,'0123456789');
//Clean name without extra information such as AKA, DBA, etc. Only grabbing initial name if names can be parsed with semicolon
		set of string MultiLender			  := STD.STr.SplitWords(SELF.Origlenderben, ';');
		TempOriglender									:= IF(STD.Str.FindCount(SELF.Origlenderben,';')>0, MultiLender[1],SELF.Origlenderben);
		TempOrigLender2									:= BKMortgage.fGetName.NoDBAName(TempOrigLender); //parse from DBA name if available
		TempOrigDBA											:= BKMortgage.fGetName.DBAName(SELF.Origlenderben);
		TempClnLenderBen								:= STD.Str.CleanSpaces(IF(TRIM(TempOrigLender2) = TRIM(TempOrigDBA) AND STD.Str.FindCount(SELF.Origlenderben,';')>0,
																															MultiLender[2],TempOrigLender2));
		SELF.ClnLenderBen								:= MAP(STD.Str.Find(TempClnLenderBen, '(DOCUMENT ALSO )',1) > 0 => STD.Str.FindReplace(TempClnLenderBen, '(DOCUMENT ALSO)','')
																					,STD.Str.Find(TempClnLenderBen, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempClnLenderBen, 'NOT PROVIDED','')
																					,STD.Str.Find(TempClnLenderBen, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempClnLenderBen, 'NOT AVAILABLE','')
																					,LENGTH(TRIM(TempClnLenderBen)) = 3 AND STD.Str.Find(TempClnLenderBen, 'N/A',1) > 0 => STD.Str.FindReplace(TempClnLenderBen, 'N/A','')
																					,TempClnLenderBen);
																															
		set of string MultiLender2		  := STD.STr.SplitWords(SELF.CurrentLenderBen, ';');
		TempCurrLender									:= IF(STD.Str.FindCount(SELF.CurrentLenderBen,';')>0, MultiLender2[1],SELF.CurrentLenderBen);
		TempCurrLender2									:= BKMortgage.fGetName.NoDBAName(TempCurrLender); //parse from DBA name if available
		TempCurrDBA											:= BKMortgage.fGetName.DBAName(SELF.CurrentLenderBen);
		TempCurrLenderBen								:= STD.Str.CleanSpaces(IF(TRIM(TempCurrLender2) = TRIM(TempCurrDBA) AND STD.Str.FindCount(SELF.CurrentLenderBen,';')>0,
																															MultiLender[2],TempCurrLender2));
		SELF.ClnCurrentLenderBen				:= MAP(STD.Str.Find(TempCurrLenderBen, '(DOCUMENT ALSO )',1) > 0 => STD.Str.FindReplace(TempCurrLenderBen, '(DOCUMENT ALSO)','')
																					,STD.Str.Find(TempCurrLenderBen, 'NOT PROVIDED',1) > 0 => STD.Str.FindReplace(TempCurrLenderBen, 'NOT PROVIDED','')
																					,STD.Str.Find(TempCurrLenderBen, 'NOT AVAILABLE',1) > 0 => STD.Str.FindReplace(TempCurrLenderBen, 'AVAILABLE','')
																					,LENGTH(TRIM(TempCurrLenderBen)) = 3 AND STD.Str.Find(TempCurrLenderBen, 'N/A',1) > 0 => STD.Str.FindReplace(TempCurrLenderBen, 'N/A','')
																					,TempCurrLenderBen);
																															
		SELF.DBALenderBen								:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',TempOrigDBA,''));
		SELF.DBACurrentLenderBen				:= STD.Str.CleanSpaces(REGEXREPLACE('^[^A-Z0-9]',TempCurrDBA,''));
		SELF	:= L;
		SELF	:= [];
	END;
	
	  Clean_out := project(ClnRawIn,CleanTrimFields(LEFT));
 
RETURN Clean_out(TRIM(OrigLenderBen) <> '' OR TRIM(CurrentLenderBen) <> '' OR TRIM(BorrowerName) <> '');

END;