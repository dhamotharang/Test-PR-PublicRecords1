IMPORT $;

EXPORT KEY_BYAGENCYID := INDEX({$.Layouts.BY_AGENCYID_KEYED_FIELDS}, 
		                           {$.Layouts.BY_AGENCYID_PAYLOAD_FIELDS},
		                            $.Files.FILE_KEY_ANALYTICS_BY_AGENCY_ID_SF
										           );