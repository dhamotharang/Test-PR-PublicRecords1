export string12 getTimeStamp () := function

// Function to get time in HHMMSS Milliseconds format

string12 getTime() := BEGINC++
     struct timeval tv;
     struct timezone tz;

     char outstr[13];  // allow for trailing null
			
     struct tm localt; // localtime in "tm" structure
		 
     gettimeofday(&tv, &tz);
     localtime_r(&tv.tv_sec, &localt);
     sprintf(outstr, "%02d%02d%02d%06d", localt.tm_hour, localt.tm_min,
              localt.tm_sec, (int)tv.tv_usec);

		 strncpy(__result, outstr, 12);
		 
ENDC++;

return getTime();

end;