// lfn := $.Promote().sfAdds;
// EXPORT In_Tradeline := dataset(lfn, cortera_tradeline.Layout_Tradeline, CSV(
																								// SEPARATOR('|')
																							// , TERMINATOR(['\n', '\r\n'])
																							// , HEADING(1)
																							// , MAXLENGTH(1024)
																							// ));
EXPORT In_Tradeline := $.Files().Input.Tradeline_Adds.Using;
