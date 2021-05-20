import std;

#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

//Concat Locations, Countries, and Passport Countries

export Mapping_and_Rollup_Addresses(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Layout	
	Layout_Addresses := record
		string	Type{xpath('Type')};
		string	Street_1{xpath('Street_1')};
		string	Street_2{xpath('Street_2')};
		string	City{xpath('City')};
		string	State{xpath('State')};
		string	Postal_Code{xpath('Postal_Code')};
		string	Country{xpath('Country')};
		string	Comments{xpath('Comments')};
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_Addresses;
		string addr_info;
		//string ID;
	end;

	//Input Files
	in_file_2			:= distribute(in_f, random());
	ds_with_new_fields 	:= in_file_2;

	// Shared parsing pieces for AKAs and alternate spellings
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
	end;

	Invalid_Names 		:= ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];
	Invalid_Countries := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','NONE REPORTED'/*, 'UNKNOWN'*/];

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

	// Normalize the Locations
	ds_NormLocations := NORMALIZE(MyParsedLocations
                            ,1
							,trfLocations(left));
							
	Layout_temp locationsTran(ds_NormLocations l):= transform
		self.Street_1		:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[1..stringlib.stringfind(l.addr_info, '~', 1)-1], left, right),
									'');	
		self.Street_2		:= '';
		self.City			:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[stringlib.stringfind(l.addr_info, '~', 1)+1..stringlib.stringfind(l.addr_info, '~', 2)-1], left, right),
									'');
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= if(regexfind('~', l.addr_info, 0)<>'',
									trim(l.addr_info[stringlib.stringfind(l.addr_info, '~', 2)+1..length(l.addr_info)], left, right),
									'');
		self := l;
	end;
	
reformLocation 	:= project(ds_NormLocations, locationsTran(left));

	
	Layout_temp cityTran(reformLocation l):= transform
		self.Street_1		:= trim(l.Street_1, left, right);
		self.City			:= if(l.City=',',
											'',
										if(l.City[length(l.City)]=',',
											trim(l.City[1..length(l.City)-1], left, right),	
											trim(l.City, left, right)));

//Fix mappings where street_1 = city name; city = ,; (i.e: Brejo Alegre, SÃ£o Paulo ~,~ BRAZIL)
/*		self.Street_1		:= if(regexfind('State of', trim(l.City, left, right), 0) <> '' and trim(l.State, left, right) = '' and trim(l.Country, left, right) = 'USA'
													,''
													,if(l.City=',' and stringlib.stringfind(',', l.Street_1, 2)=0 and l.Street_1<>'',
														'',
														trim(l.Street_1, left, right))
													);
		self.City			:= if(regexfind('State of', trim(l.City, left, right), 0) <> '' and trim(l.State, left, right) = '' and trim(l.Country, left, right) = 'USA'
											,''
											,if(l.City=',' and stringlib.stringfind(',', l.Street_1, 2)=0 and l.Street_1<>'',
											l.Street_1,
										if(l.City=',',
											'',
										if(l.City[length(l.City)]=',',
											trim(l.City[1..length(l.City)-1], left, right),	
											trim(l.City, left, right))))
											);
	*/	
		self.State		:= if(regexfind('State of', trim(l.City, left, right), 0) <> '' and trim(l.State, left, right) = '' and trim(l.Country, left, right) = 'USA'
											,trim(regexreplace('State of', l.City[stringlib.stringfind(l.City, 'State of', 1)..stringlib.stringfind(l.City, ',', 1)-1], ''), left, right)
											,l.State);
		self 					:= l;
	end;

reformLocations	:= project(reformLocation, cityTran(left));

	foreignLocations := reformLocations(trim(stringlib.stringtouppercase(country), left, right) <> 'USA');
	usaLocations	 := reformLocations(trim(stringlib.stringtouppercase(country), left, right) = 'USA');

	Layout_temp USLocationsTran(usaLocations l):= transform
		
		//~ New York City, New York ~ USA
		city_filter  		:= if(regexfind('State of', l.city, 0)<>'',
												'',
											 if(regexfind(',', l.city, 0)<>'',
												trim(l.city[1..stringlib.stringfind(l.city, ',', 1)-1], left, right),
												''));					
		state_filter 		:= if(trim(l.state, left, right)<>'',
												l.state,
											 if(regexfind(',', l.city, 0)<>'',
												trim(l.city[stringlib.stringfind(l.city, ',', 1)+1.. length(l.city)], left, right),
												''));
		
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
		
		self.Street_1			:= if(stringlib.stringfind(l.street_1, ',', 2)<>0,
													trim(comma_street_1, left, right),
													'');
		self.Street_2			:= if(stringlib.stringfind(l.street_1, ',', 3)<>0,
													trim(comma_street_2, left, right),
													'');
		self.City					:= if(city_filter<>'',
													trim(city_filter, left, right),
													trim(comma_city, left, right));
		self.State				:= if(state_filter<>'',
													trim(state_filter, left, right),
													trim(comma_state, left, right));
		self.Postal_Code	:= if(comma_zip<>'',
													trim(comma_zip, left, right),
													'');
		self.Country		:= trim(l.country, left, right);
		self.addr_info	:= trim(l.street_1, left, right);
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
		self.addr_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Countries
									,SKIP
									,TRIM(l.CompleteName,left,right));
		self.Type 			:= ''; 
		self.Street_1		:= '';	
		self.Street_2		:= '';
		self.City			:= '';
		self.State			:= '';
		self.Postal_Code	:= '';
		self.Country		:= '';
		self.Comments		:= 'Countries';
		self.ID				:= l.uid;
	end;

	// Normalize the Countries
	ds_NormCountries := NORMALIZE(MyParsedCountries
                            ,1
							,trfCountries(left));
							
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

concatAddr 	:= allReformLocations + reformCountries + reformPC : persist('~thor_200::persist::worldcheck::normalized_addresses');

/////////////////////////////////////////////////////////////////////////////////////////////////
	
	// Rollup Locations, Countries, and Passport Countries
	Addr_rollup := record
		string ID;
		dataset(Layout_Addresses) Address{xpath('Address')};
		//string ID;
	end;

	Addr_rollup t_Addr(concatAddr L) := transform
		self.Address 	:= row(L, Layout_Addresses);
		self := L;
	end;

	p_Addr := project(concatAddr, t_Addr(left));
	
	Addr_rollup  t_Addr_child(p_Addr L, p_Addr R) := transform
		self.Address   := L.Address + row({r.Address[1].Type,
													r.Address[1].Street_1,
													r.Address[1].Street_2,
													r.Address[1].City,
													r.Address[1].State,
													r.Address[1].Postal_Code,
													r.Address[1].Country,
													r.Address[1].Comments}
												   ,Layout_Addresses);
		self              	:= L;
	end;

Address_out 				:= rollup(sort(p_Addr,record)
								,t_Addr_child(left,right)
								,ID): persist('~thor_200::persist::worldcheck::address');

return address_out;

end;