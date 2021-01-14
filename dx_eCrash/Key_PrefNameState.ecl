IMPORT $;

EXPORT KEY_PREFNAMESTATE := INDEX({$.Layouts.PREFNAME_KEYED_FIELDS}, 
		                              {$.Layouts.PREFNAME_PAYLOAD_FIELDS},
		                              $.Files.FILE_KEY_PREFNAME_STATE_SF
										              );