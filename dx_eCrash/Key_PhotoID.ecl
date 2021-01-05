IMPORT $;

EXPORT KEY_PHOTOID := INDEX({$.Layouts.PHOTOID_KEYED_FIELDS}, 
		                        {$.Layouts.PHOTOID_PAYLOAD_FIELDS},
		                        $.Files.FILE_KEY_PHOTO_ID_SF
										        );