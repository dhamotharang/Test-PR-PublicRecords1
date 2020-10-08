IMPORT LN_PropertyV2;

EXPORT getPropertyIDsByBDID(DATASET(doxie_cbrs.layout_references) infile) := FUNCTION

outf := RECORD
  UNSIGNED6 bdid;
  STRING12 fid;
  STRING2 source_code;
END;

kaf := LN_PropertyV2.key_search_bdid;

outf intof(infile le, kaf ri) := TRANSFORM
  SELF.bdid := le.bdid;
  SELF.fid := ri.ln_fares_id;
  SELF.source_code := ri.source_code;
END;
  
jr := JOIN(infile,kaf,LEFT.bdid = RIGHT.s_bid,
           intof(LEFT, RIGHT), atmost(1000));

RETURN jr;

END;
