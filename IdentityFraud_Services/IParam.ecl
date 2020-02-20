import PersonReports, doxie;

export IParam := module

  export _identityfraudreport := INTERFACE (doxie.IDataAccess, PersonReports.IParam._report)
    export unsigned max_imposters := 20;
    export boolean include_ri_uspis := false;
    export boolean include_ri_advo := false;
    export boolean include_phonesplus := false;
				export boolean include_identity_risk_level := true;
				export boolean include_source_risk_level := true;
				export boolean include_velocity_risk_level := true;
				export boolean skip_penalty_filter := false;

     //debug:
    export boolean count_by_source := false;
    export unsigned1 max_top_hri := 6; // TODO:
    export boolean include_summary := false;
    export unsigned1 indicators_per_imposter := 3;
  end;

end;
