// This clean function utilizes the same general parsing approach as Text.date
// but does not support the week  and day of year variants for ISO dates
//
// Note that date values which are all numeric with no formatting are 
// assumed to be YYYY, YYYYMM, or YYYYMMDD format
//
// The WHOLE option is used for parsing, so the input must be a date value in
// one of the accepted patterns.  00000000 is returned for any input not matching a valid whole date pattern

export string8 CleanDate(string date) := FUNCTION

date_in := dataset([{trim(date)}], {string s});

pattern front		:= any not in pattern('^[a-zA-Z0-9]') | FIRST;
pattern back 		:= any not in pattern('^[a-zA-Z0-9]') | LAST;

pattern sws := PATTERN('[ \t\r\n]');
pattern ws := sws+;
pattern digit := PATTERN('[0-9]');
pattern month := (['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Sept','Oct','Nov','Dec'] OPT('.')) | ['January','February','March','April','May','June','July','August','September','October','November','December'];

pattern digit2 := digit*2;
pattern digit3 := digit*3;
pattern digit4 := digit*4;

pattern date_year := digit2 | digit4;
pattern date_month := validate(digit+, (integer)matchtext >= 1 and (integer)matchtext <= 12);
pattern date_wday := pattern('[1-7]');
pattern date_mday := validate(digit+, (integer)matchtext >= 1 and (integer)matchtext <= 31); // needs additional validation based on month/year

pattern date_dmy_num := (date_mday '/' date_month '/' date_year) |
                        (date_mday '.' date_month '.' date_year) |
                        (date_mday '-' date_month '-' date_year);

pattern date_dmy_mname := date_mday opt(['th','st','nd']) ws opt('of' ws) month opt('.') opt(ws date_year);

pattern date_dmy := date_dmy_num | nocase(date_dmy_mname);

// Date forms starting with month
// November 16, 2003
// November 16th 
// Nov. 16, 2003 
// 11/16/2003, 11-16-2003, 11.16.2003 or 11.16.03
//
pattern date_mdy_num := (date_month '/' date_mday '/' date_year) |
                        (date_month '.' date_mday '.' date_year) |
                        (date_month '-' date_mday '-' date_year);

pattern date_mdy_mname := month opt('.') ws date_mday opt(['th','st','nd']) opt(opt(',') ws date_year);

pattern date_mdy := date_mdy_num | nocase(date_mdy_mname);

// Date forms starting with year
// 2003 November 16 
// 2003/11/16, 2003.11.16, 2003-11-16 (ISO)

pattern date_ymd_num := (date_year '/' date_month '/' date_mday) |
                        (date_year '.' date_month '.' date_mday) |
                        (date_year '-' date_month opt('-' date_mday)) |
                        // order is important here
						(date_year) |
						(date_year date_month) |
						(date_year date_month date_mday);

pattern date_ymd_mname := date_year ws month ws date_mday;

pattern date_ymd := date_ymd_num | nocase(date_ymd_mname);

// American forms receive precedence
pattern date_all := (((date_mdy | date_ymd | date_dmy) after front) before back);

string2 ConvertMonth(string3 mname) := map(mname = 'JAN' => '01',
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
										  
integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

// 70-30 rule: if 2-digit reference year is less than current year + 30, assume 2000, otherwise 1900
string4 AdjustYear(string year) := map(length(year) <> 2 => year,
                                       (integer)year <= (current_yy + 30) => (string4)(2000 + (integer)year),
									   (string4)(1900 + (integer)year));

 
date_match := record
string4 yyyy := intformat((integer)AdjustYear(matchtext(date_all/date_year)),4,1);
string2 mm := if(matched(date_all/month), ConvertMonth(stringlib.stringtouppercase(matchtext(date_all/month))[1..3]), intformat((integer)matchtext(date_all/date_month),2,1));
string2 dd := intformat((integer)matchtext(date_all/date_mday),2,1);
end;

date_parse := parse(date_in, s, date_all, date_match, first, not matched, whole);

date_val := date_parse[1].yyyy + date_parse[1].mm + date_parse[1].dd;

return date_val;
END;