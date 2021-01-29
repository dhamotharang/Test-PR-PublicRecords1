// This clean function utilizes the same general parsing approach as Text.date
// but does not support the week and day of year variants for ISO dates
//
// Note that date values which are all numeric with no formatting are
// assumed to be YYYY, YYYYMM, or YYYYMMDD format
//
// The WHOLE option is used for parsing, so the input must be a date value in
// one of the accepted patterns. 00000000 is returned for any input not matching a valid whole date pattern
IMPORT STD;
EXPORT STRING8 CleanDate(STRING date) := FUNCTION

  date_in := DATASET([{TRIM(date)}], {STRING s});

  PATTERN front := ANY NOT IN PATTERN('^[a-zA-Z0-9]') | FIRST;
  PATTERN back := ANY NOT IN PATTERN('^[a-zA-Z0-9]') | LAST;

  PATTERN sws := PATTERN('[ \t\r\n]');
  PATTERN ws := sws+;
  PATTERN digit := PATTERN('[0-9]');
  PATTERN month := (['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Sept','Oct','Nov','Dec'] OPT('.')) | 
    ['January','February','March','April','May','June','July','August','September','October','November','December'];

  PATTERN digit2 := digit*2;
  PATTERN digit3 := digit*3;
  PATTERN digit4 := digit*4;

  PATTERN date_year := digit2 | digit4;
  PATTERN date_month := VALIDATE(digit+, (INTEGER)MATCHTEXT >= 1 AND (INTEGER)MATCHTEXT <= 12);
  PATTERN date_wday := PATTERN('[1-7]');
  PATTERN date_mday := VALIDATE(digit+, (INTEGER)MATCHTEXT >= 1 AND (INTEGER)MATCHTEXT <= 31); // needs additional validation based on month/year

  PATTERN date_dmy_num := (date_mday '/' date_month '/' date_year) |
                          (date_mday '.' date_month '.' date_year) |
                          (date_mday '-' date_month '-' date_year);

  PATTERN date_dmy_mname := date_mday OPT(['th','st','nd']) ws OPT('of' ws) month OPT('.') OPT(ws date_year);

  PATTERN date_dmy := date_dmy_num | NOCASE(date_dmy_mname);

  // Date forms starting with month
  // November 16, 2003
  // November 16th
  // Nov. 16, 2003
  // 11/16/2003, 11-16-2003, 11.16.2003 or 11.16.03
  //
  PATTERN date_mdy_num := (date_month '/' date_mday '/' date_year) |
                          (date_month '.' date_mday '.' date_year) |
                          (date_month '-' date_mday '-' date_year);

  PATTERN date_mdy_mname := month OPT('.') ws date_mday OPT(['th','st','nd']) OPT(OPT(',') ws date_year);

  PATTERN date_mdy := date_mdy_num | NOCASE(date_mdy_mname);

  // Date forms starting with year
  // 2003 November 16
  // 2003/11/16, 2003.11.16, 2003-11-16 (ISO)

  PATTERN date_ymd_num := 
    (date_year '/' date_month '/' date_mday) |
    (date_year '.' date_month '.' date_mday) |
    (date_year '-' date_month OPT('-' date_mday)) |
    // order is important here
    (date_year) |
    (date_year date_month) |
    (date_year date_month date_mday);

  PATTERN date_ymd_mname := date_year ws month ws date_mday;

  PATTERN date_ymd := date_ymd_num | NOCASE(date_ymd_mname);

  // American forms receive precedence
  PATTERN date_all := (((date_mdy | date_ymd | date_dmy) AFTER front) BEFORE back);

  STRING2 ConvertMonth(STRING3 mname) := MAP(
    mname = 'JAN' => '01',
    mname = 'FEB' => '02',
    mname = 'MAR' => '03',
    mname = 'APR' => '04',
    mname = 'MAY' => '05',
    mname = 'JUN' => '06',
    mname = 'JUL' => '07',
    mname = 'AUG' => '08',
    mname = 'SEP' => '09',
    mname = 'OCT' => '10',
    mname = 'NOV' => '11',
    mname = 'DEC' => '12',
    '00');
  
  INTEGER current_yy := (INTEGER)(STD.Date.Today()[3..4]);

  // 70-30 rule: if 2-digit reference year is less than current year + 30, assume 2000, otherwise 1900
  STRING4 AdjustYear(STRING year) := MAP(
    LENGTH(year) <> 2 => year,
    (INTEGER)year <= (current_yy + 30) => (STRING4)(2000 + (INTEGER)year),
    (STRING4)(1900 + (INTEGER)year)
    );

  date_match := RECORD
    STRING4 yyyy := INTFORMAT((INTEGER)AdjustYear(MATCHTEXT(date_all/date_year)),4,1);
    STRING2 mm := IF(MATCHED(date_all/month), ConvertMonth(STD.STR.ToUpperCase(MATCHTEXT(date_all/month))[1..3]), INTFORMAT((INTEGER)MATCHTEXT(date_all/date_month),2,1));
    STRING2 dd := INTFORMAT((INTEGER)MATCHTEXT(date_all/date_mday),2,1);
  END;

  date_parse := PARSE(date_in, s, date_all, date_match, FIRST, NOT MATCHED, whole);

  date_val := date_parse[1].yyyy + date_parse[1].mm + date_parse[1].dd;

  RETURN date_val;
END;
