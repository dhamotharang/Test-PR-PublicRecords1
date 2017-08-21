
export File_BusTitle_Standard_Tbl := dataset('~thor_data400::in::bus_title_standardization_table',
																						 layouts.bustitle_standard_tbl,
																						 csv(heading(1),
																								 separator(','),
																								 quote('"')
																							  )
																					  );
