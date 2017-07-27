IMPORT iesp, AutoHeaderI;

EXPORT IParam := MODULE

  shared questions_list := INTERFACE
    export dataset (iesp.eAuth.t_QuestionReq) questions := dataset ([], iesp.eAuth.t_QuestionReq);
  end;

  export records := INTERFACE (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full, questions_list)
    // can be "reduced" to
			// AutoHeaderI.LIBIN.FetchI_Hdr_Indv_Address.params,
			// FetchI_Hdr_Indv_Name.params,
			// FetchI_Hdr_Indv_SSN.params,
			// FetchI_Hdr_Indv_SSNPartial.params,
			// AutoStandardI.InterfaceTranslator.allow_wildcard_val.params,
			// AutoStandardI.InterfaceTranslator.use_onlybestdid.params,
			// AutoStandardI.InterfaceTranslator.adl_service_ip.params,
			// AutoStandardI.InterfaceTranslator.DPPA_Purpose.params,
			// AutoStandardI.InterfaceTranslator.keep_old_ssns_val.params,
			// AutoStandardI.InterfaceTranslator.AllowLeadingLname_value.params
    export boolean IsDeceased;
    export boolean GetMultipleCorrect;
    export boolean GetDOD;
    export boolean GetDOB;
    export boolean VerifySSN;
    export boolean IncludeCurrentProperty;
    export boolean IncludeCurrentVehicles;

    // temporarily fix to interface definitions problem: need to sort "defaults" out,
    // since some of these are not even related to this service and could use (reasonably defined) defaults.
    // see PersonReports.input for details
    export boolean use_verified_address_ra := false;
    // export boolean use_verified_address_nb := false;
    export boolean use_bestaka_ra := true;
    // export boolean use_bestaka_nb := false;
  end;
END;