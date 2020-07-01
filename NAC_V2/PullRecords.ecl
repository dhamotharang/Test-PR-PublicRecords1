EXPORT PullRecords(DATASET($.Layouts2.rNac2Ex) nac2) := MODULE

		EXPORT cases := PROJECT(nac2(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.CaseRec;
										));

		EXPORT clients := PROJECT(nac2(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ClientRec;
										));
		EXPORT addresses := PROJECT(nac2(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.AddressRec;
										));
		EXPORT contacts := PROJECT(nac2(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.StateContactRec;
										));
										
		EXPORT exceptions := PROJECT(nac2(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ExceptionRec;
										));
										
		EXPORT badRecords := PROJECT(nac2(RecordCode NOT IN Nac_V2.Layouts2.validRecordCodes), TRANSFORM(Nac_V2.Layouts2.rBadRecordEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.BadRec;
										));
										
		EXPORT exceptionArchive := PROJECT(exceptions(errors=0), TRANSFORM($.Layouts2.rExceptionRecord,
										self.SourceGroupId := left.GroupId;
										self := left;));

		EXPORT errs := DISTRIBUTE((+)(addresses.dsErrs,clients.dsErrs,cases.dsErrs,contacts.dsErrs,exceptions.dsErrs,badRecords.dsErrs), RANDOM());



END;