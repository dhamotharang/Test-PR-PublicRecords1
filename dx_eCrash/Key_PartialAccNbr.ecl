IMPORT $;

EXPORT KEY_PARTIALACCNBR := INDEX({$.Layouts.PARTIAL_ACCNBR_KEYED_FIELDS}, 
		                              {$.Layouts.PARTIAL_ACCNBR_PAYLOAD_FIELDS},
		                              $.Files.FILE_KEY_PARTIAL_ACCNBR_SF
										              );