IMPORT $;

//Used this index method to carry the maxlength.
dsDRIVERSLICENSE := DATASET([], $.Layouts.DRIVERSLICENSE);
EXPORT Key_DRIVERSLICENSE := INDEX(dsDRIVERSLICENSE,
                             {$.Layouts.DRIVERSLICENSE_KEYED}, 
                             {$.Layouts.DRIVERSLICENSE_PAYLOAD},
                             $.Names.i_DRIVERSLICENSE_SF
                             );
