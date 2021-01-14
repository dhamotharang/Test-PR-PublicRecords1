IMPORT $;

EXPORT KEY_LASTNAME := INDEX({$.Layouts.LASTNAME_KEYED_FIELDS}, 
		                         {$.Layouts.LASTNAME_PAYLOAD_FIELDS},
		                         $.Files.FILE_KEY_LAST_NAME_STATE_SF
										         );