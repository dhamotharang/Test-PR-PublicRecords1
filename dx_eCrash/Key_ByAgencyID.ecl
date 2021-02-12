IMPORT $;

EXPORT KEY_BYAGENCYID := INDEX({$.Layouts.BY_AGENCYID_KEYED}, 
                               {$.Layouts.BY_AGENCYID_PAYLOAD},
                               $.Names.i_ANALYTICS_BY_AGENCY_ID_SF
                              );
