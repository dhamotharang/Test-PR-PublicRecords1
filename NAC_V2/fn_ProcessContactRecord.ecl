import STD;
/**
 Process new state contact records
**/
lfn := $.Superfile_List.sfContactRecords + '_' + WORKUNIT;
EXPORT fn_ProcessContactRecord(DATASET($.Layouts2.rNac2Ex) nac2) := FUNCTION

	newcontacts := $.fn_PullRecords(nac2).StateContacts(errors=0);
	
	contacts := $.Process_ContactRecords(newcontacts); 

	return IF(EXISTS(newcontacts),
						ORDERED(
							OUTPUT(contacts,,lfn, COMPRESSED),
							$.Superfile_List.Promote($.Superfile_List.sfContactRecords, lfn)
						)
					);

END;