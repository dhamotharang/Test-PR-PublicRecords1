import	std;

/*

	Perform preliminary processing
		1.	Field level validation
		2.	Set dates

*/

AddDates(infile) := FUNCTIONMACRO
	result := PROJECT(infile, TRANSFORM(recordof(infile),
											self.Created := Std.Date.Today();
											self.Updated := Std.Date.Today();
											self := left;
										));
	return result;
ENDMACRO;

EXPORT PreprocessNCF2(string ilfn) := function

	r1 := RECORD
		string	text;
	END;
	ds := dataset(ilfn, r1, CSV);

	nacin := PROJECT(ds, TRANSFORM(Nac_V2.Layouts2.rNac2,
				string4 rc := left.text[1..4];
				string350 text := left.text[5..];
				self.CaseRec := IF(rc='CA01', TRANSFER(text, Nac_V2.Layouts2.rCase - RecordCode));
				self.ClientRec := IF(rc='CL01', TRANSFER(text, Nac_V2.Layouts2.rClient - RecordCode));
				self.AddressRec := IF(rc='AD01', TRANSFER(text, Nac_V2.Layouts2.rAddress - RecordCode));
				self.StateContactRec := IF(rc='SC01', TRANSFER(text, Nac_V2.Layouts2.rStateContact - RecordCode));
				self.ExceptionRec := IF(rc='EX01', TRANSFER(text, Nac_V2.Layouts2.rException - RecordCode));
				self.BadRecord := IF(rc NOT IN Nac_V2.Layouts2.validRecordCodes, left.text, '');
				self.RecordCode := rc;
				));

	 cases := AddDates(
						Nac_V2.mod_Validation.CaseFile(
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCase,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										)),
								));

	 clients := AddDates(
								NAC_V2.proc_CleanClients(
									Nac_V2.mod_Validation.ClientFile(
										PROJECT(nacin(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClient,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										),
									)
								));

	// address validation requires cleaned addresses
	 addresses := 	AddDates(
									Nac_V2.mod_Validation.AddressFile(
										Nac_V2.proc_cleanAddr(
											PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := []))
										)
								));

	 contacts := 	AddDates(Nac_V2.mod_Validation.StateContactFile(
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContact,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;))));
										
	 exceptions := 	AddDates(Nac_V2.mod_Validation.ExceptionFile(
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rException,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;))));

  recombined := PROJECT(cases, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.CaseRec := left;
								self := []) 
							) &
							PROJECT(clients, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.ClientRec := left;
								self := []) 
							) &
							PROJECT(addresses, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.AddressRec := left;
								self := []) 
							) &
							PROJECT(clients, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.ClientRec := left;
								self := []) 
							) &
							PROJECT(contacts, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.StateContactRec := left;
								self := []) 
							) &
							PROJECT(exceptions, TRANSFORM(nac_v2.Layouts2.rNac2Ex,
								self.ExceptionRec := left;
								self := []) 
							)
							;

		return recombined;
		
END;