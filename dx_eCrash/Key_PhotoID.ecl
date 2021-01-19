IMPORT $;

EXPORT KEY_PHOTOID := INDEX({$.Layouts.PHOTOID_KEYED}, 
                            {$.Layouts.PHOTOID_PAYLOAD},
                            $.Names.i_PHOTO_ID_SF
                            );
