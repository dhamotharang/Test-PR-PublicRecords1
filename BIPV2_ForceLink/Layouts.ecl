EXPORT Layouts :=
module

  export input := 
  module
  
    export Proxid_Underlink := BIPV2_ForceLink._Config().proxid_underlink_file_tools.in_recLayout ; // {unsigned6 proxid  ,integer underlinkid ,string comment}
    export lgid3_Underlink  := BIPV2_ForceLink._Config().lgid3_underlink_file_tools .in_recLayout ; // {unsigned6 lgid3   ,integer underlinkid ,string comment}

  end;
  
  export base := 
  module
  
    export Proxid_Underlink := BIPV2_ForceLink._Config().proxid_underlink_file_tools.recLayout; // {unsigned6 proxid  ,integer underlinkid ,string date_added ,string userid ,string comment }
    export lgid3_Underlink  := BIPV2_ForceLink._Config().lgid3_underlink_file_tools.recLayout ; // {unsigned6 lgid3   ,integer underlinkid ,string date_added ,string userid ,string comment }

  end;
  
end;
