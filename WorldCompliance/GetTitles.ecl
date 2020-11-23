import STD;

rTitleEx := RECORD
	unsigned8	id;
	boolean		isHonor;
	boolean		isDeceased;
	boolean		isRelative;
	integer		hasDate;
	string		Subcategory;
	unicode		title;
	string		date;
	string		cleaned := '';
END;
months := '(JANUARY|JAN|FEBRUARY|FEB|MARCH|MAR|APRIL|APR|MAY|JUNE|JUN|JULY|JUL|AUGUST|AUG|SEPTEMBER|SEP|OCTOBER|OCT|NOVEMBER|NOV|DECEMBER|DEC)';
rgxMY_MDY := '\\(' + months + ' *,? *\\d{4} *- *'+months+' +\\d{1,2}, *\\d{4}\\)$';
rgxMDY_MY := '\\(' + months + ' +\\d{1,2}, *\\d{4} *- *'+months+' *,? *\\d{4}\\)$';
rgxMDY_MDY := '\\(' + months + ' +\\d{1,2} *, *\\d{4} *- *'+months+' +\\d{1,2} *, *\\d{4}\\)$';
rgxMY_Y := '(\\(' + months + ' *,? +\\d{4} *- *\\d{4}\\))$';
rgxMY_MY := '\\('+months+' *,? *\\d{4} *- *' +months+' *,? *\\d{4}\\)$';
rgxY_MY := '\\(\\d{4} *- *' +months+' *,? *\\d{4}\\)$';
rgxMY_P := '(\\(' + months + ' *,? *\\d{4} *- *PRESENT\\))$';
rgxPresent := '(\\( *PRESENT *\\))$';
rgxY_MDY := '(\\(\\d{4} *- *' +months+' +\\d{1,2} *,? *\\d{4}\\))$';
rgxMDY_Y := '(\\(' + months + ' +\\d{1,2}, *\\d{4} *- *\\d{4}\\))$';
rgxMDY := '(\\(' + months + ' +\\d{1,2}, *\\d{4}\\))$';
rgxHMDY := '([,;-] *(' + months + ' +\\d{1,2} *, *\\d{4})\\.?)$';
rgxHMY := '([,;-] *(' + months + ' *,? *\\d{4}))$';
rgxHY := '([,;-] *(\\d{4}))$';
rgxDMY_DMY := '(\\(\\d{1,2} +' + months + ' +\\d{4} *- *\\d{1,2} +' + months + ' +\\d{4}\\))';

integer	CheckDate(string s) := MAP(
			REGEXFIND('\\(\\d{4} *- *\\d{4}\\)$',s,NOCASE) => 1,
			REGEXFIND('\\d{4} *- *\\d{4}$',s,NOCASE) => 2,
			REGEXFIND('\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *\\d{4} *\\)$',s,NOCASE) => 3,
			REGEXFIND('\\( *\\d{4} +- *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *\\)$',s,NOCASE) => 4,
			REGEXFIND('\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *\\)$',s,NOCASE) => 5,
			REGEXFIND('\\(\\d{4}\\)$',s) => 6,		// (ccyy)
			REGEXFIND('\\(\\d{4} *- *PRESENT\\)$',s,NOCASE) => 7,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\)$',s,NOCASE) => 8,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4}\\)$',s,NOCASE) => 9,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'\\d{4}\\)$',s,NOCASE) => 10,
			REGEXFIND('\\(\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? +\\d{4}\\)$',s,NOCASE) => 11,
			REGEXFIND(', *APPOINTED [IO]N +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}$',s,NOCASE) => 12,
			REGEXFIND(', *APPOINTED [IO]N +\\d{4}$',s,NOCASE) => 13,
			REGEXFIND(', *APPOINTED ON +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) +\\d{1,2}, * +\\d{4}$',s,NOCASE) => 14,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *PRESENT\\)$',s,NOCASE) => 15,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\)$',s,NOCASE) => 16,
			REGEXFIND(rgxY_MDY,s,NOCASE) => 17,
			REGEXFIND(rgxMDY_Y,s,NOCASE) => 18,
			REGEXFIND(rgxHMDY,s,NOCASE) => 19,
			REGEXFIND(rgxHMY,s,NOCASE) => 20,
			REGEXFIND(rgxHY,s,NOCASE) => 21,
			REGEXFIND(rgxMDY,s,NOCASE) => 22,
			REGEXFIND(rgxDMY_DMY,s,NOCASE) => 23,
			//
			REGEXFIND('\\bELECTED IN \\d{4}$',s,NOCASE) => 30,
			REGEXFIND(rgxMY_P,s,NOCASE) => 31,
			REGEXFIND(rgxPresent,s,NOCASE) => 32,
			// Spanish
			REGEXFIND('\\(ELIGIO EL \\d{4} DE OCTUBRE\\)$',s,NOCASE) => 35,
			0);
			
