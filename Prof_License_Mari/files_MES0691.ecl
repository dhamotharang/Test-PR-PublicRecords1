//Raw professional license files from the source MES0691 

export files_MES0691 := dataset('~thor_data400::in::prolic::MES0691::LENDERS',Prof_License_Mari.layout_MES0691,csv(SEPARATOR(','),heading(1),quote('"')))
                       +dataset('~thor_data400::in::prolic::MES0691::BROKERS',Prof_License_Mari.layout_MES0691,csv(SEPARATOR(','),heading(1),quote('"')));