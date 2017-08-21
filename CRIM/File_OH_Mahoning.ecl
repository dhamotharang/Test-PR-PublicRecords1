
export File_OH_Mahoning := module

export austintown := dataset('~thor_data400::in::crim_court::oh_mahoning_austintown', crim.Layout_OH_Mahoning.austintown, csv(separator('|'), quote('')));

export boardman := dataset('~thor_data400::in::crim_court::oh_mahoning_boardman', crim.Layout_OH_Mahoning.austintown, csv(separator('|'), quote('')));

export canfield := dataset('~thor_data400::in::crim_court::oh_mahoning_canfield', crim.Layout_OH_Mahoning.austintown, csv(separator('|'), quote('')));

export commonpleas := dataset('~thor_data400::in::crim_court::oh_mahoning_commonpleas', crim.Layout_OH_Mahoning.commonpleas, csv(separator('|'), quote('')));

export sebring := dataset('~thor_data400::in::crim_court::oh_mahoning_sebring', crim.Layout_OH_Mahoning.austintown, csv(separator('|'), quote('')));


end;