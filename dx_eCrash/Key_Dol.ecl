IMPORT $;

EXPORT KEY_DOL := INDEX({$.Layouts.DOL_KEYED_FIELDS}, 
		                    {$.Layouts.DOL_PAYLOAD_FIELDS},
		                    $.Files.FILE_KEY_DOL_SF
										    );