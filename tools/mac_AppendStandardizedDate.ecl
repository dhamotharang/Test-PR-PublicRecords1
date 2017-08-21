//This is patterned after seep.CleanDate
//modified to take in a dataset, and return a dataset with the cleaned date
// This clean function utilizes the same general parsing approach as Text.date
// but does not support the week  and day of year variants for ISO dates
//
// Note that date values which are all numeric with no formatting are 
// assumed to be YYYY, YYYYMM, or YYYYMMDD format
//
// The WHOLE option is used for parsing, so the input must be a date value in
// one of the accepted patterns.  00000000 is returned for any input not matching a valid whole date pattern
export mac_AppendStandardizedDate(
	 pDataset									// Input Dataset
	,pDateField								// Field with Dirty Date
	,pOutputDataset						// Output Dataset
	,pYMD						= 'false' // can be YMD, MDY, DMY
	,pMDY						= 'false' // can be YMD, MDY, DMY
	,pDMY						= 'false' // can be YMD, MDY, DMY
	,pYM						= 'false' // can be YMD, MDY, DMY
) :=
macro
pattern front		:= any not in pattern('^[a-zA-Z0-9]') | FIRST;
pattern back 		:= any not in pattern('^[a-zA-Z0-9]') | LAST;
pattern sws := PATTERN('[ \t\r\n]');
pattern ws := sws+;
pattern digit := PATTERN('[0-9]');
pattern month := (['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Sept','Oct','Nov','Dec'] OPT('.')) | ['January','February','March','April','May','June','July','August','September','October','November','December'];
pattern digit2 := digit*2;
pattern digit3 := digit*3;
pattern digit4 := digit*4;
pattern date_year := validate(digit2 | digit4,	(length(matchtext) = 2 and (integer)matchtext >= 0  and (integer)matchtext <= 99) or
																								(length(matchtext) = 4 and (integer)matchtext >= 1600  and (integer)matchtext <= 2100)
											);
pattern date_year4 := validate(digit4,	(length(matchtext) = 4 and (integer)matchtext >= 1600  and (integer)matchtext <= 2100)
											);
pattern date_month := validate(repeat(digit,1,2), (integer)matchtext >= 1 and (integer)matchtext <= 12);
pattern date_wday := pattern('[1-7]');
pattern date_mday := validate(repeat(digit,1,2), (integer)matchtext >= 1 and (integer)matchtext <= 31); // needs additional validation based on month/year
pattern date_dmy_num := 	(date_mday '/' date_month '/' date_year)
                        | (date_mday '.' date_month '.' date_year)
                        | (date_mday '-' date_month '-' date_year)
												;
pattern date_dmy_mname := 	(date_mday opt(['th','st','nd']) ws opt('of' ws) month opt('.') opt(ws date_year))
													| (date_mday '-' month '-' date_year)
													| (date_mday '/' month '/' date_year)
													| (date_mday '.' month '.' date_year)
													;
pattern date_dmy := date_dmy_num | nocase(date_dmy_mname);
// Date forms starting with month
// November 16, 2003
// November 16th 
// Nov. 16, 2003 
// 11/16/2003, 11-16-2003, 11.16.2003 or 11.16.03
//
pattern date_mdy_num := 	(date_month '/' date_mday '/' date_year)
                        | (date_month '.' date_mday '.' date_year) 
                        | (date_month '-' date_mday '-' date_year)
//                        | (date_month     date_mday     date_year)
												;
pattern date_mdy_mname := month opt('.') ws date_mday opt(['th','st','nd']) opt(opt(',') ws date_year);
pattern date_mdy := date_mdy_num | nocase(date_mdy_mname);
// Date forms starting with year
// 2003 November 16 
// 2003/11/16, 2003.11.16, 2003-11-16 (ISO)
pattern date_ymd_num := 	(date_year '/' date_month '/' date_mday)
                        | (date_year '.' date_month '.' date_mday)
                        | (date_year '-' date_month opt('-' date_mday))
												;
pattern date_ymd_mname := date_year ws month ws date_mday;
pattern date_ymd := date_ymd_num | nocase(date_ymd_mname);
pattern date_ym_num := 		(date_year '/' date_month)
                        | (date_year '.' date_month)
                        | (date_year '-' date_month)
												;
pattern date_ym_mname := date_year ws month;
pattern date_ym := date_ym_num | nocase(date_ym_mname);
pattern last_resort_full :=	date_year4
												| (date_month date_mday 	date_year)
                        | (date_mday  date_month	date_year)
												| (date_year 	date_month	date_mday)
												| (date_year 	date_month)
												| (date_year)
												;
pattern last_resort_dmy :=		 date_year4
														| 	(date_mday  date_month	date_year)
												;
pattern last_resort_mdy :=		 date_year4
														| (date_month date_mday 	date_year)
												;
pattern last_resort_ymd :=		 date_year4
														| (date_year 	date_month	date_mday)
												| (date_year 	date_month)
												| (date_year)
												;
pattern last_resort_ym :=	 date_year4
														| (date_year 	date_month)
														| (date_year)
												;
// American forms receive precedence
//check month		day 	year
//			day 		month year
//			year 		month day
//pattern date_all := if(pOrderHint != '', (((date_mdy | date_dmy | date_ymd | last_resort_full) after front) before back), date_dmy);
pattern date_all_ymd := (((date_ymd | last_resort_ymd) after front) before back);
pattern date_all_dmy := (((date_dmy | last_resort_dmy) after front) before back);
pattern date_all_mdy := (((date_mdy | last_resort_mdy) after front) before back);
pattern date_all_ym  := (((date_ym  | last_resort_ym ) after front) before back);
                                                
#if(pYMD)
	pattern date_all := date_all_ymd	;
#else
#if(pMDY)
	pattern date_all := date_all_mdy	;
#else
#if(pDMY)
	pattern date_all := date_all_dmy	;
#else    
#if(pYM)
	pattern date_all := date_all_ym		;
#else    
	pattern date_all := (((date_mdy | date_dmy | date_ymd | last_resort_full) after front) before back)	;
#end
#end
#end
#end						
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
 
date_match :=
record, maxlength(8192)
	recordof(pDataset);
	string4 yyyy := intformat((integer)AdjustYear(matchtext(date_all/date_year)),4,1);
	string2 mm := if(matched(date_all/month), ConvertMonth(stringlib.stringtouppercase(matchtext(date_all/month))[1..3]), intformat((integer)matchtext(date_all/date_month),2,1));
#if(pYM)
	string2 dd := '00';
#else
	string2 dd := intformat((integer)matchtext(date_all/date_mday),2,1);
#end
end;
date_match tgetmatch(pDataset l) :=
transform
	self := l;
	self.yyyy :=  if(matched(date_all/date_year4)
										,intformat((integer)AdjustYear(matchtext(date_all/date_year4)),4,1)
										,intformat((integer)AdjustYear(matchtext(date_all/date_year)),4,1)
								);
	self.mm := if(matched(date_all/month), ConvertMonth(stringlib.stringtouppercase(matchtext(date_all/month))[1..3]), intformat((integer)matchtext(date_all/date_month),2,1));
#if(pYM)
	self.dd := '00';
#else
	self.dd := intformat((integer)matchtext(date_all/date_mday),2,1);
#end
end;
pOutputDataset := parse( pDataset					//dataset
										,pDateField				//field to parse out
										,date_all					//pattern used to parse it
										,tgetmatch(left)	//transform to add cleaned date fields
										,first
										,not matched
										,best
										,nocase
									);
ENDmacro;
