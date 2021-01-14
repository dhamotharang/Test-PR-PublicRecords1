IMPORT $;

EXPORT KEY_AGENCY := INDEX({$.Layouts.AGENCY_KEYED_FIELDS}, 
		                       {$.Layouts.AGENCY_PAYLOAD_FIELDS},
		                       $.Files.FILE_KEY_AGENCY_SF
										       );