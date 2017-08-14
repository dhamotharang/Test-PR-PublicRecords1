Import data_services;
r:=RECORD
	string28 prim_name;
	string10 prim_range;
	string2 st;
	unsigned4 city_code;
	string5 zip;
	string8 sec_range;
	string6 dph_lname;
	string20 lname;
	string20 pfname;
	string20 fname;
	unsigned8 states;
	unsigned4 lname1;
	unsigned4 lname2;
	unsigned4 lname3;
	unsigned4 lookups;
	unsigned6 did;
END;

d	:=dataset([],r);

EXPORT Key_Auto_Address(string Platform) :=	Index(d,{d},
																									data_services.Data_location.Prefix(Platform) + 'thor_data400::key::' 
																									+Platform	+'::qa::autokey::address');

