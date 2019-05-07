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

EXPORT PreprocessNCF2(DATASET(Layouts2.rNac2) nacin = Nac_V2.Files('').dsNCF2) := MODULE

	EXPORT cases := AddDates(
						Nac_V2.mod_Validation.CaseFile(
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCase,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										)),
								));

	EXPORT clients := AddDates(
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
	EXPORT addresses := 	AddDates(
									Nac_V2.mod_Validation.AddressFile(
										Nac_V2.proc_cleanAddr(
											PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := []))
										)
								));

	EXPORT contacts := 	AddDates(Nac_V2.mod_Validation.StateContactFile(
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContact,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;))));
										
	EXPORT exceptions := 	AddDates(Nac_V2.mod_Validation.ExceptionFile(
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rException,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;))));



END;