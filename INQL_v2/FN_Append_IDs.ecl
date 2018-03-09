///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 
	 Appends
		 BDID
		 DID
		 SSN
		 TaxID
   
   Sandboxed Items are in cguyton for prod. These sandboxed attributes do the following:
		 Increase threads send to roxie pipe (20 to simulate 200 way (1M recs a min), 40 to simulate 400 way (2M recs a min)). Currently set to 40.
		 Output Max_SSN during pipe through for DID
		 Output Max_TaxID during pipe through for BDID
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, watchdog, business_header, INQL_v2;

export FN_Append_IDs(dataset(INQL_v2.Layouts.Common_layout) pInFile) := function

	Infile := distribute(project(pInFile(fname + lname + clean_cname1 <> '')
			, transform({unsigned8 id, recordof(pInFile)},
					self.id := hash64(left.fname, left.mname, left.lname, left.name_suffix, left.ssn, left.dob, 
														left.prim_range, left.prim_name, left.sec_range, left.zip5, left.st, left.personal_phone,
														left.clean_cname1, left.company_phone, left.ein);
					self := left)), id);

	trimInfile := table(infile, {id, appendadl, appendssn, appendbdid, appendtaxid, 
															 fname, mname, lname, name_suffix, clean_cname1, ein,
															 ssn, dob, personal_phone, company_phone,
															 prim_range, prim_name, sec_range, zip5, st}, local);																				
															 
	dedInfile := dedup(sort(trimInfile, id, local), id, local);

	did_match_set := ['A','D','S','P','4','Z'];

	did_add.MAC_Match_Flex(dedInfile(fname <> '' and lname <> ''), did_match_set,
							ssn, dob, fname, mname, lname, name_suffix,
							prim_range, prim_name, sec_range, zip5, st, personal_phone,
							appendadl, recordof(dedInfile),false,'',
							75, DIDedFile);

			candi := DIDedFile(appendadl > 0);
	not_candi := DIDedFile(appendadl = 0);

	did_add.MAC_Add_SSN_By_DID(candi, appendadl, appendssn, addSSN, false);

	ForBDIDAppend := addSSN + not_candi + dedInfile(fname = '' or lname = '');

	bdid_match_set := ['A','P','F']; 

	FiltForBDIDAppend :=  ForBDIDAppend(CLEAN_CNAME1 <> '' or ein <> '');

	Business_Header_SS.MAC_Match_Flex(FiltForBDIDAppend, bdid_match_set,
										CLEAN_CNAME1,
										prim_range, prim_name, zip5, sec_range, st, company_phone, ein,
										appendbdid, recordof(dedInfile), 
										false, '', BDIDFile);

			candi_bus := BDIDFile(appendbdid > 0);
	not_candi_bus := BDIDFile(appendbdid = 0);

	Business_Header_SS.MAC_Add_FEIN_By_BDID(candi_bus, appendbdid, appendtaxid, addFEIN)

	AppendedFile := addFEIN + not_candi_bus + ForBDIDAppend(CLEAN_CNAME1 = '' and ein = '');

	JnRecsBack := join(Infile, distribute(AppendedFile, id), left.id = right.id,
											transform({recordof(pinfile)}, 
																self.appendadl := right.appendadl;										
																self.appendssn := right.appendssn;										
																self.appendbdid := right.appendbdid;										
																self.appendtaxid := right.appendtaxid;										
																self := left), left outer, local);

	return project(JnRecsBack, INQL_v2.Layouts.Common_layout) + project(pInFile(fname + lname + clean_cname1 = ''), INQL_v2.Layouts.Common_layout);
end;