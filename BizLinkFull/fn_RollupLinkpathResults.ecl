EXPORT fn_RollupLinkpathResults(
  dataset(Process_Biz_Layouts.LayoutScoredFetch) infile
) := FUNCTION
/*
RETURN DATASET MUST BE DISTRIBUTED BY HASH(REFERENCE) SINCE RESULT WILL BE FED INTO MAC_Dups_Restore IN LOCAL MODE
steps:
1) dist
2) sort and rollup
3) sort and dedup
*/
rolled :=
rollup(
  sort(
    distribute(
      infile, 
      hash(Reference)
    ),
    Reference,
    Proxid,
    Local
  ), 
  BizLinkFull02.Process_Biz_Layouts.combine_scores(left, right), 
  Reference, 
  Proxid, 
  local
);
ddp :=
dedup(
  sort(
    rolled,
    Reference,
    -weight,
    local
  ),
  Reference,
  keep(BizLinkFull02.Config_BIP.linkpath_dedup_keep),
  local
);
RETURN ddp;
END;

