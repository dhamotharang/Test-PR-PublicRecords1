IMPORT $;

EXPORT KEY_BYHOD := INDEX({$.Layouts.BY_HOD_KEYED_FIELDS}, 
		                      {$.Layouts.BY_HOD_PAYLOAD_FIELDS},
		                       $.Files.FILE_KEY_ANALYTICS_BY_HOD_SF
										      );