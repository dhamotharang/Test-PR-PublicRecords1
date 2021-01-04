IMPORT $;

EXPORT KEY_BYDOW := INDEX({$.Layouts.BY_DOW_KEYED_FIELDS}, 
		                      {$.Layouts.BY_DOW_PAYLOAD_FIELDS},
		                      $.Files.FILE_KEY_ANALYTICS_BY_DOW_SF
										      );