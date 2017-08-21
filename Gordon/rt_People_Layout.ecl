/*--METADATA('SampleFile', '~file::10.150.51.30::c$::jim::people')*/
/*--METADATA('SampleFileType', 'Flat')*/
export rt_people_Layout := 
  record
	string15 FirstName;
	string25 FamilyName;
	string15 MiddleName;
	string5 Zip5;
	string42 StreetAddress;
	string20 City;
	string2 StateCode;
  end;
