/**
 separate record types from processed NCF2 file
**/
EXPORT fn_PullRecords(DATASET($.Layouts2.rNac2Ex) nac2) := MODULE

	EXPORT cases := PROJECT(nac2(RecordCode = 'CA01'), TRANSFORM($.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										));

	EXPORT clients := PROJECT(nac2(RecordCode = 'CL01'), TRANSFORM($.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											)
										);
										
	EXPORT addresses := PROJECT(nac2(RecordCode = 'AD01'), TRANSFORM($.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self := []));


	EXPORT StateContacts := PROJECT(nac2(RecordCode = 'SC01'), TRANSFORM($.Layouts2.rStateContactEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.StateContactRec;
										));

	EXPORT exceptions := PROJECT(nac2(RecordCode = 'EX01'), TRANSFORM($.Layouts2.rExceptionEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ExceptionRec;
										));

END;