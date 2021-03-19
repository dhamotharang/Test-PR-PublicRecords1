import Data_Services;
export	File_In_SuppressionTPS_National	:=	
dataset('~thor_data400::in::suppression::tps_national',
																											DMA.layout_in_suppressionTPS_National,
																											csv(separator(','),terminator('\n'))
																										);