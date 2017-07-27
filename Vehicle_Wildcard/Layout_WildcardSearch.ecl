import doxie_build;

export Layout_WildcardSearch :=
RECORD
	Matrix_Wildcard.Layout_BaseFile;
	string10 source := doxie_build.buildstate;
	STRING10 FailureLocation := 'XX';
	INTEGER  FailureCode := 0;
	STRING50   FailureMessage := '';
END;