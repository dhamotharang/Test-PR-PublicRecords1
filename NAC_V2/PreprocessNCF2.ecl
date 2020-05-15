import	std;

/*

	Perform preliminary processing
		1.	Field level validation
		2.	Set dates

*/


GetCases(string ilfn) := 
		DEDUP(SORT(DISTRIBUTE($.ExtractRecords(ilfn).cases, hash32(CaseId)),
					CaseId, filename, -seqnum, LOCAL), CaseId, filename, LOCAL);
					
GetClients(string ilfn) := 
		DEDUP(SORT(DISTRIBUTE($.ExtractRecords(ilfn).clients, hash32(ClientId)),
					ClientId, CaseId, filename, -seqnum, LOCAL),
					ClientId, CaseId, filename, LOCAL);
		
GetAddresses(string ilfn) := 
		DEDUP(SORT(DISTRIBUTE($.ExtractRecords(ilfn).addresses, hash32(CaseId, ClientId)),
					CaseId, ClientId, AddressType, filename, -seqnum, LOCAL),
					CaseId, ClientId, AddressType, filename, LOCAL);

GetContacts(string ilfn) := $.ExtractRecords(ilfn).contacts;
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