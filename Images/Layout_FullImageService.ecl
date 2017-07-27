import doxie_build;

export Layout_FullImageService :=
RECORD, MAXLENGTH(MaxLength_FullImage)
	unsigned6 did;
	string2 state;
	string2 rtype;
	string60 id;
	unsigned2 seq;
	unsigned2 num;
	string8 date;
	string10 source := doxie_build.buildstate;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo;
END;