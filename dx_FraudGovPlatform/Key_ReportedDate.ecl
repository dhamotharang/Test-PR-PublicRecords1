IMPORT $;

//Used this index method to carry the maxlength.
dsREPORTEDDATE := DATASET([], $.Layouts.REPORTEDDATE);
EXPORT Key_REPORTEDDATE := INDEX(dsREPORTEDDATE,
                             {$.Layouts.REPORTEDDATE_KEYED}, 
                             {$.Layouts.REPORTEDDATE_PAYLOAD},
                             $.Names.i_REPORTEDDATE_SF
                             );
