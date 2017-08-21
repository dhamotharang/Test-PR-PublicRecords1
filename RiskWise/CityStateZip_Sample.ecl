layout_ctystzip_raw := record
	string1 copyrightdetailcode;
	string5 zip5;
	string6 ctystkey;
	string1 zipclass;
	string28 city;
	string13 ctystabbr;
	string1 ctystfaccde;
	string1 ctystmail;
	string6 prefctystkey;
	string28 prefctystname;
	string1 ctydelind;
	string1 carrterate;
	string1 unqzip;
	string6 finanum;
	string2 state;
	string3 cntynum;
	string25 county;
end;



dFile_CityStateZip := sort(File_CityStateZip, zip5, city, county);

raw_citystatezip_data_father := dataset('~thor_data400::in::usps::20111024::citystatezip', layout_ctystzip_raw, flat);
detail_records_father := raw_citystatezip_data_father(copyrightdetailcode='D');  // filter out only the detail records

Riskwise.Layout_CityStZip removeUnusedfather(detail_records_father le) := transform
	self := le;
	end;
	
File_CityStateZip_father :=	project(detail_records_father, removeUnusedfather(left));
	
dFile_CityStateZip_father := sort(File_CityStateZip_father, zip5, city, county);

Riskwise.Layout_CityStZip tjoin(dFile_CityStateZip l ,dFile_CityStateZip_father r) := transform
self := l;
end;

j1 := join(dFile_CityStateZip,dFile_CityStateZip_father,LEFT.zip5=RIGHT.zip5 and LEFT.city=RIGHT.city and LEFT.county=RIGHT.county, tjoin(LEFT,RIGHT) , LEFT ONLY);

export CityStateZip_Sample := output(j1);
