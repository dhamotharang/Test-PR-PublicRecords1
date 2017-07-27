import doxie_build;

export Layout_ImageService :=
RECORD
	unsigned6 did;
	string2 state;
	string2 rtype;
	string60 id;
	unsigned2 seq;
	unsigned2 num;
	string8 date;
	string10 source := doxie_build.buildstate;
	UNSIGNED4 imgLength;
	UNSIGNED8 __filepos;
END;