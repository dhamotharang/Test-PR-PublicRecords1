IMPORT $;

//Used this index method to carry the maxlength.
dsBANKROUTINGNUMBER := DATASET([], $.Layouts.BANKROUTINGNUMBER);
EXPORT Key_BANKROUTINGNUMBER := INDEX(dsBANKROUTINGNUMBER,
                             {$.Layouts.BANKROUTINGNUMBER_KEYED}, 
                             {$.Layouts.BANKROUTINGNUMBER_PAYLOAD},
                             $.Names.i_BANKROUTINGNUMBER_SF
                             );
