IMPORT STD;

ReportFileName(string ilfn, string rpt) := Std.Str.SubstituteIncluded(ilfn, 'ncf2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];

EXPORT PreprocessNCF2File(string ilfn) := function

	ds := DATASET(ilfn,$.Layouts2.rNac2,thor);
	
	incases := PROJECT(ds(RecordCode = 'CA01'), TRANSFORM($.Layouts2.rCase,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										));

	inclients := PROJECT(ds(RecordCode = 'CL01'), TRANSFORM($.Layouts2.rClient,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										);

	inaddresses := PROJECT(ds(RecordCode = 'AD01'), TRANSFORM($.Layouts2.rAddress,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := []));

	incontacts := PROJECT(ds(RecordCode = 'SC01'), TRANSFORM($.Layouts2.rStateContact,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;));
										
	addr1 := $.PreprocessNCF2(ds).addresses;				// : PERSIST('~thor::nac2::test_addressesx');
	clients1 := $.PreprocessNCF2(ds).clients;				// : PERSIST('~thor::nac2::test_clientsx');
	cases := $.PreprocessNCF2(ds).cases;						// : PERSIST('~thor::nac2::test_casesx');
	contacts := $.PreprocessNCF2(ds).contacts;			// : PERSIST('~thor::nac2::test_contactsx');
	exceptions := $.PreprocessNCF2(ds).exceptions;	// : PERSIST('~thor::nac2::test_exceptionsx');
	
	clients := $.mod_Validation.VerifyRelatedClients(cases(errors=0), clients1);
	addr := nac_v2.mod_Validation.VerifyRelatedAddresses(cases(errors=0), clients(errors=0), addr1(errors=0)) + addr1(errors<>0);
	
	errs := DISTRIBUTE((+)(addr.dsErrs,clients.dsErrs,cases.dsErrs,contacts.dsErrs,exceptions.dsErrs), RANDOM());
	
	total := COUNT(ds);
	nErrors := COUNT(errs(Severity='E'));
	nWarnings := COUNT(errs(Severity='W'));
	nRejected := COUNT(addr(errors>0)) + COUNT(cases(errors>0)) + COUNT(clients(errors>0)) + COUNT(contacts(errors>0));
	nWarned := COUNT(addr(warnings>0)) + COUNT(cases(warnings>0)) + COUNT(clients(warnings>0)) + COUNT(contacts(warnings>0));

	lfn := ExtractFileName(ilfn);
	
	ncr := $.Print.NCR2_Report(lfn, errs, total, nErrors, nWarnings, 'XX', false);

	ncd := $.Print.NCD2_Report(lfn, errs, total, nErrors, nWarnings, nWarned, nRejected, 'XX', false);

	ncx := $.Print.NCX2_Report(cases, clients, addr, contacts); 

	SEQUENTIAL(
		OUTPUT(ncr,,ReportFileName(ilfn,'ncr2'),OVERWRITE),
		OUTPUT(ncd,,ReportFileName(ilfn,'ncd2'),OVERWRITE),
		OUTPUT(ncx,,ReportFileName(ilfn,'ncx2'),OVERWRITE)
	);


	return 0;
end;