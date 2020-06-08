import STD;
sfList := [$.Superfile_List.sfContactRecords,
						$.Superfile_List.sfContactRecords + '_father',
						$.Superfile_List.sfContactRecords + '_grandfather',
						$.Superfile_List.sfContactRecords + '_delete'
					];
lfn := $.Superfile_List.sfContactRecords + '_' + WORKUNIT;
EXPORT fn_ProcessContactRecord(DATASET($.Layouts2.rStateContactEx) inrec) := FUNCTION

	contacts := $.Process_ContactRecords(inrec(errors=0)); 

	return IF(EXISTS(contacts), ORDERED(
			OUTPUT(contacts,,lfn, COMPRESSED),
			Std.file.fPromoteSuperFileList(sfList, lfn, deltail := true)
	));

END;