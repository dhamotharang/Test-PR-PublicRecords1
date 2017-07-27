//-----------------------------------------------------------------------------
//Full file was delived in XML and contained all databases
//-----------------------------------------------------------------------------

import ut;
EXPORT File_Transunion_Full_In  := 
						DATASET( '~thor_data400::in::transunionptrak_full',
						Transunion_PTrak.Layout_Transunion_Full_In.LayoutTransunionXMLMainIn , 
						XML('batch/doc'));