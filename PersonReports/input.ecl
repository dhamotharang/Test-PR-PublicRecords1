// TODO: create common defaults to use in AutoStandardI.GlobalModule, here, etc.

// Encapsulates input parameters for each particular component
// (probably will be split and moved to each correspondent service)

// Currently almost all of these are "fake": just synonyms of a superset input

import AutoHeaderI, AutoStandardI, Accident_Services,
  Hunting_Fishing_Services, ATF_Services,
  Foreclosure_Services, InternetDomain_Services,
  suppress, relationship, FCRA;

EXPORT input := MODULE

  // Most generous structure for reading input parameters. Unfortunately, individual structures must extend
  // this huge structure, because of legacy code (sudden "#store" calls)
  export _didsearch := INTERFACE (AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
  end;

  // 2 interfaces to replace AutoStandardI/DataRestrictionI.params; with defaults
  export restrictions := INTERFACE
    export string DataRestrictionMask := '000000000000000000000000';
    export boolean ignoreFares := false;
    export boolean ignoreFidelity:= false;
  end;

  export permissions := INTERFACE (AutoStandardI.PermissionI_Tools.params,AutoStandardI.InterfaceTranslator.application_type_val.params)
    export boolean AllowAll := false;
    export boolean AllowGLB := false;
    export boolean AllowDPPA := false;
    export unsigned1 GLBPurpose := 0;
    export unsigned1 DPPAPurpose := 0;
    export boolean IncludeMinors := false;
  end;

  // Some things common for all (or most of the) reports. Any report can redefine these.
  export _report := INTERFACE (permissions, restrictions, FCRA.iRules)
    // other common parameters
    export string6 ssn_mask := 'NONE';
    export boolean mask_dl := false;
    export unsigned1 dob_mask := suppress.Constants.dateMask.NONE;
    export boolean include_hri := false;
    export boolean legacy_verified := true;
    export unsigned1 score_threshold := 10; //needed in phones+    : stored('ScoreThreshold');
    export unsigned2 penalty_threshold := 10;
    export boolean ln_branded := false;
    export unsigned1 max_hri := 10; // same as unsigned1 maxHriPer_value := 10 : stored('MaxHriPer')
    export boolean include_BlankDOD := false; // allows to return death records with no DOD
    // export string5  industryclass
    export unsigned3 dateval := 0; // unsigned3 of 'YYYYMM';
		export boolean smart_rollup := false;
    export integer1 non_subject_suppression := suppress.Constants.NonSubjectSuppression.doNothing;
	end;

  /////////////// STAND ALONE (SINGLE SOURCE)  ///////////////
  export accidents := INTERFACE (Accident_Services.IParam.searchRecords)
  end;

  export ccw := INTERFACE (_report)
  end;

  export corpaffil := INTERFACE (_report)
  end;

  export criminal := INTERFACE (_report)
    export boolean AllowGraphicDescription := false;
    export boolean Include_BestAddress := false;
		export boolean IncludeAllCriminalRecords := false;
    export boolean IncludeSexualOffenses := false;
  end;

  export dea := INTERFACE (_report)
  end;

  export dl := INTERFACE
    // defines whether Certegy data will be used in addition to the Government+Experian
    export boolean use_nonDMVSources := false;
  end;

  export faacerts := INTERFACE (_report)
  end;
	
	//not used ?
  export firearms := INTERFACE (ATF_Services.IParam.search_params)
  end;

  export huntingfishing := INTERFACE (Hunting_Fishing_Services.Search_Records.params)
  end;

  export liens := INTERFACE (_report)
    export string1 liens_party_type := '';
    export string50 tmsid_value := ''; // reserved for future needs if any
  end;

  export internetdomains := INTERFACE (InternetDomain_Services.SearchService_Records.params)
  end;

  // general (vs. productwise) phones options
  export phones := INTERFACE
    export boolean indicate_restricted := false; // will show "UNPUB"
    export boolean include_phonesfeedback := false;
  end;

  export phonesplus := INTERFACE (phones, _report)
  end;

  // health care providers
  export providers := INTERFACE
    export boolean include_groupaffiliations    := false;
    export boolean include_hospitalaffiliations := false;
    export boolean include_education            := false;
    export boolean include_businessaddress      := false;
  end;

  export sanctions := INTERFACE (_didsearch)
  end;

  export sexoffenses := INTERFACE (_report)
  end;
	
  export ucc := INTERFACE (_report)
    export boolean includemultiplesecured := false;
    export boolean returnrolleddebtors := false;
    export string1 ucc_party_type := '';
  end;

  export vehicles := INTERFACE (_report)
    export boolean   Use_CurrentlyOwnedVehicles := FALSE;
  end;

  export voters := INTERFACE (_report)
  end;

  export watercrafts := INTERFACE (_report)
		export boolean include_NonRegulated_WatercraftSources:= FALSE;
  end;

  export mardiv := INTERFACE (_didsearch) end;

  // =========================================================================
  // ================= Central Records, Comprehensive Report ================= 
  // =========================================================================


  // Until we switch all reports to the $.IParam._report interface: an utility macro to copy report's fields 
  EXPORT mac_copy_report_fields (mod_new) := MACRO
    export boolean AllowAll := mod_new.unrestricted = doxie.compliance.ALLOW.ALL; //TODO: use "unrestricted" field.
    export boolean AllowGLB := mod_new.unrestricted & doxie.compliance.ALLOW.GLB = doxie.compliance.ALLOW.GLB;
    export boolean AllowDPPA := mod_new.unrestricted & doxie.compliance.ALLOW.DPPA = doxie.compliance.ALLOW.DPPA;
    EXPORT unsigned1 GLBPurpose := mod_new.glb;
    EXPORT unsigned1 DPPAPurpose := mod_new.dppa;
    EXPORT boolean IncludeMinors := mod_new.show_minors;
    EXPORT boolean restrictPreGLB := mod_new.isPreGLBRestricted();
    EXPORT string32 ApplicationType := mod_new.application_type;
    EXPORT string5 industryclass := mod_new.industry_class;
    EXPORT string DataPermissionMask := mod_new.DataPermissionMask;
    EXPORT string DataRestrictionMask := mod_new.DataRestrictionMask;
    EXPORT boolean probation_override := mod_new.probation_override; //Note: it is not defined in _report (old style _report)

    EXPORT boolean ignoreFares := mod_new.ignoreFares;
    EXPORT boolean ignoreFidelity := mod_new.ignoreFidelity;
    EXPORT INTEGER FCRAPurpose := mod_new.FCRAPurpose;  
    EXPORT integer8 FFDOptionsMask := mod_new.FFDOptionsMask;
    EXPORT string6 ssn_mask := mod_new.ssn_mask;
    EXPORT boolean mask_dl := mod_new.dl_mask = 1;
    EXPORT unsigned1 dob_mask := mod_new.dob_mask;
    EXPORT boolean ln_branded := mod_new.ln_branded;
    EXPORT unsigned3 dateval := mod_new.date_threshold;

    // Other fields:
    EXPORT boolean include_hri := mod_new.include_hri;
    EXPORT boolean legacy_verified := mod_new.legacy_verified;
    EXPORT unsigned1 score_threshold := mod_new.score_threshold;
    EXPORT unsigned2 penalty_threshold := mod_new.penalty_threshold;
    EXPORT unsigned1 max_hri := mod_new.max_hri;
    EXPORT boolean include_BlankDOD := mod_new.include_BlankDOD;
    EXPORT boolean smart_rollup := mod_new.smart_rollup;
    EXPORT integer1 non_subject_suppression := mod_new.non_subject_suppression;
  ENDMACRO;    

END;
