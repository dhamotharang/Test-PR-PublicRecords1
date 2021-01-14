IMPORT $;

EXPORT KEY_VIN7 := INDEX({$.Layouts.VIN7_KEYED_FIELDS}, 
		                     {$.Layouts.VIN7_PAYLOAD_FIELDS},
		                     $.Files.FILE_KEY_VIN7_SF
										     );