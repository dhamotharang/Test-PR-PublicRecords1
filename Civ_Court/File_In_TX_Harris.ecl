import Data_Services;

export File_In_TX_Harris := 

		dataset(Data_Services.foreign_prod + 'thor_200::in::civil::tx_harris',Civ_Court.Layout_In_TX_Harris.common 
																		  , csv(terminator('\n'), separator('|')))
	 +
	 dataset('~thor_200::in::civil::tx_harris_new',Civ_Court.Layout_In_TX_Harris.common
	                                    , CSV(terminator('\n'), SEPARATOR(','),QUOTE('"')));
																			
																			
	