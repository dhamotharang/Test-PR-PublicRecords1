IMPORT ut;

EXPORT Files := module

	EXPORT file_in := DATASET(Constants.in_mfind, Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

	EXPORT file_base := DATASET(Constants.base_mfind, Layouts.layout_base, FLAT );

	EXPORT file_did := PROJECT(file_base(did<>0), Layouts.layout_keys);

	EXPORT file_vid := PROJECT(file_base(trim_vid<>''), Layouts.layout_keys);

	EXPORT file_autokey := PROJECT(file_base,
																 TRANSFORM(Layouts.layout_autokey, 
																		SELF.addr.st := LEFT.st;
																		SELF.addr.zip5 := LEFT.zip;
																		SELF.addr := LEFT;
																		SELF.addr := [];
																		SELF.name := LEFT;
																		SELF := LEFT;
																		)
																	);

END;