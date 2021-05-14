// -- both take in datasets in their respective layouts.  Adds those candidates to the underlink file.

// -- BIPV2_ForceLink.Layouts.input.Proxid_Underlink  -- { unsigned6 proxid  ,integer   underLinkId  ,string comment}
// -- BIPV2_ForceLink.Layouts.input.lgid3_Underlink   -- { unsigned6 lgid3   ,integer   underLinkId  ,string comment}


EXPORT Add_Candidates :=
module

  export Proxid_Underlink := BIPV2_ForceLink._Config().proxid_underlink_file_tools.addCandidates;
  export lgid3_Underlink  := BIPV2_ForceLink._Config().lgid3_underlink_file_tools.addCandidates ;
  
end;