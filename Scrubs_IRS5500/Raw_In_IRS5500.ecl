Export Raw_In_IRS5500 := DATASET('~thor_data400::in::irs::sprayed::f5500', Raw_Layout_IRS5500,CSV(SEPARATOR(','), QUOTE(['\'','"']), HEADING(1)));
