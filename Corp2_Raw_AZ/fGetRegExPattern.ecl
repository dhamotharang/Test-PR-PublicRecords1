export fGetRegExPattern := module

	export Address := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;

		shared PatternInvalidWords1	 	:= '^NONE$|^NONE | NONE |^SAME|0OT REQUIRED|ADDRESS|AS ADDRESSED|COMPANY ADDRESS|CORPORATION ADDRESS|ENITTY DID NOT PROVIDE';
		shared PatternInvalidWords2	 	:= '|ENTITY DID NOT PROVIDE ADDRESSS|ENTITY DID NOT PROVIDE|ENTITY DID NOT PROVIDE AN ADDRESSS|- MAILING ADDRESS';
		shared PatternInvalidWords3	 	:= '|MAILING ADDRESS|MAILING|N0T REQUIRED X X|N0T REQUIRED|NO ADDRES REQUIRED|NO REQUIRED|NOAT REQUIRED|NOIT REQUIRED';
		shared PatternInvalidWords4	 	:= '|-NONE ON FILE-|NOOT REQUIRED XX|NOOT REQUIRED|NOT APPLICABLE|NOT GIVEN|NOT PROVIDED|NOT REQIURED|NOT REQUIED|NOT REQUIQRED';
		shared PatternInvalidWords5	 	:= '|NOT REQUIRD|NOT REQUIRED|NOT REQUIRE|NOT REQURIED|NOT RREQUIREDENTITY DID NOT PROVIDE CORPORATION ADDRESS';
		shared PatternInvalidWords6	 	:= '|NOT RREQUIRED|NOTR REQUIRED X X|NOTR REQUIRED XX|NOTR REQUIRED|NOTT REQUIRED|NOTY REQUIRED|NPOT REQUIRED|NTO REQUIRED';
		shared PatternInvalidWords7	 	:= '|SAME AS ABOVE|THIS IS A STREET ADDRESS|USE THIS ADDRESS FOR MAIL';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2 + PatternInvalidWords3 + PatternInvalidWords4 + PatternInvalidWords5 + PatternInvalidWords6 + PatternInvalidWords7;
	end;
                                               

	export City := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= '^XX|SAME AS ABOVE|^SAME|NOT GIVEN|-NONE ON FILE-|^NONE|NOT PROVIDED|NOT APPLICABLE|NOT REQUIRED|NOT REQUIRE|NOTREQUIRED|NO REQUIRED|OT REQUIRED';
		export InvalidWords						:= PatternInvalidWords1;
	end;
													 
	export State := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'XX';
		export InvalidWords						:= PatternInvalidWords1;
	end;

	export Zip := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME AS ABOVE|^SAME$|^SAME | SAME |NOT GIVEN|-NONE ON FILE-|NOT PROVIDED|NOT REQUIRED|COMPANY ADDRESS|';		
		shared PatternInvalidWords2	 	:= 'AS ADDRESSED|^NONE|ENTITY DID NOT PROVIDE CORPORATION ADDRESS|ENTITY DID NOT PROVIDE ADDRESSS';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;
	
	export Country := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME AS ABOVE|^SAME$|^SAME | SAME |NOT GIVEN|-NONE ON FILE-|NOT PROVIDED|NOT REQUIRED|COMPANY ADDRESS|';		
		shared PatternInvalidWords2	 	:= 'AS ADDRESSED|^NONE|ENTITY DID NOT PROVIDE CORPORATION ADDRESS|ENTITY DID NOT PROVIDE ADDRESSS';
		export InvalidWords						:= PatternInvalidWords1 + PatternInvalidWords2;
	end;

	export LastName := module
		//Note:Hex values are as follows:x2a=>*;x5c=>\;x27=>';x60=>`;x40=>@;x5b=>[;x5d=>];
		shared PatternInvalidChar1		:= '(\\x2a)*(\\x5c)*(\\x27)*(\\x60)*(\\x40)*(\\$)*(\\{)*(\\})*(\\x5b)*(\\x5d)*(\\^)*(\\!)*(\\~)*(\\`)*';
		shared PatternInvalidChar2		:= '(\\")*(\\.)*(\\,)*(\\:)*(\\=)*(\\|)*(\\;)*(\\()*(\\))*';
		export InvalidChars						:= PatternInvalidChar1  + PatternInvalidChar2;
		
		shared PatternInvalidWords1	 	:= 'SAME AS ABOVE|^SAME$|^SAME | SAME |^NONE$|^NONE | NONE |UNKNOWN|NOT GIVEN|NOT PROVIDED|ENTITY DID NOT PROVIDE';
		export InvalidWords						:= PatternInvalidWords1;
	end;

end;