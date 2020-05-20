import Marketing_List, ut;

export MakeRevenueList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;
												
	// Make the Revenue portion of the file from the filters
	string ParmFilterName_RevenueRange					:= 'SALESRANGE';
	string ParmFilterName_RevenueGT							:= 'SALESGT';
	string ParmFilterName_RevenueLT							:= 'SALESLT';
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | 03 - Revenue              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

  rs_record_RevenueRange        			    		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueRange);
  set of string filter_RevenueRange     			:= 	IF(COUNT(rs_record_RevenueRange) > 0, rs_record_RevenueRange[1].set_filter_values, ['']);

  rs_record_RevenueGT        			        		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueGT);
  set of string filter_RevenueGT       				:= 	IF(COUNT(rs_record_RevenueGT) > 0, rs_record_RevenueGT[1].set_filter_values, ['']);
	
	rs_record_RevenueLT        			  	    		:= 	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_RevenueLT);
  set of string filter_RevenueLT       				:= 	IF(COUNT(rs_record_RevenueLT) > 0, rs_record_RevenueLT[1].set_filter_values, ['']);

	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Revenue Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/	
	dsRevRanges			:=	DATASET(filter_RevenueRange,{STRING rangeVal}); 

	RevRangeLayout	:=	record
		string LTValue;
		string GTValue;
	end;

	RevRangeLayout	trfparseRangeValues(dsRevRanges l)	:=	transform
		position 			:=	StringLib.Stringfind(l.rangeVal, '-', 1);
		self.LTValue	:=	l.rangeVal[1..position - 1];
		self.GTValue	:=	l.rangeVal[position + 1..];
	end;

	parseRangevalues:=	project(dsRevRanges, trfparseRangeValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeRangeList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, RevRangeLayout r)	:=	transform
		self					:=	l;
	end;
	
	RevRangeCheck		:=	Join(	inSlimFile,
														parseRangevalues,
														left.annual_revenue >=	(integer)right.LTValue and 
														left.annual_revenue <=	(integer)right.GTValue,
														trfMakeRangeList(left,right),ALL
													);	
												
	// Less than value parsing
	dsRevLT					:=	DATASET(filter_RevenueLT,{STRING LTVal}); 

	RevLTLayout			:=	record
		string LTValue;
	end;

	RevLTLayout	trfparseLTValues(dsRevLT l)	:=	transform
		self.LTValue	:=	l.LTVal;
	end;

	parseLTValues		:=	project(dsRevLT, trfparseLTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeLTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, RevLTLayout r)	:=	transform
		self					:=	l;
	end;
	
	RevLTCheck			:=	Join(	inSlimFile,
														parseLTValues,
														left.annual_revenue <	(integer)right.LTValue,
														trfMakeLTList(left,right),ALL
													);
												
												
  // Greater than value parsing												
	dsRevGT					:=	DATASET(filter_RevenueGT,{STRING GTVal}); 

	RevGTLayout			:=	record
		string GTValue;
	end;

	RevGTLayout	trfparseGTValues(dsRevGT l)	:=	transform
		self.GTValue	:=	l.GTVal;
	end;

	parseGTValues		:=	project(dsRevGT, trfparseGTValues(left));

	Marketing_Suite_List_Gen.Layouts.Layout_TempBus trfMakeGTList(Marketing_Suite_List_Gen.Layouts.Layout_TempBus l, RevGTLayout r)	:=	transform
		self					:=	l;
	end;
	
	RevGTCheck			:=	Join(	inSlimFile,
														parseGTValues,
														left.annual_revenue >	(integer)right.GTValue,
														trfMakeGTList(left,right),ALL
													);
												
	RevRangeMatches	:=	if (filter_RevenueRange[1] <> '', 
														RevRangeCheck);
													
	RevLTMatches		:=	if (filter_RevenueLT[1] <> '', 
														RevLTCheck);
													
	RevGTMatches		:=	if (filter_RevenueGT[1] <> '', 
														RevGTCheck);
														
	RevenueRecords	:=	dedup(sort(RevRangeMatches + RevLTMatches + RevGTMatches,record),record);
	
	return RevenueRecords;
	
end;