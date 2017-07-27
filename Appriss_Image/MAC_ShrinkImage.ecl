/*2005-03-22T11:26:49Z (Mark Luber1)
2004-03-31T16:56:07Z, Copied with AMT from Attribute Modified by Mark Luber
*/
export MAC_ShrinkImage(ds, filename, lengthfield, photofield, outfile) := 
MACRO
// separate out the big ones to convert
#uniquename(toobig)
#uniquename(justright)
%toobig% := ds(lengthfield > 49000);
%justright% := ds(lengthfield <= 49000);

// add a sequency number, convert to fixed-width binary
#uniquename(plusSeq_Layout)
#uniquename(photo)
#uniquename(seq)
%plusSeq_Layout% :=
RECORD
	ds.filename;
	ds.lengthfield;
	DATA2000000 photofield;
	INTEGER %seq%;
END;

#uniquename(addSeq)
#uniquename(withSeq)
%plusSeq_Layout% %addSeq%(ds L, INTEGER C) :=
TRANSFORM
	SELF.photofield := L.photofield;
	SELF.%seq% := C;
	SELF := L;
END;
ut.MAC_Sequence_Records_NewRec(%toobig%, %plusSeq_Layout%, %seq%, %withSeq%)
// %withSeq% := PROJECT(%toobig%, %addSeq%(LEFT, COUNTER));

// pull out the photo
#uniquename(justPhoto_Layout)
#uniquename(justPhoto)
%justPhoto_Layout% :=
RECORD
	%withSeq%.photofield;
END;
%justPhoto% := TABLE(%withSeq%, %justPhoto_Layout%);

// pipe through the photos
#uniquename(smallPhoto_Layout)
#uniquename(justSmallPhoto)
#uniquename(photo)
%smallPhoto_Layout% :=
RECORD, MAXLENGTH(MaxLength_FullImage)
	DATA photofield;
END;
%justSmallPhoto% := PIPE(%justPhoto%, '/T$/jpeg/resizeimage.sh', %smallPhoto_Layout%, REPEAT);

// add back the sequence number
#uniquename(smallPhoto_Layout2)
#uniquename(addSeq2)
%smallPhoto_Layout2% :=
RECORD, MAXLENGTH(MaxLength_FullImage)
	INTEGER %seq%;
	DATA photofield;
END;
%smallPhoto_Layout2% %addSeq2%(%smallPhoto_Layout% L, INTEGER C) :=
TRANSFORM
	SELF.%seq% := C;
	SELF.photofield := L.photofield;
END;
#uniquename(SmallPhotoSeq)
ut.MAC_Sequence_Records_NewRec(%justSmallPhoto%, %smallPhoto_Layout2%, %seq%, %SmallPhotoSeq%)
// %SmallPhotoSeq% := PROJECT(%justSmallPhoto%, %addSeq2%(LEFT, COUNTER));

#uniquename(joiner)
#uniquename(cleaner)
#uniquename(tooBigInCommon)
#uniquename(justRightInCommon)
typeof(ds) %joiner%(%SmallPhotoSeq% L, %withSeq% R) :=
TRANSFORM
	SELF.filename := R.filename;
	SELF.lengthfield := LENGTH(L.photofield);
	SELF.photofield := L.photofield;
END;
%tooBigInCommon% := JOIN(%SmallPhotoSeq%, %withSeq%, LEFT.%seq% = RIGHT.%seq%, %joiner%(LEFT, RIGHT), NOSORT, LOCAL);

typeof(ds) %cleaner%(ds L) :=
TRANSFORM
	SELF.filename := L.filename;
	SELF.lengthfield := LENGTH(L.photofield);
	SELF.photofield := L.photofield
END;
%justRightInCommon% := PROJECT(%justright%, %cleaner%(LEFT));

outfile := %toobigInCommon% + %justRightInCommon%;

ENDMACRO;