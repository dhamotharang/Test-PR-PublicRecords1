IMPORT BIPV2, Business_Risk, doxie, Gateway, MDR, Risk_Indicators, Targus, Business_Risk_BIP, STD;

EXPORT getTargusGateway(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	 applyOptOut := TRUE; // Temporary variable to enable Targus opt out

	// Gateway url for development: 'http://rw_score_dev:[PASSWORD_REDACTED]@gatewaycertesp.sc.seisint.com:7726/WsGateway'

	RESTRICTED_SET := ['0', ''];
	RESTRICT_GATEWAY_URL := '';

	restrict_targus := mod_access.DataPermissionMask[2] IN RESTRICTED_SET OR NOT Options.IncludeTargusGateway;

	// 1. Determine whether to make the Targus Gateway call at all. Kill the Gateway call by
	// setting the url to nothing, if DataPermissionMask[2] is not flipped to '1'.
	targus_gateway_cfg_pre :=
		PROJECT(
			Options.Gateways,
			TRANSFORM( Gateway.Layouts.Config,               // targus and targuse3220 should have the same url
				SELF.ServiceName := IF( LEFT.Servicename NOT IN ['targus','targuse3220'], SKIP, LEFT.Servicename ),
				SELF.Url := IF( restrict_targus, RESTRICT_GATEWAY_URL, LEFT.Url ),
				SELF := LEFT
			)
		);

	targus_gateway_cfg := targus_gateway_cfg_pre[1];

	makeGatewayCall := targus_gateway_cfg.url != '';

	// 2. Prep Business Shell records for input to Targus Gateway.
	targus.layout_targus_in prep_for_Targus(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM
		SELF.user.GLBPurpose                      := mod_access.glb;
		SELF.user.DLPurpose                       := mod_access.dppa;
		SELF.user.QueryID                         := (STRING)le.seq;
		SELF.searchBy.CompanyName                 := le.Clean_Input.CompanyName;
		SELF.searchby.ConsumerName.Fname          := le.Clean_Input.Rep_FirstName;
		SELF.searchby.ConsumerName.Lname          := le.Clean_Input.Rep_LastName;
		SELF.searchby.PhoneNumber                 := le.Clean_Input.Phone10;
		SELF.searchby.Address.streetName          := le.Clean_Input.Prim_Name;
		SELF.searchby.Address.streetNumber        := le.Clean_Input.Prim_Range;
		SELF.searchby.Address.streetPreDirection  := le.Clean_Input.PreDir;
		SELF.searchby.Address.streetPostDirection := le.Clean_Input.PostDir;
		SELF.searchby.Address.StreetSuffix        := le.Clean_Input.Addr_Suffix;
		SELF.searchby.Address.UnitDesignation     := le.Clean_Input.Unit_Desig;
		SELF.searchby.Address.UnitNumber          := le.Clean_Input.Sec_Range;
		SELF.searchby.Address.StreetAddress1      := le.Clean_Input.StreetAddress1;
		SELF.searchby.Address.StreetAddress2      := le.Clean_Input.StreetAddress2;
		SELF.searchby.Address.City                := le.Clean_Input.City;
		SELF.searchby.Address.State               := le.Clean_Input.State;
		SELF.searchby.Address.zip5                := IF( le.Clean_Input.Zip != '', le.Clean_Input.Zip[1..5], le.Clean_Input.Zip5 );
		SELF.searchby.Address.zip4                := IF( le.Clean_Input.Zip != '', le.Clean_Input.Zip[6..9], le.Clean_Input.Zip4 );

		// Perform the following searches:
		SELF.options.IncludeWirelessConnectionSearch   := TRUE; // Royalty.Constants.RoyaltyCode.TARGUS_WCS
		SELF.options.IncludePhoneDataExpressSearch     := TRUE; // Royalty.Constants.RoyaltyCode.TARGUS_PDE

		SELF.options.VerifyExpressOptions.IncludeInputPhoneScore              := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedName                  := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedPrimaryAddress        := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedSecondaryAddress      := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedCityName              := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedState                 := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedCorrectedZIPCode      := TRUE;
		SELF.options.VerifyExpressOptions.IncludeMatchedOrCorrectedPhone      := TRUE;
		SELF.options.VerifyExpressOptions.IncludeCurrentPhoneStatus           := TRUE;
		SELF.options.VerifyExpressOptions.IncludeNameAddressCurrencyIndicator := TRUE;
		SELF.options.VerifyExpressOptions.IncludeEquipmentPortFlag            := TRUE;
		SELF.options.VerifyExpressOptions.IncludeStatusCodes                  := TRUE;
		SELF := [];
	end;

	targus_in := PROJECT(Shell, prep_for_Targus(LEFT));

	// 3. Call Targus Gateway.
	timeout := 2;	// 2 seconds
	retries := 0;	// don't retry because of SLA's

	// Redundant makeGatewayCall passed to SOAP call as a safety mechanism in case Roxie
	// ever decides to execute both sides of the IF statement.
	targus_out_pre := // Targus.Layout_Targus_Out
		IF(
			makeGatewayCall,
			Gateway.SoapCall_Targus(targus_in, targus_gateway_cfg, timeout, retries, makeGatewayCall, mod_access, applyOptOut),
			DATASET([],targus.layout_targus_out)
		);

	targus_out := SORT( targus_out_pre, Response.Header.QueryId ); // For convenience while debugging.

	// 4. Transform Targus Gateway results to obtain the data needed for the Business Shell.
	layout_temp := RECORD
		UNSIGNED4 seq;
		STRING1 PhoneMatch;
		STRING1 BNAP;
		STRING2 InputPhoneEntityCount;
		STRING1 InputPhoneMobile;
		STRING2 PhoneDisconnected;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
	END;

	layout_temp xfm_get_needed_data(Business_Risk_BIP.Layouts.Shell le, targus.layout_targus_out ri) := TRANSFORM
		Enhanced_Data    := ri.Response.VerifyExpressResult.EnhancedData;
		PDESearchResult  := ri.Response.PhoneDataExpressSearchResult;
		TargusHit        := PDESearchResult.StatusCode = 'Success';

		NamePopulated    := TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(PDESearchResult.BusinessName) <> '';
		NameMatched      := NamePopulated AND le.Clean_Input.CompanyName[1] = PDESearchResult.BusinessName[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, PDESearchResult.BusinessName));

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(PDESearchResult.PrimaryAddressNumber) <> '' AND TRIM(PDESearchResult.ZIPCode) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND PDESearchResult.ZIPCode <> '' AND le.Clean_Input.Zip5[1] = PDESearchResult.ZIPCode[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, PDESearchResult.ZIPCode), NoScoreValue);
		CityStateScore			:= IF(ZIPScore <> NoScoreValue AND le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND PDESearchResult.PostOfficeCityName <> '' AND PDESearchResult.State <> '' AND le.Clean_Input.State[1] = PDESearchResult.State[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, PDESearchResult.PostOfficeCityName, PDESearchResult.State, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						PDESearchResult.PrimaryAddressNumber, PDESearchResult.StreetName, PDESearchResult.SecondaryAddressNumber,
																						ZIPScore, CityStateScore)));

		StateMatched				:= STD.Str.ToUpperCase(le.Clean_Input.State) = STD.Str.ToUpperCase(PDESearchResult.State);

		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(Enhanced_Data.Phone) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = Enhanced_Data.Phone[1] OR le.Clean_Input.Phone10[4] = Enhanced_Data.Phone[4] OR le.Clean_Input.Phone10[4] = Enhanced_Data.Phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, Enhanced_Data.Phone));
		PhoneDisonnectStatus :=
			CASE( STD.Str.touppercase(Enhanced_Data.phonestatus), 'CONNECTED' => '0', 'DISCONNECTED' => '1', '2'); // A 2 indicates "Unknown"

		// NOTE: The results from the Targus Gateway contain no date information whatsoever so
		// set date first and last seen dates to '0'.
		PhoneSourceList      := DATASET([{MDR.SourceTools.src_Targus_Gateway, Business_Risk_BIP.Constants.MissingDate,  Business_Risk_BIP.Constants.MissingDate,  Business_Risk_BIP.Constants.MissingDate, Business_Risk_BIP.Constants.MissingDate, 1}], Business_Risk_BIP.Layouts.LayoutSources);
		PhoneSourceBlankList := DATASET([], Business_Risk_BIP.Layouts.LayoutSources);

		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and
		// Business_Risk_BIP.getOtherSources to help boost verification.
		BNAPCalc            := Business_Risk_BIP.Common.calcBNAP_wide( PhoneMatched, PhonePopulated, NameMatched, AddressMatched, StateMatched);
		IsPhoneMatch        := BNAPCalc IN ['4', '5', '8'];

		SELF.Seq  := le.Seq;
		SELF.BNAP := BNAPCalc;

		// The Targus Gateway returns only one record per input.
		SELF.InputPhoneEntityCount := IF( TargusHit, '1', '0' );
		SELF.InputPhoneMobile :=
				IF( STD.Str.touppercase(ri.Response.WirelessConnectionSearchResult.OwnerType) = 'WIRELESS' OR
		        STD.Str.find( STD.Str.touppercase(ri.Response.VerifyExpressResult.InputVerification.Phone.PhoneType),'CELL',1 ) > 0,
						'1',
						'0');

		SELF.PhoneDisconnected := PhoneDisonnectStatus;

		// A BNAP of 4, 5, or 8 should also update the PhoneMatch flag as we effectively have
		// verified the input phone against the input Business Name AND/OR Business Address.
		SELF.PhoneMatch   := Business_Risk_BIP.Common.SetBoolean(IsPhoneMatch);
		SELF.PhoneSources := IF( PhoneMatched, PhoneSourceList, PhoneSourceBlankList );
	END;

	targus_result :=
		JOIN(
			Shell, targus_out,
			LEFT.seq = (INTEGER)RIGHT.Response.Header.QueryId AND
			LEFT.Clean_Input.phone10 = RIGHT.searchby.phonenumber,
			xfm_get_needed_data(LEFT,RIGHT),
			INNER
		);

	// OUTPUT( Options.Gateways, NAMED('Options_Gateways') );
	// OUTPUT( targus_gateway_cfg_pre, NAMED('targus_gateway_cfg_pre') );
	// OUTPUT( targus_gateway_cfg, NAMED('targus_gateway_cfg') );
	// OUTPUT( targus_in, NAMED('targus_in') );
	// OUTPUT( targus_out, NAMED('targus_out') );

	RETURN targus_result;
END;
