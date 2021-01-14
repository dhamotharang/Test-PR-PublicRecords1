IMPORT $;

EXPORT KEY_ECRASH1 := INDEX({$.Layouts.ECRASH1_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH1_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH1_SF
										        );