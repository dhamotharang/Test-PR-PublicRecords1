export boolean isNumeric(const STRING instring) := 
	BEGINC++
	  if (strlen(instring) == 0)
		  return false;

		static const char* const numbers = "0123456789";
		for(const char * finger = instring; finger && *finger != 0; ++finger)
		{
			if (strchr(numbers, *finger) == NULL)
			  return false;
		}
		return true;
	ENDC++;