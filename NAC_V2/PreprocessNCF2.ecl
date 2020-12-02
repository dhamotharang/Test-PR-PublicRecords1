import	std;

/*

	Perform preliminary processing on a new file or superfile
    1. Remove duplicate record types. The last record in the file is used	
    2. Field level validation
		2. Rollup up records in the case of 

*/

string uc(string s) := Std.Str.ToUpperCase(s);
string fix(string s) := Std.Str.CleanSpaces(uc(Std.Str.SubstituteIncluded(s,'._',' ')));

GetCases(string ilfn) := PROJECT(
		SORT(DISTRIBUTE($.ExtractRecords(ilfn).cases, hash32(CaseId)),
					CaseId, filename, seqnum, LOCAL),
				TRANSFORM($.Layouts2.rCaseEx,
					self.ProgramState := uc(left.ProgramState);
					self.CountyName := uc(left.CountyName);
					self := left;
			));

GetClients(string ilfn) := PROJECT(
		SORT(DISTRIBUTE($.ExtractRecords(ilfn).clients, hash32(ClientId,CaseId)),
					ClientId, CaseId, Eligibility, filename, seqnum, LOCAL),
				//	ClientId, CaseId, Eligibility, filename, LOCAL),
				TRANSFORM($.Layouts2.rClientEx,
					self.ProgramState := uc(left.ProgramState);
					self.LastName := fix(left.LastName);
					self.FirstName := fix(left.FirstName);
					self.MiddleName := fix(left.MiddleName);
					self.NameSuffix := fix(left.NameSuffix);
					self.Email := TRIM(left.email,left,right);
					self := left;
			));
				
GetAddresses(string ilfn) := PROJECT(
		SORT(DISTRIBUTE($.ExtractRecords(ilfn).addresses, hash32(CaseId, ClientId)),
					CaseId, ClientId, AddressType, filename, seqnum, LOCAL),
					TRANSFORM($.Layouts2.rAddressEx,
						self.ProgramState := uc(left.ProgramState);
						self.Street1 := uc(left.Street1);
						self.Street2 := uc(left.Street2);
						self.City := uc(left.City);
						self.State := uc(left.State);						
						self := left;
			));

GetContacts(string ilfn) := DEDUP(SORT(DISTRIBUTE(
				PROJECT($.ExtractRecords(ilfn).contacts,
						TRANSFORM($.Layouts2.rStateContactEx;
							self.ProgramState := uc(left.ProgramState);
							self.ContactName := fix(left.ContactName);
							self := left;
						)),
				hash32(contactname)),
				contactname, programstate, programcode, programregion, programcounty, caseid, clientid,updatetype,
				filename, seqnum, local),
				contactname, programstate, programcode, programregion, programcounty, caseid, clientid,updatetype,
				right, local);

GetExceptions(string ilfn) := $.ExtractRecords(ilfn).exceptions;
																	
EXPORT PreprocessNCF2(string ilfn) := function	

	cases := 	Nac_V2.mod_Validation.CaseFile(GetCases(ilfn));

	clients1 := 	NAC_V2.proc_CleanClients(
									Nac_V2.mod_Validation.ClientFile(GetClients(ilfn)));

	// address validation requires cleaned addresses
	addresses1 := 	Nac_V2.mod_Validation.AddressFile(
										Nac_V2.proc_cleanAddr(GetAddresses(ilfn)));

	contacts := 	Nac_V2.mod_Validation.StateContactFile(GetContacts(ilfn));
									
	exceptions := Nac_V2.mod_Validation.ExceptionFile(GetExceptions(ilfn));
										
	clients := nac_v2.mod_Validation.VerifyRelatedClients(cases, clients1);
	addresses := nac_v2.mod_Validation.VerifyRelatedAddresses(cases, clients, addresses1);
	
	bad :=		Nac_V2.mod_Validation.ValidateRecordCode(
								 $.ExtractRecords(ilfn).BadRecords);

	
  recombined := PROJECT(cases, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.CaseRec := left;
								self.RecordCode := left.RecordCode;
								self := []) 
							) &
							PROJECT(clients, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.ClientRec := left;
								self.RecordCode := left.RecordCode;
								self := []) 
							) &
							PROJECT(addresses, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.AddressRec := left;
								self.RecordCode := left.RecordCode;
								self := []) 
							) &
							PROJECT(contacts, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.StateContactRec := left;
								self.RecordCode := left.RecordCode;
								self := [])
							) &
							PROJECT(exceptions, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.ExceptionRec := left;
								self.RecordCode := left.RecordCode;
								self := []) 
							) &
							PROJECT(bad, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.BadRec := left;
								self.RecordCode := left.RecordCode;
								self := []) 
							)
							;

		return recombined;
		
END;