IMPORT $;

//Used this index method to carry the maxlength.
dsHOUSEHOLDID := DATASET([], $.Layouts.HOUSEHOLDID);
EXPORT Key_HOUSEHOLDID := INDEX(dsHOUSEHOLDID,
                             {$.Layouts.HOUSEHOLDID_KEYED}, 
                             {$.Layouts.HOUSEHOLDID_PAYLOAD},
                             $.Names.i_HOUSEHOLDID_SF
                             );
