IMPORT $;

EXPORT KEY_UNRESTRICTEDACCNBRV1 := INDEX({$.Layouts.UNRESTRICTED_ACCNBRV1_KEYED_FIELDS}, 
		                                     {$.Layouts.UNRESTRICTED_ACCNBRV1_PAYLOAD_FIELDS},
		                                     $.Files.FILE_KEY_UNRESTRICTED_ACCNBRV1_SF
										                     );