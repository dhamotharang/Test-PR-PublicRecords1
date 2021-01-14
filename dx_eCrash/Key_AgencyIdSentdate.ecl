IMPORT $;

EXPORT KEY_AGENCYIDSENTDATE := INDEX({$.Layouts.AGENCYID_SENTDATE_KEYED_FIELDS}, 
		                                 {$.Layouts.AGENCYID_SENTDATE_PAYLOAD_FIELDS},
		                                 $.Files.FILE_KEY_AGENCY_ID_SENT_DATE_STATE_SF
										                 );