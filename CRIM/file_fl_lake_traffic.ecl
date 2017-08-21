IMPORT crim, ut;

EXPORT file_fl_lake_traffic := dataset('~thor_data400::in::crim_court::fl_Lake_traffic',crim.layout_FL_Lake_traffic.raw_in,csv(separator('|')));
