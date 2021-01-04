IMPORT $;

EXPORT KEY_ACCNBRV1 := INDEX({$.Layouts.ACCNBRV1_KEYED_FIELDS}, 
		                         {$.Layouts.ACCNBRV1_PAYLOAD_FIELDS},
		                         $.Files.FILE_KEY_ACCNBRV1_SF
										         );