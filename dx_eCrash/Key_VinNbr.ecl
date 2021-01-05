IMPORT $;

EXPORT KEY_VINNBR := INDEX({$.Layouts.VINNBR_KEYED_FIELDS}, 
		                       {$.Layouts.VINNBR_PAYLOAD_FIELDS},
		                       $.Files.FILE_KEY_VINNBR_SF
										       );