export utilities :=
module

	export fIsUSA(string pCountry) :=
	function
	
		isusa := if(
			regexfind('^(UNITED[ ]*STATES[ ]*OF[ ]*AMERICA|U[.]?S[.]?[A]?[.]?)$',trim(pCountry,left,right),nocase)	,true
																																										,false
		
		
		);
		
		RETURN isusa;
	
	end;


end;