// -- Add Proxid underlinks
// -- add proxids that you want linked together to this dataset
// -- proxids that should be force linked should have the same underlinkid
ds_proxid_underlinks := 
  dataset([
    // { <proxid>  ,<underLinkId>  ,<comment>}
    { 1234   ,1   ,'BH-1044 -- Implement non-salt FORCE LINK for proxid and lgid3'} // -- examples
   ,{ 12345  ,1   ,'BH-1044 -- Implement non-salt FORCE LINK for proxid and lgid3'} // -- examples
  ]  ,BIPV2_ForceLink.Layouts.Input.Proxid_Underlink);  //{ unsigned6 proxid  ,integer   underLinkId ,string comment}

BIPV2_ForceLink.Add_Candidates.Proxid_Underlink(ds_proxid_underlinks);

// -- Add lgid3 underlinks
ds_lgid3_underlinks := 
  dataset([
    // { <lgid3>  ,<underLinkId>  ,<comment>}
    { 1234   ,1   ,'BH-1044 -- Implement non-salt FORCE LINK for proxid and lgid3'} // -- examples
   ,{ 12345  ,1   ,'BH-1044 -- Implement non-salt FORCE LINK for proxid and lgid3'} // -- examples
  ]  ,BIPV2_ForceLink.Layouts.Input.lgid3_Underlink);  //{ unsigned6 lgid3  ,integer   underLinkId ,string comment }

BIPV2_ForceLink.Add_Candidates.lgid3_Underlink(ds_lgid3_underlinks);
