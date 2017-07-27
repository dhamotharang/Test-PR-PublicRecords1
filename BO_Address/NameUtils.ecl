//////////////////////////////////////////////////////////////////////
// these are the guys that you call
import BO_Address, lib_stringlib;
export NameUtils := module
export string prename(string payload) := function
return(BO_Address.parse_xml('PRENAME',payload));
end;
export string fname(string payload) := function
return(BO_Address.parse_xml('FIRST_NAME',payload));
end;
export string mname(string payload) := function
return(BO_Address.parse_xml('MIDDLE_NAME',payload));
end;
export string lname(string payload) := function
return(BO_Address.parse_xml('LAST_NAME',payload));
end;
export string honpost(string payload) := function
return(BO_Address.parse_xml('HONARY_POST',payload));
end;
export string honpost_2(string payload) := function
return(BO_Address.parse_xml('HONORARY_POSTNAME',payload));
end;
export string matpost(string payload) := function
return(BO_Address.parse_xml('SUFFIX_NAME',payload));
end;
export string title(string payload) := function
return(BO_Address.parse_xml('TITLE',payload));
end;
export string score(string payload) := function
//return(parse_xml('SCORE',payload));
return('99');
end;

export string gender_id(string payload) := function
return(BO_Address.parse_xml('GENDER_ID',payload));
end;

export string preferred_name(string payload) := function
return(BO_Address.parse_xml('PREFERRED_NAME',payload));
end;





export string prename2(string payload) := function
return(BO_Address.parse_xml('PRENAME2',payload));
end;
export string fname2(string payload) := function
return(BO_Address.parse_xml('FIRST_NAME2',payload));
end;
export string mname2(string payload) := function
return(BO_Address.parse_xml('MIDDLE_NAME2',payload));
end;
export string lname2(string payload) := function
return(BO_Address.parse_xml('LAST_NAME2',payload));
end;
export string honpost2(string payload) := function
return(BO_Address.parse_xml('HONARY_POST2',payload));
end;
export string matpost2(string payload) := function
return(BO_Address.parse_xml('SUFFIX_NAME2',payload));
end;
export string title2(string payload) := function
return(BO_Address.parse_xml('TITLE2',payload));
end;
export string score2(string payload) := function
return(BO_Address.parse_xml('SCORE2',payload));
end;
export string firm1(string payload) := function
return(BO_Address.parse_xml('FIRM1',payload));
end;
export string firm2(string payload) := function
return(BO_Address.parse_xml('FIRM2',payload));
end;

export fixfirmname(string prawname,string pcleanname) := 
function
	// try to fix problems where it explodes out acronyms. 
	lfixed1 := if((stringlib.stringfind(prawname,'DEPARTMENT OF MEDICAL EDUCATION',1) = 0) and stringlib.stringfind(pcleanname,'DEPARTMENT OF MEDICAL EDUCATION',1) != 0
								,stringlib.stringfindreplace(pcleanname,'DEPARTMENT OF MEDICAL EDUCATION','DME')
								,pcleanname
							);
	lfixed2 := if((stringlib.stringfind(prawname,'HEWLETTPACKARD',1) = 0) and stringlib.stringfind(lfixed1,'HEWLETTPACKARD',1) != 0
								,stringlib.stringfindreplace(lfixed1,'HEWLETTPACKARD','HP')
								,lfixed1
							);
	lfixed3 := if((stringlib.stringfind(prawname,'DUN BRADSTREET',1) = 0) and stringlib.stringfind(lfixed2,'DUN BRADSTREET',1) != 0
								,stringlib.stringfindreplace(lfixed2,'DUN BRADSTREET','D&B')
								,lfixed2
							);
	lfixed4 := if((stringlib.stringfind(prawname,'GENERAL MOTORS',1) = 0) and stringlib.stringfind(lfixed3,'GENERAL MOTORS',1) != 0
								,stringlib.stringfindreplace(lfixed3,'GENERAL MOTORS','GM')
								,lfixed3
							);

	return lfixed4;

end;

end;