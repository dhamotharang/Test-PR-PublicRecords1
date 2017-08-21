IMPORT Civ_Court, ut;

EXPORT File_In_FL_Lake := dataset('~thor_data400::in::civil::fl_lake', Civ_Court.Layout_In_FL_Lake,csv(separator('|')));