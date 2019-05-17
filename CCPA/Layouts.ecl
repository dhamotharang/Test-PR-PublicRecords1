import $;

export Layouts := module  

  export l_input := RECORD
    unsigned6 did;
    integer seq := 0;
  end;

  export l_out_rec := RECORD(l_input)
    unsigned4 global_sid;
    unsigned4 record_sid;
    string20 payload;
  end;

  export l_out_svc := RECORD
    boolean hit;
    dataset(l_out_rec) pl_recs;
    dataset(l_out_rec) oc_recs;
  END;

end;