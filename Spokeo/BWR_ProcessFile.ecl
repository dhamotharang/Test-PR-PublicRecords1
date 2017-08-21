#stored('did_add_force', 'thor');
#option('multiplePersistInstances',FALSE);

version := '201703';

ds := Spokeo.File_Spokeo_In;

result := Spokeo.ProcessFile(ds);

out := Spokeo.ToSpokeoOut(result);

writeitout := OUTPUT(out,,'~thor::spokeo::out::' + version, CSV(
																SEPARATOR('|')
																, TERMINATOR('\r\n')
																, HEADING(1,SINGLE)
																,QUOTE('"')
																),
													OVERWRITE);


SEQUENTIAL(
	OUTPUT(result,,'~thor::spokeo::processed::' + workunit, COMPRESSED, OVERWRITE),
	writeitout,
	// despray
	BUILDINDEX(Spokeo.Key_LexId, OVERWRITE)
);
