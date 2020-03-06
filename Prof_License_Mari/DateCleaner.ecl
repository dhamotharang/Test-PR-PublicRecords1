export DateCleaner := MODULE

import lib_date;
import lib_stringlib, ut;

// canonical form for dates is YYYYMMDD

// converts from MM/DD/YY
export unsigned8 FromMMDDYY(string8 date) := FUNCTION
	return lib_date.Date_MMDDYY_I2(StringLib.StringFilterOut(date, '/'));
END;

// converts from MM/DD/YYYY
export unsigned8 FromMMDDYYYY(string10 date) := FUNCTION
	return (unsigned8)(date[7..10]+date[1..2]+date[4..5]);
END;

// converts to MM/DD/YYYY
export string10 ToMMDDYYYY(unsigned8 date) := FUNCTION
	unsigned2 year := date/10000;
	unsigned2 month := (date % 10000)/100;
	unsigned2 day := date % 100;
	return IF(date=0, '', 
				intformat(month,2,1)+'/'+intformat(day,2,1)+'/'+(string4)year);
END;

// convert ISO (yyyy-mm-dd or yyyymmdd) to US (mm/dd/yyyy)
export ISOToUS(string date) := FUNCTION
	d := StringLib.StringFilterOut(date, '-');
	return IF(date='', '', d[5..6] + '/' + d[7..8] + '/' + d[1..4]);
END;

// convert ISO (mm-dd-yyyy) to US (mm/dd/yyyy)
export FromISOToUS(string date) := FUNCTION
	d := StringLib.StringFilterOut(date, '-');
	return IF(date='', '', d[1..2] + '/' + d[3..4] + '/' + d[5..8]);
END;

// converts from dd-MMM-yy
export unsigned8 FromDDMMMYY(string9 date) := FUNCTION
	string2 month := CASE(date[4..6], 
		'JAN' => '01',
		'FEB' => '02',
		'MAR' => '03',
		'APR' => '04',
		'MAY' => '05',
		'JUN' => '06',
		'JUL' => '07',
		'AUG' => '08',
		'SEP' => '09',
		'OCT' => '10',
		'NOV' => '11',
		'DEC' => '12',
		'00'
		);
	string4	year := IF(date[8..9]<'40','20','19') + date[8..9];
	return (unsigned8)(year + month + date[1..2]);
END;

// converts from dd-MMM-yy
EXPORT STRING8 FromDDMMMYY_New(string date) := FUNCTION
  dd := REGEXFIND('([0-9]+)\\-([A-z]{3})\\-([0-9]{2})',date,1,NOCASE);
  mm := REGEXFIND('([0-9]+)\\-([A-z]{3})\\-([0-9]{2})',date,2,NOCASE);
  yy := REGEXFIND('([0-9]+)\\-([A-z]{3})\\-([0-9]{2})',date,3,NOCASE);
	string2 day		:= IF(LENGTH(dd)=1,'0'+dd,dd);
	string2 month := CASE(ut.CleanSpacesAndUpper(mm), 
		'JAN' => '01',
		'FEB' => '02',
		'MAR' => '03',
		'APR' => '04',
		'MAY' => '05',
		'JUN' => '06',
		'JUL' => '07',
		'AUG' => '08',
		'SEP' => '09',
		'OCT' => '10',
		'NOV' => '11',
		'DEC' => '12',
		'00'
		);
	string4	year := IF(yy<'40','20','19') + yy;
	return (STRING8) (year + month + day);
END;

// Convert MON DD YYYY to YYYYMMDD
export string fmt_dateMONDDYYYY(string11 date) := FUNCTION
	string2 month := CASE(date[1..3], 
		'JAN' => '01',
		'FEB' => '02',
		'MAR' => '03',
		'APR' => '04',
		'MAY' => '05',
		'JUN' => '06',
		'JUL' => '07',
		'AUG' => '08',
		'SEP' => '09',
		'OCT' => '10',
		'NOV' => '11',
		'DEC' => '12',
		'00'
		);
	string4	year := date[8..11];
	return (string)(year + month + date[5..6]);
END;
 

shared string3 MonthName(integer month) := FUNCTION
	RETURN CASE(month, 
		1 => 'JAN',
		2 => 'FEB',
		3 => 'MAR',
		4 => 'APR',
		5 => 'MAY',
		6 => 'JUN',
		7 => 'JUL',
		8 => 'AUG',
		9 => 'SEP',
		10 => 'OCT',
		11 => 'NOV',
		12 => 'DEC',
		'UNK'
		);

