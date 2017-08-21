import ut;
export File_SC_York := dataset('~thor_data400::in::crim_court::sc_york_updt', crim.Layout_SC_York, csv(terminator('\r\n'), separator('|'), quote('')));