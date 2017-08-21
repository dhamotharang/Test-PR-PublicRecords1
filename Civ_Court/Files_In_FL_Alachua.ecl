IMPORT Civ_Court;

EXPORT Files_In_FL_Alachua	:= MODULE

EXPORT	lte :=  dataset('~thor_data400::in::civil::fl_alachua_lte', Civ_Court.Layout_In_FL_Alachua.lte,flat);
EXPORT	nlj	:= 	dataset('~thor_data400::in::civil::fl_alachua_nlj', Civ_Court.Layout_In_FL_Alachua.nlj,csv(terminator('\n'), separator('|')));
EXPORT	civil	:= dataset('~thor_data400::in::civil::fl_alachua_civil',Civ_Court.Layout_In_FL_Alachua.civil,csv(terminator('\n'), separator('|')));

END;