

import BO_Address, BO_Address.NameUtils;
	

export CleanPersonFMLEnclarity(const string line1,
							const string server, 
							unsigned2 port)	:= FUNCTION
							
string xmldata := BO_Address.BOCleanFMLNameEnclarity(RegexReplace('(<)|(>)|\\0',line1,''),server,port);

string15 pre := BO_Address.NameUtils.prename(xmldata);
string50 fn := BO_Address.NameUtils.fname(xmldata);
string50 mn := BO_Address.NameUtils.mname(xmldata);
string50 lsn := BO_Address.NameUtils.lname(xmldata);
string15 hp := BO_Address.NameUtils.honpost_2(xmldata);
string15 mp := BO_Address.NameUtils.matpost(xmldata);
string15 tt := BO_Address.NameUtils.title(xmldata);
string5 scr := BO_Address.NameUtils.score(xmldata);
string1 gen := BO_Address.NameUtils.gender_id(xmldata);
string50 pn := BO_Address.NameUtils.preferred_name(xmldata);
return(pre+fn+mn+lsn+hp+mp+tt+scr+gen+pn);

							
end;