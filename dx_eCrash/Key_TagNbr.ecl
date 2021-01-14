IMPORT $;

EXPORT KEY_TAGNBR := INDEX({$.Layouts.TAGNBR_KEYED_FIELDS}, 
		                       {$.Layouts.TAGNBR_PAYLOAD_FIELDS},
		                       $.Files.FILE_KEY_TAG_NBR_SF
										       );