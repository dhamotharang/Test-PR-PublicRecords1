import Marketing_List, ut;

export MakeEmployeeList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;
												
	string ParmFilterName_EmployeeRange					:= 'EMPLOYEERANGE';
	string ParmFilterName_EmployeeGT						:= 'EMPLOYEEGT';
	string ParmFilterName_EmployeeLT						:= 'EMPLOYEELT';	
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Employee              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_EmployeeRange        			    		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeRange);
  set of string filter_EmployeeRange     			:= 	IF(COUNT(rs_record_EmployeeRange) > 0, rs_record_EmployeeRange[1].set_filter_values, ['']);

  rs_record_EmployeeGT        			        	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeGT);
  set of string filter_EmployeeGT       			:= 	IF(COUNT(rs_record_EmployeeGT) > 0, rs_record_EmployeeGT[1].set_filter_values, ['']);
	
	rs_record_EmployeeLT        			  	    	:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_EmployeeLT);
  set of string filter_EmployeeLT       			:= 	IF(COUNT(rs_record_EmployeeLT) > 0, rs_record_EmployeeLT[1].set_filter_values, ['']);	

	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Employee Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/	
	dsEmployeeRanges		:=	DATASET(filter_EmployeeRange,{STRING rangeVal}); 

	EmployeeRangeLayout	:=	record
		string LTValue;
		string GTValue;
	end;

	EmployeeRangeLayout	trfparseEmplRangeValues(dsEmployeeRanges l)	:=	transform
		position 		:=	StringLib.Stringfind(l.rangeVal, '-', 1);
		self.LTValue:=	l.rangeVal[1..position - 1];
		self.GTValue:=	l.rangeVal[position + 1..];
	end;

	parseEmplRangevalues	:=	project(dsEmployeeRanges, trfparseEmplRangeValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeEmplRangeList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, EmployeeRangeLayout r)	:=	transform
		self				:=	l;
	end;
	
	EmployeeRangeCheck	:=	Join(	inSlimFile,
																parseEmplRangevalues,
																left.num_employees >=	(integer)right.LTValue and 
																left.num_employees <=	(integer)right.GTValue,
																trfMakeEmplRangeList(left,right),ALL
															);	
												
	// Less than value parsing
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
												
  // Greater than value parsing												
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
												
	// Do Employee filters
	EmployeeRangeMatches	:=	if (filter_EmployeeRange[1] <> '', 
																	EmployeeRangeCheck);
													
	EmployeeLTMatches			:=	if (filter_EmployeeLT[1] <> '', 
																	EmployeeLTCheck);
													
	EmployeeGTMatches			:=	if (filter_EmployeeGT[1] <> '', 
																	EmployeeGTCheck);
														
	EmployeeRecords	:=	dedup(sort(EmployeeRangeMatches + EmployeeLTMatches + EmployeeGTMatches,record),record);
	
	return EmployeeRecords;
	
end;