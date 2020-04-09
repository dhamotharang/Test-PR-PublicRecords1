import Marketing_List, ut;

export MakeBusEmailList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;
												
												
	// Build the Bus Email file from the filter											
	string ParmFilterName_BusEmailPresent				:= 'BUSEMAILPRESENT';
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Check to see if the 'Business Email Present' parameter is in our list. If so set the filter to 'Y'.            
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  rs_record_bus_email_present									:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusEmailPresent and set_filter_values[1] = 'Y');
	string filter_BusEmailPresent								:=	IF(COUNT(rs_record_bus_email_present) > 0,'Y','');
														 
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| If the filter is set to 'Y', then grab all records where a business email is present. Return those records.
	|--------------------------------------------------------------------------------------------------------------------------------------*/
	BusEmailPresent	:=	if (filter_BusEmailPresent='Y',
														inSlimFile(	ut.CleanSpacesAndUpper(email)<>''));	
														
	return BusEmailPresent;
	
end;												