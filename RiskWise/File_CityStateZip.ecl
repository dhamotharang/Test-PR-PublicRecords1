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

raw_citystatezip_data := dataset('~thor_data400::in::citystatezip', layout_ctystzip_raw, flat);

detail_records := raw_citystatezip_data(copyrightdetailcode='D');  // filter out only the detail records

Riskwise.Layout_CityStZip removeUnused(detail_records le) := transform
	self := le;
end;

export File_CityStateZip := project(detail_records, removeUnused(left));




