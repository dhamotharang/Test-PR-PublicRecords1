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
  | Contact              
  |--------------------------------------------------------------------------------------------------------------------------------------*/

	rs_record_contact_addr_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactAddressPresent and set_filter_values[1] = 'Y');
	string filter_ContactAddrPresent					:=	if(count(rs_record_contact_addr_present) > 0,'Y','');	
	
	rs_record_contact_email_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactEmailPresent and set_filter_values[1] = 'Y');
	string filter_ContactEmailPresent					:=	if(count(rs_record_contact_email_present) > 0,'Y','');
	
	rs_record_contact_lexid_present						:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterName_ContactLexidPresent and set_filter_values[1] = 'Y');
	string filter_ContactLexidPresent					:=	if(count(rs_record_contact_lexid_present) > 0,'Y','');	
														 
	/*---------------------------------------------------------------------------------------------------------------------------------------
	| Contact Filters
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