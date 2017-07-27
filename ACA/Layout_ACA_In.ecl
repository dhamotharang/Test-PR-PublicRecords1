export Layout_ACA_In := record
//**** Old Layout - 2007
//	string50	name;
//	string70	title;
//	string200	Institution;
//	string120	Addr1;
//	string120	Addr2;
//	string30	City;
//	string10	State;
//	string9	Zip;
//**** New Layout - 2009
	string2		Inst_type;
	string200	Institution;
	string240	Mail_Addr;
	string30	Mail_City;
	string10	Mail_State;
	string9		Mail_Zip;
	string240	Addr1;
	string30	City;
	string10	State;
	string9		Zip;
	string100	Notes;	
end;
	