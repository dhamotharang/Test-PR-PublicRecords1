import Marketing_List, ut;

export MakeContactList(
												dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
												dataset(Marketing_List.layouts.business_contact) inContactFile
											)	:= function;
	
	// Make the contact portion of the file from the filters
	string ParmFilterName_ContactAddressPresent	:= 'CONTACTADDRPRESENT';
	string ParmFilterName_ContactEmailPresent		:= 'CONTACTEMAILPRESENT';
	string ParmFilterName_ContactLexidPresent		:= 'CONTACTLEXIDPRESENT';
	
	/*---------------------------------------------------------------------------------------------------------------------------------------
  | Check to see if any of the 'contact present' parameters are in our list. If so set the appropriate filters to 'Y'.            
  |--------------------------------------------------------------------------------------------------------------------------------------*/

	rs_record_contact_addr_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactAddressPresent and set_filter_values[1] = 'Y');
	string filter_ContactAddrPresent					:=	if(count(rs_record_contact_addr_present) > 0,'Y','');	
	
	rs_record_contact_email_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactEmailPresent and set_filter_values[1] = 'Y');
	string filter_ContactEmailPresent					:=	if(count(rs_record_contact_email_present) > 0,'Y','');
	
	rs_record_contact_lexid_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactLexidPresent and set_filter_values[1] = 'Y');
	string filter_ContactLexidPresent					:=	if(count(rs_record_contact_lexid_present) > 0,'Y','');	
														 
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Check each filter. If it is set to 'Y', then grab all records that meet this criteria. So, if we want records
	| where a contact full address is present (i.e. filter_ContactAddrPresent = 'Y', then grab all records where a
	| contact address is present. The ame holds for the other two contact parameters (email and lexid). Once we have grabbed
	| all records needed, combine and dedup those records and return them.
	|--------------------------------------------------------------------------------------------------------------------------------------*/

	AddressPresent		:=	if (filter_ContactAddrPresent='Y',
															inContactFile(ut.CleanSpacesAndUpper(	contact_address + city + 
																																		state + zip5)<>''));
													
	EmailPresent			:=	if (filter_ContactEmailPresent='Y', 
															inContactFile(ut.CleanSpacesAndUpper(contact_email_address) <>''));
													
	LexidPresent			:=	if (filter_ContactLexidPresent='Y', 
															inContactFile(lexid<>0))
															;																						
													
	ContactRecords		:=	dedup(sort(AddressPresent + EmailPresent + LexidPresent,record),record);
	
	return ContactRecords;

end;