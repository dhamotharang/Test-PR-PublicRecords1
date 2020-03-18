import Marketing_List, ut;

export MakeBusEmailList(
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
													dataset(Marketing_Suite_List_Gen.Layouts.Layout_TempBus) inSlimFile
												)	:= function;
												
	string ParmFilterName_BusEmailPresent				:= 'BUSEMAILPRESENT';
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Business Email Present              
  |--------------------------------------------------------------------------------------------------------------------------------------*/
  rs_record_bus_email_present									:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_BusEmailPresent and set_filter_values[1] = 'Y');
	string filter_BusEmailPresent								:=	IF(COUNT(rs_record_bus_email_present) > 0,'Y','');
														 
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Business Email Filters
	|--------------------------------------------------------------------------------------------------------------------------------------*/
	BusEmailPresent	:=	if (filter_BusEmailPresent='Y',
														inSlimFile(	ut.CleanSpacesAndUpper(email)<>''));	
														
	return BusEmailPresent;
	
end;												