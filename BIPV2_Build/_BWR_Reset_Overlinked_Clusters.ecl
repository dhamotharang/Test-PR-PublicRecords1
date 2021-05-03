// -- use to reset clusters that are overlinked.  if the cluster can be split into two, use 
// --   BIPV2_BlockLink._BWR_LGID3_BlockLink
// -- instead since it will not require writing out another base file.
// -- set your seleids first that should be reset
// -- also, in the transform, blank out any fields that need it to prevent the match from occuring again.
// -- this should only be for D&B fein old records usually
/*
  BIPV2.BWR_ManualSuppression -- suppress records from output keys in the kfetch(example here: BIPV2_Suppression.BWR_Test).
  BIPV2.BWR_ManualUnderlinks  -- force lgid3s or proxids together.  uses UnderLinks attribute file, so this will only work if both lgid3s/proxids are in the lgid3/proxid Match Candidates.
  BIPV2_Suppression.BWR_ManualSuppression -- same as BIPV2.ManualSuppression.addCandidates from BIPV2.BWR_ManualSuppression above

*/
set_seleids := [
   396292  // LNK-5080
  ,2070601 // LNK-4704
];

ds_base := bipv2.commonbase.ds_base;

ds_base_To_Reset  := ds_base(seleid     in set_seleids);
ds_base_Rest      := ds_base(seleid not in set_seleids);

ds_base_Did_Reset := project(ds_base_To_Reset ,transform(
  {boolean didreset ,recordof(left)},
   old_fein_record   := left.source = mdr.sourcetools.src_Dunn_Bradstreet_Fein and left.ingest_status = 'Old';
   self.company_fein := if(old_fein_record  ,'' ,left.company_fein);
   self.didreset     := old_fein_record;
   self.lgid3        := left.proxid;
   self.seleid       := left.proxid;
   self              := left;

));

ds_base_concat := project(ds_base_Did_Reset ,recordof(ds_base)) + ds_base_Rest;

ds_stats := dataset([
  {'Count ds_base'                              ,ut.fIntWithCommas(count(ds_base                      ))}
 ,{'Count ds_base_To_Reset'                     ,ut.fIntWithCommas(count(ds_base_To_Reset             ))}
 ,{'Count ds_base_Rest    '                     ,ut.fIntWithCommas(count(ds_base_Rest                 ))}
 ,{'Count ds_base_Did_Reset'                    ,ut.fIntWithCommas(count(ds_base_Did_Reset            ))}
 ,{'Count ds_base_Did_Reset applied reset'      ,ut.fIntWithCommas(count(ds_base_Did_Reset(didreset)  ))}
 ,{'Count ds_base_Did_Reset NOT applied reset'  ,ut.fIntWithCommas(count(ds_base_Did_Reset(~didreset) ))}
 ,{'Count ds_base_concat'                       ,ut.fIntWithCommas(count(ds_base_concat               ))}

],{string stat_description  ,string stat_value});

output(ds_stats                                                                 ,named('ds_base'));

output(ds_base_concat ,,'~thor_data400::bipv2::internal_linking::20200729a' ,compressed,overwrite);