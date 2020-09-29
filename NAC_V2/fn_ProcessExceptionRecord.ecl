import STD;
sfList := [$.Superfile_List.sfExceptionRecords,
						$.Superfile_List.sfExceptionRecords + '_father',
						$.Superfile_List.sfExceptionRecords + '_grandfather',
						$.Superfile_List.sfExceptionRecords + '_delete'
					];
lfn := $.Superfile_List.sfExceptionRecords + '_' + WORKUNIT;
/**
 Process new exception records
**/
EXPORT fn_ProcessExceptionRecord(DATASET($.Layouts2.rNac2Ex) nac2) := FUNCTION

	newexceptions := PROJECT(nac2(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.ExceptionRec;
										))(errors=0);
										
	formattedExceptions := PROJECT(newexceptions, TRANSFORM($.Layouts2.rExceptionRecord,
										self.SourceGroupId := left.GroupId;
										self := left;));

	exceptions := $.Process_ExceptionRecords(formattedExceptions); 

	return IF(EXISTS(newexceptions),
						ORDERED(
							OUTPUT(exceptions,,lfn, COMPRESSED),
							Std.file.fPromoteSuperFileList(sfList, lfn, deltail := true)
						)
					);

END;