EXPORT Files := MODULE

	export Adds := DATASET($.Promote().sfAdds, $.Layout_Tradeline, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							));

	export Dels := DATASET($.Promote().sfDels, $.Layout_Delete, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							));
																							
	export Base := Dataset($.Promote().sfBase, $.layout_Tradeline_Base, THOR);

END;