string GetDate(string s, integer n) := 
		TRIM(STD.Str.filterout(
		CASE(n,
			1 => REGEXFIND('(\\(\\d{4} *- *\\d{4}\\)$)',s,1,NOCASE),
			2 => REGEXFIND('(\\d{4} *- *\\d{4})$',s, 1,NOCASE),
			3 => REGEXFIND('(\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *\\d{4} *\\))$',s,1,NOCASE),
			4 => REGEXFIND('(\\( *\\d{4} +- *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *\\))$',s,1,NOCASE),
			5 => REGEXFIND('(\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *\\))$',s,1,NOCASE),
			6 => REGEXFIND('(\\(\\d{4}\\))$',s,1),		// (ccyy)
			7 => REGEXFIND('(\\(\\d{4} *- *PRESENT\\))$',s,1,NOCASE),
			8 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\))$',s,1,NOCASE),
			9 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4}\\))$',s,1,NOCASE),
			10 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'\\d{4}\\))$',s,1,NOCASE),
			11 => REGEXFIND('(\\(\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? +\\d{4}\\))$',s,1,NOCASE),
			12 => REGEXFIND(', *(APPOINTED [IO]N +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4})$',s,1,NOCASE),
			13 => REGEXFIND(', *(APPOINTED [IO]N +\\d{4})$',s,1,NOCASE),
			14 => REGEXFIND(', *(APPOINTED ON +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) +\\d{1,2}, * +\\d{4})$',s,1,NOCASE),
			15 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *PRESENT\\))$',s,1,NOCASE),
			16 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\))$',s,1,NOCASE),
			17 => REGEXFIND(rgxY_MDY,s, 1,NOCASE),
			18 => REGEXFIND(rgxMDY_Y,s, 1,NOCASE),
			19 => REGEXFIND(rgxHMDY,s, 2,NOCASE),
			20 => REGEXFIND(rgxHMY,s, 2,NOCASE),
			21 => REGEXFIND(rgxHY,s, 2,NOCASE),
			22 => REGEXFIND(rgxMDY,s, 1,NOCASE),
			23 => REGEXFIND(rgxDMY_DMY,s, 1,NOCASE),
			//
			30 => REGEXFIND('\\b(ELECTED IN \\d{4})$',s,1,NOCASE),
			31 => REGEXFIND(rgxMY_P,s,1,NOCASE),
			32 => REGEXFIND(rgxPresent,s,1,NOCASE),
			// Spanish
			35 => REGEXFIND('(\\(ELIGIO EL \\d{4} DE OCTUBRE\\))$',s,1,NOCASE),
			''),'()'),LEFT,RIGHT);
			
