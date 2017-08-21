
export File_OH_Fulton := module

export Fulton := 
	dataset('~thor_data400::in::crim_court::oh_fulton',
	Crim.Layout_OH_Fulton.fulton_layout,csv(heading(1),terminator('\n'), separator('|'), quote('')));

export Fulton_West := 
	dataset('~thor_data400::in::crim_court::oh_fulton_west',
	Crim.Layout_OH_Fulton.western_layout,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
end;