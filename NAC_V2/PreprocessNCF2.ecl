import	std;

/*

	Perform preliminary processing
		1.	Field level validation
		2.	Set dates

*/


RightNow := Std.Date.Today();

GetFileName(string ilfn) := FUNCTION
		s1 := Std.Str.FindReplace(ilfn, '::', ' ');
		n := Std.Str.WordCount(s1);
		return Std.Str.GetNthWord(s1, n);
END;
																	
EXPORT PreprocessNCF2(string ilfn) := function

	r1 := RECORD
		string	text;
	END;
	ds := dataset(ilfn, r1, CSV)(LENGTH(TRIM(text,left,right)) > 4);

	nacin := PROJECT(ds, TRANSFORM(Nac_V2.Layouts2.rNac2,
				string4 rc := left.text[1..4];
				len := MIN(LENGTH(left.text), 484);
				string484 text := left.text[5..len] + IF(len < 484, Std.Str.Repeat(' ', 484-len), '');
				self.CaseRec := IF(rc='CA01', TRANSFER(text, Nac_V2.Layouts2.rCase - RecordCode));
				self.ClientRec := IF(rc='CL01', TRANSFER(text, Nac_V2.Layouts2.rClient - RecordCode));
				self.AddressRec := IF(rc='AD01', TRANSFER(text, Nac_V2.Layouts2.rAddress - RecordCode));
				self.StateContactRec := IF(rc='SC01', TRANSFER(text, Nac_V2.Layouts2.rStateContact - RecordCode));
				self.ExceptionRec := IF(rc='EX01', TRANSFER(text, Nac_V2.Layouts2.rException - RecordCode));
				self.BadRec := IF(rc NOT IN Nac_V2.Layouts2.validRecordCodes, TRANSFER(text, Nac_V2.Layouts2.rBadRecord - RecordCode));
				self.RecordCode := rc;
				));
				
	fname := GetFileName(ilfn);
	gid := Std.Str.ToUpperCase(fname[6..9]);

	cases := 	Nac_V2.mod_Validation.CaseFile(
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := gid;
										self.OrigGroupId := gid;
										self.filename := fname;
										self.Created := RightNow;
										self.Updated := RightNow;
										self := [];
										)),
							);

	 clients1 := 	NAC_V2.proc_CleanClients(
									Nac_V2.mod_Validation.ClientFile(
										PROJECT(nacin(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											self.GroupId := gid;
											self.OrigGroupId := gid;
											self.filename := fname;
											self.Created := RightNow;
											self.Updated := RightNow;
											self := [];
											)
										),
									)
								);

	// address validation requires cleaned addresses
	 addresses1 := 	Nac_V2.mod_Validation.AddressFile(
										Nac_V2.proc_cleanAddr(
											PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self.GroupId := gid;
												self.OrigGroupId := gid;
												self.filename := fname;
												self.Created := RightNow;
												self.Updated := RightNow;
												self := []))
										)
								);

	 contacts := 	Nac_V2.mod_Validation.StateContactFile(
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := gid;
										self.OrigGroupId := gid;
										self.filename := fname;
										self.Created := RightNow;
										self.Updated := RightNow;
										self := [];
										)));
									
	 exceptions := 	Nac_V2.mod_Validation.ExceptionFile(
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;
										self.SourceGroupId := gid;
										self.filename := fname;
										self.Created := RightNow;
										self.Updated := RightNow;
										self := [];
										)));
										
	clients := nac_v2.mod_Validation.VerifyRelatedClients(cases, clients1);
	addresses := nac_v2.mod_Validation.VerifyRelatedAddresses(cases, clients, addresses1);
	
		bad :=		Nac_V2.mod_Validation.ValidateRecordCode(
								PROJECT(nacin(RecordCode NOT IN Nac_V2.Layouts2.validRecordCodes), TRANSFORM(Nac_V2.Layouts2.rBadRecord,
										self := LEFT.BadRec;
										self.RecordCode := left.RecordCode;
							)));

	
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