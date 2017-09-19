IMPORT address,Bair_ExternalLinkKeys,iesp,STD;
IMPORT BairRx_PSS,BairRx_Common;

EXPORT SALTParam := MODULE
	
	SHARED CleanAddress(iesp.bair_share.t_BAIRInputAddress in_address) := FUNCTION
		
		// InterfaceTranslator (?) - deliberately not including it for now...
		
		in_street_addr 	:= STD.Str.ToUpperCase(TRIM(in_address.StreetAddress));		
		in_prim_range 	:= STD.Str.ToUpperCase(TRIM(in_address.StreetNumber));
		in_prim_name 		:= STD.Str.ToUpperCase(TRIM(in_address.StreetName));		
		in_addr_suffix 	:= STD.Str.ToUpperCase(TRIM(in_address.StreetSuffix));
		in_predir 			:= STD.Str.ToUpperCase(TRIM(in_address.StreetPreDirection));
    in_postdir 			:= STD.Str.ToUpperCase(TRIM(in_address.StreetPostDirection));		
    in_unit_desig 	:= STD.Str.ToUpperCase(TRIM(in_address.UnitDesignation));
		in_sec_range 		:= STD.Str.ToUpperCase(TRIM(in_address.UnitNumber));		
		in_city_name 		:= STD.Str.ToUpperCase(TRIM(in_address.City));
		in_state 				:= STD.Str.ToUpperCase(TRIM(in_address.State));
		in_zip 					:= STD.Str.ToUpperCase(TRIM(in_address.Zip));		
		
		in_street_addr_comp := address.Addr1FromComponents(in_prim_range, in_predir, in_prim_name, in_addr_suffix, in_postdir, in_unit_desig, in_sec_range);		    
		_ADDR1 := IF(in_street_addr<>'', in_street_addr, in_street_addr_comp);
		_ADDR2 := Address.Addr2FromComponents(in_city_name, in_state, in_zip);
		_allowclean := (in_city_name <> '' AND in_state <> '') OR in_zip <> ''; 		
		CA := address.GetCleanAddress(_ADDR1,_ADDR2,address.Components.country.US).results;
		
		cl_layout := RECORD
			string cl_prim_range;
			string cl_prim_name;
			string cl_addr_suffix;
			string cl_predir;
			string cl_postdir;
			string cl_unit_desig;
			string cl_sec_range;
			string cl_city_name;
			string cl_state;
			string cl_zip;
			string cl_zip4;
			string cl_addr1;
			string cl_addr2;
			string cl_error;			
		END;
		
		cl_layout clean_addr() := TRANSFORM
			SELF.cl_prim_range 	:= IF(_allowclean, CA.prim_range, in_prim_range),
			SELF.cl_prim_name 	:= IF(_allowclean, CA.prim_name, in_prim_name),		
			SELF.cl_addr_suffix := IF(_allowclean, CA.suffix, in_addr_suffix),				
			SELF.cl_predir 			:= IF(_allowclean, CA.predir, in_predir),
			SELF.cl_postdir 		:= IF(_allowclean, CA.postdir, in_postdir),		
			SELF.cl_unit_desig 	:= IF(_allowclean, CA.unit_desig, in_unit_desig),
			SELF.cl_sec_range 	:= IF(_allowclean, CA.sec_range, in_sec_range),		
			SELF.cl_city_name 	:= IF(_allowclean, CA.p_city, in_city_name),
			SELF.cl_state		 		:= IF(_allowclean, CA.state, in_state),
			SELF.cl_zip			 		:= IF(_allowclean, CA.zip, in_zip),		
			SELF.cl_zip4				:= IF(_allowclean, CA.zip4, ''),
			SELF.cl_addr1				:= IF(_allowclean, address.Addr1FromComponents(SELF.cl_prim_range, SELF.cl_predir, SELF.cl_prim_name, SELF.cl_addr_suffix, SELF.cl_postdir, SELF.cl_unit_desig, SELF.cl_sec_range),	_ADDR1),	
			SELF.cl_addr2				:= IF(_allowclean, address.Addr2FromComponents(SELF.cl_city_name, SELF.cl_state, SELF.cl_zip), _ADDR2),
			SELF.cl_error				:= IF(_allowclean, CA.error_msg, 'cleaner not called')			
		END;
		
		RETURN ROW(clean_addr());
		
	END;
	
	// output: DATASET(LayoutIn)
	EXPORT GetInput(iesp.bair_share.t_BAIRBasePSSearchBy searchBy, iesp.bair_share.t_BAIRBasePSSearchOption options, iesp.bair_share.t_BAIRUser user) := FUNCTION
			
		_StrType := BairRx_Common.SALTGold.StrType;	
		UNSIGNED InputMaxIds0 := IF(options.MaxResults = 0,BairRx_PSS.Constants.DEFAULT_MAX_IDS,options.MaxResults);
		UNSIGNED Input_MaxIds := MIN(InputMaxIds0,iesp.bair_constants.MAX_EID_RECS);
		UNSIGNED InputLeadThreshold0 := 0 : STORED('LeadThreshold');
		UNSIGNED Input_LeadThreshold := IF(InputLeadThreshold0=0, BairRx_PSS.Constants.DEFAULT_LEAD_THRESHOLD, InputLeadThreshold0);
				
		in_address := CleanAddress(searchBy.Address);
		
		Template := DATASET([],BairRx_PSS.SALTLayout.LayoutIn);
		BairRx_PSS.SALTLayout.LayoutIn xt() := TRANSFORM
			SELF.UniqueId := (TYPEOF(Template.UniqueID))TRIM(searchBy.LexID),
			SELF.MaxIDs := Input_MaxIds,
			SELF.LeadThreshold := Input_LeadThreshold,
			// ---- NAME ---
			SELF.NAME_SUFFIX := (TYPEOF(Template.NAME_SUFFIX))Bair_ExternalLinkKeys.Fields.Make_NAME_SUFFIX((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Name.Suffix))),
			SELF.FNAME := (TYPEOF(Template.FNAME))Bair_ExternalLinkKeys.Fields.Make_FNAME((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Name.First))),
			SELF.MNAME := (TYPEOF(Template.MNAME))Bair_ExternalLinkKeys.Fields.Make_MNAME((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Name.Middle))),
			SELF.LNAME := (TYPEOF(Template.LNAME))Bair_ExternalLinkKeys.Fields.Make_LNAME((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Name.Last))),
			SELF.MAINNAME := '';
			SELF.FULLNAME := (TYPEOF(Template.FULLNAME))Bair_ExternalLinkKeys.Fields.Make_FULLNAME((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Name.Full))),
			// ---- ADDRESS ---
			SELF.SEARCH_ADDR1 := (TYPEOF(Template.SEARCH_ADDR1))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR1((_StrType)in_address.cl_addr1),
			SELF.SEARCH_ADDR2 := (TYPEOF(Template.SEARCH_ADDR2))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR2((_StrType)in_address.cl_addr2),
			SELF.PRIM_RANGE := (TYPEOF(Template.PRIM_RANGE))Bair_ExternalLinkKeys.Fields.Make_PRIM_RANGE((_StrType)in_address.cl_prim_range),
			SELF.PRIM_NAME := (TYPEOF(Template.PRIM_NAME))Bair_ExternalLinkKeys.Fields.Make_PRIM_NAME((_StrType)in_address.cl_prim_name),
			SELF.SEC_RANGE := (TYPEOF(Template.SEC_RANGE))Bair_ExternalLinkKeys.Fields.Make_SEC_RANGE((_StrType)in_address.cl_sec_range),
			SELF.P_CITY_NAME := (TYPEOF(Template.P_CITY_NAME))Bair_ExternalLinkKeys.Fields.Make_P_CITY_NAME((_StrType)in_address.cl_city_name),
			SELF.ST := (TYPEOF(Template.ST))Bair_ExternalLinkKeys.Fields.Make_ST((_StrType)in_address.cl_state),
			SELF.ZIP := (TYPEOF(Template.ZIP))in_address.cl_zip,			
			// -------
			SELF.DOB := (TYPEOF(Template.DOB))Bair_ExternalLinkKeys.Fields.Make_DOB(iesp.ECL2ESP.t_DateToString8(searchBy.DOB)),
			SELF.PHONE := (TYPEOF(Template.PHONE))searchBy.PhoneNumber,
			SELF.DL_ST := (TYPEOF(Template.DL_ST))Bair_ExternalLinkKeys.Fields.Make_DL_ST((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.DLState))),
			SELF.DL := (TYPEOF(Template.DL))Bair_ExternalLinkKeys.Fields.Make_DL((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.DLNumber))),
			SELF.LEXID := (TYPEOF(Template.LEXID))Bair_ExternalLinkKeys.Fields.Make_LEXID((_StrType)TRIM(searchBy.LexID)),
			SELF.POSSIBLE_SSN := (TYPEOF(Template.POSSIBLE_SSN))Bair_ExternalLinkKeys.Fields.Make_POSSIBLE_SSN((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.SSN))),
			SELF.DT_FIRST_SEEN := (TYPEOF(Template.DT_FIRST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_FIRST_SEEN(iesp.ECL2ESP.t_DateToString8(searchBy.StartDate));
			SELF.DT_LAST_SEEN := (TYPEOF(Template.DT_LAST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_LAST_SEEN(iesp.ECL2ESP.t_DateToString8(searchBy.EndDate));
			SELF.VIN := (TYPEOF(Template.VIN))Bair_ExternalLinkKeys.Fields.Make_VIN((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.VIN))),
			SELF.PLATE := (TYPEOF(Template.PLATE))Bair_ExternalLinkKeys.Fields.Make_PLATE((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.Plate))),
			SELF.MatchRecords := FALSE, // Only show records which match
			SELF.FullMatch := FALSE, // Only show EID_HASH if it has a record which fully matches
			SELF.clean_company_name := (TYPEOF(Template.clean_company_name))Bair_ExternalLinkKeys.Fields.Make_CLEAN_COMPANY_NAME((_StrType)STD.Str.ToUpperCase(TRIM(searchBy.CompanyName))),
			// ------------------------------------------------------
			SELF.IncludeEvents := options.IncludeEvents,
			SELF.IncludeCFS := options.IncludeCFS,
			SELF.IncludeCrash := options.IncludeCrash,
			SELF.IncludeOffenders := options.IncludeOffenders,
			SELF.IncludeLPR := options.IncludeLPR,
			SELF.AgencyORI := user.AgencyORI,
			// ------------------------------------------------------
			SELF.addr_clean_error := in_address.cl_error, // for debugging only			
			SELF.zip4 := in_address.cl_zip4, // for debugging only			
			SELF := []
		END;		
		
		RETURN DATASET([xt()]);		
	END;
			
END;