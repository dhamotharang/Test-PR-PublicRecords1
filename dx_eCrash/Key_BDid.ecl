IMPORT $;

EXPORT KEY_BDID := INDEX({$.Layouts.BDID_KEYED_FIELDS}, 
		                     {$.Layouts.BDID_PAYLOAD_FIELDS},
		                      $.Files.FILE_KEY_BDID_SF
										     );