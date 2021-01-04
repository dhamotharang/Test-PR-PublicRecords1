IMPORT $;

EXPORT KEY_ECRASH5 := INDEX({$.Layouts.ECRASH5_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH5_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH5_SF
										        );