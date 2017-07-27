layout_pat_keybuild := record
	patriot.Layout_Patriot;
	unsigned8	__fpos {virtual(fileposition)};
end;

export file_patriot_keybuild := dataset('~thor_data400::in::patriot_file',Layout_Pat_keybuild,flat);