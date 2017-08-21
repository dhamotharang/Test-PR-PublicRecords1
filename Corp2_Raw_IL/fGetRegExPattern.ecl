export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1 	:= '^NONE *(SAME *AS  *ABOVE)|^SAME$|^SAME | SAME |^XX|SEE DOCUMENT|NONE PROVIDED|NONE( )*GIVEN(\\.)*|';
		shared PatternInvalidWords2 	:= 'UNDER *NONE|^NONE$|^NONE | NONE |UNKNOWN|^NON(\\-)*COMPLIANCE$';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1		:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE | NONE$|UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1		:= '^XX|NO$|^UN|^FF|^NA|^U |SELECT STATE';

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1		:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE | NONE$|UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^SAME | SAME |^NONE$|^NONE | NONE | NONE$|UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;

	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^AGENT VACATED$|^THE SAME AS ABOVE$|^SAME AS SAME$|^SAME SAME$|^SAMEM$|^SAME AS ABOVE IL$|^SAME AS ABOVE$|^AS ABOVE$|^SAME AS BELOW$|^BELOW$|';
		shared PatternInvalidWords2	 	:= '^VOLUNTARY DISSOLUTION$|^INVOLUNTARY DISSOLUTION$|^NONE IL$|^REVOKED|SAME IL$|^SAME$|^SAME | SAME$| SAME |^NONE$|^NONE | NONE | NONE$|^SOLE OFFICER$|';
		shared PatternInvalidWords3	 	:= '^REGISTERED NAME EXPIRED$|^INVOLUNTARY DISSOLUTION$|^UNKNOWN$|^VACANT IL$|^VACANT MI$|^VACANT$|^WITHDRAWN$|^SANE|^N\\/A$';

		export InvalidWords						:= PatternInvalidWords1+PatternInvalidWords2+PatternInvalidWords3;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^AGENT VACATED$|^THE SAME AS ABOVE$|^SAME AS SAME$|^SAME SAME$|^SAMEM$|^SAME AS ABOVE IL$|^SAME AS ABOVE$|^AS ABOVE$|^SAME AS BELOW$|^BELOW$|';
		shared PatternInvalidWords2	 	:= '^VOLUNTARY DISSOLUTION$|^INVOLUNTARY DISSOLUTION$|^NONE IL$|^REVOKED|SAME IL$|^SAME$|^SAME | SAME$| SAME |^NONE$|^NONE | NONE | NONE$|^SOLE OFFICER$|';
		shared PatternInvalidWords3	 	:= '^REGISTERED NAME EXPIRED$|^INVOLUNTARY DISSOLUTION$|^UNKNOWN$|^VACANT IL$|^VACANT MI$|^VACANT$|^WITHDRAWN$|^SANE|^N\\/A$';

		export InvalidWords						:= PatternInvalidWords1+PatternInvalidWords2+PatternInvalidWords3;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^AGENT VACATED$|^THE SAME AS ABOVE$|^SAME AS SAME$|^SAME SAME$|^SAMEM$|^SAME AS ABOVE IL$|^SAME AS ABOVE$|^AS ABOVE$|^SAME AS BELOW$|^BELOW$|';
		shared PatternInvalidWords2	 	:= '^VOLUNTARY DISSOLUTION$|^INVOLUNTARY DISSOLUTION$|^NONE IL$|^REVOKED|SAME IL$|^SAME$|^SAME | SAME$| SAME |^NONE$|^NONE | NONE | NONE$|^SOLE OFFICER$|';
		shared PatternInvalidWords3	 	:= '^REGISTERED NAME EXPIRED$|^INVOLUNTARY DISSOLUTION$|^UNKNOWN$|^VACANT IL$|^VACANT MI$|^VACANT$|^WITHDRAWN$|^SANE|^N\\/A$';

		export InvalidWords						:= PatternInvalidWords1+PatternInvalidWords2+PatternInvalidWords3;
	end;

end;