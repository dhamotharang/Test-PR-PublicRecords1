import STD;
sfList := [$.Superfile_List.sfExceptionRecords,
						$.Superfile_List.sfExceptionRecords + '_father',
						$.Superfile_List.sfExceptionRecords + '_grandfather',
						$.Superfile_List.sfExceptionRecords + '_delete'
					];
lfn := $.Superfile_List.sfExceptionRecords + '_' + WORKUNIT;
EXPORT fn_ProcessExceptionRecord(DATASET($.Layouts2.rExceptionRecord) inrec) := FUNCTION

	exceptions := $.Process_ExceptionRecords(inrec); 

	return ORDERED(
			OUTPUT(exceptions,,lfn, COMPRESSED),
			Std.file.fPromoteSuperFileList(sfList, lfn, deltail := true)
	);

END;