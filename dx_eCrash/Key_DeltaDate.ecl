IMPORT $;

EXPORT KEY_DELTADATE := INDEX({$.Layouts.DELTADATE_KEYED_FIELDS}, 
		                          {$.Layouts.DELTADATE_PAYLOAD_FIELDS},
		                          $.Files.FILE_KEY_DELTA_DATE_SF
										          );