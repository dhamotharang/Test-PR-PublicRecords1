export Chr2PhoneDigit(STRING1 c) := 
MAP(c IN ['A','B','C'] => 2,
		c IN ['D','E','F'] => 3,
		c IN ['G','H','I'] => 4,
		c IN ['J','K','L'] => 5,
		c IN ['M','N','O'] => 6,
		c IN ['P','Q','R','S'] => 7,
		c IN ['T','U','V'] => 8,
		c IN ['W','X','Y','Z'] => 9, 0);
															