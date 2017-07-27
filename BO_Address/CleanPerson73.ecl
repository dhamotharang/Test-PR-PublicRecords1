


////////////////////////////////////////////////////////////////////////////
// clean U return a 73 byte string

import BO_Address.NameUtils;
	

export CleanPerson73(const string line1,
							const string server = Bo_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION
							
string xmldata := BOCleanUName(RegexReplace('(<)|(>)',line1,''),server,port);

string5 pre := NameUtils.prename(xmldata);
string20 fn := NameUtils.fname(xmldata);
string20 mn := NameUtils.mname(xmldata);
string20 lsn := NameUtils.lname(xmldata);
string5 hp := NameUtils.honpost(xmldata);
string5 mp := NameUtils.matpost(xmldata);
string5 tt := NameUtils.title(xmldata);
string5 scr := NameUtils.score(xmldata);
return(pre+fn+mn+lsn+if(hp = '',if(mp = '',tt,mp),hp)+scr);

							
end;