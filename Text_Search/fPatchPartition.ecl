IMPORT lib_ThorLib;
EXPORT fPatchPartition(FileName_Info info, FileName_Info info_incr,
                       DATASET(Layout_Posting) postings,
                       BOOLEAN incremental, BOOLEAN replace_increment) := FUNCTION
  min_curr_mrg_part := IF(replace_increment, MIN(Indx_ExtKeyOut2(info_incr),part), 0);
  mrg_part_adj := (min_curr_mrg_part DIV ThorLib.nodes()) * ThorLib.Nodes();
  max_combined_part := IF(incremental, MAX(Indx_ExtKeyOut2(info), part), 0);
  combined_adj := ((max_combined_part DIV ThorLib.nodes()) + 1) * ThorLib.nodes();
  Layout_Posting adjust_part(Layout_Posting posting) := TRANSFORM
    SELF.part := MAP(NOT incremental      => posting.part,
                     replace_increment    => posting.part + mrg_part_adj,
                     posting.part + combined_adj);
    SELF := posting;
  END;
  RETURN PROJECT(postings, adjust_part(LEFT));
END;