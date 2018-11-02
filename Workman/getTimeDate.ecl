//Most of this code is taken from ut.GetTime

export getTimeDate() := function

// Function to get time in HHMMSS format
// Courtesy : Nigel/Gavin

string19 getTimeDate() := BEGINC++

#option pure
	// Declarations
	struct tm localt; // localtime in "tm" structure
	time_t timeinsecs;  // variable to store time in secs
	// char ret[19];
	
	
	// Get time in sec since Epoch
	time(&timeinsecs);  
	// Convert to local time
	localtime_r(&timeinsecs,&localt);
	// Format the local time value
	strftime(__result, 20, "%F %H:%M:%S%u", &localt); // Formats the localtime to YYYY-MM-DDHHMMSSW where W is the weekday

	
ENDC++;

return getTimeDate();

end;