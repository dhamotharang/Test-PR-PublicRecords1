import data_services;

export Offense_Category := Module
export Layout_lookup := record
	string	Offese_desc;
	string	Category;
end;
export File_Lookup := dataset(data_services.foreign_prod+'thor_data400::in::offense_category_lookup', 
                                               Layout_lookup, 
																							 csv(terminator('\r\n'), separator('\t'),quote('"')));

End;