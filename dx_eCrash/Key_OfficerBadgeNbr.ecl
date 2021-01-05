IMPORT $;

EXPORT KEY_OFFICERBADGENBR := INDEX({$.Layouts.OFFICERBADGENBR_KEYED_FIELDS}, 
		                                {$.Layouts.OFFICERBADGENBR_PAYLOAD_FIELDS},
		                                $.Files.FILE_KEY_OFFICER_BADGE_NBR_STATE_SF
										                );