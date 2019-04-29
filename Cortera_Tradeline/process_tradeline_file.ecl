ProcessFiles(string8 feed, string8 version) := FUNCTION 
		dels := dataset('~thor::cortera::in::bugatti_delete_' + feed + '_output.dat', Cortera_Tradeline.Layout_Delete, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							), OPT);
		adds := dataset('~thor::cortera::in::bugatti_incr_' + feed + '_output.dat', Cortera_Tradeline.Layout_Tradeline, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							), OPT);

		base1 := $.proc_delete_records(dels, Cortera_Tradeline.Files.Base, version);
		base1a := $.proc_create_base(adds, base1);
		
		base2 := $.proc_link_bip(base1a);

		return base2;
END;


EXPORT process_tradeline_file(string8 feed, string8 version) := FUNCTION
	base := ProcessFiles(feed, version);
	return	SEQUENTIAL(
			OUTPUT(version, named('version')),
			OUTPUT(base,,$.Promote.sfBase + '_' + version, COMPRESSED, OVERWRITE),
			$.Promote.PromoteBase($.Promote.sfBase + '_' + version)
		);
END;
