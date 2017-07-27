////////////////////////////////////////////////////////////////////////////
// clean fml return a 50 byte string

import BO_Address.NameUtils;
	

export CleanFirmName(const string line1,const string line2 = '',
							const string server = Bo_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION
							
string xmldata := BOCleanFirmName(RegexReplace('(<)|(>)',line1,''),RegexReplace('(<)|(>)',line2,''),server,port);

string120 firm1 := NameUtils.fixfirmname(line1,NameUtils.firm1(xmldata));
string120 firm2 := NameUtils.fixfirmname(line2,NameUtils.firm2(xmldata));

string5 pre := NameUtils.prename(xmldata);
string20 fn := NameUtils.fname(xmldata);
string20 mn := NameUtils.mname(xmldata);
string20 lsn := NameUtils.lname(xmldata);
string5 hp := NameUtils.honpost(xmldata);
string5 mp := NameUtils.matpost(xmldata);
string5 tt := NameUtils.title(xmldata);

string5 pre2 := NameUtils.prename2(xmldata);
string20 fn2 := NameUtils.fname2(xmldata);
string20 mn2 := NameUtils.mname2(xmldata);
string20 lsn2 := NameUtils.lname2(xmldata);
string5 hp2 := NameUtils.honpost2(xmldata);
string5 mp2 := NameUtils.matpost2(xmldata);
string5 tt2 := NameUtils.title2(xmldata);

return(firm1 + firm2 + (pre+fn+mn+lsn+if(hp = '',if(mp = '',tt,mp),hp) ) 
+ (pre2+fn2+mn2+lsn2+if(hp2 = '',if(mp2 = '',tt2,mp2),hp2) ));

							
end;