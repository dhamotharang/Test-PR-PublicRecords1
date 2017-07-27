#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib;

export Parse_and_Rollup_Addresses(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Layout	
	Layout_Addresses := record
		string	Type;
		string	Street_1;
		string	Street_2;
		string	City;
		string	State;
		string	Postal_Code;
		string	Country;
		string	Comments;
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Addresses;
		//string ID;
		string addr_info;
	end;

	//Input Files
	//in_f 				:= worldcheck.File_WorldCheck_In;
	in_file_2			:= distribute(in_f, random());
	ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for AKAs and alternate spellings
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
	end;

	Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

//POPULATE ADDRESSES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing Locations//////////
	// Parse the Locations	
	MyParsedLocations := PARSE(ds_with_new_fields(trim(Locations,left,right) != ''),Locations,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid Locations
	// Transform the Locations
	Layout_temp trfLocations(MyParsedLocations l) := transform
		self.addr_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= ''; 
		self.Street_1		:= '';	
		self.Street_2		:= '';
		self.City			:= '';
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= '';
		self.Comments		:= '';
		self.ID				:= l.uid;
	end;

	// Reformat Locations
	ds_NormLocations := project(MyParsedLocations, trfLocations(left));
							
	Layout_temp locationsTran(ds_NormLocations l):= transform
		self.Street_1		:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[1..stringlib.stringfind(l.addr_info, '~', 1)-1]),
									'');	
		self.Street_2		:= '';
		self.City			:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[stringlib.stringfind(l.addr_info, '~', 1)+1..stringlib.stringfind(l.addr_info, '~', 2)-1]),
									'');
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[stringlib.stringfind(l.addr_info, '~', 2)+1..length(l.addr_info)]),
									'');
		self := l;
	end;
	
reformLocations := project(ds_NormLocations, locationsTran(left));

	foreignLocations := reformLocations(trim(stringlib.stringtouppercase(country), left, right) <> 'USA');
	usaLocations	 := reformLocations(trim(stringlib.stringtouppercase(country), left, right) = 'USA');

	Layout_temp USLocationsTran(usaLocations l):= transform
		
		//~ New York City, New York ~ USA
		city_filter  		:= if(regexfind(',', l.city, 0)<>'',
									trim(l.city[1..stringlib.stringfind(l.city, ',', 1)-1]),
									'');					
		state_filter 		:= if(regexfind(',', l.city, 0)<>'',
									trim(l.city[stringlib.stringfind(l.city, ',', 1)+1.. length(l.city)]),
									'');
		
		//NORTH RICHLAND HILLS, TX ~,~ USA
		comma_street_1		:= if(stringlib.stringfind(l.street_1, ',', 4)<>0,
									trim(l.street_1[1..stringlib.stringfind(l.street_1, ',', 2)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 3)<>0,
									trim(l.street_1[1..stringlib.stringfind(l.street_1, ',', 1)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 2)<>0,
									trim(l.street_1[1..stringlib.stringfind(l.street_1, ',', 1)-1], left, right),
								'')));
									
		comma_street_2		:= if(stringlib.stringfind(l.street_1, ',', 4)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 2)+1..stringlib.stringfind(l.street_1, ',', 3)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 3)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 1)+1..stringlib.stringfind(l.street_1, ',', 2)-1], left, right),
									''));

		comma_city			:= if(stringlib.stringfind(l.street_1, ',', 4)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 3)+1..stringlib.stringfind(l.street_1, ',', 4)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 3)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 2)+1..stringlib.stringfind(l.street_1, ',', 3)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 2)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 1)+1..stringlib.stringfind(l.street_1, ',', 2)-1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 1)<>0,
									trim(l.street_1[1..stringlib.stringfind(l.street_1, ',', 1)-1], left, right),
								''))));

		comma_state			:= if(stringlib.stringfind(l.street_1, ',', 4)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 4)+1..(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 3)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 3)+1..(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 2)<>0 and regexfind('[0-9]+', trim(l.street_1[(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+2..length(l.street_1)], left, right), 0)<>'',
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 2)+1..(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 2)<>0,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 2)+1..(length(l.street_1))],left, right),
								if(stringlib.stringfind(l.street_1, ',', 1)<>0 and regexfind('[0-9]+', trim(l.street_1[(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+2..length(l.street_1)], left, right), 0)<>'',
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 1)+1..(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+1], left, right),
								if(stringlib.stringfind(l.street_1, ',', 1)<>0 ,
									trim(l.street_1[stringlib.stringfind(l.street_1, ',', 1)+1..length(l.street_1)], left, right),
								''))))));

		comma_zip				:= if(stringlib.stringfind(l.street_1, ',', 1)<>0 and regexfind('[0-9]+', trim(l.street_1[(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+2..length(l.street_1)], left, right), 0)<>'',
									trim(l.street_1[(length(l.street_1)-stringlib.stringfind(StringLib.StringReverse(l.street_1), ' ', 1))+2..length(l.street_1)], left, right),
									'');
		
		self.Street_1		:= if(stringlib.stringfind(l.street_1, ',', 2)<>0,
									comma_street_1,
									'');
		self.Street_2		:= if(stringlib.stringfind(l.street_1, ',', 3)<>0,
									comma_street_2,
									'');
		self.City			:= if(city_filter<>'',
									city_filter,
									comma_city);
		self.State			:= if(state_filter<>'',
									state_filter,
									comma_state);
		self.Postal_Code	:= if(comma_zip<>'',
									comma_zip,
									'');
		self.Country		:= l.country;
		self.addr_info		:= l.street_1;
		self := l;
	end;
	
	usaReformLocations := project(usaLocations, USlocationsTran(left));

allReformLocations := foreignLocations + usaReformLocations;

//POPULATE COUNTRIES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	////////// Begin parsing and normalizing Countries//////////
	// Parse the Countries	
	MyParsedCountries := PARSE(ds_with_new_fields(trim(Countries,left,right) != ''),Countries,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid Countries
	// Transform the Countries
	Layout_temp trfCountries(MyParsedCountries l) := transform
		self.addr_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= ''; 
		self.Street_1		:= '';	
		self.Street_2		:= '';
		self.City			:= '';
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= '';
		self.Comments		:= '';
		self.ID				:= l.uid;
	end;

	// Reformat Countries
	ds_NormCountries := project(MyParsedCountries, trfCountries(left));
							
	Layout_temp CountriesTran(ds_NormCountries l):= transform
		self.Country		:= l.addr_info;
		self := l;
	end;
	
reformCountries := project(ds_NormCountries, CountriesTran(left));

//POPULATE PASSPORT COUNTRIES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	input_PC := worldcheck_bridger.Mapping_Passports(in_f);	
	
	//Reformat to Address Layout
	Layout_temp PCTran(input_PC l):= transform
		self.Type			:= 'Unknown';
		self.Street_1		:= '';
		self.Street_2		:= '';
		self.City			:= '';
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= l.Issued_By;
		self.Comments		:= 'Passport Country';
		self.ID				:= l.ID;
		self.addr_info		:= '';
		self := l;
	end;
	
reformPC 	:= project(input_PC, PCTran(left));

concatAddr 	:= allReformLocations + reformCountries + reformPC : persist('~thor_200::persist::worldcheck::addresses');

return concatAddr;

end;