END;
 
 
// converts to dd-MMM-yy
export string9 ToDDMMMYY(unsigned8 date) := FUNCTION
	unsigned2 year := date/10000;
	unsigned2 m := (date % 10000)/100;
	unsigned2 day := date % 100;
	string3 month := CASE(m, 
		1 => 'JAN',
		2 => 'FEB',
		3 => 'MAR',
		4 => 'APR',
		5 => 'MAY',
		6 => 'JUN',
		7 => 'JUL',
		8 => 'AUG',
		9 => 'SEP',
		10 => 'OCT',
		11 => 'NOV',
		12 => 'DEC',
		'UNK'
		);
	return IF(date=0, '', 
				intformat(day,2,1) + '-' + month + '-' + intformat(year%100,2,1));
END;

// input format yyyy-mm-dd [hh:mm:ss]
export string11 ISOToMonDDYYYY(string iso) := FUNCTION
	return 	IF(LENGTH(iso) = 0, '',
			MonthName((integer)iso[6..7]) + ' ' + iso[9..10] + ' ' + iso[1..4]);
END;


// normalize date to 8 chars
export string8 norm_date(string8 date) := FUNCTION
	return IF(Length(Trim(date)) = 7, '0'+ trim(date), date);
END;

// m/d/yyyy to mm/dd/yyyy
export string10 norm_date2(string10 s) := FUNCTION
	sep := '/';
	i := StringLib.StringFind(s, sep, 1);
	string2 month := IF(i = 2, '0' + s[1..1], s[1..2]);
	j := StringLib.StringFind(s, sep, 2);
	string2 day := IF(j - i = 2, '0' + s[i+1..i+1], s[i+1..i+2]);
	string4 year := (s[j+1..j+4]);
	
	return month + sep + day + sep + year;
END;

// m/d/yyyy hh:mm:ss to mm/dd/yyyy
export string10 norm_date3(string10 s) := FUNCTION
	regex := '([0-9]+)/([0-9]+)/([0-9]{4})(.*)';
	month := REGEXFIND(regex, s, 1);
	day := REGEXFIND(regex, s, 2);
	year := REGEXFIND(regex, s, 3);

	return IF(LENGTH(TRIM(month)) = 1, '0' + TRIM(month), month) + '/' +
			IF(LENGTH(TRIM(day)) = 1, '0' + TRIM(day), day) + '/' +
			year;
END;

export integer CompareTodayMMDDYYYY(string10 date) := FUNCTION
	string8 d := norm_date(StringLib.StringFilterOut(date, '/'));
	string8 yyyymmdd := d[5..8] + d[1..2] + d[3..4];
	string8 today := StringLib.GetDateYYYYMMDD();
	n := MAP (
		yyyymmdd > today => 1,
		yyyymmdd = today => 0,
		-1
	);
	return n;
END;

// input date in m-d-yy format. E.g., 1-7-95
export string10 fix_date(string s, string1 sep) := FUNCTION
	i := StringLib.StringFind(s, sep, 1);
	string2 month := IF(i = 2, '0' + s[1..1], s[1..2]);
	j := StringLib.StringFind(s, sep, 2);
	string2 day := IF(j - i = 2, '0' + s[i+1..i+1], s[i+1..i+2]);
	n := (integer)(s[j+1..j+2]);
	string4 year := (string4)(IF(n < 21, 2000 + n, 1900 + n));
	
	return month + sep + day + sep + year;
END;


// Standard Date Format MM/DD/YYYY to YYYYMMDD
export string fmt_dateMMDDYYYY(string date) := FUNCTION
	regex 	:= '([0-9]+)/([0-9]+)/([0-9]{4})';
	year 	:= (integer)REGEXFIND(regex, date, 3);
	day		:= (integer)REGEXFIND(regex, date, 2);
	month	:= (integer)REGEXFIND(regex, date, 1);
	clean_date := IF(date != '', (string4)year+intformat(month,2,1)+intformat(day,2,1),'');
		return clean_date;
		// return	(string4)year+intformat(month,2,1)+intformat(day,2,1);
END;
			
// Standard Date Format YYYY-MM-DD to YYYYMMDD
export string fmt_dateYYYYMMDD(string date) := FUNCTION
	regex 	:= '([0-9]{4})\\-([0-9]+)\\-([0-9]+)';
	year 	:= (integer)REGEXFIND(regex, date, 1);
	month	:= (integer)REGEXFIND(regex, date, 2);
	day		:= (integer)REGEXFIND(regex, date, 3);
	clean_date := IF(date != '', (string4)year+intformat(month,2,1)+intformat(day,2,1),'');
		return clean_date;
		// return	(string4)year+intformat(month,2,1)+intformat(day,2,1);
