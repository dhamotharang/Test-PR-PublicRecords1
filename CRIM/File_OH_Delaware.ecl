import UT;
//Input file definition for Oh Delaware Criminal Court
export File_OH_Delaware := dataset(ut.foreign_prod + '~thor_data400::in::crim_court::oh_delaware', Crim.Layout_OH_Delaware, csv(heading(1),terminator('\r\n'), separator('|'), quote('')));
