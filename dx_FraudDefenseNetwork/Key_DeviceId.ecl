IMPORT $;

//Used this index method to carry the maxlength.
dsDEVICEID := DATASET([], $.Layouts.DEVICEID);
EXPORT KEY_DEVICEID := INDEX(dsDEVICEID,
                             {$.Layouts.DEVICEID_KEYED}, 
                             {$.Layouts.DEVICEID_PAYLOAD},
                             $.Names.i_DEVICEID_SF
                             );
