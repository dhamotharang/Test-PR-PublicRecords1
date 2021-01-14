IMPORT $;

EXPORT KEY_BYINTER := INDEX({$.Layouts.BY_INTER_KEYED_FIELDS}, 
		                        {$.Layouts.BY_INTER_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ANALYTICS_BY_INTER_SF
										        );