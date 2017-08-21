import ut;

export File_OH_adam := module

export crim2 := dataset('~thor_data400::in::crim_court::oh_adam_crim', crim.Layout_OH_adam.crim, csv(separator('|'), quote('')));

export lexis := dataset('~thor_data400::in::crim_court::oh_adam_lexis', crim.Layout_OH_Adam.lexis, csv(separator('|'), quote('')));

end;