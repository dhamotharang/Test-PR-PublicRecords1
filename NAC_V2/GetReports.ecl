import STD;
ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'nac2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];

EXPORT GetReports(DATASET($.Layouts2.rNac2Ex) nac2, string fn) := function

		//nac2 := DATASET(lfn, $.Layouts2.rNac2Ex, thor);

		cases := PROJECT(nac2(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.CaseRec;
										));

		clients := PROJECT(nac2(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ClientRec;
										));
		addresses := PROJECT(nac2(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.AddressRec;
										));
		contacts := PROJECT(nac2(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.StateContactRec;
										));
										
		exceptions := PROJECT(nac2(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ExceptionRec;
										));
										
		badRecords := PROJECT(nac2(RecordCode NOT IN Nac_V2.Layouts2.validRecordCodes), TRANSFORM(Nac_V2.Layouts2.rBadRecordEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.BadRec;
										));
										
		exceptionArchive := PROJECT(exceptions(errors=0), TRANSFORM($.Layouts2.rExceptionRecord,
										self.SourceGroupId := left.GroupId;
										self := left;));

		errs := DISTRIBUTE((+)(addresses.dsErrs,clients.dsErrs,cases.dsErrs,contacts.dsErrs,exceptions.dsErrs,badRecords.dsErrs), RANDOM());

		total := COUNT(nac2);
		nErrors := COUNT(errs(Severity='E'));
		nWarnings := COUNT(errs(Severity='W'));
		nRejected := COUNT(addresses(errors>0)) + COUNT(cases(errors>0)) + COUNT(clients(errors>0)) + COUNT(contacts(errors>0)) + COUNT(exceptions(errors>0)) + COUNT(badrecords);
		nWarned := COUNT(addresses(warnings>0)) + COUNT(cases(warnings>0)) + COUNT(clients(warnings>0)) + COUNT(contacts(warnings>0)) + COUNT(exceptions(warnings>0));
		nRejectable := COUNT(addresses(errors>0)) + COUNT(cases(errors>0)) + COUNT(clients(errors>0)) + COUNT(badrecords);

		err_rate := nRejectable/total;		// omit contact and exception records for threshold calculation
		ExcessiveInvalidRecordsFound :=	(total=0) OR (err_rate	> $.Mod_Sets.threshld);


		ncr := nac_v2.Print.NCR2_Report(fn, errs, total, nErrors, nWarnings, 'XX', ExcessiveInvalidRecordsFound);

		ncd := nac_v2.Print.NCD2_Report(fn, errs, total, nErrors, nWarnings, nWarned, nRejected, 'XX', ExcessiveInvalidRecordsFound);

		ncx := Nac_v2.Print.NCX2_Report(cases, clients, addresses, contacts, exceptions, badRecords); 

		return MODULE
			EXPORT	DATASET($.ValidationCodes.rError) dsErrs := errs;
			EXPORT	DATASET($.Print.dRow) dsNcr2 := ncr;
			EXPORT	DATASET($.Print.rNCD) dsNcd2 := ncd;
			EXPORT	DATASET($.Print.rNcx2) dsNcx2 := ncx;
			EXPORT	integer RejectedCount := nRejected;		// all rejected records
			EXPORT	integer RejectableCount := nRejectable;	// no contact/exception records
			EXPORT	integer ErrorCount := nErrors;
			EXPORT	integer WarningCount := nWarnings;
			EXPORT	integer WarnedCount := nWarned;
			EXPORT	integer	TotalRecords := total;
			EXPORT	boolean	RejectFile := ExcessiveInvalidRecordsFound;
			EXPORT	DATASET($.Layouts2.rStateContactEx) dsContacts := contacts;
			EXPORT	DATASET($.Layouts2.rExceptionRecord) dsExceptions := exceptionArchive;
		END; 

END;