export TimeZone_Convert(unsigned1 timezone, string2 state) := 
	ut.TimeZones((2* timezone) + if(ut.GetDaylightSavings(state),1,0));