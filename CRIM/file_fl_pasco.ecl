IMPORT Crim;

EXPORT file_fl_pasco := dataset('~thor_data400::in::crim_court::fl_Pasco',CRIM.layout_fl_pasco.raw_in,csv(separator('|'), quote('"'), heading(single)));



