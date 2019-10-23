import STD;

ModifyFileName(string ilfn, string rpt) := Std.Str.FindReplace(ilfn, 'xxx2', rpt);
ExtractFileName(string ilfn) := Std.Str.SplitWords(ilfn, '::')[4];

EXPORT GetErrors(string lfn) := function

		nac2 := DATASET(lfn, $.Layouts2.rNac2Ex, thor);

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

		errs := DISTRIBUTE((+)(addresses.dsErrs,clients.dsErrs,cases.dsErrs,contacts.dsErrs,exceptions.dsErrs), RANDOM());

		total := COUNT(nac2);
		nErrors := COUNT(errs(Severity='E'));
		nWarnings := COUNT(errs(Severity='W'));
		nRejected := COUNT(addresses(errors>0)) + COUNT(cases(errors>0)) + COUNT(clients(errors>0)) + COUNT(contacts(errors>0));
		nWarned := COUNT(addresses(warnings>0)) + COUNT(cases(warnings>0)) + COUNT(clients(warnings>0)) + COUNT(contacts(warnings>0));
		
		return MODULE
			EXPORT	DATASET($.ValidationCodes.rError) dsErrs := errs;
			EXPORT	integer RejectedCount := nRejected;
			EXPORT	integer ErrorCount := nErrors;
			EXPORT	integer WarningCount := nWarnings;
			EXPORT	integer WarnedCount := nWarned;
			EXPORT	integer	TotalRecords := total;
		END; 

END;