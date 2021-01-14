IMPORT $;

EXPORT KEY_REPORTLINKID := INDEX({$.Layouts.REPORTLINKID_KEYED_FIELDS}, 
		                             {$.Layouts.REPORTLINKID_PAYLOAD_FIELDS},
		                             $.Files.FILE_KEY_REPORT_LINKID_SF
										             );