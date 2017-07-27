IMPORT  BO_Address;


export BOZip9ToGeo34(const string zip9,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION 
							
string send_payload := '<transaction><command_name>Zip9ToGeo34</command_name><parameters>' +
	if(zip9[1..5] = ''	,'', '<POSTCODE1>' + zip9[1..5] + '</POSTCODE1>')+
	if(zip9[6..9] = ''	,'', '<POSTCODE2>' + zip9[6..9] + '</POSTCODE2>')+
	'</parameters></transaction>';

 clean := AddrCleanLib.CleanLNBO (send_payload, server, port); 
 
// lat long msa cgeo_blk geo_match 
// 26.169178 -80.308352 2680060118151
/*
lat 26.169178
long -80.308352
msa 2680
geo blk 06011815
geo match 1
*/

string10 ga := AddrUtils.geo_lat(clean);
string11 go := AddrUtils.geo_long(clean);
string4 ma := AddrUtils.msa(clean);
string7 gb := AddrUtils.geo_blk(clean);
string1 gm := AddrUtils.geo_match(clean);
 


return(ga+go+ma+gb+gm+ if(ga+go+ma+gb+gm = '' , 0 , 1));
 // return clean; 
END;							