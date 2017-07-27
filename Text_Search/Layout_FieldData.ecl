EXPORT Layout_FieldData := RECORD
	STRING4							prefix;
	Types.SegmentType		segType;
	Types.WordType			typ;
	Types.WordRelByte		pos;
	Types.PartitionID		part;
	Types.DocRef				docRef;
	Types.Segment				seg;
	Types.KWP						kwp;
	Types.WIP						wip;
	Types.WordStrV			subTerm;
	UNSIGNED8 fpos{virtual(fileposition)} := 0;
END;
