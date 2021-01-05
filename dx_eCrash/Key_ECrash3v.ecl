IMPORT $;

EXPORT KEY_ECRASH3V := INDEX({$.Layouts.ECRASH3V_KEYED_FIELDS}, 
		                         {$.Layouts.ECRASH3V_PAYLOAD_FIELDS},
		                         $.Files.FILE_KEY_ECRASH3V_SF
										         );