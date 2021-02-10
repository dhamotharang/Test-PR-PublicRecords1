IMPORT Business_Risk_BIP, BusinessInstantID20_Services, STD;

EXPORT Risk_Reporting.Layouts.LOG_BIID20 To_LOG_BIID20(
																				DATASET(Business_Risk_BIP.Layouts.Shell) ds_Business_Shell,
																				UNSIGNED2 Product_ID,
																				UNSIGNED1 Process_Type = Risk_Reporting.ProcessType.Internal,
																				BusinessInstantID20_Services.iOptions Options
																				) := FUNCTION

	/* **********************************************************************
	 *   BIID 2.0 Intermediate Logging: log the Business Shell only, since  *
	 *   the BIID 2.0 output is logged in SCOUT/SOAT input/output database. *
	 ************************************************************************ */
	maxlengthXML := 162000; // 228000

	ds_Business_Shell_first_row := ds_Business_Shell[1];

	// 3. In order to TOXML and FROMXML to work correctly for child datasets they must be placed in a wrapper.
	XMLWrapper := RECORD
		Business_Risk_BIP.Layouts.Shell wrapper;
	END;

	XMLWrapped := ROW({ds_Business_Shell_first_row}, XMLWrapper);

	cleanedXML := '<Row>' + (STRING)TOXML(XMLWrapped) + '</Row>';

	// 4.  Final transform
	Risk_Reporting.Layouts.LOG_BIID20_Record FormatIntermediate := TRANSFORM
		SELF.transaction_id      := ''; // Set by the ESP
		SELF.product_id          := Product_ID;
		SELF.date_added          := (STRING8)Std.Date.Today() + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		SELF.process_type        := (STRING4)Process_Type; // 0 = Undetermined, 1 = Request, 2 for Response, 3 = Context, 4 = Internal
		SELF.processing_time     := '000.000'; // Set by the ESP
		SELF.source_code         := '';
		SELF.content_Type        := '';
		SELF.version             := (STRING20)Options.BusShellVersion;
		SELF.reference_number    := '';
		SELF.options.DPPA_Purpose	              := Options.dppa;
		SELF.options.GLBA_Purpose	              := Options.glb;
		SELF.options.DataRestrictionMask        := Options.DataRestrictionMask;
		SELF.options.DataPermissionMask         := Options.DataPermissionMask;
		SELF.options.IndustryClass              := Options.industry_class;
		SELF.options.LinkSearchLevel            := Options.LinkSearchLevel;
		SELF.options.MarketingMode              := Options.MarketingMode;
		SELF.options.AllowedSources             := Options.AllowedSources;
		SELF.options.OFAC_Version               := Options.OFAC_Version;
		SELF.options.Global_Watchlist_Threshold := Options.Global_Watchlist_Threshold;
		SELF.options.Watchlists_Requested       := Options.Watchlists_Requested;
		SELF.options.Gateways                   := Options.Gateways;
		SELF.options.BIID20ProductType          := (UNSIGNED1)Options.BIID20_productType;
		SELF.content_data := IF(LENGTH(cleanedXML) > maxlengthXML, cleanedXML[1..maxlengthXML], cleanedXML);
		SELF := [];
	END;

	logResult :=
		IF(
			Options.DisableIntermediateShellLogging,
			DATASET( [], Risk_Reporting.Layouts.LOG_BIID20_Record ),
			DATASET([ FormatIntermediate ])
		);

	RETURN DATASET([{logResult}], Risk_Reporting.Layouts.LOG_BIID20);
END;
