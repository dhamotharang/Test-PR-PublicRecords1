IMPORT $;

EXPORT KEY_ECRASH6 := INDEX({$.Layouts.ECRASH6_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH6_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH6_SF
										        );