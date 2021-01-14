IMPORT $;

EXPORT KEY_ECRASH7 := INDEX({$.Layouts.ECRASH7_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH7_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH7_SF
										        );