IMPORT $;

EXPORT KEY_ECRASH2V := INDEX({$.Layouts.ECRASH2V_KEYED_FIELDS}, 
		                         {$.Layouts.ECRASH2V_PAYLOAD_FIELDS},
		                         $.Files.FILE_KEY_ECRASH2V_SF
										         );
							