


EXPORT CleanDiscreetPerson (const string prename,
							const string fname,
							const string mname,
							const string lname,
							const string honpost,
							const string matpost,
							const string title,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION


string send_payload := '<transaction><command_name>discreet_person</command_name><parameters>' +
	if(prename = ''	,'', '<prename>' + RegexReplace('(<)|(>)',prename,'') + '</prename>')+
	if(fname = ''	,'', '<fname>' + RegexReplace('(<)|(>)',fname,'') + '</fname>')+
	if(mname = ''	,'', '<mname>' + RegexReplace('(<)|(>)',mname,'') + '</mname>')+
	if(lname = ''	,'', '<lname>' + RegexReplace('(<)|(>)',lname,'') + '</lname>')+
	if(honpost = ''	,'', '<honpost>' + RegexReplace('(<)|(>)',honpost,'') + '</honpost>')+
	if(matpost = ''	,'', '<matpost>' + RegexReplace('(<)|(>)',matpost,'') + '</matpost>')+
	if(title = ''	,'', '<title>' + RegexReplace('(<)|(>)',title,'') + '</title>') +
	'</parameters></transaction>';

 clean := AddrCleanLib.CleanLNBO (send_payload, server, port); 
 
 
 
string5 pren := AddrUtils.dpn(clean);
string20 firstn := AddrUtils.fn(clean);
string20 midn := AddrUtils.mn(clean);
string20 lastname := AddrUtils.dlastn(clean);
string5 sufx := AddrUtils.dsuf(clean); 
string5 honp := AddrUtils.dhon(clean);
string5 the_title := AddrUtils.dtl(clean);

return(pren+firstn+midn+lastname+sufx+honp+the_title);
 // return clean; 
END;