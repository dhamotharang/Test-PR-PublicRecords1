IMPORT $;

EXPORT KEY_LICENSEPLATENBR := INDEX({$.Layouts.LICENSEPLATENBR_KEYED_FIELDS}, 
		                                {$.Layouts.LICENSEPLATENBR_PAYLOAD_FIELDS},
		                                $.Files.FILE_KEY_LICENSE_PLATE_NBR_SF
										                );