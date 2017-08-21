IMPORT CRIM, ut;

EXPORT file_fl_pasco_traffic := dataset('~thor_data400::in::crim_court::fl_Pasco_traffic',CRIM.layout_fl_pasco_traffic.raw_in,flat);

