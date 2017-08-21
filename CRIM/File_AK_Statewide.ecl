
fCrimraw := dataset('~thor_data400::in::crim_court::ak_crim_statewide', crim.Layout_AK_Statewide.rawlayout, CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));

export File_AK_Statewide := project(fCrimraw, transform(Crim.Layout_AK_Statewide.parsed, SELF := TRANSFER(left.line, Crim.Layout_AK_Statewide.parsed)));
