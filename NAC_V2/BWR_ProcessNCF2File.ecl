import Nac_V2, Std;
// Spray Filesd

AddDates(infile) := FUNCTIONMACRO
	result := PROJECT(infile, TRANSFORM(recordof(infile),
											self.Created := Std.Date.Today();
											self.Updated := Std.Date.Today();
											self := left;
										));
	return result;
ENDMACRO;

nacin := Nac_V2.Files('').dsNCF2;

	cases := AddDates(DISTRIBUTE(
						Nac_V2.Validate.CaseFile(
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCase,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										)),
								), HASH64(ProgramState, ProgramCode, CaseId)));

	clients := AddDates(DISTRIBUTE(
								NAC_V2.proc_CleanClients(
									Nac_V2.Validate.ClientFile(
										PROJECT(nacin(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClient,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										),
									)
								), HASH64(ProgramState, ProgramCode, CaseId, ClientId)));

	addresses := 	AddDates(DISTRIBUTE(
									Nac_V2.proc_cleanAddr(
										Nac_V2.Validate.AddressFile(
											PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddress,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;))
										)
								), HASH64(ProgramState, ProgramCode, CaseId)));

	contacts := 	AddDates(Nac_V2.Validate.StateContactFile(
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContact,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;))));
										
	exceptions := 	AddDates(Nac_V2.Validate.ExceptionFile(
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rException,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;))));


	out := PARALLEL(
		OUTPUT(cases,,Nac_V2.Superfile_List('').sfCaseRecords+'::'+workunit,COMPRESSED),
		OUTPUT(clients,,Nac_V2.Superfile_List('').sfClientRecords+'::'+workunit,COMPRESSED),
		OUTPUT(addresses,,Nac_V2.Superfile_List('').sfAddressRecords+'::'+workunit,COMPRESSED),
		OUTPUT(contacts,,Nac_V2.Superfile_List('').sfContactRecords+'::'+workunit,COMPRESSED),
		OUTPUT(exceptions,,Nac_V2.Superfile_List('').sfExceptionRecords+'::'+workunit,COMPRESSED)
	);

	promote := PARALLEL(
		nac_v2.Promote_Superfiles(Nac_V2.Superfile_List('').sfCaseRecords,Nac_V2.Superfile_List('').sfCaseRecords+'::'+workunit),
		nac_v2.Promote_Superfiles(Nac_V2.Superfile_List('').sfClientRecords,Nac_V2.Superfile_List('').sfClientRecords+'::'+workunit),
		nac_v2.Promote_Superfiles(Nac_V2.Superfile_List('').sfAddressRecords,Nac_V2.Superfile_List('').sfAddressRecords+'::'+workunit),
		nac_v2.Promote_Superfiles(Nac_V2.Superfile_List('').sfContactRecords,Nac_V2.Superfile_List('').sfContactRecords+'::'+workunit),
		nac_v2.Promote_Superfiles(Nac_V2.Superfile_List('').sfExceptionRecords,Nac_V2.Superfile_List('').sfExceptionRecords+'::'+workunit)
	);
	
SEQUENTIAL(Out, Promote);


//EXPORT BWR_ProcessNCF2File := 'todo';