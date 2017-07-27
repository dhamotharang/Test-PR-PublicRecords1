// Patch up KWP values when ranges are discontigous on input
EXPORT fPatchKWP(DATASET(Layout_Posting) postings, 
								 DATASET(Layout_Segment_ComposeDef) segDefs) := FUNCTION
  Work_Posting := RECORD(Layout_Posting)
    UNSIGNED8 rel_pos;
    INTEGER4 kwp_adj;
    Types.KWP low_kwp;
  END;
  Work_Posting expandPosting(Layout_Posting post) := TRANSFORM
    SELF.kwp_adj := 0;
    SELF.rel_pos := 0;
    SELF.low_kwp := post.kwp;
    SELF := post;
  END;
  inv_0 := PROJECT(postings, expandPosting(LEFT));
  Work_Posting enumPosting(Work_Posting prev, Work_Posting curr) := TRANSFORM
    SELF.rel_pos := MAP(prev.docRef <> curr.docRef    => prev.rel_pos+1,
                        prev.kwp > curr.kwp + 1       => prev.rel_pos+1,
                        prev.rel_pos);
    SELF := curr;
  END;
  inv_1 := ITERATE(inv_0, enumPosting(LEFT, RIGHT), LOCAL);
  Work_Posting sumPosting(Work_Posting summ, Work_Posting incr) := TRANSFORM
    SELF.low_kwp := summ.low_kwp;
    SELF := incr; // keep last
  END;
  last_post := ROLLUP(inv_1, sumPosting(LEFT,RIGHT), docRef, rel_pos, LOCAL);
  lp_sorted := SORT(last_post, docRef.src, docRef.doc, rel_pos, LOCAL);
	Work_Posting c2(Work_Posting prev, Work_Posting curr) := TRANSFORM
    need_adj := prev.docRef=curr.docRef AND prev.kwp + prev.kwp_adj >= curr.low_kwp;
    SELF.kwp_adj := IF(need_adj, prev.kwp_adj + prev.kwp + Constants.InterSubSegDistance, 0);
    SELF.sect:= IF(need_adj, prev.sect + 1, curr.sect);
    SELF := curr;
  END;
  with_kwp := ITERATE(lp_sorted, c2(LEFT, RIGHT), LOCAL);
  only_deltas := with_kwp(kwp_adj > 0);
  Layout_Posting adj_wp(Work_posting inv, Work_Posting adj) := TRANSFORM
    SELF.sect := IF(adj.kwp_adj>0, adj.sect, inv.sect);
    SELF.kwp := inv.kwp + adj.kwp_adj;
    SELF := inv;
  END;
  kwpPostings := JOIN(inv_1, only_deltas,
              LEFT.rel_pos=RIGHT.rel_pos AND LEFT.docRef=RIGHT.docRef,
              adj_wp(LEFT, RIGHT), LEFT OUTER, LOOKUP, LOCAL);  
  RETURN kwpPostings;
END;