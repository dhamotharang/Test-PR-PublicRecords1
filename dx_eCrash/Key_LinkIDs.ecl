IMPORT $;

EXPORT KEY_LINKIDS := INDEX({$.Layouts.LINKIDS_KEYED_FIELDS}, 
		                        {$.Layouts.LINKIDS_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_LINKIDS_SF
										        );