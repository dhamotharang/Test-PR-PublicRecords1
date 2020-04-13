import Marketing_List, ut;

export MakeEmployeeList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;
	
	// Make the eployee portion of the file from the filters
	string ParmFilterName_EmployeeRange					:= 'EMPLOYEERANGE';
	string ParmFilterName_EmployeeGT						:= 'EMPLOYEEGT';
	string ParmFilterName_EmployeeLT						:= 'EMPLOYEELT';	
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | There are three employee parameters possible. 1) The customer wants records with an employee count in a range, 2) The
	| customer wants records where the employee count is greater than a value 3) The customer want records where the 
	| employee count is less than a value. So for each parameter determine if that criteria is wanted and set the filter
	| to the appropriate parameter value(s).
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_EmployeeRange        			    		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeRange);
  set of string filter_EmployeeRange     			:= 	IF(COUNT(rs_record_EmployeeRange) > 0, rs_record_EmployeeRange[1].set_filter_values, ['']);

  rs_record_EmployeeGT        			        	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeGT);
  set of string filter_EmployeeGT       			:= 	IF(COUNT(rs_record_EmployeeGT) > 0, rs_record_EmployeeGT[1].set_filter_values, ['']);
	
	rs_record_EmployeeLT        			  	    	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeLT);
  set of string filter_EmployeeLT       			:= 	IF(COUNT(rs_record_EmployeeLT) > 0, rs_record_EmployeeLT[1].set_filter_values, ['']);	

	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Employee Range Filter - In this case a range is wanted. The first thing we need to do is determine the less than & 
	| greater than values in the range. We do this by looking for the dash in the parameter value(s). Once we have the less 
	| than and greater than values, we can join to the marketing file to grab the records that meet that criteria.
	|--------------------------------------------------------------------------------------------------------------------------------------*/	
	dsEmployeeRanges		:=	DATASET(filter_EmployeeRange,{STRING rangeVal}); 

	EmployeeRangeLayout	:=	record
		string LTValue;
		string GTValue;
	end;

	// Find the less than & greater than values by looking for the dash.
	EmployeeRangeLayout	trfparseEmplRangeValues(dsEmployeeRanges l)	:=	transform
		position 		:=	StringLib.Stringfind(l.rangeVal, '-', 1);
		self.LTValue:=	l.rangeVal[1..position - 1];
		self.GTValue:=	l.rangeVal[position + 1..];
	end;

	parseEmplRangevalues	:=	project(dsEmployeeRanges, trfparseEmplRangeValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeEmplRangeList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, EmployeeRangeLayout r)	:=	transform
		self				:=	l;
	end;
	
	// Join the range values to the slim marketing file, matching based on the less than & greater than values in our
	// parameter.
	EmployeeRangeCheck	:=	Join(	inSlimFile,
																parseEmplRangevalues,
																left.num_employees >=	(integer)right.LTValue and 
																left.num_employees <=	(integer)right.GTValue,
																trfMakeEmplRangeList(left,right),ALL
															);	
												
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Employee Less Than Filter - In this case a less than value is wanted. We join the marketing file with the less than
	| value(s) to grab the records that meet that criteria.
	|--------------------------------------------------------------------------------------------------------------------------------------*/		
	dsEmployeeLT				:=	DATASET(filter_EmployeeLT,{STRING LTVal}); 
	
	EmployeeLTLayout	:=	record
		string LTValue;
	end;

	EmployeeLTLayout	trfparseEmplLTValues(dsEmployeeLT l)	:=	transform
		self.LTValue:=	l.LTVal;
	end;

	parseEmplLTValues	:=	project(dsEmployeeLT, trfparseEmplLTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeEmplLTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, EmployeeLTLayout r)	:=	transform
		self				:=	l;
	end;
	
	EmployeeLTCheck		:=	Join(	inSlimFile,
															parseEmplLTValues,
															left.num_employees <	(integer)right.LTValue,
															trfMakeEmplLTList(left,right),ALL
														);
												
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Employee Greater Than Filter - In this case a greater than value is wanted. We join the marketing file with the 
	| greater than value(s) to grab the records that meet that criteria.
	|--------------------------------------------------------------------------------------------------------------------------------------*/
	dsEmployeeGT			:=	DATASET(filter_EmployeeGT,{STRING GTVal}); 

	EmployeeGTLayout	:=	record
		string GTValue;
	end;

	EmployeeGTLayout	trfparseEmplGTValues(dsEmployeeGT l)	:=	transform
		self.GTValue:=	l.GTVal;
	end;

	parseEmplGTValues	:=	project(dsEmployeeGT, trfparseEmplGTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeEmplGTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, EmployeeGTLayout r)	:=	transform
		self				:=	l;
	end;
	
	EmployeeGTCheck		:=	Join(	inSlimFile,
															parseEmplGTValues,
															left.num_employees >	(integer)right.GTValue,
															trfMakeEmplGTList(left,right),ALL
														);
												
	// Once we have all the records, lets combine them and deup them for return.
	EmployeeRangeMatches	:=	if (filter_EmployeeRange[1] <> '', 
																	EmployeeRangeCheck);
													
	EmployeeLTMatches			:=	if (filter_EmployeeLT[1] <> '', 
																	EmployeeLTCheck);
													
	EmployeeGTMatches			:=	if (filter_EmployeeGT[1] <> '', 
																	EmployeeGTCheck);
														
	EmployeeRecords	:=	dedup(sort(EmployeeRangeMatches + EmployeeLTMatches + EmployeeGTMatches,record),record);
	
	return EmployeeRecords;
	
end;