export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'FICHE|FILED|FILING|CHAPTER|^C\\/*O |^NON( )*APPLICABLE|^NOT( )*APPLICABLE|^N(\\/)*A$|^NONE|^SAME *(AS)*|^AS|';
		shared PatternInvalidWords2	 	:= 'SEE CARD|SEE TRUST|SEE FILE|SEE FILING|SEE DOCUMENT|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;

		shared PatternInvalidWords1	 	:= 'FICHE|FILED|FILING|CHAPTER|^C\\/*O |^NON( )*APPLICABLE|^NOT( )*APPLICABLE|^N(\\/)*A$|^NONE|^SAME *(AS)*|^AS|';
		shared PatternInvalidWords2	 	:= 'SEE CARD|SEE TRUST|SEE FILE|SEE FILING|SEE DOCUMENT|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1		:= '^XX|NO$|^UN|^FF|^NA|^U ';

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME|NONE|UNKNOWN';
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^SAME$|^NONE$|^UNKNOWN$';
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'ABOVE|AGENT RESIGNED|NO AGENT|AMENDMENT|FOR ADDITIONAL|SEE CARD|SEE DOCUMENT|NAMES|';
		shared PatternInvalidWords2	 	:= '^SAME$|^NONE$|^UNKNOWN$';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'ABOVE|AGENT RESIGNED|NO AGENT|AMENDMENT|FOR ADDITIONAL|SEE CARD|SEE DOCUMENT|NAMES|';
		shared PatternInvalidWords2	 	:= '^SAME$|^NONE$|^UNKNOWN$';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*(\\_)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		shared PatternInvalidWords1	 	:= 'ABOVE|AGENT RESIGNED|NO AGENT|AMENDMENT|FOR ADDITIONAL|SEE CARD|SEE DOCUMENT|NAMES|NONE|';
		shared PatternInvalidWords2	 	:= '^SAME$|^UNKNOWN$';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

end;