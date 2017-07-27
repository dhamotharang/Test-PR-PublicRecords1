/* 
 * Std.Date.Std.date.ConvertDateFormatMultiple can be replacement for this attribute
 * Std.Date.Std.date.ConvertDateFormatMultiple returns same result except when no date
 * November 2015 input to Std.date.ConvertDateFormatMultiple returns 10/31/2015
 * November 2015 input to UT.ConvertDateMultiple returns 11/00/2015. 

*/
/****************

Universal Date/Time format Converter

This function is like ConvertDate, except that it will take a set of possible formats
It will match them in the order specified, stopping only if it finds a match

Parameters:
	s		the string to convert
	fmtsin	set of input format string (See documentation fo strptime)
			http://linux.die.net/man/3/strftime
	fmtout	output format string (See documentation fo strftime)
			http://linux.die.net/man/3/strptime
			
Returns an empty string if the date cannot be parsed using any of the supplied formats
******************/
export string ConvertDateMultiple(varstring s, set of varstring fmtsin, varstring fmtout='%Y%m%d') := BEGINC++
#include <stdio.h>
#include <time.h>
#body
struct tm tm;
char * out;
size32_t len;
char buf[255]; 

char *res;
char *fmtin = (char *)fmtsin;
char *fmtend = fmtin + lenFmtsin;

while (fmtin < fmtend)
{
  memset(&tm, 0, sizeof(struct tm));
	res = strptime(s, fmtin, &tm);
	if (res != NULL)
		break;
	fmtin = fmtin + strlen(fmtin) + 1;
}
	
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

ENDC++ : DEPRECATED('Use Std.date.ConvertDateFormatMultiple instead') ; 