rec :=
RECORD
	STRING seisint_primary_key;
	string filename;
END;


export File_SO_CommonInfo := DATASET('~thor_data400::in::sexoffender_imagemapping',rec,CSV(separator('|')));