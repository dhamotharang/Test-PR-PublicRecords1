
import ut,std;
export Dates := MODULE


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
		
export string CvtDate(string s1, varstring fmtout = '%m/%d/%Y', boolean doCheck = true) := FUNCTION
	fmts := [
		'%m/%d/%Y',
		'%d %B %Y',
		'%d %b %Y',
		'%d %b. %Y',
		'%d.%m.%Y',
		'%Y-%m-%d',
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
	dt := Std.date.ConvertDateFormatMultiple(s, fmts, fmtout);
	return dt;
	//return IF(dt='','',
	//			if(doCheck,SanityCheck(FixSlashCentury(dt)),dt));
END;

string CvtDateEx(string s, varstring fmtout = '%m/%d/%Y') := FUNCTION
	dt := CvtDate(s);
	return IF(dt='','',Std.Date.ConvertDateFormat(dt, '%m/%d/%Y', fmtout, ));
END;


rgxApprox := 
	'(Approximately|APPORXIMATELY|APPOXIMATELY|APPROXIMADAMENTE|APPROXMATELY|Ap-proximately|APPROX\\.?|circa|vers|APROXIMADAMENTE EN|APROXIMADAMENTE|ALREDEDOR DE|en torno a|hacia|est\\.?|c\\.) +(\\d{4})';
rgxEstimation := '(\\d{4}) \\((alrededor de|Approximately|circa|estimated|estimation|estimacion|PROBABLY|probablemente|vers)\\)';
rgxCirca := '(\\d{4}) (Approximately|APPOXIMATIVEMENT|APPROXIMATIVEMENT|circa|estimated|estimation|estimacion|PROBABLY|probablemente|vers)';
rgxOtra := 'Otra fecha de nacimiento: (\\d{4})';

//return yyyy/mm/dd
// year only => yyyy/00/00
export string ParseBirthday(string birthday) :=
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
export string FixBirthday(string birthday) := FUNCTION
	dob := ParseBirthday(birthday);
	return 
		MAP(
			dob = '' => '',
			dob[6..10] = '00/00' => dob[1..4] + '0101',
			dob[9..10] = '00' => dob[1..4] + dob[6..7] + '01',
			Std.Date.ConvertDateFormat(dob,'%Y/%m/%d','%Y%m%d')
			);
END;


export string10 fSlashedMDYtoCYMD(string pDateIn) := 
		Std.Date.ConvertDateFormat(pDateIn, '%Y%m%d', '%Y/%m/%d');
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

export integer dobRange1(string s) := MAP(
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
export integer dobRange2(string s) := MAP(
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
	
export integer deltaRange(string s) := FUNCTION
	lo := dobRange1(s);
	hi := dobRange2(s);

	return MAP(
	 lo = 0 or hi = 0 or hi < lo => 0,
	 hi - lo + 1);
END;
	
	
export boolean HasDateRange(string s) := 
	deltaRange(s) between 1 and 99;

	
END;