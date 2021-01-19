IMPORT $;
	
EXPORT KEY_LASTNAME := INDEX({$.Layouts.LASTNAME_KEYED}, 
                             {$.Layouts.LASTNAME_PAYLOAD},
                             $.Names.i_LAST_NAME_STATE_SF
                             );
