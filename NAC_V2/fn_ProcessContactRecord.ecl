import STD;
sfList := [$.Superfile_List.sfContactRecords,
						$.Superfile_List.sfContactRecords + '_father',
						$.Superfile_List.sfContactRecords + '_grandfather',
						$.Superfile_List.sfContactRecords + '_delete'
					];
lfn := $.Superfile_List.sfContactRecords + '_' + WORKUNIT;
/**
 Process new state contact records
**/
EXPORT fn_ProcessContactRecord(DATASET($.Layouts2.rNac2Ex) nac2) := FUNCTION

	newcontacts := PROJECT(nac2(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self.RecordCode := left.RecordCode;
										self := LEFT.StateContactRec;
										))(errors=0);
	
	contacts := $.Process_ContactRecords(newcontacts); 

	return IF(EXISTS(newcontacts),
						ORDERED(
							OUTPUT(contacts,,lfn, COMPRESSED),
							Std.file.fPromoteSuperFileList(sfList, lfn, deltail := true)
						)
					);

END;