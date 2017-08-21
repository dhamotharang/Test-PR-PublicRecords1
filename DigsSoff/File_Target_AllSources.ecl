export File_Target_AllSources := DATASET('~thor_data50::in::digssoff::SOFF_OKC_OUTFILE', 
                                    Layout_Target_OKC_Layout, 
																		csv(separator('|'),terminator(['\r\n','\r','\n']),quote(''),
																		MAXLENGTH(10000)));
