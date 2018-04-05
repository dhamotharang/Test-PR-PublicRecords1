import Data_Services;
export File_In_MI_Kent := MODULE

	EXPORT old := dataset('~thor_data400::in::civil::mi_kent',
	Civ_Court.Layout_MI_Kent.old_layout,csv(heading(1),terminator('\n'), quote('"'), separator('\t')));

	EXPORT new := dataset('~thor_data400::in::civil::mi_kent_new',
	Civ_Court.Layout_MI_Kent.new_layout,csv(heading(1),terminator('\n'), quote('"'),separator('\t')));	
	
END;	