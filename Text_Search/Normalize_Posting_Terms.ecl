//Normalize the posting term string as required
Layout_Posting nt(Layout_Posting posting) := TRANSFORM
  SELF.word := IF(posting.typ=Types.WordType.TextStr,
                  TRIM(StringLib.StringToUpperCase(posting.word), LEFT,RIGHT),
                  TRIM(posting.word, LEFT, RIGHT));
  SELF := posting;
END;
EXPORT Normalize_Posting_Terms(DATASET(Layout_Posting) ds) := PROJECT(ds,nt(LEFT));
