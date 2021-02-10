IMPORT $;

EXPORT KEY_LICENSEPLATENBR := INDEX({$.Layouts.LICENSEPLATENBR_KEYED}, 
                                    {$.Layouts.LICENSEPLATENBR_PAYLOAD},
                                    $.Names.i_LICENSE_PLATE_NBR_SF
                                    );
