export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |';		
		shared PatternInvalidWords2	 	:= 'SAME AS ABOVE';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1		 := '^SAME$|^SAME | SAME |SAME AS ABOVE';
		export InvalidWords						:= PatternInvalidWords1;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		SHARED PatternInvalidWords1		 := '^XX|^SAME$|^SAME | SAME |SAME AS ABOVE';

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |SAME AS ABOVE';
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |SAME AS ABOVE';
		export InvalidWords						:= PatternInvalidWords1;
	end;

	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE |UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE |UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE |UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;

end;