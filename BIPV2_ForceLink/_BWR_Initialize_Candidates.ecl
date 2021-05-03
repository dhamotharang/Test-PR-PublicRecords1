// -- initialize the forcelink underlink files using the existing proxid and lgid3 salt underlink files
    
// ds_proxid_init := project(BIPV2_Proxid.ManualUnderLinks.dataIn_file ,transform(BIPV2_ForceLink.Layouts.Input.Proxid_Underlink ,self := left,self.comment := 'copied from Proxid underlink file'));

// sequential(
   // BIPV2_ForceLink._Config().proxid_underlink_file_tools.clearsuperfile
  // ,BIPV2_ForceLink.Add_Candidates.Proxid_Underlink(ds_proxid_init)
// );


ds_lgid3_init := project(BIPV2_Lgid3.ManualUnderLinks.dataIn_file ,transform(BIPV2_ForceLink.Layouts.Input.lgid3_Underlink ,self := left,self.comment := 'copied from lgid3 underlink file'));

sequential(
   BIPV2_ForceLink._Config().lgid3_underlink_file_tools.clearsuperfile
  ,BIPV2_ForceLink.Add_Candidates.lgid3_Underlink(ds_lgid3_init)
);
