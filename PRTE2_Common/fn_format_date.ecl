//---------------------------------------------------------------------------
// Function takes a string of date information as input and outputs the date
// in the format requested.  User can pass in two parameters:
//   s1: The date or date/time string
//   f : The format requested (e.g. mm/dd/yyyy, mm-yyyy, etc.)
//       replacement flags are mm,dd,yy, and yyyy. Any other character
//       sequences are passed through literally
//       Default is YYYYMMDD
//---------------------------------------------------------------------------
EXPORT fn_format_date(STRING s1,STRING f='YYYYMMDD'):=FUNCTION
  // Strip any time information from the end of the string and truncate any
	// numeric string that is more than 4-digits
  s2:=REGEXREPLACE(' [0-9]{1,2}(?=:)',stringlib.stringtouppercase(s1),'');
	s3:=REGEXREPLACE('(?<=[0-9]{4})[0-9]*',s2,'');
  s4:=REGEXREPLACE(':.*',s3,'');
	
	// Make any single-digit a double by prepending a zero
	s5:=REGEXREPLACE('(?<![0-9])(?=[0-9][^(0-9)])',s4,'0');
	
	// Replace month names with their corresponding numeric values
	s6:=REGEXREPLACE('(JAN|JANUARY)',
	    REGEXREPLACE('(FEB|FEBRUARY)',
	    REGEXREPLACE('(MAR|MARCH)',
	    REGEXREPLACE('(APR|APRIL)',
	    REGEXREPLACE('(MAY)',
	    REGEXREPLACE('(JUN|JUNE)',
	    REGEXREPLACE('(JUL|JULY)',
	    REGEXREPLACE('(AUG|AUGUST)',
	    REGEXREPLACE('(SEP|SEPTEMBER)',
	    REGEXREPLACE('(OCT|OCTOBER)',
	    REGEXREPLACE('(NOV|NOVEMBER)',
	    REGEXREPLACE('(DEC|DECEMBER)',s5,'12'),'11'),'10'),'09'),'08'),'07'),'06'),'05'),'04'),'03'),'02'),'01');
			
	// Shrink any non-numeric strings into a single character, and change those
	// single characters to a "-". In the case of a trailing non-numeric
	// character, truncate the string to 10 characters
	s7:=REGEXREPLACE('(?<=[^0-9])[^0-9]*',s6,'');
	sf:=REGEXREPLACE('[^(0-9)]',s7,'-')[..10];
	
	// Pull out the year, month and day based on the location of the hyphens
	y:=IF(StringLib.StringFind(sf,'-',1)=5,sf[..4],IF(LENGTH(sf)=8,IF((UNSIGNED)sf[9..]>30,'19','20')+sf[7..],sf[7..]));
	m:=IF(StringLib.StringFind(sf,'-',1)=5,sf[6..7],sf[..2]);
	d:=IF(StringLib.StringFind(sf,'-',1)=5,sf[9..],sf[4..5]);
	
	// Construct the output based on the format requested
	r1:=REGEXREPLACE('(y|Y){4}',f,y);
	r2:=REGEXREPLACE('(y|Y){2}',r1,y[3..]);
	r3:=REGEXREPLACE('(m|M){2}',r2,m);
	r4:=REGEXREPLACE('(d|D){2}',r3,d);
	RETURN r4;
END;
