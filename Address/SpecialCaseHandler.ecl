export SpecialCaseHandler := MODULE

	export string StandardizeCityName(string addr_second_line):=FUNCTION
		Standard_addr_second_line:= REGEXREPLACE('^ST[ .]+', addr_second_line, '$1SAINT ',NOCASE);
		return Standard_addr_second_line;
	END;
	
END;


// Alternate ways for implementing:
// The purpose is to replace ST or ST. with SAINT only when it is in the begining of City name
// Standard_addr_second_line:= REGEXREPLACE('(ST)(.*) ', addr_second_line, 'SAINT ',NOCASE); // Not working as expected
// Standard_addr_second_line:= REGEXREPLACE('^ST[ .]+', addr_second_line, '$1SAINT ',NOCASE);
// Standard_addr_second_line:=  REGEXREPLACE('^(ST |ST. )', addr_second_line,'SAINT ',NOCASE);

// Standard_addr_second_line_tmp:= REGEXREPLACE('ST ', addr_second_line, 'SAINT ',NOCASE);
// Standard_addr_second_line:= REGEXREPLACE('ST. ', Standard_addr_second_line_tmp, 'SAINT ',NOCASE);




