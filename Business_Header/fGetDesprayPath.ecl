export fGetDesprayPath(

	 string pKeyname
	,string pDestinationMount

) :=
function

	//use regex to get rid out beginning of keyname
	regex 	:= '^.*key::moxie[.](.*)$';
	regex2	:= '^.*key::moxie[.]([^.]*).*$';
	
	destinationkeyname	:= regexreplace(regex	, pKeyname, '$1', nocase);
	subdir							:= regexreplace(regex2, pKeyname, '$1', nocase);
	
	destinationfullpath := if(regexfind('people', subdir, nocase)
														,pDestinationMount + destinationkeyname
														,pDestinationMount + subdir + '/' + destinationkeyname
													);
	
	return destinationfullpath;

end;