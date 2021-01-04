IMPORT $;

EXPORT KEY_ACCNBR := INDEX({$.Layouts.ACCNBR_KEYED_FIELDS}, 
		                       {$.Layouts.ACCNBR_PAYLOAD_FIELDS},
		                       $.Files.FILE_KEY_ACCNBR_SF
										       );