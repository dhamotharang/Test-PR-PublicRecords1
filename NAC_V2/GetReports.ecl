import STD;

ExtractFileName(string ilfn) := FUNCTION
		s1 := Std.Str.SplitWords(ilfn, '::');
		n := COUNT(s1);
		return s1[n];
END;

EXPORT GetReports(DATASET($.Layouts2.rNac2Ex) nac2, string ilfn, BOOLEAN show_email_message = FALSE) := function

		fn := ExtractFileName(ilfn);


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



  clients_programcodes := TABLE(clients, {clients.programcode, sumprogs:= COUNT(GROUP)}, programcode);

	NAC_V2.Layouts2.rItemSummary transform_programs(RECORDOF(clients_programcodes) l) := TRANSFORM
		SELF.itemcode := l.programcode;
		SELF.counts :=  l.sumprogs;
	END;
	ds_programs01 := PROJECT(clients_programcodes, transform_programs(LEFT));


 		programs := SORT(ds_programs01 , itemcode, LOCAL);
 		
		

	types01 := SORT(Nac_V2.ExtractRecords(ilfn).Types, RecordCode, LOCAL);
	NAC_V2.Layouts2.rItemSummary transform_types(RECORDOF(types01) l) := TRANSFORM
		SELF.itemcode := l.recordcode;
		SELF.counts :=  l.n;
	END;
	types := PROJECT(types01, transform_types(LEFT));


		ncr := nac_v2.Print.NCR2_Report(fn, errs, total, nErrors, nWarnings, 'XX', ExcessiveInvalidRecordsFound, programs, types, show_email_message); 

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