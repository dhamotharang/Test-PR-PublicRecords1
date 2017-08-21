export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;

		shared PatternInvalidWords1	 	:= '^NAME RESERVATION$|^RESERVED$|^RESIGNED$|^NONE$| NONE |^NO STREET LISTED$|^NONE DESIGNATED$|^NONE GIVEN$|^NONE LISTED$|^NO STREET LISTED$|^NO ADDRESS LISTED$|^NO ADDRESS GIVEN$|^NO STREET ADDRESS$';
		shared PatternInvalidWords2	 	:= '^NO STREET$|^NO STREET ADDRESS GIVEN$|^NONE APPOINTED$|^NO STREET ADDRESS LISTED$';

		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;

		shared PatternInvalidWords1	 	:= '^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		SHARED PatternInvalidWords1		:= '^XX$|^NO$|^UN$|^FF$|^NA$|^U $|^TBD$';

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1;
	end;
	
	export FirstName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;

		shared PatternInvalidWords1	 	:= 'NOT ENTERED IN SYSTEM|^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export MiddleName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT ENTERED IN SYSTEM|^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	

		export InvalidWords						:= PatternInvalidWords1;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*(\\#)*(\\+)*(\\-)*(\\^)*(\\/)*(\\Â¦)*(\\])*(\\[)*(\\%)*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'NOT ENTERED IN SYSTEM|^N(\\/)A$|^NONE$|^SAME$|^SAME AS|^UNKNOWN$|^UNKNONW$|^NKNOWN$';	
		export InvalidWords						:= PatternInvalidWords1;
	end;                                                                                         
  
	export FullName := module
		//Note:Hex values are as follows:;x60=>`;
		shared PatternInvalidChar1		:= '(\\x60)*';
		export InvalidChars						:= PatternInvalidChar1;
		shared PatternInvalidWords1	 	:= '^ADD FOR SVC$|^ADDRESS FOR SERVICE$|^ADDRES FOR SERVICE$|^ADDRSS FOR SERVICE, AGENT$|^ADDRESS OF PROCESS$$|^AGENT RESIGNATION$|^AGENT RESIGNED$|^AGENT$|';
		shared PatternInvalidWords2	 	:= '^AGT$|^HDQRTRS$|^HDQRTS$|^HDQTERS$|^HDQTRS$|^HADTRS ADDRESS$|^HEADQUARTERS$|^NAME$|^NAME REGISTRATION$|^NAME RESERVATION$|^NONE$|';
		shared PatternInvalidWords3	 	:= '^PRINCIPLE OFFIC$E|^PRINC OFC$|^REGISTER NAME REGISTERED$|^REGISTERED NAME$|^REGISTERED$|^REGISTER$|^RESERVE NAME$|^RESERVED$|^RESERVE$|';
		shared PatternInvalidWords4	 	:= '^RESERVED LLC NAME$|^SERVICE ADDRESS$|^REGISTRATION$|^ADD FOR SERVICE$|^RESERVATION$|^NONPROFIT$|^FOR SERVICE$|^CORPORATE$';

		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3 + PatternInvalidWords4;
	end;

end;