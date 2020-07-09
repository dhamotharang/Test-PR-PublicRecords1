IMPORT VotersV2;

EXPORT File_OptOut_In(string filedate) := dataset(VotersV2.cluster + 'in::Voters::OptOut::sprayed::'+filedate
																					,VotersV2.Layout_Emerges_OptOut	
																					,csv(heading(1),separator(','),terminator(['\r\n','\r','\n']),quote('"')));
												
