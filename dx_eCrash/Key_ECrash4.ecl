IMPORT $;

EXPORT KEY_ECRASH4 := INDEX({$.Layouts.ECRASH4_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH4_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH4_SF
										        );				