import ut;
export file_lookup := dataset(ut.foreign_prod+'~thor_data400::in::CourtLocatorLookup'
																,Court_locator.layout_lookup
																,csv(heading(1),terminator('\r\n'), separator('\t'), quote('')));