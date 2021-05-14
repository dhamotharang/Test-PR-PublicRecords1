IMPORT $;

//Used this index method to carry the maxlength.
dsISP := DATASET([], $.Layouts.ISP);
EXPORT Key_ISP := INDEX(dsISP,
                             {$.Layouts.ISP_KEYED}, 
                             {$.Layouts.ISP_PAYLOAD},
                             $.Names.i_ISP_SF
                             );
