import Marketing_List, ut;

export MakeExecContactList(
														dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
														dataset(Marketing_List.layouts.business_contact) inContactFile
													)	:= function;
													
	// Make the Executive Contact portion of the file from the filters
	string ParmFilterName_ContactExecTitlePresent	:= 'CONTACTEXECTITLEPRESENT';												
	
	// Check to see if the executive title set is present. This is a set list of titles that we are looking for.
	rs_record_contact_exec_title_present			:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactExecTitlePresent);
	set of string filt_ContactExecTitlePresent:=	if(count(rs_record_contact_exec_title_present) > 0, rs_record_contact_exec_title_present[1].set_filter_values, ['']);											
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Check all 5 titles we have in the data to see if any match the executive title list. If so, grab those records and return them.
	|--------------------------------------------------------------------------------------------------------------------------------------*/
													
	ExecTitle		:=	if (filt_ContactExecTitlePresent[1] <> '', 
													inContactFile(	ut.CleanSpacesAndUpper(title) in filt_ContactExecTitlePresent  or
																					ut.CleanSpacesAndUpper(title2) in filt_ContactExecTitlePresent or
																					ut.CleanSpacesAndUpper(title3) in filt_ContactExecTitlePresent or
																					ut.CleanSpacesAndUpper(title4) in filt_ContactExecTitlePresent or
																					ut.CleanSpacesAndUpper(title5) in filt_ContactExecTitlePresent));
																			
	ExecRecords	:=	dedup(sort(ExecTitle,record),record);
	
	return ExecRecords;

end;