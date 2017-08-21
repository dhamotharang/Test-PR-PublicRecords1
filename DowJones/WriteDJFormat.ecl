
hdr := '<?xml version="1.0" encoding="utf-8"?><PFA><Records>\r\n';
Footer := '</Records></PFA>\r\n';
					
EXPORT WriteDJFormat(dataset(recordof(Layouts.rPersons)) infile, string filename) := FUNCTION

	return OUTPUT(infile,,'~thor::dowjones::test::'+filename,
			xml('Person', heading(hdr
						,Footer),trim, OPT), overwrite);
END;