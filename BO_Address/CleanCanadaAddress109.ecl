
export CleanCanadaAddress109(const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port,
							string1 lang = '')	:= FUNCTION
		 		
string xmldata := BOCleanCanadaAddress(
			RegexReplace('(<)|(>)',line1,''),
			RegexReplace('(<)|(>)',line2,''),
			server,port,lang);


string10 pr := AddrUtils.prim_range(xmldata);
string2 pd := AddrUtils.postdir(xmldata);
string28 pn := AddrUtils.prim_name(xmldata);
string4 ads := AddrUtils.addr_suffix(xmldata);
string10 ud := AddrUtils.unit_desig(xmldata);
string8 sr := AddrUtils.sec_range(xmldata);
string30 pcn := AddrUtils.p_city_name(xmldata);
string2 re := AddrUtils.region1(xmldata);
string6 pf := AddrUtils.postcode_full(xmldata);
string2 rt := AddrUtils.record_type(xmldata);
string1 lan := AddrUtils.language(xmldata);
string5 sc := AddrUtils.status_code(xmldata);

return(pr+pd+pn+ads+ud+sr+pcn+re+pf+
					rt+lan+sc);



							
end;