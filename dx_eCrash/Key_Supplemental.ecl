IMPORT $;

EXPORT KEY_SUPPLEMENTAL := INDEX({$.Layouts.SUPPLEMENTAL_KEYED_FIELDS}, 
		                             {$.Layouts.SUPPLEMENTAL_PAYLOAD_FIELDS},
		                             $.Files.FILE_KEY_SUPPLEMENTAL_SF
										             );