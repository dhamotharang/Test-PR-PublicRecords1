import ut, did_add, Business_Header;

// Clean person names
edgar_contacts := Edgar.File_Edgar_Contact_In;

layout_contact_temp := record
edgar_contacts;
string73  cleanName;
end;

layout_contact_temp CleanNames(edgar_contacts l) := transform
self.position := stringlib.StringToUpperCase(l.position);
self.organization := stringlib.StringToUpperCase(l.organization);
self.status := stringlib.StringToUpperCase(l.status);
self.startdate := stringlib.StringToUpperCase(l.startdate);
self.enddate := stringlib.StringToUpperCase(l.enddate);
self.cleanName := addrcleanlib.cleanPerson73(TRIM(l.firstname) + IF(L.middlename <> '', (' ' + TRIM(l.middlename) + ' '), ' ') + TRIM(l.lastname) + ' ' + TRIM(l.suffix));
self := l;
end;

edgar_contacts_clean := project(edgar_contacts, CleanNames(left));
edgar_contacts_clean_dist := distribute(edgar_contacts_clean, hash(trim(accession)));

// Combine Edgar Company information with Contact information
edgar_companies := Edgar.File_Edgar_Company_Base;
edgar_companies_dist := distribute(edgar_companies, hash(trim(accNumber)));
edgar_companies_sort := sort(edgar_companies_dist, accNumber, if(bus_zip4 <> '', 0, 1), if(bus_zip <> '', 0, 1), if(bus_st <> '', 0, 1), local);
edgar_companies_dedup := dedup(edgar_companies_sort, accNumber, local);

Edgar.Layout_Edgar_Contact_Base MatchAccession(layout_contact_temp l, Edgar.Layout_Edgar_Company r) := transform
self.title := l.cleanName[1..5];
self.fname := l.cleanName[6..25];
self.mname := l.cleanName[26..45];
self.lname := l.cleanName[46..65];
self.name_suffix := l.cleanName[66..70];
self.name_score := l.cleanName[71..73];
self.did := 0;
self.bdid := r.bdid;
self.Companytaxid := r.taxid;
self := l;
self := r;
end;

edgar_contacts_combined := join(edgar_contacts_clean_dist,
                                edgar_companies_dedup,
                                trim(left.accession) = trim(right.accNumber),
                                MatchAccession(left, right),
                                left outer,
                                local);

// Filter out bad names, company names
edgar_contacts_filtered := edgar_contacts_combined(confidence in ['0','1'],
                                                    (integer)name_score > 90,
                                                    (integer)(Business_Header.CleanName(firstname,middlename,lastname,suffix)[142]) < 2,
                                                    Business_Header.CheckPersonName(firstname,middlename,lastname,suffix),
                                                    not (fname='U' and middlename = 'S'),
                                                    stringlib.stringfind(trim(lname), ' ', 1) = 0,
                                                    (trim(fname) + ' ' + trim(mname) + if(mname <> '', ' ', '') + trim(lname)) not in Edgar.Set_Bad_Contact_Names );

edgar_matchset := ['A','P'];

did_add.MAC_Match_Flex(edgar_contacts_filtered, edgar_matchset,
	 ssn_field, dob_field, fname, mname,lname, name_suffix,
	 bus_prim_range, bus_prim_name, bus_sec_range, bus_zip, bus_st, bus_phone10,
	 did,
	 Edgar.Layout_Edgar_Contact_Base,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped
	 edgar_contacts_did)

//output(edgar_contacts_did,,'BASE::Edgar_Contacts_' + Edgar.Version_Edgar_Company, overwrite);
ut.MAC_SF_BuildProcess(edgar_contacts_did,'~thor_data400::base::edgar_contacts',do1,2);


export make_edgar_contact_base := do1;
