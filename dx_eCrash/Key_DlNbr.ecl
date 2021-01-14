IMPORT $;

EXPORT KEY_DLNBR := INDEX({$.Layouts.DLNBR_KEYED_FIELDS}, 
		                      {$.Layouts.DLNBR_PAYLOAD_FIELDS},
		                      $.Files.FILE_KEY_DL_NBR_SF
										      );