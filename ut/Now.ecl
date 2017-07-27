/***

This function returns the current date and time in any format supported by strftime
The default format is yyyymmdd

if utc is false, the result will be the local time
if utc is true, the result will be Coordinated Universal Time

NOTE: '%T' will display the time as hh:mm:ss

***/
export string Now(varstring fmtout='%Y%m%d', boolean utc=false) := BEGINC++
#include <time.h>

;
char	buf[100];

time_t t = time(NULL);
struct tm tm;	// broken down time

if (utc)
	gmtime_r(&t,&tm);
else
	localtime_r(&t,&tm);

strftime(buf, sizeof(buf), fmtout, &tm); 
int  len = strlen(buf);
char *out = (char *)rtlMalloc(len);
memcpy(out, buf, len);

__lenResult = len;
__result = out; 

ENDC++;