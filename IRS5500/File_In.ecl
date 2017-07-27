EXPORT File_In := DATASET('~thor_data400::in::irs::sprayed::f5500', Layout_Raw_In.Current_Input,
                             CSV(SEPARATOR(','), QUOTE(['\'','"']), HEADING(1)));