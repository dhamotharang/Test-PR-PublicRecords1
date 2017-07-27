EXPORT fnCleanFunction := module

export clean_address(string address) := function

remove_junk := stringlib.stringcleanspaces(if(stringlib.stringfind(address, 'C/O', 1) > 0 and ~regexfind('[0-9]+', address),
'', if(stringlib.stringfind(address, 'C/O', 1) > 0,  stringlib.StringFindReplace(address, 'C/O', ''), address))); 

bad_address := ['ATTN: DANIELLE FERREIRA 78548-083, FCI MARIANNA', 'FCI DUBLIN, FEDERAL CORRECTIONAL INSTITUTION', 'FEINSTEIN BLDG, UNIVERSITY OF RHODE ISLAND',
'FCI LA TUNA, FEDERAL CORRECTIONAL INSTITUTION'];

remove_junk1 := if(remove_junk in bad_address, '', remove_junk);

return remove_junk1;
			
END;	
		

export clean_date(string indate) := function //dates 08/18/2006
                       
										cleanit 	:= trim(indate, left, right);								
										indate_clean := if(cleanit <> '' and ~regexfind('[a-zA-Z]+',cleanit), cleanit[7..10] + cleanit[1..2] + cleanit[4..5], cleanit);
								return indate_clean;

end;				
end;
		