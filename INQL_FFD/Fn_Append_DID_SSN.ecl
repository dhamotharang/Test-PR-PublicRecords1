import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, watchdog, business_header, Inql_FFD;

export FN_Append_DID_SSN(dataset(Layouts.Input_Formatted) pInFile) := function

Infile := distribute(project(pInFile(fname + lname <> '')
		, transform({unsigned8 id, recordof(pInFile)},
				self.id := hash64(left.fname, left.mname, left.lname, left.name_suffix, left.formatted_ssn, left.formatted_dob, 
													left.prim_range, left.prim_name, left.sec_range, left.zip5, left.st, left.formatted_phone_nbr);
				self := left)), id);

trimInfile := table(infile, {id, appendadl, appendssn,  
														 fname, mname, lname, name_suffix, 
														 ssn, formatted_dob, formatted_phone_nbr, 
														 prim_range, prim_name, sec_range, zip5, st}, local);																				
														 
dedInfile := dedup(sort(trimInfile, id, local), id, local);

did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(dedInfile(fname <> '' and lname <> ''), did_match_set,
						ssn, formatted_dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip5, st, formatted_phone_nbr,
						appendadl, recordof(dedInfile),false,'',
						75, DIDedFile);

    candi := DIDedFile(appendadl > 0);
not_candi := DIDedFile(appendadl = 0);

did_add.MAC_Add_SSN_By_DID(candi, appendadl, appendssn, addSSN, false);

AppendedFile := addSSN + not_candi + dedInfile(fname = '' or lname = '');
 
JnRecsBack := join(Infile, distribute(AppendedFile, id), left.id = right.id,
										transform({recordof(pinfile)}, 
															self.appendadl := right.appendadl;										
															self.appendssn := right.appendssn;										
															self := left), left outer, local);

return JnRecsBack + pInFile(fname + lname = '');

end;