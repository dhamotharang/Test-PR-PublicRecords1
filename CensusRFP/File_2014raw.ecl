EXPORT File_2014raw(string lfn) := 

		PROJECT(DATASET(lfn, layouts_census.layout_out, 
				       CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n'))),						 
						layouts_census.layout_out);
							 
		
