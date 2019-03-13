IMPORT BIPV2, Business_Risk_BIP, iesp, Patriot, BusinessInstantID20_Services;

EXPORT mod_BusinessShell(DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                           BusinessInstantID20_Services.iOptions Options) := 
	MODULE

			SHARED Business_Risk_BIP.Layouts.Input convertToBusinessShellInput(RECORDOF(ds_input) le) := TRANSFORM
				SELF.Seq                 := le.Seq;
				SELF.AcctNo              := le.AcctNo;
				SELF.HistoryDate         := (UNSIGNED3)(((STRING12)le.HistoryDate)[1..6]);
				SELF.HistoryDateTime     := le.HistoryDate;
				SELF.CompanyName         := le.CompanyName;
				SELF.AltCompanyName      := le.AltCompanyName;
				SELF.StreetAddress1      := le.StreetAddress1;
				SELF.StreetAddress2      := le.StreetAddress2;
				SELF.City                := le.City;
				SELF.State               := le.State;
				SELF.Zip                 := le.Zip;
				SELF.FEIN                := le.FEIN;
				SELF.Phone10             := le.Phone10;
				SELF.Fax_Number          := le.Fax_Number;
				// Auth Rep 1
				SELF.Rep_FullName        := le.AuthReps[1].FullName;
				SELF.Rep_FirstName       := le.AuthReps[1].FirstName;
				SELF.Rep_MiddleName      := le.AuthReps[1].MiddleName;
				SELF.Rep_LastName        := le.AuthReps[1].LastName;
				SELF.Rep_NameSuffix      := le.AuthReps[1].NameSuffix;
				SELF.Rep_FormerLastName  := le.AuthReps[1].FormerLastName;
				SELF.Rep_StreetAddress1  := le.AuthReps[1].StreetAddress1;
				SELF.Rep_StreetAddress2  := le.AuthReps[1].StreetAddress2;
				SELF.Rep_City            := le.AuthReps[1].City;
				SELF.Rep_State           := le.AuthReps[1].State;
				SELF.Rep_Zip             := le.AuthReps[1].Zip;
				SELF.Rep_SSN             := le.AuthReps[1].SSN;
				SELF.Rep_DateOfBirth     := le.AuthReps[1].DateOfBirth;
				SELF.Rep_Phone10         := le.AuthReps[1].Phone10;
				SELF.Rep_Age             := le.AuthReps[1].Age;
				SELF.Rep_DLNumber        := le.AuthReps[1].DLNumber;
				SELF.Rep_DLState         := le.AuthReps[1].DLState;
				// Auth Rep 2
				SELF.Rep2_FullName       := le.AuthReps[2].FullName;
				SELF.Rep2_FirstName      := le.AuthReps[2].FirstName;
				SELF.Rep2_MiddleName     := le.AuthReps[2].MiddleName;
				SELF.Rep2_LastName       := le.AuthReps[2].LastName;
				SELF.Rep2_NameSuffix     := le.AuthReps[2].NameSuffix;
				SELF.Rep2_FormerLastName := le.AuthReps[2].FormerLastName;
				SELF.Rep2_StreetAddress1 := le.AuthReps[2].StreetAddress1;
				SELF.Rep2_StreetAddress2 := le.AuthReps[2].StreetAddress2;
				SELF.Rep2_City           := le.AuthReps[2].City;
				SELF.Rep2_State          := le.AuthReps[2].State;
				SELF.Rep2_Zip            := le.AuthReps[2].Zip;
				SELF.Rep2_SSN            := le.AuthReps[2].SSN;
				SELF.Rep2_DateOfBirth    := le.AuthReps[2].DateOfBirth;
				SELF.Rep2_Phone10        := le.AuthReps[2].Phone10;
				SELF.Rep2_Age            := le.AuthReps[2].Age;
				SELF.Rep2_DLNumber       := le.AuthReps[2].DLNumber;
				SELF.Rep2_DLState        := le.AuthReps[2].DLState;
				// Auth Rep 3
				SELF.Rep3_FullName       := le.AuthReps[3].FullName;
				SELF.Rep3_FirstName      := le.AuthReps[3].FirstName;
				SELF.Rep3_MiddleName     := le.AuthReps[3].MiddleName;
				SELF.Rep3_LastName       := le.AuthReps[3].LastName;
				SELF.Rep3_NameSuffix     := le.AuthReps[3].NameSuffix;
				SELF.Rep3_FormerLastName := le.AuthReps[3].FormerLastName;
				SELF.Rep3_StreetAddress1 := le.AuthReps[3].StreetAddress1;
				SELF.Rep3_StreetAddress2 := le.AuthReps[3].StreetAddress2;
				SELF.Rep3_City           := le.AuthReps[3].City;
				SELF.Rep3_State          := le.AuthReps[3].State;
				SELF.Rep3_Zip            := le.AuthReps[3].Zip;
				SELF.Rep3_SSN            := le.AuthReps[3].SSN;
				SELF.Rep3_DateOfBirth    := le.AuthReps[3].DateOfBirth;
				SELF.Rep3_Phone10        := le.AuthReps[3].Phone10;
				SELF.Rep3_Age            := le.AuthReps[3].Age;
				SELF.Rep3_DLNumber       := le.AuthReps[3].DLNumber;
				SELF.Rep3_DLState        := le.AuthReps[3].DLState;
				// Auth Rep 4
				SELF.Rep4_FullName       := le.AuthReps[4].FullName;
				SELF.Rep4_FirstName      := le.AuthReps[4].FirstName;
				SELF.Rep4_MiddleName     := le.AuthReps[4].MiddleName;
				SELF.Rep4_LastName       := le.AuthReps[4].LastName;
				SELF.Rep4_NameSuffix     := le.AuthReps[4].NameSuffix;
				SELF.Rep4_FormerLastName := le.AuthReps[4].FormerLastName;
				SELF.Rep4_StreetAddress1 := le.AuthReps[4].StreetAddress1;
				SELF.Rep4_StreetAddress2 := le.AuthReps[4].StreetAddress2;
				SELF.Rep4_City           := le.AuthReps[4].City;
				SELF.Rep4_State          := le.AuthReps[4].State;
				SELF.Rep4_Zip            := le.AuthReps[4].Zip;
				SELF.Rep4_SSN            := le.AuthReps[4].SSN;
				SELF.Rep4_DateOfBirth    := le.AuthReps[4].DateOfBirth;
				SELF.Rep4_Phone10        := le.AuthReps[4].Phone10;
				SELF.Rep4_Age            := le.AuthReps[4].Age;
				SELF.Rep4_DLNumber       := le.AuthReps[4].DLNumber;
				SELF.Rep4_DLState        := le.AuthReps[4].DLState;
				// Auth Rep 5
				SELF.Rep5_FullName       := le.AuthReps[5].FullName;
				SELF.Rep5_FirstName      := le.AuthReps[5].FirstName;
				SELF.Rep5_MiddleName     := le.AuthReps[5].MiddleName;
				SELF.Rep5_LastName       := le.AuthReps[5].LastName;
				SELF.Rep5_NameSuffix     := le.AuthReps[5].NameSuffix;
				SELF.Rep5_FormerLastName := le.AuthReps[5].FormerLastName;
				SELF.Rep5_StreetAddress1 := le.AuthReps[5].StreetAddress1;
				SELF.Rep5_StreetAddress2 := le.AuthReps[5].StreetAddress2;
				SELF.Rep5_City           := le.AuthReps[5].City;
				SELF.Rep5_State          := le.AuthReps[5].State;
				SELF.Rep5_Zip            := le.AuthReps[5].Zip;
				SELF.Rep5_SSN            := le.AuthReps[5].SSN;
				SELF.Rep5_DateOfBirth    := le.AuthReps[5].DateOfBirth;
				SELF.Rep5_Phone10        := le.AuthReps[5].Phone10;
				SELF.Rep5_Age            := le.AuthReps[5].Age;
				SELF.Rep5_DLNumber       := le.AuthReps[5].DLNumber;
				SELF.Rep5_DLState        := le.AuthReps[5].DLState;				
				SELF := le;
				SELF := [];
			END;
			
			SHARED Shell_Input := PROJECT(ds_input, convertToBusinessShellInput(LEFT));
      
      // Per requirements concerning the Business only: assign Boolean TRUE/FALSE to 
      // include_additional_watchlists based solely on BIID product type.  
      //   o  Business InstantID 2.0 - search OFAC only (always search OFAC an any case)
      //   o  Business InstantID 2.0 Compliance & Business InstantID 2.0 Compliance with SBFE -- 
      //      search the global watch list        
      SHARED includeAddlWatchlists := 
        Options.BIID20_productType IN [ BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE, BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE ];

      SHARED ds_derived_watchlists := 
				DATASET([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem) + // always run OFAC for the Business
				IF(includeAddlWatchlists, DATASET([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem));

      SHARED ds_WatchlistsRequested := Options.Watchlists_Requested + ds_derived_watchlists;
      // SHARED ds_WatchlistsRequested := DATASET([],iesp.Share.t_StringArrayItem);
			 
			// Grab Business Shell results. Layout is Business_Risk_BIP.Layouts.Shell .
			SHARED Shell_Results := Business_Risk_BIP.LIB_Business_Shell_Function(Shell_Input,
																																		 Options.DPPA_Purpose,
																																		 Options.GLBA_Purpose,
																																		 Options.DataRestrictionMask,
																																		 Options.DataPermissionMask,
																																		 Options.IndustryClass,
																																		 Options.LinkSearchLevel,
																																		 Options.BusShellVersion,
																																		 Options.MarketingMode,
																																		 Options.AllowedSources,
																																		 Options.BIPBestAppend,
																																		 Options.OFAC_Version,
																																		 Options.Global_Watchlist_Threshold,
																																		 ds_WatchlistsRequested,
																																		 Options.KeepLargeBusinesses, 
																																		 Options.IncludeTargusGateway,
																																		 Options.Gateways,
																																		 Options.RunTargusGatewayAnywayForTesting, // for testing purposes only
																																		 Options.OverRideExperianRestriction, 
																																		 BusinessInstantID20_Services.Constants.INCLUDE_AUTHREP_IN_BIP_APPEND,
																																		 BusinessInstantID20_Services.Constants.IS_BIID_20);						

			SHARED BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(Business_Risk_BIP.Layouts.Shell le) := 
				TRANSFORM
					SELF.UniqueID		:= le.Seq;
					SELF.PowID			:= (UNSIGNED6)le.Verification.InputIdMatchPowID;
					SELF.ProxID			:= (UNSIGNED6)le.Verification.InputIdMatchProxID;
					SELF.SeleID			:= (UNSIGNED6)le.Verification.InputIdMatchSeleID;
					SELF.OrgID			:= (UNSIGNED6)le.Verification.InputIdMatchOrgID;
					SELF.UltID			:= (UNSIGNED6)le.Verification.InputIdMatchUltID;
					SELF := []; // Don't populate DotID or EmpID
				END;
			
			EXPORT BIPIDs := PROJECT(Shell_Results, grabLinkIDs(LEFT));
			
			EXPORT Records := Shell_Results; 

	END;