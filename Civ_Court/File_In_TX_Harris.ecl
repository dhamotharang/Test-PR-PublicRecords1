import Data_Services;

RawIn	:= dataset('~thor_200::in::civil::tx_harris_new',Civ_Court.Layout_In_TX_Harris.raw
	                                    , CSV(HEADING(1),terminator('\n'), SEPARATOR(','),QUOTE('"')));
																			
pRaw2Common	:= PROJECT(RawIn,TRANSFORM(Civ_Court.Layout_In_TX_Harris.common,SELF := LEFT; SELF := [];));																			

Common :=		dataset(Data_Services.foreign_prod + 'thor_200::in::civil::tx_harris',Civ_Court.Layout_In_TX_Harris.common 
																											, csv(HEADING(1),terminator('\n'), separator('|')))
						+ pRaw2Common;
						// dataset('~thor_200::in::civil::tx_harris_new',Civ_Court.Layout_In_TX_Harris.common
																										// , CSV(terminator('\n'), SEPARATOR(','),QUOTE('"')));
																			
export File_In_TX_Harris := Common;
																			
																			
	