IMPORT ut, DID_Add, business_header;

layout_bc_temp := record
unsigned6 new_did := 0;
string9   new_ssn := '';
Business_Header.Layout_Business_Contact_Out;
end;

layout_bc_temp InitContacts(Business_Header.Layout_Business_Contact_Out l) := transform
self := l;
end;

bc_out_init := project(Business_Header.File_Business_Contacts_Out, InitContacts(left));

count(bc_out_init(did <> ''));
count(bc_out_init(ssn <> ''));

// DID using the Flex Macro
Business_Contact_Matchset := ['A','S','P'];

// DID using the contact name, contact address
DID_Add.MAC_Match_Flex(bc_out_init,
	 Business_Contact_Matchset,
	 ssn, NONE, fname, mname,lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, state, phone,
	 new_did,
	 layout_bc_temp,
	 false, did_score,
      75,  //low score threshold
	 bc_out_init_did)

// Append SSN by DID to Contacts
DID_Add.MAC_Add_SSN_By_DID(bc_out_init_did, new_did, new_ssn, bc_out_init_ssn)

Business_Header.Layout_Business_Contact_Out FormatBCOutput(layout_bc_temp l) := transform
self.did := if(l.new_did <> 0, (string12)intformat(l.new_did, 12, 1), '');
self.ssn := if(l.new_ssn <> '' and l.new_ssn <> l.ssn, l.new_ssn, l.ssn);
self := l;
end;

bc_out_reset := project(bc_out_init_ssn, FormatBCOutput(left));

count(bc_out_reset(did <> ''));
count(bc_out_reset(ssn <> ''));

output(bc_out_reset,,'TEMP::Business_Contacts_' + Business_Header.version, overwrite);


layout_emp_temp := record
unsigned6 new_did := 0;
string9   new_ssn := '';
Business_Header.Layout_Employment_Out;
end;

layout_emp_temp InitEmployees(Business_Header.Layout_Employment_Out l) := transform
self := l;
end;

emp_out_init := project(Business_Header.File_Employment_Out, InitEmployees(left));

count(emp_out_init(did <> ''));
count(emp_out_init(ssn <> ''));

// DID using the contact name, contact address
DID_Add.MAC_Match_Flex(emp_out_init,
	 Business_Contact_Matchset,
	 ssn, NONE, fname, mname,lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, state, phone,
	 new_did,
	 layout_emp_temp,
	 false, did_score,
      75,  //low score threshold
	 emp_out_init_did)

// Append SSN by DID to Contacts
DID_Add.MAC_Add_SSN_By_DID(emp_out_init_did, new_did, new_ssn, emp_out_init_ssn)

Business_Header.Layout_Employment_Out FormatEmpOutput(layout_emp_temp l) := transform
self.did := if(l.new_did <> 0, (string12)intformat(l.new_did, 12, 1), '');
self.ssn := if(l.new_ssn <> '' and l.new_ssn <> l.ssn, l.new_ssn, l.ssn);
self := l;
end;

emp_out_reset := project(emp_out_init_ssn, FormatEmpOutput(left));

count(emp_out_reset(did <> ''));
count(emp_out_reset(ssn <> ''));

output(emp_out_reset,,'TEMP::Employment_' + Business_Header.version, overwrite);
