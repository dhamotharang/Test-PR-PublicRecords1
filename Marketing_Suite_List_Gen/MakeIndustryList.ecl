import Marketing_List, ut;

export MakeIndustryList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;

	// Make the Industry (SIC & NAICS) portion of the file from the filters
	string ParmFilterName_IndustryPrimarySIC		:= 'PRIMARYSICCODE';
	string ParmFilterName_IndustryALLSIC				:= 'ALLSICCODE';
	string ParmFilterName_IndustryPrimaryNAICS	:= 'PRIMARYNAICSCODE';
	string ParmFilterName_IndustryALLNAICS			:= 'ALLNAICSCODE';
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | There are 4 Industry parameters possible. 1) The customer can ask for the primary SIC code match a value(s) 2) The
	| customer can ask for the primary and/or secondary SIC codes to match a value(s) 3) The customer can ask for the primary 
	| NAICS code to match a value(s) 4) The customer can ask for the primary and/or secondary NAICS code to match a value(s). 
	| Determine which one(s) are needed. Also in addition to the above criteria, the customer can restrict how many digits 
	| of the code need to match. So a customer can say give me all records where SIC code starts with '53'. 
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_IndustryPrimarySIC								:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryPrimarySIC);
  set of string filter_IndustryPrimarySIC			:= 	IF(COUNT(rs_record_IndustryPrimarySIC) > 0, rs_record_IndustryPrimarySIC[1].set_filter_values, ['']);

  rs_record_IndustryAllSIC										:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryAllSIC);
  set of string filter_IndustryAllSIC					:= 	IF(COUNT(rs_record_IndustryAllSIC) > 0, rs_record_IndustryAllSIC[1].set_filter_values, ['']);
	
  rs_record_IndustryPrimaryNAICS							:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryPrimaryNAICS);
  set of string filter_IndustryPrimaryNAICS		:= 	IF(COUNT(rs_record_IndustryPrimaryNAICS) > 0, rs_record_IndustryPrimaryNAICS[1].set_filter_values, ['']);

  rs_record_IndustryAllNAICS									:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_IndustryAllNAICS);
  set of string filter_IndustryAllNAICS				:= 	IF(COUNT(rs_record_IndustryAllNAICS) > 0, rs_record_IndustryAllNAICS[1].set_filter_values, ['']);	
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Industry Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/	

	//---------------------------------------------------------------------------------------------
	// SIC Code Processing
	//---------------------------------------------------------------------------------------------
	
	// Only the primary SIC code needs to be evaluated for a match.
	dsPrimarySic		:=	DATASET(filter_IndustryPrimarySIC,{STRING PrimarySICVal}); 

	IndustryPrimarySICLayout	:=	record
		string PrimarySICValue;
	end;

	IndustryPrimarySICLayout	trfparsePrimarySICValues(dsPrimarySic l)	:=	transform
		self.PrimarySICValue		:=	l.PrimarySICVal;
	end;

	parsePrimarySICValues			:=	project(dsPrimarySic, trfparsePrimarySICValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakePrimarySICList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, IndustryPrimarySICLayout r)	:=	transform
		self				:=	l;
	end;
	
	IndustryPrimarySICCheck		:=	Join(	inSlimFile,
																			parsePrimarySICValues,
																			left.SIC_Primary[1..length(right.PrimarySICValue)]=right.PrimarySICValue,
																			trfMakePrimarySICList(left,right),ALL
														);
														
	// ALL SIC codes need to be evaluated for a match.
	dsAllSIC							:=	DATASET(filter_IndustryAllSIC,{STRING AllSICVal}); 

	IndustryAllSICLayout	:=	record
		string AllSICValue;
	end;

	IndustryAllSICLayout	trfparseAllSICValues(dsAllSIC l)	:=	transform
		self.AllSICValue		:=	l.AllSICVal;
	end;

	parseAllSICValues			:=	project(dsAllSIC, trfparseAllSICValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeAllSICList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, IndustryAllSICLayout r)	:=	transform
		self								:=	l;
	end;
	
	IndustryAllSICCheck		:=	Join(	inSlimFile,
																	parseAllSICValues,
																	left.SIC_Primary[1..length(right.AllSICValue)]=right.AllSICValue or
																	left.SIC2[1..length(right.ALLSICValue)]=right.AllSICValue or
																	left.SIC3[1..length(right.ALLSICValue)]=right.AllSICValue or
																	left.SIC4[1..length(right.ALLSICValue)]=right.AllSICValue or
																	left.SIC5[1..length(right.ALLSICValue)]=right.AllSICValue,
																	trfMakeAllSICList(left,right),ALL
														);	
														
	//---------------------------------------------------------------------------------------------
	// NAICS Code Processing
	//---------------------------------------------------------------------------------------------
	
	// Only the primary NAICS code needs to be evaluated for a match.	
	dsPrimaryNAICS		:=	DATASET(filter_IndustryPrimaryNAICS,{STRING PrimaryNAICSVal}); 
	
	IndustryPrimaryNAICSLayout	:=	record
		string PrimaryNAICSValue;
	end;

	IndustryPrimaryNAICSLayout	trfparsePrimaryNAICSValues(dsPrimaryNAICS l)	:=	transform
		self.PrimaryNAICSValue		:=	l.PrimaryNAICSVal;
	end;

	parsePrimaryNAICSValues			:=	project(dsPrimaryNAICS, trfparsePrimaryNAICSValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakePrimaryNAICSList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, IndustryPrimaryNAICSLayout r)	:=	transform
		self				:=	l;
	end;
	
	IndustryPrimaryNAICSCheck		:=	Join(	inSlimFile,
																				parsePrimaryNAICSValues,
																				left.NAICS_Primary[1..length(right.PrimaryNAICSValue)]=right.PrimaryNAICSValue,
																				trfMakePrimaryNAICSList(left,right),ALL
																			);
														
	// All NAICS codes need to be evaluated for a match.
	dsAllNAICS										:=	DATASET(filter_IndustryAllNAICS,{STRING AllNAICSVal}); 

	IndustryAllNAICSLayout	:=	record
		string AllNAICSValue;
	end;

	IndustryAllNAICSLayout	trfparseAllNAICSValues(dsAllNAICS l)	:=	transform
		self.AllNAICSValue		:=	l.AllNAICSVal;
	end;

	parseAllNAICSValues			:=	project(dsAllNAICS, trfparseAllNAICSValues(left));
	
	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeAllNAICSList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, IndustryAllNAICSLayout r)	:=	transform
		self								:=	l;
	end;
	
	IndustryAllNAICSCheck		:=	Join(	inSlimFile,
																		parseAllNAICSValues,
																		left.NAICS_Primary[1..length(right.AllNAICSValue)]=right.AllNAICSValue or
																		left.NAICS2[1..length(right.AllNAICSValue)]=right.AllNAICSValue or
																		left.NAICS3[1..length(right.AllNAICSValue)]=right.AllNAICSValue or
																		left.NAICS4[1..length(right.AllNAICSValue)]=right.AllNAICSValue or
																		left.NAICS5[1..length(right.AllNAICSValue)]=right.AllNAICSValue,
																		trfMakeAllNAICSList(left,right),ALL
																	 );
																	
	//---------------------------------------------------------------------------------------------
	// Put together all industry filtering
	//---------------------------------------------------------------------------------------------
	PrimarySICMatches					:=	if (filter_IndustryPrimarySIC[1] <> '', 
																			IndustryPrimarySICCheck);
													
	AllSICMatches							:=	if (filter_IndustryAllSIC[1] <> '', 
																			IndustryAllSICCheck);

	PrimaryNAICSMatches				:=	if (filter_IndustryPrimaryNAICS[1] <> '', 
																			IndustryPrimaryNAICSCheck);
													
	AllNAICSMatches						:=	if (filter_IndustryAllNAICS[1] <> '', 
																			IndustryAllNAICSCheck);																			
														
	IndustryRecords						:=	dedup(sort(PrimarySICMatches + AllSICMatches + PrimaryNAICSMatches + AllNAICSMatches,record),record);	
	
	return IndustryRecords;
	
end;