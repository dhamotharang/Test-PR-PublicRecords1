export File_MD_Statewide := module 

 export Circuit := 
	dataset('~thor_data400::in::crim_court::MD_Statewide_Circuit',
	Crim.Layout_MD_Statewide.Circuit,csv(heading(1),terminator('\n'), separator('|'), quote('')));

 export  District := 
	dataset('~thor_data400::in::crim_court::MD_Statewide_District',
	Crim.Layout_MD_Statewide.District,csv(heading(1),terminator('\n'), separator('|'), quote('')));


end;