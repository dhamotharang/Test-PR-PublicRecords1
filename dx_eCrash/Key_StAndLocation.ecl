IMPORT $;

EXPORT KEY_STANDLOCATION := INDEX({$.Layouts.STANDLOCATION_KEYED_FIELDS}, 
		                              {$.Layouts.STANDLOCATION_PAYLOAD_FIELDS},
		                              $.Files.FILE_KEY_ST_AND_LOCATION_SF
										              );