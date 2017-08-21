export file_in_suppressionMPS := 
		dataset('~thor_data400::in::suppression::MPS',
						layout_in_suppressionMPS,
						csv(heading(1),separator('\t'),quote('"'))
					 );