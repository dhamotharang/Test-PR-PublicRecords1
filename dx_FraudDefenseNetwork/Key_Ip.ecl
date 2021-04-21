IMPORT $;

//Used this index method to carry the maxlength.
dsIP := DATASET([], $.Layouts.IP);
EXPORT KEY_IP := INDEX(dsIP,
                       {$.Layouts.IP_KEYED}, 
                       {$.Layouts.IP_PAYLOAD},
                       $.Names.i_IP_SF
                       );