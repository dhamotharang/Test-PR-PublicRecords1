IMPORT $;

EXPORT KEY_AGENCYIDSENTDATE := INDEX({$.Layouts.AGENCYID_SENTDATE_KEYED}, 
                                     {$.Layouts.AGENCYID_SENTDATE_PAYLOAD},
                                     $.Names.i_AGENCY_ID_SENT_DATE_STATE_SF
                                     );
