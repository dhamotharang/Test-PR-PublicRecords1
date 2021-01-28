IMPORT $;

EXPORT KEY_REPORTID := INDEX({$.Layouts.REPORTID_KEYED}, 
                             {$.Layouts.REPORTID_PAYLOAD},
                             $.Names.i_REPORT_ID_SF
                             );
