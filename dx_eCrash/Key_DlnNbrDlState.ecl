IMPORT $;

EXPORT KEY_DLNNBRDLSTATE := INDEX({$.Layouts.DLNNBRDLSTATE_KEYED_FIELDS}, 
		                              {$.Layouts.DLNNBRDLSTATE_PAYLOAD_FIELDS},
		                              $.Files.FILE_KEY_DLN_NBR_DL_STATE_SF
										              );