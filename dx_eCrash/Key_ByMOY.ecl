IMPORT $;

EXPORT KEY_BYMOY := INDEX({$.Layouts.BY_MOY_KEYED_FIELDS}, 
		                      {$.Layouts.BY_MOY_PAYLOAD_FIELDS},
		                      $.Files.FILE_KEY_ANALYTICS_BY_MOY_SF
										      );