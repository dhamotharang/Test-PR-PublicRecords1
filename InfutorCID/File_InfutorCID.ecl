import ut;
/* input file is a full file refresh */
export File_InfutorCID := dataset('~thor_data400::in::infutorcid', infutorCID.Layout_InfutorCID, csv(terminator('\r\n'), separator('\t')));