END;

// input date in m-yy format. E.g., 1-95
export string10 fix_date_yr(string s, string1 sep) := FUNCTION
	i := StringLib.StringFind(s, sep, 1);
	string2 month := IF(i = 2, '0' + s[1..1], s[1..2]);
	n := (integer)(s[i+1..i+2]);
	string4 year := (string4)(IF(n < 21, 2000 + n, 1900 + n));
	
	return month + sep + year;
END;

// converts from dd-MMM-yy to YYYYMMDD
export STRING8 FromDD_MMM_YY(STRING date) := FUNCTION

  day := IF(date[3]='-',date[1..2],'0'+date[1]);
	month_pos := IF(date[3]='-',4,3);
	mon_temp	:= StringLib.StringToUpperCase(date[month_pos..month_pos+2]);
	string2 month := CASE(mon_temp, 
												'JAN' => '01',
												'FEB' => '02',
												'MAR' => '03',
												'APR' => '04',
												'MAY' => '05',
												'JUN' => '06',
												'JUL' => '07',
												'AUG' => '08',
												'SEP' => '09',
												'OCT' => '10',
												'NOV' => '11',
												'DEC' => '12',
												'00'
											 );
	string4	year := IF(date[month_pos+4..month_pos+5]<thorlib.wuid()[4..5]+1,'20','19') + date[month_pos+4..month_pos+5];
	return year + month + day;
END;

//This function accepts below date format and converts them to YYYMMDD. Note that we do not check the range of month, day, or year.
//Return
//		- 17530101 if input is blank, or in unexpected format.
//		- YYYYMMDD
//Accepted formats:
//		- Expires: MM/DD/YYYY
//		- MM/DD/YYYY or M/D/YYYY
//		- MM/DD/YY or M/D/YY
//		- YYYYMMDD
//		- YYYY-MM-DD   (added 8/26/13)
// 		- dd-MMM-yy
//		- MMM DD, YYYY
EXPORT ToYYYYMMDD(string date) := FUNCTION

	//Extract date in mm/dd/yy or mm/dd/yyyy format
	tmpDateString1 		:= MAP(REGEXFIND('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})',date)
													   => REGEXFIND('([0-9]{1,2}/[0-9]{1,2}/[0-9]{2,4})',date,1),
													 REGEXFIND('([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})',date)	 
													   => REGEXFIND('([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})',date,2) + '/' +
														    REGEXFIND('([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})',date,3) + '/' +
																REGEXFIND('([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})',date,1),
													 date);
											 
	//convert mm/dd/yy to mm/dd/yyyy format
	tmpDateString2		:= IF(LENGTH(REGEXFIND('[0-9]+/[0-9]+/([0-9]+)',tmpDateString1,1))=2,
													fix_date(tmpDateString1,'/'),
													tmpDateString1);

	//convert MM/DD/YYYY to YYYYMMDD
	tmpDateString3		:= IF(REGEXFIND('[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}',tmpDateString2),
													fmt_dateMMDDYYYY(tmpDateString2),
													tmpDateString2);
	//convert MMM DD, YYYY to YYYYMMDD
	tmpDateString4		:= IF(REGEXFIND('[A-Za-z]{3} [0-9]{2}, [0-9]{4}',tmpDateString3),
													fmt_dateMONDDYYYY(REGEXREPLACE(',',tmpDateString3,'')),
													tmpDateString3);
	//convert DD MMM YY to YYYYMMDD
	tmpDateString5		:= IF(REGEXFIND('[0-9]{1,2}-[A-Za-z]{3}-[0-9]{2}',tmpDateString4),
													FromDD_MMM_YY(tmpDateString4),
													tmpDateString4);
	//convert DD-MMM-YY to YYYYMMDD
	tmpDateString6		:= IF(REGEXFIND('([0-9]+)\\-([A-z]{3})\\-([0-9]{2})',tmpDateString5),
													FromDDMMMYY_New(tmpDateString5),
													tmpDateString5);
	tmpDateString7		:= TRIM(tmpDateString6,LEFT,RIGHT);
	tmpDateStringLast	:= MAP(tmpDateString7=' ' => '17530101',
													 REGEXFIND('^[0-9]{8}$',tmpDateString6) => tmpDateString7,
													 '17530101');
  RETURN tmpDateStringLast;
	
END;



END;