string RemoveDate(string s, integer n) := 
		TRIM(STD.Str.filterout(
		CASE(n,
			1 => REGEXReplace('(\\(\\d{4} *- *\\d{4}\\)$)',s,'',NOCASE),
			2 => REGEXReplace('(\\d{4} *- *\\d{4})$',s, '',NOCASE),
			3 => REGEXReplace('(\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *\\d{4} *\\))$',s,'',NOCASE),
			4 => REGEXReplace('(\\( *\\d{4} +- *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\) *)$',s,'',NOCASE),
			5 => REGEXReplace('(\\( *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2} *, *\\d{4} *\\))$',s,'',NOCASE),
			6 => REGEXReplace('(\\(\\d{4}\\))$',s,''),		// (ccyy)
			7 => REGEXReplace('(\\(\\d{4} *- *PRESENT\\))$',s,'',NOCASE),
			8 => REGEXReplace('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\))$',s,'',NOCASE),
			9 => REGEXReplace('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? *\\d{4}\\))$',s,'',NOCASE),
			10 => REGEXReplace('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'\\d{4}\\))$',s,''),
			11 => REGEXReplace('(\\(\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) *,? +\\d{4}\\))$',s,'',NOCASE),
			12 => REGEXReplace(', *(APPOINTED [IO]N +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4})$',s,'',NOCASE),
			13 => REGEXReplace(', *(APPOINTED [IO]N +\\d{4})$',s,'',NOCASE),
			14 => REGEXReplace(', *(APPOINTED ON +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) +\\d{1,2}, * +\\d{4})$',s,'',NOCASE),
			15 => REGEXReplace('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *PRESENT\\))$',s,'',NOCASE),
			16 => REGEXReplace('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\))$',s,'',NOCASE),
			17 => REGEXReplace(rgxY_MDY,s, '',NOCASE),
			18 => REGEXReplace(rgxMDY_Y,s, '',NOCASE),
			19 => REGEXReplace(rgxHMDY,s, '',NOCASE),
			20 => REGEXReplace(rgxHMY,s, '',NOCASE),
			21 => REGEXReplace(rgxHY,s, '',NOCASE),
			22 => REGEXReplace(rgxMDY,s, '',NOCASE),
			23 => REGEXReplace(rgxDMY_DMY,s,'',NOCASE),
			//
			30 => REGEXReplace('\\b(ELECTED IN \\d{4})$',s,'',NOCASE),
			31 => REGEXReplace(rgxMY_P,s,'',NOCASE),
			32 => REGEXReplace(rgxPresent,s,'',NOCASE),
			// Spanish
			35 => REGEXReplace('(\\(ELIGIO EL \\d{4} DE OCTUBRE\\))$',s,'',NOCASE),
			s),'()'),LEFT,RIGHT);
			
honors := ['DR.','DR','MR.','MR','MRS.','MS.','MS','SIR','SIR.',
						'HIS EXCELLENCY', 'HON.','HON. MR.','HONORABLE','RT HON','SENATOR',
						'PROF','PROF.',
					/* NOBILITY */ 'KING','PRINCE','BARON','BARONESS','VISCOUNT','H.E.','EARL','LORD',
					/* ME */		'SHEIKH','MULLAH','MAULAVI','MAULAWI','HAJI','ALHAJ',
					/* Military */		'GENERAL','GEN','GEN.','LT. GEN.','ADMIRAL','BRIGADIER','CDR','CDR.','LT COL','LTC','COLONEL','COL','COL.','MAJOR','MAJ','MAJ.',
																'CAPTAIN','CAPT','CAPT.','LIEUTENANT','LT','LT.','LTC','LTC.','SERGEANT','SGT','SGT.','CPL','CPL.','CPRL.','PFC','PFC.'];					
					
boolean CheckDeceased(unicode s) := REGEXFIND(U'^(DECEASED|Deceased) +' ,s) OR 
			REGEXFIND(U'\\DECEASED (IN|ON|-) +',s,NOCASE);

boolean CheckRelative(string s) := 
			REGEXFIND('^(HUSBAND|WIFE|EX-HUSBAND|EX-WIFE|SPOUSE|WIDOW|SON|DAUGHTER|BROTHER|SISTER|STEPSON|STEP SON|STEPDAUGHTER|STEP DAUGHTER) +OF +',s,nocase);

string UniToAscii(unicode s) := (string)REGEXREPLACE(U'\\p{Dash_Punctuation}',s,'-');

EXPORT GetTitles(dataset(Layouts.rEntity) infile) := 
					PROJECT(infile, TRANSFORM(rtitleEx,
														title := UniToAscii(LEFT.Positions);
														SELF.id := LEFT.Ent_id;
														self.isHonor := title in honors;
														self.isDeceased := CheckDeceased(LEFT.Positions) OR CheckDeceased(LEFT.remarks)
																										OR CheckDeceased(LEFT.DOB);
														self.isRelative := CheckRelative(title);
														datetype := CheckDate(title);
														self.hasDate := datetype;
														self.Subcategory := LEFT.EntrySubcategory;
														SELF.title := LEFT.Positions;
														self.date := GetDate(title,datetype);
														self.cleaned := RemoveDate(title,datetype);));
