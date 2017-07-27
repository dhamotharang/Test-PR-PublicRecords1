IMPORT iesp, ut;

out_rec := layouts.question_ext;
ds_blank := dataset ([], out_rec);

export QuestionFactory_Misc := MODULE



  // ========================= WHICH OF THE FOLLOWING PEOPLE DO YOU KNOW? =========================
  // returns a list of relatives: may contain few real relatives for a person plus random
  // ==============================================================================================
  export out_rec GetPeople (string question, unsigned ans_all, unsigned ans_correct, 
                                         dataset (iesp.share.t_Identity) people_source) := function
    // fetch real relatives
   Functions.MAC_RANDOM (people_source, ans_correct, ds_correct);
    res_correct := project (ds_correct, transform (iesp.eauth.t_Answer, 
                                                   Self.Value := trim (Left.Name.First) + ' ' + trim (Left.Name.Last); Self._IsValid := true));
    // Deduping the relative names based on first and last so 
    // the actual number of relatives returned will be less the the number of relatives displayed in other services.
    
    res_correct_ddp := dedup (res_correct(trim(Value)<>''), Value, ALL);
    unsigned cnt_actual := count (res_correct_ddp);
    boolean IsSufficient := cnt_actual >= 0 or ans_correct=0;

    // fetch max number of records, since "real" data can be fetched here as well.
   Functions.MAC_RANDOM (fake_files.people1, ans_all, fake_data);

    ds_fakes := choosen (join (fake_data, res_correct_ddp, //at most one row...
                               Left.full_name = Right.Value,
                               left only, atmost (1)), ans_all - cnt_actual);  // adjusted number of fake answers

    ds_combined := res_correct_ddp +
                   project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := trim (Left.full_name), Self._IsValid := false));

   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand);
  
    boolean is_multiple := (cnt_actual > 1) and (ans_correct > 1);
    return if (~IsSufficient, ds_blank,
               dataset ([{question, is_multiple, ds_rand & Functions.none_of_above (cnt_actual=0)}], out_rec));
  end;
  // TODO: better returning relatives with a different last names only, doesn't make much sense otherwise.



  // ==================== IN WHAT STATE WAS YOUR SOCIAL SECURITY NUMBER ISSUED? ===================
  // returns a list of states: at most one valid plus random
  // ==============================================================================================
  export out_rec GetSSNStates (string question, unsigned ans_all, unsigned ans_correct, 
                               dataset (iesp.share.t_Identity) aka_source) := function
   // validate input
    valid_input := ((ans_correct =0) or (ans_correct =1)) and (ans_all > 0) and (ans_all < 20);

    // fetch real SSN state
    ds_correct := choosen (aka_source, 1) (SSNInfo.IssuedLocation != '');
    unsigned cnt_actual := count (ds_correct);
    boolean IsSufficient := valid_input and (cnt_actual > 0);

    res_correct := project (ds_correct, transform (iesp.eauth.t_Answer, 
                                                   Self.Value := trim (Left.SSNInfo.IssuedLocation); Self._IsValid := true));
    // fetch max number of records, since "real" data can be fetched here as well.
    Functions.MAC_RANDOM (fake_files.states, ans_all, fake_data);

    // remove real one, if happens to be among random states:
    real_state_name := stringlib.StringToUpperCase (res_correct[1].Value);
    ds_fakes := if (cnt_actual > 0, 
                    choosen (fake_data (stringlib.StringToUpperCase (trim (state_name)) != real_state_name), ans_all - cnt_actual), 
                    fake_data);

    ds_fakes_proj:=project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.state_name, Self._IsValid := false));
    ds_combined := if(ans_correct=0,ds_fakes_proj,res_correct +ds_fakes_proj);
    Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); // shuffle
  
    return if (~IsSufficient, ds_blank,
               dataset ([{question, false, ds_rand & Functions.none_of_above (ans_correct=0)}], out_rec));
  end;




END;