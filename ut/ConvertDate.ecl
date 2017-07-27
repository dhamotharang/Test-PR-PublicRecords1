/* 
 * Std.Date.ConvertDateFormat can be a replacement for this attribute
 * Std.Date.ConvertDateFormat returns same result except when no date
 * November 2015 input to Std.Date.ConvertDateFormat returns 10/31/2015
 * November 2015 input to UT.ConvertDate returns 11/00/2015. 

*/
/****************

Universal Date/Time format Converter

Parameters:
	s		the string to convert
	fmtin	input format string (See documentation fo strptime)
			http://linux.die.net/man/3/strftime
	fmtout	output format string (See documentation fo strftime)
			http://linux.die.net/man/3/strptime
			
Common date formats
	%b or %B	Month name (full or abbreviation)
	%C			Century (0-99)
	%d			Day of month
	%t			Whitespace
	%y			year within century (00-99)
	%Y			Full year (yyyy)
	
Common date formats
	American	'%m/%d/%Y'	mm/dd/yyyy  (default input format)
	Euro		'%d/%m/%Y'	dd/mm/yyyy
	Iso format	'%Y-%m-%d'	yyyy-mm-dd	
	Iso basic	'%Y%m%d'	yyyymmdd	(default output format)
				'%d-%b-%Y'  dd-mon-yyyy	e.g., '21-Mar-1954' 

NOTE: This function will also handle time data
	
Returns an empty string if the date cannot be parsed.

******************/
export string ConvertDate(varstring s, varstring fmtin='%m/%d/%Y', varstring fmtout='%Y%m%d') := BEGINC++
#include <stdio.h>
#include <time.h>
#body
struct tm tm;
char * out;
size32_t len;
char buf[255]; 

memset(&tm, 0, sizeof(struct tm));
char * res = strptime(s, fmtin, &tm);

if (res != NULL)
{
   strftime(buf, sizeof(buf), fmtout, &tm); 
   len = strlen(buf);
   out = (char *)rtlMalloc(len);
   memcpy(out, buf, len);
}
else {
	len = 0;
	out = NULL;
}
__lenResult = len;
__result = out; 


ENDC++ : DEPRECATED('Use Std.Date.ConvertDateFormat instead.');