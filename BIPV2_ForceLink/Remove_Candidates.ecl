// -- both take in 1 underlink id as an integer -- integer gid

EXPORT Remove_Candidates :=
module

  export Proxid_Underlink := BIPV2_ForceLink._Config().proxid_underlink_file_tools.removeCandidates;
  export lgid3_Underlink  := BIPV2_ForceLink._Config().lgid3_underlink_file_tools.removeCandidates ;
  
end;