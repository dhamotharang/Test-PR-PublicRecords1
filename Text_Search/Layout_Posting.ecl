// The detail posting record for the inversion.
//
export Layout_Posting := RECORD
	Types.PartitionID		part;
	Types.Nominal				nominal;
	Types.NominalSuffix	suffix;
	Types.DocRef				docRef;
	Types.Segment				seg;
	Types.KWP						kwp;
	Types.WIP						wip;
	Types.WordType			typ;
	Types.Section				sect;
	Types.WordRelByte		pos;
	Types.RID_Type			rid;
	Types.LID_Type			lid;
	Types.DocID					sid;
	Types.SourceID			src;
	Types.ShortSegName	segName;
	Types.WordLength		len;
	Types.WordStrV			word;
END;