import ut;
export File_OK_Comanche := dataset('~thor_data400::in::crim_court::ok::comanche', layout_ok_adair, csv(separator('|'), quote(''), maxlength(6000)));