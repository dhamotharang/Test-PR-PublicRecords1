export parameter_interfaces :=
	module
		// SSN-related parameters
		export p__SSNTypos :=
			interface
				export boolean parm_SSNTypos := false;
			end;
		// FEIN-related parameters
		export p__fein :=
			interface
				export string parm_fein := '';
			end;
		// Phone-related parameters
		export p__phone :=
			interface
				export string parm_phone := '';
			end;
		// Name-related parameters
		export p__companyname :=
			interface
				export string parm_companyname := '';
			end;
		export p__lname :=
			interface
				export string parm_lname := '';
			end;
		export p__LastName :=
			interface
				export string parm_LastName := '';
			end;
		export p__Lname4 :=
			interface
				export string parm_Lname4 := '';
			end;
		export p__Fname3 :=
			interface
				export string parm_Fname3 := '';
			end;
		export p__UnParsedFullName :=
			interface
				export string parm_UnParsedFullName := '';
			end;
		export p__nameasis :=
			interface
				export string parm_nameasis := '';
			end;
		export p__asisname :=
			interface
				export string parm_asisname := '';
			end;
		export p__lfmname :=
			interface
				export string parm_lfmname := '';
			end;
		export p__PhoneticMatch :=
			interface
				export boolean parm_PhoneticMatch := false;
			end;
		export p__AllowNicknames :=
			interface
				export boolean parm_AllowNicknames := false;
			end;
		export p__FirstName :=
			interface
				export string parm_FirstName := '';
			end;
		export p__MiddleName :=
			interface
				export string parm_MiddleName := '';
			end;
		export p__OtherLastName1 :=
			interface
				export string parm_OtherLastName1 := '';
			end;
		export p__cn :=
			interface
				export string parm_cn := '';
			end;
		export p__company :=
			interface
				export string parm_company := '';
			end;
		export p__corpname :=
			interface
				export string parm_corpname := '';
			end;
		// Address-related parameters
		export p__addr :=
			interface
				export string parm_addr := '';
			end;
		export p__city :=
			interface
				export string parm_city := '';
			end;
		export p__state :=
			interface
				export string parm_state := '';
			end;
		export p__zip :=
			interface
				export string parm_zip := '';
			end;
		export p__County :=
			interface
				export string parm_County := '';
			end;
		export p__OtherState1 :=
			interface
				export string parm_OtherState1 := '';
			end;
		export p__OtherState2 :=
			interface
				export string parm_OtherState2 := '';
			end;
		export p__predir :=
			interface
				export string parm_predir := '';
			end;
		export p__StateCityZip :=
			interface
				export string parm_StateCityZip := '';
			end;
		export p__z5 :=
			interface
				export string parm_z5 := '';
			end;
		export p__prim_name :=
			interface
				export string parm_prim_name := '';
			end;
		export p__street_name :=
			interface
				export string parm_street_name := '';
			end;
		export p__prim_range :=
			interface
				export string parm_prim_range := '';
			end;
		export p__st :=
			interface
				export string parm_st := '';
			end;
		export p__st_orig :=
			interface
				export string parm_st_orig := '';
			end;
		// Age-related parameters
		export p__DOB :=
			interface
				export unsigned parm_DOB := 0;
			end;
		export p__AgeHigh :=
			interface
				export unsigned parm_AgeHigh := 0;
			end;
		export p__AgeLow :=
			interface
				export unsigned parm_AgeLow := 0;
			end;
		// Relative-related parameters
		export p__RelativeFirstName1 :=
			interface
				export string parm_RelativeFirstName1 := '';
			end;
		export p__RelativeFirstName2 :=
			interface
				export string parm_RelativeFirstName2 := '';
			end;
		export p__ScoreThreshold :=
			interface
				export unsigned parm_ScoreThreshold := 10;
			end;
		export p__did :=
			interface
				export string parm_did := '';
			end;
		export p__LookupType :=
			interface
				export string parm_LookupType := '';
			end;
		export p__PartyType :=
			interface
				export string parm_PartyType := '';
			end;
		export p__BDID :=
			interface
				export string parm_BDID := '';
			end;
		export p__suffix :=
			interface
				export string parm_suffix := '';
			end;
		export p__postdir :=
			interface
				export string parm_postdir := '';
			end;
		export p__sec_range :=
			interface
				export string parm_sec_range := '';
			end;
		export p__ZipRadius :=
			interface
				export unsigned parm_ZipRadius := 0;
			end;
		export p__OtherCity1 :=
			interface
				export string parm_OtherCity1 := '';
			end;
		export p__NoDeepDive :=
			interface
				export boolean parm_NoDeepDive := false;
			end;
		export p__MileRadius :=
			interface
				export unsigned parm_MileRadius := 0;
			end;
		export p__useSupergroup :=
			interface
				export boolean parm_useSupergroup := false;
			end;
		export p__useLevels :=
			interface
				export boolean parm_useLevels := true;
			end;
		export p__ExactOnly :=
			interface
				export boolean parm_ExactOnly := true;
			end;
		export p__SeisintAdlService :=
			interface
				export string parm_SeisintAdlService := '';
			end;
		export p__NonExclusion :=
			interface
				export boolean parm_NonExclusion := false;
			end;
		export p__LnBranded :=
			interface
				export boolean parm_LnBranded := false;
			end;
		export p__rid :=
			interface
				export string parm_rid := '';
			end;
		export p__SearchGoodSSNOnly :=
			interface
				export boolean parm_SearchGoodSSNOnly := false;
			end;
		export p__SearchIgnoresAddressOnly :=
			interface
				export boolean parm_SearchIgnoresAddressOnly := false;
			end;
		export p__PenaltThreshold :=
			interface
				export unsigned parm_PenaltThreshold := 0;
			end;
		export p__DateFirstSeen :=
			interface
				export unsigned parm_DateFirstSeen := 0;
			end;
		export p__DateLastSeen :=
			interface
				export unsigned parm_DateLastSeen := 0;
			end;
		export p__AllowDateSeen :=
			interface
				export boolean parm_AllowDateSeen := false;
			end;
		export p__AllowWildcard :=
			interface
				export boolean parm_AllowWildcard := if(thorlib.getenv('AllowWildcard','Default')='1',true,false);
			end;
		export p__UseOnlyBestDID :=
			interface
				export boolean parm_UseOnlyBestDID := false;
			end;
		export p__KeepOldSsns :=
			interface
				export boolean parm_KeepOldSsns := false;
			end;
		export p__UsingKeepSSNs :=
			interface
				export boolean parm_UsingKeepSSNs := false;
			end;
		export p__Household :=
			interface
				export boolean parm_Household := false;
			end;
		export p__AllowAll :=
			interface
				export boolean parm_AllowAll := false;
			end;
		export p__AllowDPPA :=
			interface
				export boolean parm_AllowDPPA := false;
			end;
		export p__DPPAPurpose :=
			interface
				export unsigned parm_DPPAPurpose := 0;
			end;
		export p__AllowGLB :=
			interface
				export boolean parm_AllowGLB := false;
			end;
		export p__GLBPurpose :=
			interface
				export unsigned parm_GLBPurpose := 8;
			end;
		export p__MaxResults :=
			interface
				export unsigned parm_MaxResults := 2000;
			end;
		export p__SkipRecords :=
			interface
				export unsigned parm_SkipRecords := 0;
			end;
		export p__MaxResultsThisTime :=
			interface
				export unsigned parm_MaxResultsThisTime := 2000;
			end;
		export p__ssn :=
			interface
				export string parm_ssn := '';
			end;
		export p__isCrs :=
			interface
				export boolean parm_isCrs := false;
			end;
	end;
	