IMPORT $;

EXPORT KEY_REPORTID := INDEX({$.Layouts.REPORTID_KEYED_FIELDS}, 
		                         {$.Layouts.REPORTID_PAYLOAD_FIELDS},
		                         $.Files.FILE_KEY_REPORT_ID_SF
										         );