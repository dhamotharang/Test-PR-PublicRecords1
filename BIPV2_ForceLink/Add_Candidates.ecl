// -- both take in datasets in their respective layouts.  Adds those candidates to the underlink file.

// -- BIPV2_ForceLink.Layouts.Proxid_Underlink  -- { unsigned6 proxid  ,integer   underLinkId }
// -- BIPV2_ForceLink.Layouts.lgid3_Underlink   -- { unsigned6 lgid3   ,integer   underLinkId }


EXPORT Add_Candidates :=
module

  export Proxid_Underlink := BIPV2_ForceLink._Config().proxid_underlink_file_tools.addCandidates;
  export lgid3_Underlink  := BIPV2_ForceLink._Config().lgid3_underlink_file_tools.addCandidates ;
  
end;