IMPORT $;

EXPORT KEY_BYCOLLISIONTYPE := INDEX({$.Layouts.BY_CT_KEYED_FIELDS}, 
		                                {$.Layouts.BY_CT_PAYLOAD_FIELDS},
		                                $.Files.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE_SF
										                );