import images;

export Layout_Common :=
RECORD, MAXLENGTH(MaxLength_FullImage)
	unsigned6 did := 0;
	string2 state;
	string2 rtype;
	string60 id;
	unsigned2 seq;
	string8 date;
	unsigned2 num;
	string image_link;
	UNSIGNED4 imgLength;
	string photo;
END;