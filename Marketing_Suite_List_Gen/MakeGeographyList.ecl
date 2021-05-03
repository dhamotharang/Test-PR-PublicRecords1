import Marketing_List, ut;

EXPORT MakeGeographyList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;

	// Make the Geography portion of the file from the filters
	string ParmFilterName_GeoState   						:= 'STATE';	
	string ParmFilterName_GeoStateCounty  			:= 'STATECOUNTY';	
	string ParmFilterName_GeoStateCity  				:= 'STATECITY';	
	string ParmFilterName_GeoStateCityCounty 		:= 'STATECITYCOUNTY';	
	string ParmFilterName_GeoStateCityCountyZip	:= 'STATECITYCOUNTYZIP';	
	string ParmFilterName_GeoStateZip						:= 'STATEZIP';	
	string ParmFilterName_GeoStateCityZip  			:= 'STATECITYZIP';	
	string ParmFilterName_GeoStateCountyZip  		:= 'STATECOUNTYZIP';	
	string ParmFilterName_GeoZipCode						:= 'ZIPCODE';	
												
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | 02 - Geography              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_GeoState        			        		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoState);
  set of string filter_GeoState       				:= 	IF(COUNT(rs_record_GeoState) > 0, rs_record_GeoState[1].set_filter_values, ['']);

  rs_record_GeoStateCounty    		        		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCounty);
  set of string filter_GeoStateCounty  				:= 	IF(COUNT(rs_record_GeoStateCounty) > 0, rs_record_GeoStateCounty[1].set_filter_values, ['']);
	
	rs_record_GeoStateCity        			  	    := 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCity);
  set of string filter_GeoStateCity       		:= 	IF(COUNT(rs_record_GeoStateCity) > 0, rs_record_GeoStateCity[1].set_filter_values, ['']);
	
  rs_record_GeoStateCityCounty        		 		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityCounty);
  set of string filter_GeoStateCityCounty 		:= 	IF(COUNT(rs_record_GeoStateCityCounty) > 0, rs_record_GeoStateCityCounty[1].set_filter_values, ['']);

  rs_record_GeoStateCityCountyZip    		   		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityCountyZip);
  set of string filter_GeoStateCityCountyZip	:= 	IF(COUNT(rs_record_GeoStateCityCountyZip) > 0, rs_record_GeoStateCityCountyZip[1].set_filter_values, ['']);
	
	rs_record_GeoStateZip        			  		    := 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateZip);
  set of string filter_GeoStateZip  	    		:= 	IF(COUNT(rs_record_GeoStateZip) > 0, rs_record_GeoStateZip[1].set_filter_values, ['']);
	
	rs_record_GeoStateCityZip     			  	 		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCityZip);
  set of string filter_GeoStateCityZip     		:= 	IF(COUNT(rs_record_GeoStateCityZip) > 0, rs_record_GeoStateCityZip[1].set_filter_values, ['']);

	rs_record_GeoStateCountyZip     			  		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoStateCountyZip);
  set of string filter_GeoStateCountyZip    	:= 	IF(COUNT(rs_record_GeoStateCountyZip) > 0, rs_record_GeoStateCountyZip[1].set_filter_values, ['']);
	
	rs_record_GeoZipCode     			  	      		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_GeoZipCode);
  set of string filter_GeoZipCode       			:= 	IF(COUNT(rs_record_GeoZipCode) > 0, rs_record_GeoZipCode[1].set_filter_values, ['']);
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Geography Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/	
	GeoLayout	:=	record
		string StateValue;
		string CityValue;
		string CountyValue;
		string CountyCode;
		string ZipCodeValue;
	end;
	
	ExtractCountyCode( DATASET(GeoLayout) pRawInput) := FUNCTION
	
		WithCountyCode	:=	JOIN(	pRawInput,
															Marketing_Suite_List_Gen.Files().Input.CountyTable,
															ut.CleanSpacesAndUpper(left.CountyValue)=ut.CleanSpacesAndUpper(right.CountyName) and
															ut.CleanSpacesAndUpper(left.StateValue)=ut.CleanSpacesAndUpper(right.CountyState),
															transform(GeoLayout,self.CountyCode	:=	right.CountyCode; self := left)
														);
		return WithCountyCode;
	end;
	
	//---------------------------------------------------------------------------------------------
	// State Only Processing
	//---------------------------------------------------------------------------------------------
	StateCheck						:=	if (filter_GeoState[1] <> '', 
																	inSlimFile(	ut.CleanSpacesAndUpper(state) in filter_GeoState));
																	
	//---------------------------------------------------------------------------------------------
	// State/City Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCity						:=	DATASET(filter_GeoStateCity,{STRING StateCityVal}); 

	GeoLayout	trfParseStateCityValues(dsStateCity l)	:=	transform
		position 						:=	StringLib.Stringfind(l.StateCityVal, '-', 1);
		self.StateValue			:=	l.StateCityVal[1..position - 1];
		self.CityValue			:=	l.StateCityVal[position + 1..];
		self								:=	[];
	end;

	ParseStateCityValues	:=	project(dsStateCity, trfParseStateCityValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCityList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCityCheck				:=	Join(	inSlimFile,
																	ParseStateCityValues,
																	left.state =	right.StateValue and 
																	left.city	=	right.CityValue,
																	trfMakeStateCityList(left,right),ALL
																);	
																
	//---------------------------------------------------------------------------------------------
	// State/County Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCounty					:=	DATASET(filter_GeoStateCounty,{STRING StateCountyVal}); 

	GeoLayout	trfParseStateCountyValues(dsStateCounty l)	:=	transform
		position 						:=	StringLib.Stringfind(l.StateCountyVal, '-', 1);
		self.StateValue			:=	l.StateCountyVal[1..position - 1];
		self.CountyValue		:=	l.StateCountyVal[position + 1..];
		self								:=	[];
	end;

	ParseStateCountyValues:=	project(dsStateCounty, trfParseStateCountyValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCountyList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCountyCheck			:=	Join(	inSlimFile,
																	ParseStateCountyValues,
																	ut.CleanSpacesAndUpper(left.County_Name)=	ut.CleanSpacesAndUpper(right.CountyValue) and
																	ut.CleanSpacesAndUpper(left.State)=	ut.CleanSpacesAndUpper(right.StateValue),																	
																	trfMakeStateCountyList(left,right),ALL
																);	

	//---------------------------------------------------------------------------------------------
	// State/City/County Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCityCounty			:=	DATASET(filter_GeoStateCityCounty,{STRING StateCityCountyVal}); 

	GeoLayout	trfParseStateCityCountyValues(dsStateCityCounty l)	:=	transform
		position1						:=	StringLib.Stringfind(l.StateCityCountyVal, '-', 1);
		position2						:=	StringLib.Stringfind(l.StateCityCountyVal, '-', 2);

		self.StateValue			:=	l.StateCityCountyVal[1..position1 - 1];
		self.CityValue			:=	l.StateCityCountyVal[position1 + 1..position2 - 1];
		self.CountyValue		:=	l.StateCityCountyVal[position2 + 1..];
		self								:=	[];
	end;

	ParseStateCityCountyValues	:=	project(dsStateCityCounty, trfParseStateCityCountyValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCityCountyList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCityCountyCheck	:=	Join(	inSlimFile,
																	ParseStateCityCountyValues,
																	ut.CleanSpacesAndUpper(left.County_Name)=	ut.CleanSpacesAndUpper(right.CountyValue) and
																	ut.CleanSpacesAndUpper(left.city)=	ut.CleanSpacesAndUpper(right.CityValue),																	
																	trfMakeStateCityCountyList(left,right),ALL
																);																	
																
	//---------------------------------------------------------------------------------------------
	// State/City/County/Zip Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCityCountyZip			:=	DATASET(filter_GeoStateCityCountyZip,{STRING StateCityCountyZipVal}); 

	GeoLayout	trfParseStateCityCountyZipValues(dsStateCityCountyZip l)	:=	transform
		position1						:=	StringLib.Stringfind(l.StateCityCountyZipVal, '-', 1);
		position2						:=	StringLib.Stringfind(l.StateCityCountyZipVal, '-', 2);
		position3						:=	StringLib.Stringfind(l.StateCityCountyZipVal, '-', 3);
		self.StateValue			:=	l.StateCityCountyZipVal[1..position1 - 1];
		self.CityValue			:=	l.StateCityCountyZipVal[position1 + 1..position2 - 1];
		self.CountyValue		:=	l.StateCityCountyZipVal[position2 + 1..position3 - 1];
		self.ZipCodeValue		:=	l.StateCityCountyZipVal[position3 + 1..];
		self								:=	[];
	end;

	ParseStateCityCountyZipValues	:=	project(dsStateCityCountyZip, trfParseStateCityCountyZipValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCityCountyZipList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCityCountyZipCheck		:=	Join(	inSlimFile,
																			ParseStateCityCountyZipValues,
																			ut.CleanSpacesAndUpper(left.County_Name) =	ut.CleanSpacesAndUpper(right.CountyValue) and
																			ut.CleanSpacesAndUpper(left.City) =	ut.CleanSpacesAndUpper(right.CityValue) and																			
																			left.zip_code = right.ZipCodeValue,
																			trfMakeStateCityCountyZipList(left,right),ALL
																		);		
																	
	//---------------------------------------------------------------------------------------------
	// State/Zip Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateZip						:=	DATASET(filter_GeoStateZip,{STRING StateZipVal}); 

	GeoLayout	trfParseStateZipValues(dsStateZip l)	:=	transform
		position1						:=	StringLib.Stringfind(l.StateZipVal, '-', 1);
		self.StateValue			:=	l.StateZipVal[1..position1 - 1];
		self.ZipCodeValue		:=	l.StateZipVal[position1 + 1..];
		self								:=	[];
	end;

	ParseStateZipValues		:=	project(dsStateZip, trfParseStateZipValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateZipList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateZipCheck					:=	Join(	inSlimFile,
																	ParseStateZipValues,
																	left.state=right.StateValue and 
																	left.zip_code=right.ZipCodeValue,
																	trfMakeStateZipList(left,right),ALL
																);	
																
	//---------------------------------------------------------------------------------------------
	// State/City/Zip Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCityZip				:=	DATASET(filter_GeoStateCityZip,{STRING StateCityZipVal}); 

	GeoLayout	trfParseStateCityZipValues(dsStateCityZip l)	:=	transform
		position1						:=	StringLib.Stringfind(l.StateCityZipVal, '-', 1);
		position2						:=	StringLib.Stringfind(l.StateCityZipVal, '-', 2);
		self.StateValue			:=	l.StateCityZipVal[1..position1 - 1];
		self.CityValue			:=	l.StateCityZipVal[position1 + 1..position2 - 1];
		self.ZipCodeValue		:=	l.StateCityZipVal[position2 + 1..];
		self								:=	[];
	end;

	ParseStateCityZipValues		:=	project(dsStateCityZip, trfParseStateCityZipValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCityZipList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCityZipCheck			:=	Join(	inSlimFile,
																	ParseStateCityZipValues,
																	left.state=right.StateValue and 
																	left.city=right.CityValue and
																	left.zip_code=right.ZipCodeValue,
																	trfMakeStateCityZipList(left,right),ALL
																);	
																
	//---------------------------------------------------------------------------------------------
	// State/County/Zip Only Processing
	//---------------------------------------------------------------------------------------------																	
	dsStateCountyZip			:=	DATASET(filter_GeoStateCountyZip,{STRING StateCountyZipVal}); 

	GeoLayout	trfParseStateCountyZipValues(dsStateCountyZip l)	:=	transform
		position1						:=	StringLib.Stringfind(l.StateCountyZipVal, '-', 1);
		position2						:=	StringLib.Stringfind(l.StateCountyZipVal, '-', 2);
		self.StateValue			:=	l.StateCountyZipVal[1..position1 - 1];
		self.CountyValue		:=	l.StateCountyZipVal[position1 + 1..position2 - 1];
		self.ZipCodeValue		:=	l.StateCountyZipVal[position2 + 1..];
		self								:=	[];
	end;

	ParseStateCountyZipValues	:=	project(dsStateCountyZip, trfParseStateCountyZipValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeStateCountyZipList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, GeoLayout r)	:=	transform
		self								:=	l;
	end;
	
	StateCountyZipCheck		:=	Join(	inSlimFile,
																	ParseStateCountyZipValues,
																	ut.CleanSpacesAndUpper(left.County_Name)=	ut.CleanSpacesAndUpper(right.CountyValue) and
																	ut.CleanSpacesAndUpper(left.State)=	ut.CleanSpacesAndUpper(right.StateValue) and																
																	left.zip_code=right.ZipCodeValue,
																	trfMakeStateCountyZipList(left,right),ALL
																);		
																	
	//---------------------------------------------------------------------------------------------
	// ZipCode Only Processing
	//---------------------------------------------------------------------------------------------
	ZipCodeCheck		:=	if (filter_GeoZipCode[1] <> '', 
													inSlimFile(	ut.CleanSpacesAndUpper(zip_code) in filter_GeoZipCode));	
													
	// Determine Geo Results												

	StateMatches							:=	if (filter_GeoState[1] <> '', 
																			StateCheck);

	StateCityMatches					:=	if (filter_GeoStateCity[1] <> '', 
																			StateCityCheck);
														
	StateCountyMatches				:=	if (filter_GeoStateCounty[1] <> '', 
																			StateCountyCheck);
															
	StateCityCountyMatches		:=	if (filter_GeoStateCityCounty[1] <> '', 
																			StateCityCountyCheck);

	StateCityCountyZipMatches	:=	if (filter_GeoStateCityCountyZip[1] <> '', 
																			StateCityCountyZipCheck);

	StateZipMatches						:=	if (filter_GeoStateZip[1] <> '', 
																			StateZipCheck);
																			
	StateCityZipMatches				:=	if (filter_GeoStateCityZip[1] <> '', 
																			StateCityZipCheck);
															
	StateCountyZipMatches			:=	if (filter_GeoStateCountyZip[1] <> '', 
																		StateCountyZipCheck);														

	ZipCodeMatches						:=	if (filter_GeoZipCode[1] <> '', 
																		ZipCodeCheck);	
														
	GeographyRecords					:=	dedup(sort(	StateMatches + StateCityMatches + StateCountyMatches + 
																						StateCityCountyMatches + StateCityCountyZipMatches + StateZipMatches +
																						StateCityZipMatches + StateCountyZipMatches + ZipCodeMatches,record),record);	
	
	return GeographyRecords;
	
end;