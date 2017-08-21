export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';		
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^XX|SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME SEE 4|SEE 4|SAME AS ABOVE|^SAME$| SAME |AS ABOVE|NOT GIVEN|';	
		shared PatternInvalidWords2   := 'NOT PROVIDED|NOT PORVIDED|NOT PROVIDE|NOT PROVIEDED|NO PROVIDED|';
		shared PatternInvalidWords3	 	:= 'AS ADDRESSED|^NONE$|^NONE | NONE |^NA |AL NONE|VARIOUS|N/A|INACTIVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3;
	end;

end;