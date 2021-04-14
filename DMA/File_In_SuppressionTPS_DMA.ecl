export File_In_SuppressionTPS_DMA := 
		dataset('~thor_data400::base::suppression::TPS_DMA',
						layout_in_suppressionTPS_DMA,
						csv(heading(1),separator('\t'),quote('"')),opt
					 );