IMPORT AutoStandardI, doxie, iesp, PersonReports;

EXPORT SmartLinx_Person_Sections (STRING in_did, BOOLEAN include_sourceDocSection, MIDEX_Services.Iparam.smartLinxPersonIncludeOptions options/*,
																																																															boolean includeBlackKnight=false*/) :=
      // NOTE: the original SmartLinx code uses Exclude Sources -- This function takes 
      //       include sources because it is consistent with the remaining Midex attribute code.
      //       The change is made when the ExcludeSources boolean flag is set.
  FUNCTION
 // check to see if we can use a "no deep dive" parameter to remove dependency on autokeys     
    // ------------------------------------------------------------------------------------------------
    //              Person Smartlinx Flags
    // ------------------------------------------------------------------------------------------------
    // Each heading below are the sections from the person smartlinx code the boolean flags were taken from
    in_mod := AutoStandardI.GlobalModule();  
    
    search_mod := MODULE (PROJECT (in_mod, PersonReports.IParam._didsearch, OPT))
      END;

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(in_mod);  
    report_mod := MODULE (PROJECT (mod_access, PersonReports.IParam._smartlinxreport, OPT))
      // Include
      EXPORT BOOLEAN select_individually        := TRUE;
      EXPORT BOOLEAN include_akas               := TRUE;
      EXPORT BOOLEAN include_associates         := TRUE;
      EXPORT BOOLEAN include_bankruptcy         := TRUE;
      EXPORT BOOLEAN include_best               := TRUE;
      EXPORT BOOLEAN include_crimrecords        := TRUE;
      EXPORT BOOLEAN include_crimhistory        := TRUE;
      EXPORT BOOLEAN include_sexualoffences			:= options.IncludeSexualOffenses;
      EXPORT BOOLEAN include_email              := TRUE;
      EXPORT BOOLEAN include_imposters          := TRUE;
      EXPORT BOOLEAN Return_All_Imposters       := TRUE;
      EXPORT BOOLEAN include_liensjudgments     := TRUE;
      EXPORT BOOLEAN include_peopleatwork       := TRUE;
      EXPORT BOOLEAN include_phonesplus         := TRUE;
      EXPORT BOOLEAN include_properties         := TRUE;
      EXPORT BOOLEAN include_verification       := TRUE; 
      EXPORT BOOLEAN include_sources            := include_sourceDocSection;
      EXPORT BOOLEAN include_criminalindicators := TRUE;
      EXPORT BOOLEAN include_bpsaddress         := TRUE;  // needed for report addresses section
      EXPORT BOOLEAN include_relatives					:= options.IncludeRelatives;
      EXPORT BOOLEAN include_corpaffiliations		:= options.IncludeCorporateAffiliations;
      EXPORT BOOLEAN include_uccfilings					:= options.IncludePersonBusinessAssociates;	//needed for other associated business section
      EXPORT BOOLEAN include_motorvehicles			:= options.IncludePersonBusinessAssociates;	//needed for other associated business section
      EXPORT BOOLEAN include_watercrafts				:= options.IncludePersonBusinessAssociates;	//needed for other associated business section
      EXPORT BOOLEAN include_faaaircrafts				:= options.IncludePersonBusinessAssociates;	//needed for other associated business section
			
      //---------------------------------------------------------------------------------------
      // Exclude
      // Passed in parameter is include, person smartlinx uses exclude flag, must take opposite
      EXPORT BOOLEAN ExcludeSources := ~include_sourceDocSection;
      
      //---------------------------------------------------------------------------------------
      // Imposters
      EXPORT BOOLEAN return_AllImposterRecords := TRUE;
      //---------------------------------------------------------------------------------------
      // Permissions
      // EXPORT BOOLEAN AllowAll := TRUE;
      //---------------------------------------------------------------------------------------
      // Phones
      EXPORT BOOLEAN include_phonesfeedback := FALSE;  
      //---------------------------------------------------------------------------------------
      // Providers
      EXPORT BOOLEAN include_groupaffiliations := TRUE;
      //---------------------------------------------------------------------------------------
      // Report
      EXPORT BOOLEAN include_hri  := TRUE;  // check with Prashant - make sure he's using them
      EXPORT BOOLEAN smart_rollup := TRUE;
      //---------------------------------------------------------------------------------------
      // _smartlinxreport
      
      EXPORT BOOLEAN   include_blankdod          := FALSE;
      EXPORT BOOLEAN   include_censusdata        := TRUE;
      EXPORT BOOLEAN   include_relativeaddresses := options.IncludeRelatives;
      EXPORT BOOLEAN   use_bestaka_nb            := FALSE;
      // EXPORT BOOLEAN use_bestaka_ra := TRUE;
      EXPORT BOOLEAN   use_bestaka_ra            := FALSE;
      EXPORT UNSIGNED1 addresses_per_neighbor    := 20;
      EXPORT UNSIGNED1 max_relatives_addresses   := if(options.IncludeRelatives, 5, 0);
      EXPORT UNSIGNED1 max_imposter_akas         := 50;
      EXPORT UNSIGNED1 neighborhoods             := 0;
      EXPORT UNSIGNED1 neighbors_per_address     := 1;
      EXPORT UNSIGNED1 relative_depth            := 3;
      EXPORT UNSIGNED1 email_version             := 1;
      EXPORT BOOLEAN   includeVendorSourceB := options.includeVendorSourceB;
      EXPORT BOOLEAN   IncludeAssignmentsAndReleases := options.IncludeAssignmentsAndReleases;
    END;

    in_didUnsigned := (UNSIGNED6) in_did;
    ds_did         := DATASET ([ {in_didUnsigned} ],doxie.layout_references);

    smartLinxPersonRecsRaw := PersonReports.SmartLinxReport (ds_did, report_mod, FALSE);
    RETURN smartLinxPersonRecsRaw;
  END;  // end SmartLinx_Person_Sections function
