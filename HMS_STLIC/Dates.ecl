IMPORT ut,STD;
EXPORT Dates := MODULE

	string FixMonth(string s) := FUNCTION
		inmon := REGEXFIND('\\d+ +([A-Z.]+) +\\d+',s,1,NOCASE);
		outmon := CASE(stringlib.stringtolowercase(inmon),
			'janvier' => 'January',
			'fevrier' => 'February',
			'fÃƒÂ©vrier' => 'February',
			'mars' => 'March',
			'avril' => 'April',
			'mai' => 'May',
			'juin' => 'June',
			'juillet' => 'July',
			'aout' => 'August',
			'aoÃƒÂ»t' => 'August',
			'septembre' => 'September',
			'octobre' => 'October',
			'novembre' => 'November',
			'decembre' => 'December',
			'dÃƒÂ©cembre' => 'December',
			'');

		return if(outmon='',s,
				StringLib.StringFindReplace(s,' '+inmon+' ',' '+outmon+' '));
	END;

	GetCentury(string pDateIn) := FUNCTION
		year := (integer)REGEXFIND('/([0-9]+)$', pDateIn, 1);
		return 
			IF(year < 20,'20','19');
	END;

	CorrectCentury(string pDateIn) :=
		IF(REGEXFIND('/([0-9]+)$', pDateIn, 1) = '200',pDateIn + '0',pDateIn);


	FixSlashCentury(string pDateIn) := 
		MAP(
			REGEXFIND('^\\d{4}/',pDateIn) => pDateIn,		// this is year/m/d
			REGEXFIND('/\\d{1}$',pDateIn) => 
				REGEXREPLACE('/(\\d{1})$',pDateIn,'/'+GetCentury(pDateIn)+'0$1'),
			REGEXFIND('/\\d{2}$',pDateIn) => 
				REGEXREPLACE('/(\\d{2})$',pDateIn,'/'+GetCentury(pDateIn)+'$1'),
			pDateIn);
			
	string CheckLeapYear(string pDateIn, integer2 year) :=
		IF(ut.LeapYear(year),pDateIn,
			IF(REGEXFIND('^(\\d{1,2})/',pDateIn,1) in ['02','2',' 2'] AND
				REGEXFIND('/(\\d{1,2})/',pDateIn,1) = '29', '', pDateIn));
			
	string SanityCheck(string pDateIn) := FUNCTION
		year := (integer2)REGEXFIND('/([0-9]+)$', pDateIn, 1);
		return 
			IF(year < 1900,'',CheckLeapYear(pDateIn,year));
	END;
			
	EXPORT string CvtDate(string s1, varstring fmtout = '%m/%d/%Y', boolean doCheck = true) := FUNCTION
		fmts := [
			'%m/%d/%Y',
			'%d %B %Y',
			'%d %b %Y',
			'%d %b. %Y',
			'%d.%m.%Y',
			'%Y-%m-%d',
			'%Y/%m/%d',
			'%m-%d-%Y',
			'%B %d, %Y',
			'%b %d, %Y',
			'%b, %d, %Y',
			'%B. %d, %Y',
			'%d-%B-%Y',
			'%B %Y',
			'%B. %Y',
			'%B, %Y'
			];
		s2 := REGEXREPLACE('^(1 ?er) ',s1,'1 ',NOCASE);
		s := MAP(
			REGEXFIND('\\bSEPT\\b', s1, NOCASE) => 			// Linux does not handle SEPT as abbreviation
				REGEXREPLACE('\\b(SEPT)\\b',s1,'SEP',NOCASE),
			REGEXFIND('[0-9]+ +[A-Z.]+ +[0-9]+',s2,NOCASE) =>		// see if date is in French or needs correction
				FixMonth(s2),
			s1);
		// dt := ut.ConvertDateMultiple(FixSlashCentury(s), fmts, fmtout);
		dt := Std.Date.ConvertDateFormatMultiple(FixSlashCentury(s), fmts, fmtout);
		return dt;
		//return IF(dt='','',
		//			if(doCheck,SanityCheck(FixSlashCentury(dt)),dt));
	END;

	EXPORT boolean ChkDtStr(string s) := function
		pats := REGEXFIND('^(.*)/(.*)/(.*)$', s, 0);
		patd := REGEXFIND('^(.*)-(.*)-(.*)$', s, 0);
		patp := REGEXFIND('^(.*) (.*) (.*)$', s, 0);
		patx := REGEXFIND('^(.*) (.*) (.*) (.*)$', s, 0);
		return if(pats = '' and patd = '' and patp = '' and patx = '',false,true);
	end;

	string FixMonthName(string s,string rgx = '^(.*)/(.*)/(.*)$') := FUNCTION
			inmonname := REGEXFIND(rgx,s,1);
			outmondig := CASE(trim(stringlib.stringtolowercase(inmonname),left,right),
				'jan' => '01',
				'feb' => '02',
				'mar' => '03',
				'apr' => '04',
				'may' => '05',
				'jun' => '06',
				'jul' => '07',
				'aug' => '08',
				'sep' => '09',
				'oct' => '10',
				'nov' => '11',
				'dec' => '12',
				'00');
		 
			return if(outmondig='',s,
					REGEXREPLACE(inmonname,s,outmondig,NOCASE) 
					);
	END;
		 
	string CleanDtNm(string s,string daynm) := function
					st := REGEXREPLACE(daynm,s,'',NOCASE);
					return if(REGEXFIND('^(.*) (.*) (.*)$', st, 0) <> '',REGEXREPLACE(' ',trim(st,left,right),'/'),st);
	end;
	
	STRING RemoveTimeStamp(string s) := FUNCTION
							
							searchpattern := '^(.*):(.*):(.*) (AM|PM|EDT|EST|PDT|PST)';
							patStart := REGEXFIND(searchpattern,s,1);
							patEnd := REGEXFIND(searchpattern,s,0);
							f := REGEXREPLACE(s[(length(patStart)-1)..(length(patEnd))], s, '', NOCASE);
      						
					return f;
	END;
	
	EXPORT string PrepDtStr(string str) := function
			s := StringLib.StringCleanSpaces(RemoveTimeStamp(str));
			daynm := ['sun','mon','tue','wed','thu','fri','sat'];
			pat := REGEXFIND('^(.*) (.*) (.*) (.*)$', s, 1);
			patn := REGEXFIND('^(.*) (.*) (.*)$', s, 0);
			return if(stringlib.stringtolowercase(trim(pat,all)) in daynm or patn <> '',FixMonthName(CleanDtNm(s,pat)),s);								
	end;

	EXPORT string ChkRevDtStr(string s) := function
			return if((integer)s[..4] < 1900 And length(trim(s,all)) = 8, s[5..] + s[..2] + s[3..4],s);
	end;

	EXPORT string CvtDateEx(string s, varstring fmtout = '%m/%d/%Y') := FUNCTION
		dt := CvtDate(s);
		return IF(dt='','',ut.ConvertDate(dt, '%m/%d/%Y', fmtout, ));
	END;

	
	rgxApprox := 
		'(Approximately|APPORXIMATELY|APPOXIMATELY|APPROXIMADAMENTE|APPROXMATELY|Ap-proximately|APPROX\\.?|circa|vers|APROXIMADAMENTE EN|APROXIMADAMENTE|ALREDEDOR DE|en torno a|hacia|est\\.?|c\\.) +(\\d{4})';
	rgxEstimation := '(\\d{4}) \\((alrededor de|Approximately|circa|estimated|estimation|estimacion|PROBABLY|probablemente|vers)\\)';
	rgxCirca := '(\\d{4}) (Approximately|APPOXIMATIVEMENT|APPROXIMATIVEMENT|circa|estimated|estimation|estimacion|PROBABLY|probablemente|vers)';
	rgxOtra := 'Otra fecha de nacimiento: (\\d{4})';

	//return yyyy/mm/dd
	// year only => yyyy/00/00
	EXPORT string ParseBirthday(string birthday) :=
		MAP(
			REGEXFIND('^\\d{4}$',birthday) => birthday+'/00/00',
			REGEXFIND('/\\d{2}$',birthday) => CvtDateEx(
				REGEXREPLACE('/(\\d{2})$',birthday,'/19$1'), '%Y/%m/%d'),
			REGEXFIND(rgxApprox,birthday,NOCASE) => 
				REGEXFIND(rgxApprox,birthday,2,NOCASE)+'/00/00',	
			REGEXFIND(rgxEstimation,birthday,NOCASE) =>
				REGEXFIND(rgxEstimation,birthday,1,NOCASE)+'/00/00',	
			REGEXFIND(rgxCirca,birthday,NOCASE) =>
				REGEXFIND(rgxCirca,birthday,1,NOCASE)+'/00/00',	
			REGEXFIND(rgxOtra,birthday,NOCASE) =>
				REGEXFIND(rgxOtra,birthday,1,NOCASE)+'/00/00',	
			//CvtDateEx(birthday, '%Y/%m/%d')
			CvtDate(birthday, '%Y/%m/%d', false)
		);

	//return yyyymmdd
	// year only => yyyy0101
	EXPORT string FixBirthday(string birthday) := FUNCTION
		dob := ParseBirthday(birthday);
		return 
			MAP(
				dob = '' => '',
				dob[6..10] = '00/00' => dob[1..4] + '0101',
				dob[9..10] = '00' => dob[1..4] + dob[6..7] + '01',
				ut.ConvertDate(dob,'%Y/%m/%d','%Y%m%d')
			);
	END;


	EXPORT string10 fSlashedMDYtoCYMD(string pDateIn) := 
		ut.ConvertDate(pDateIn, '%Y%m%d', '%Y/%m/%d');
		
	/*	
	export string10 precleanDate(string pDateIn) := 
		fSlashedMDYtoCYMD(TRIM(
			REGEXREPLACE('(Approximately|circa|vers|APROXIMADAMENTE EN|APROXIMADAMENTE|ALREDEDOR DE|en torno a|hacia|est\\.?)',
				pDateIn,'',NOCASE),LEFT,RIGHT));
	*/			
	// DATE RANGES:
	shared rgxDob0 := '^(\\d{4}) ?(-|to) ?(\\d{4})';
	shared rgxDob1 := 'ap-?proximately (\\d{4})[/-](\\d{4})\\b';
	shared rgxDob2 := '(between|entre) (\\d{4}) (and|et|y|to|&) (\\d{4})';
	shared rgxDob3 := '(APROXIMADAMENTE|circa|vers|ALREDEDOR DE) (\\d{4}) *- *(\\d{4})';
	shared rgxDob4 := '(BETWEEN|RANGE) (\\d{4}) ?- ?(\\d{4})';
	shared rgxDob5 := '\\b(\\d{4})[-/](\\d{2})\\b';

	EXPORT integer dobRange1(string s) := MAP(
		REGEXFIND(rgxDob0, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob0, s, 1, NOCASE),
		REGEXFIND(rgxDob1, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob1, s, 1, NOCASE),
		REGEXFIND(rgxDob2, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob2, s, 2, NOCASE),
		REGEXFIND(rgxDob3, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob3, s, 2, NOCASE),
		REGEXFIND(rgxDob4, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob4, s, 2, NOCASE),
		REGEXFIND(rgxDob5, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob5, s, 1, NOCASE),
		0);			
	
	EXPORT integer dobRange2(string s) := MAP(
		REGEXFIND(rgxDob0, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob0, s, 3, NOCASE),
		REGEXFIND(rgxDob1, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob1, s, 2, NOCASE),
		REGEXFIND(rgxDob2, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob2, s, 4, NOCASE),
		REGEXFIND(rgxDob3, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob3, s, 3, NOCASE),
		REGEXFIND(rgxDob4, s, NOCASE) =>
					(integer)REGEXFIND(rgxDob4, s, 3, NOCASE),
		REGEXFIND(rgxDob5, s, NOCASE) =>
					1900 + (integer)REGEXFIND(rgxDob5, s, 2, NOCASE),
		0);
		
	EXPORT integer deltaRange(string s) := FUNCTION
		lo := dobRange1(s);
		hi := dobRange2(s);

		return MAP(
		 lo = 0 or hi = 0 or hi < lo => 0,
		 hi - lo + 1);
	END;
		
		
	EXPORT boolean HasDateRange(string s) := 
		deltaRange(s) between 1 and 99;

	EXPORT integer DayOfWeek(unsigned4 dt) := function
			yr := STD.Date.Year(dt); 
			month := STD.Date.Month(dt); 
			day := STD.Date.Day(dt); 
			year := if(month<3,yr-1,yr);
			
			c:= if(STD.Date.IsLeapYear(year),1,0);
			
			mth := '032503514624';
			
			return  ( year + year/4 - year/100 + year/400 + (unsigned1)mth[month] + day + c)%7;
	END;
	
END;

