// Generate short name for saving space in Compose Def record
EXPORT Types.ShortSegName MakeShortSeg(Types.SegmentName fullName) :=
		INTFORMAT(HASH32(StringLib.StringToUpperCase(fullName)), 10, 1);
		