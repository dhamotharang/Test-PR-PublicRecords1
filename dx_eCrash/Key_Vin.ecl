IMPORT $;

EXPORT KEY_VIN := INDEX({$.Layouts.VIN_KEYED_FIELDS}, 
		                    {$.Layouts.VIN_PAYLOAD_FIELDS},
		                    $.Files.FILE_KEY_VIN_SF
										    );