export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|AS ADDRESSED|SAME AS ABOVE|NO STREET ADDRESS LISTED|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|AS ADDRESSED|SAME AS ABOVE|NO STREET ADDRESS LISTED|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^XX|NOT GIVEN|NOT PROVIDED|AS ADDRESSED|SAME AS ABOVE|NO STREET ADDRESS LISTED|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|AS ADDRESSED|SAME AS ABOVE|NO STREET ADDRESS LISTED|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|AS ADDRESSED|SAME AS ABOVE|NO STREET ADDRESS LISTED|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|SAME AS ABOVE|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|SAME AS ABOVE|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT GIVEN|NOT PROVIDED|SAME AS ABOVE|';
		shared PatternInvalidWords2   := 'NONE LISTED|^NONE$|^SAME$|^UNKNOWN|UNKNONW|UNKOWN|^N\\/A$';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

end;