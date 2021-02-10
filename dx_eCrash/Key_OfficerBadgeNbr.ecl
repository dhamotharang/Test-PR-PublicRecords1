IMPORT $;

EXPORT KEY_OFFICERBADGENBR := INDEX({$.Layouts.OFFICERBADGENBR_KEYED}, 
                                    {$.Layouts.OFFICERBADGENBR_PAYLOAD},
                                    $.Names.i_OFFICER_BADGE_NBR_STATE_SF
                                    );
