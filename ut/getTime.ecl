export getTime() := function

// Function to get time in HHMMSS format
// Courtesy : Nigel/Gavin

string6 getTime() := BEGINC++
	// Declarations
	struct tm localt; // localtime in "tm" structure
	time_t timeinsecs;  // variable to store time in secs

	// Get time in sec since Epoch
	time(&timeinsecs);  
	// Convert to local time
	localtime_r(&timeinsecs,&localt);
	// Format the local time value
	strftime(__result, 8, "%H%M%S", &localt); // Formats the localtime to HHMMSS
	
ENDC++;

return getTime();

end;