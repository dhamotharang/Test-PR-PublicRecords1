IMPORT LNSmallBusiness, Business_Risk_BIP, Risk_Indicators, ut;

EXPORT Risk_Reporting.Layouts.LOG_Business_Shell To_LOG_Business_Shell (
																				DATASET(LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout) Business_Shell_plus_Scores,
																				UNSIGNED2 Product_ID,
																				UNSIGNED5 Version,
																				UNSIGNED1 Process_Type = Risk_Reporting.ProcessType.Internal,
																				Risk_Reporting.Layouts.Business_Risk_Job_Options rw_options
																				) := FUNCTION
	// If a company opt's out of logging this will be set to TRUE
	BOOLEAN TurnOffLogging := FALSE : STORED('OutcomeTrackingOptOut');
	
	Risk_Reporting.Layout_Business_Shell slimShell(LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout le) := TRANSFORM
		// To start with the two shells are the same, and in general will always remain the same.
		// Adding the transform just in case the two diverge slightly in the future.
		SELF := le;
	END;

	slimmedBocaShell := PROJECT(IF(TurnOffLogging, DATASET([], LNSmallBusiness.BIP_Layouts.Business_Shell_Plus_Scores_Layout), Business_Shell_plus_Scores), slimShell(LEFT));
	
	// In order to TOXML and FROMXML to work correctly for child datasets they must be placed in a wrapper.
	XMLWrapper := RECORD
		DATASET(Risk_Reporting.Layout_Business_Shell) wrapper;
	END;
	
	slimmedWrapped := ROW({slimmedBocaShell}, XMLWrapper);
	
	cleanedXML := '<Row>' + (STRING)TOXML(slimmedWrapped) + '</Row>';
	
	Risk_Reporting.Layouts.LOG_Business_Shell_Record FormatIntermediate() := TRANSFORM
		SELF.transaction_id := ''; // Set by the ESP
		SELF.product_id := Product_ID;
		SELF.date_added := ut.getDate + ut.getTime(); // Current date
		SELF.process_type := (STRING4)Process_Type; //0 = Undetermined, 1 = Request, 2 for Response, 3 = Context, 4 = Internal
		SELF.processing_time := '000.000'; // Set by the ESP
		SELF.source_code := '';
		SELF.content_Type := '';    
		SELF.version := (STRING20)Version;
		SELF.reference_number := '';
		SELF.options.DPPA_Purpose	              := rw_options.DPPA_Purpose;
		SELF.options.GLBA_Purpose	              := rw_options.GLBA_Purpose;
		SELF.options.DataRestrictionMask        := rw_options.DataRestrictionMask;
		SELF.options.DataPermissionMask         := rw_options.DataPermissionMask;
		SELF.options.IndustryClass              := rw_options.IndustryClass;
		SELF.options.LinkSearchLevel            := rw_options.LinkSearchLevel;
		SELF.options.MarketingMode              := rw_options.MarketingMode;
		SELF.options.AllowedSources             := rw_options.AllowedSources;
		SELF.options.OFAC_Version               := rw_options.OFAC_Version;
		SELF.options.Global_Watchlist_Threshold := rw_options.Global_Watchlist_Threshold;
		SELF.options.Watchlists_Requested       := rw_options.Watchlists_Requested;
		SELF.options.Gateways                   := rw_options.Gateways;
		SELF.options.AttributesRequested        := rw_options.AttributesRequested;
		SELF.options.ModelsRequested            := rw_options.ModelsRequested;
		SELF.options.ModelOptions               := rw_options.ModelOptions;
		SELF.content_data := IF(LENGTH(cleanedXML) > 162000, cleanedXML[1..162000], cleanedXML);
		SELF := [];
	END;
	
	logResult := IF(TurnOffLogging, DATASET([], Risk_Reporting.Layouts.LOG_Business_Shell_Record), DATASET([FormatIntermediate ()]));
	
	RETURN DATASET([{logResult}], Risk_Reporting.Layouts.LOG_Business_Shell);
END;