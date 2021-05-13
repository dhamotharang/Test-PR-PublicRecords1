IMPORT $;

//Used this index method to carry the maxlength.
dsCITYSTATE := DATASET([], $.Layouts.CITYSTATE);
EXPORT Key_CITYSTATE := INDEX(dsCITYSTATE,
                             {$.Layouts.CITYSTATE_KEYED}, 
                             {$.Layouts.CITYSTATE_PAYLOAD},
                             $.Names.i_CITYSTATE_SF
                             );
