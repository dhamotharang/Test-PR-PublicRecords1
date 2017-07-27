import PersonReports, AutoStandardI;

export IParam := module

  export _identityfraudreport := INTERFACE (PersonReports.input._report)
    export unsigned max_imposters := 20;
    export boolean include_ri_uspis := false;
    export boolean include_ri_advo := false;
    export boolean include_phonesplus := false;
		export boolean include_identity_risk_level := true;
		export boolean include_source_risk_level := true;
		export boolean include_velocity_risk_level := true;
    export unsigned1 score_threshold := 10; //'ScoreThreshold' needed in phones+; also to provide stronger matches;

     //debug:
    export boolean count_by_source := false;
    export unsigned1 max_top_hri := 6; // TODO:
    export boolean include_summary := false;
    export unsigned1 indicators_per_imposter := 3;
    export boolean probation_override := false;
/*
inherited from PersonReports/input._report:
		export boolean AllowAll := false;
		export boolean AllowGLB := false;
		export boolean AllowDPPA := false;
    export unsigned1 GLBPurpose := 0;
    export unsigned1 DPPAPurpose := 0;
		export boolean IncludeMinors := false;
		export string32 ApplicationType := '';


    // additionally declared in AutoStandardI.DataRestrictionI.params
		export string DataRestrictionMask := '0000000000';
		export boolean ignoreFares := false;
		export boolean ignoreFidelity:= false;

    // other common parameters
    export string6 ssn_mask := 'NONE';
    export boolean include_hri := false;
    export boolean legacy_verified := true;
    export string8 record_by_date := '';
*/
  end;


end;