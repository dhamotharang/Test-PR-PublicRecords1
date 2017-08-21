
rTitleEx := RECORD
	string		id;
	boolean		isHonor;
	boolean		isDeceased;
	boolean		isRelative;
	integer		hasDate;
	string		title;
	string		date;
	string		sansdate := '';
END;
months := '(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)';
rgxMY_MDY := '\\(' + months + ' *,? *\\d{4} *- *'+months+' +\\d{1,2}, *\\d{4}\\)$';
rgxMDY_MY := '\\(' + months + ' +\\d{1,2}, *\\d{4} *- *'+months+' *,? *\\d{4}\\)$';
rgxMDY_MDY := '\\(' + months + ' +\\d{1,2}, *\\d{4} *- *'+months+' +\\d{1,2} *, *\\d{4}\\)$';
rgxMY_Y := '(\\(' + months + ' *,? +\\d{4} *- *\\d{4}\\))$';
rgxMY_MY := '\\('+months+' *,? *\\d{4} *- *' +months+' *,? *\\d{4}\\)$';
rgxY_MY := '\\(\\d{4} *- *' +months+' *,? *\\d{4}\\)$';
rgxMY_P := '(\\(' + months + ' *,? *\\d{4} *- *PRESENT\\))$';
rgxPresent := '(\\( *PRESENT *\\))$';

integer	CheckDate(string s) := MAP(
			REGEXFIND('\\(\\d{4} *- *\\d{4}\\)$',s) => 1,
			REGEXFIND('\\d{4} *- *\\d{4}$',s) => 2,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *\\d{4}\\)$',s) => 3,
			REGEXFIND('\\(\\d{4} +- *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\)$',s) => 4,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\)$',s) => 5,
			REGEXFIND('\\(\\d{4}\\)$',s) => 6,		// (ccyy)
			REGEXFIND('\\(\\d{4} *- *PRESENT\\)$',s) => 7,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\)$',s) => 8,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\)$',s) => 9,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'\\d{4}\\)$',s) => 10,
			REGEXFIND('\\(\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\)$',s) => 11,
			REGEXFIND(', *APPOINTED IN +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}$',s) => 12,
			REGEXFIND(', *APPOINTED IN +\\d{4}$',s) => 13,
			REGEXFIND(', *APPOINTED ON +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) +\\d{1,2}, * +\\d{4}$',s) => 14,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *PRESENT\\)$',s) => 15,
			REGEXFIND('\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\)$',s) => 16,
			REGEXFIND(rgxMY_P,s) => 17,
			REGEXFIND(rgxPresent,s) => 18,
			//
			REGEXFIND('\\bELECTED IN \\d{4}$',s) => 20,
			// Spanish
			REGEXFIND('\\(ELIGIO EL \\d{4} DE OCTUBRE\\)$',s) => 25,
			0);
			
string GetDate(string s, integer n) := 
		TRIM(stringlib.stringfilterout(
		CASE(n,
			1 => REGEXFIND('(\\(\\d{4} *- *\\d{4}\\)$)',s,1),
			2 => REGEXFIND('(\\d{4} *- *\\d{4})$',s, 1),
			3 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *\\d{4}\\))$',s,1),
			4 => REGEXFIND('(\\(\\d{4} +- *(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\))$',s,1),
			5 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\))$',s,1),
			6 => REGEXFIND('(\\(\\d{4}\\))$',s,1),		// (ccyy)
			7 => REGEXFIND('(\\(\\d{4} *- *PRESENT\\))$',s,1),
			8 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\))$',s,1),
			9 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\))$',s,1),
			10 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4} *- *' +
									'\\d{4}\\))$',s,1),
			11 => REGEXFIND('(\\(\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4}\\))$',s,1),
			12 => REGEXFIND(', *(APPOINTED IN +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? +\\d{4})$',s,1),
			13 => REGEXFIND(', *(APPOINTED IN +\\d{4})$',s,1),
			14 => REGEXFIND(', *(APPOINTED ON +(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) +\\d{1,2}, * +\\d{4})$',s,1),
			15 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4} *- *PRESENT\\))$',s,1),
			16 => REGEXFIND('(\\((JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER),? *\\d{4} *- *' +
									'(JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER) \\d{1,2}, *\\d{4}\\))$',s,1),
			17 => REGEXFIND(rgxMY_P,s,1),
			18 => REGEXFIND(rgxPresent,s,1),
			//
			20 => REGEXFIND('\\b(ELECTED IN \\d{4})$',s,1),
			// Spanish
			25 => REGEXFIND('(\\(ELIGIO EL \\d{4} DE OCTUBRE\\))$',s,1),
			''),'()'),LEFT,RIGHT);
			
honors := ['DR.','DR','MR.','MR','MRS.','MS.','SIR','SIR.',
						'HIS EXCELLENCY', 'HON.','HON. MR.','HONORABLE','RT HON','SENATOR',
						'PROF','PROF.',
					/* NOBILITY */ 'KING','PRINCE','BARON','BARONESS','VISCOUNT','H.E.','EARL','LORD',
					/* ME */		'SHEIKH','MULLAH','MAULAVI','MAULAWI','HAJI','ALHAJ',
					/* Military */		'GENERAL','GEN.','LT. GEN.','BRIGADIER','LT COL','COLONEL','CAPT','CAPT.'];					
					
boolean CheckDeceased(string s) := s = 'DECEASED' OR
			REGEXFIND('^DECEASED (IN|ON|-) +',s,NOCASE);

boolean CheckRelative(string s) := 
			REGEXFIND('^(HUSBAND|WIFE|EX-HUSBAND|EX-WIFE|SPOUSE|WIDOW|SON|DAUGHTER|BROTHER|SISTER|STEPSON|STEP SON|STEPDAUGHTER|STEP DAUGHTER) +OF +',s,nocase);



EXPORT GetTitles(dataset(Layouts.input.rEntity) infile) := 
					NORMALIZE(infile, LEFT.titles, TRANSFORM(rtitleEx,
														SELF.id := LEFT.id;
														self.isHonor := RIGHT.title in honors;
														self.isDeceased := CheckDeceased(RIGHT.title);
														self.isRelative := CheckRelative(RIGHT.title);
														datetype := CheckDate(RIGHT.title);
														self.hasDate := datetype;
														SELF.title := RIGHT.title;
														self.date := GetDate(RIGHT.title,datetype)));
