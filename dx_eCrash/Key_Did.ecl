IMPORT $;

EXPORT KEY_DID := INDEX({$.Layouts.DID_KEYED_FIELDS}, 
		                    {$.Layouts.DID_PAYLOAD_FIELDS},
		                    $.Files.FILE_KEY_DID_SF
										    );