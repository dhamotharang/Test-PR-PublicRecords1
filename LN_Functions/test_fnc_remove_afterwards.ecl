export test_fnc_remove_afterwards(string origName) := function


pStringIna := stringlib.stringfindreplace(stringlib.stringtouppercase(origName    ),'; OWNER OCCUPIED',' ');
pStringInb := stringlib.stringfindreplace(stringlib.stringtouppercase(pStringIna),' OWNER OCCUPIED',' ');
pStringInc := stringlib.stringfindreplace(stringlib.stringtouppercase(pStringInb),' (COMMUNITY PROPERTY)',' ');
pStringInd := stringlib.stringfindreplace(stringlib.stringtouppercase(pStringInc),' ETAL',' ');
pStringIne := stringlib.stringfindreplace(stringlib.stringtouppercase(pStringInd),' (ESTATE)',' ');
pStringInf := stringlib.stringfindreplace(stringlib.stringtouppercase(pStringIne),' ETUX',' ');
return pStringInf;

end;
//origName:= 'husband and wife';
//test_fnc_remove_afterwards(origName)