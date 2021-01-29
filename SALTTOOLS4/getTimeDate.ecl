//Most of this code is taken from ut.GetTime
export GetTimeDate() := function
// Function to get time in HHMMSS format
// Courtesy : Nigel/Gavin
string17 getTimeDate_c() := BEGINC++
#ifdef _WIN32
#include <time.h>
#endif	
#body
	// Declarations
	struct tm localt; // localtime in 'tm' structure
	time_t timeinsecs;  // variable to store time in secs
	char temp[18];
	
	// Get time in sec since Epoch
	time(&timeinsecs);  
	// Convert to local time
#ifdef _WIN32
	localtime_s(&localt,&timeinsecs);
	strftime(temp, sizeof(temp), "%Y-%m-%d%H%M%S%w", &localt); // Formats the localtime to YYYY-MM-DDHHMMSSW where W is the weekday
	if (temp[16]=='0')		// convert %w to %u
		temp[16]='7';
#else
	localtime_r(&timeinsecs,&localt);
	strftime(temp, sizeof(temp), "%F%H%M%S%u", &localt); // Formats the localtime to YYYY-MM-DDHHMMSSW where W is the weekday
#endif
	memcpy(__result, &temp, 17);
ENDC++;
return getTimeDate_c();
end;
