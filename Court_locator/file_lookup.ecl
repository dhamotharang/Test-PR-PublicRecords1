import ut;


input := dataset('~thor_data400::in::courtlocatorlookup'
																,Court_locator.layout_lookup
																,csv(heading(1),terminator('\r\n'), separator('\t'), quote('')));

export file_lookup := input;
																
