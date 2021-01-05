IMPORT $;

EXPORT KEY_ECRASH0 := INDEX({$.Layouts.ECRASH0_KEYED_FIELDS}, 
		                        {$.Layouts.ECRASH0_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_ECRASH0_SF
										        );
						 	 