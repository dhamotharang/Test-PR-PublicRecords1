import Marketing_List, ut;

export MakeYearsInBusinessList(
																dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
																dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
															)	:= function;

	// Make the Years in Business (Age) portion of the file from the filters
	string ParmFilterName_BusYearsRange					:= 'BUSYEARSRANGE';	
	string ParmFilterName_BusYearsGT						:= 'BUSYEARSGT';	
	string ParmFilterName_BusYearsLT						:= 'BUSYEARSLT';
	
  /*---------------------------------------------------------------------------------------------------------------------------------------
  | 06 - Years in Business              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_BusYearsRange        			    		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsRange);
  set of string filter_BusYearsRange     			:= 	IF(COUNT(rs_record_BusYearsRange) > 0, rs_record_BusYearsRange[1].set_filter_values, ['']);

  rs_record_BusYearsGT        			        	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsGT);
  set of string filter_BusYearsGT       			:= 	IF(COUNT(rs_record_BusYearsGT) > 0, rs_record_BusYearsGT[1].set_filter_values, ['']);
	
	rs_record_BusYearsLT        			  	    	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusYearsLT);
  set of string filter_BusYearsLT       			:= 	IF(COUNT(rs_record_BusYearsLT) > 0, rs_record_BusYearsLT[1].set_filter_values, ['']);			
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Years in Business Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/	
	dsBusYearsRanges			:=	DATASET(filter_BusYearsRange,{STRING rangeVal}); 

	BusYearsRangeLayout	:=	record
		string LTValue;
		string GTValue;
	end;

	BusYearsRangeLayout	trfparseBusYearsRangeValues(dsBusYearsRanges l)	:=	transform
		position 		:=	StringLib.Stringfind(l.rangeVal, '-', 1);
		self.LTValue:=	l.rangeVal[1..position - 1];
		self.GTValue:=	l.rangeVal[position + 1..];
	end;

	parseBusYearsRangevalues	:=	project(dsBusYearsRanges, trfparseBusYearsRangeValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeBusYearsRangeList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, BusYearsRangeLayout r)	:=	transform
		self				:=	l;
	end;
	
	BusYearsRangeCheck	:=	Join(	inSlimFile,
																parseBusYearsRangevalues,
																left.age >=	right.LTValue and 
																left.age <=	right.GTValue,
																trfMakeBusYearsRangeList(left,right),ALL
															);	
												
	// Less than value parsing
	dsBusYearsLT				:=	DATASET(filter_BusYearsLT,{STRING LTVal}); 

	BusYearsLTLayout	:=	record
		string LTValue;
	end;

	BusYearsLTLayout	trfparseBusYearsLTValues(dsBusYearsLT l)	:=	transform
		self.LTValue:=	l.LTVal;
	end;

	parseBusYearsLTValues	:=	project(dsBusYearsLT, trfparseBusYearsLTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeBusYearsLTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, BusYearsLTLayout r)	:=	transform
		self				:=	l;
	end;
	
	BusYearsLTCheck		:=	Join(	inSlimFile,
															parseBusYearsLTValues,
															left.age <	right.LTValue,
															trfMakeBusYearsLTList(left,right),ALL
														);
												
  // Greater than value parsing												
	dsBusYearsGT			:=	DATASET(filter_BusYearsGT,{STRING GTVal}); 

	BusYearsGTLayout	:=	record
		string GTValue;
	end;

	BusYearsGTLayout	trfparseBusYearsGTValues(dsBusYearsGT l)	:=	transform
		self.GTValue:=	l.GTVal;
	end;

	parseBusYearsGTValues	:=	project(dsBusYearsGT, trfparseBusYearsGTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeBusYearsGTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, BusYearsGTLayout r)	:=	transform
		self				:=	l;
	end;
	
	BusYearsGTCheck		:=	Join(	inSlimFile,
															parseBusYearsGTValues,
															left.age >	right.GTValue,
															trfMakeBusYearsGTList(left,right),ALL
														);
												
	// Do BusYears filters
	BusYearsRangeMatches	:=	if (filter_BusYearsRange[1] <> '', 
																	BusYearsRangeCheck);
													
	BusYearsLTMatches			:=	if (filter_BusYearsLT[1] <> '', 
																	BusYearsLTCheck);
													
	BusYearsGTMatches			:=	if (filter_BusYearsGT[1] <> '', 
																	BusYearsGTCheck);
														
	BusYearsRecords	:=	dedup(sort(BusYearsRangeMatches + BusYearsLTMatches + BusYearsGTMatches,record),record);	
	
	return BusYearsRecords;
	
end;