export mac_prepare_postings(infile,outfile) := macro
// Build postings directly
w0x := infile;
w1 := DISTRIBUTE(w0x, HASH32(docRef.src, docRef.doc));
 
Text_Search.Layout_Posting reMark(Text_Search.Layout_Posting l) := TRANSFORM
 SELF.part := ThorLib.node();
 SELF.word := Text_Search.KeywordingFunc(l.word);
 SELF := l;
END;
w2 := PROJECT(NOFOLD(w1), reMark(LEFT));
 
w3 := SORT(w2, docRef.src, docRef.doc, kwp, word, LOCAL);
inv:= DEDUP(w3, docRef.src, docRef.doc, kwp, word, seg, LOCAL);
 
// transform for partition and scheme 
Text_Search.Layout_Posting mak1(Text_Search.Layout_Posting l, UNSIGNED4 n, UNSIGNED3 s) := TRANSFORM
 SELF.nominal := n;
 SELF.typ := Text_Search.Types.WordType.Metadata;
 SELf.part := l.part;
 SELF.suffix := s;   
 SELF := [];
END;
 
// Create partition record
prec := DEDUP(inv, TRUE, LOCAL);
part := PROJECT(prec, mak1(LEFT, Text_Search.Constants.PartitionIDNominal, 0));
 
// Create scheme records
// scheme 2      ==> dates and numbers duplicated for efficient range search
scheme := PROJECT(prec, mak1(LEFT, Text_Search.Constants.SchemeNominal, 3));
 
// Create special numbers and dates for range searching
SET OF Text_Search.Types.WordType rangeTypes 
  := [Text_Search.Types.WordType.Numeric, Text_Search.Types.WordType.Date];
Text_Search.Layout_Posting cvtRange(Text_Search.Layout_Posting l) := TRANSFORM
 SELF.typ := CASE(l.typ,
  Text_Search.Types.WordType.Numeric => Text_Search.Types.WordType.NumericRange,
  Text_Search.Types.WordType.Date   => Text_Search.Types.WordType.DateRange,
  l.typ);
 SELF.suffix  := IF(l.typ IN rangeTypes,
          (l.nominal + l.suffix),
          l.suffix);
 SELF.nominal := l.nominal+l.suffix - SELF.suffix;
 SELF := l;
END;
rangeEntries := PROJECT(inv(typ IN rangeTypes), cvtRange(LEFT));
             
// add the special postings
outfile := inv + part + scheme + rangeEntries;
  endmacro;
