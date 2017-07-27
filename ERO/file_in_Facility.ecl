import ut;

export file_in_Facility :=  dataset(ut.foreign_prod+'~thor_200::in::ERO::FACILITY_LIST',
								ERO.layout_in_Facility,
								CSV(SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096))); 

