IMPORT Risk_Indicators, ut, std;

EXPORT Risk_Reporting.Layouts.LOG_Boca_Shell To_LOG_Boca_Shell (
																				GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) Boca_Shell,
																				UNSIGNED2 Product_ID,
																				UNSIGNED5 Version,
																				UNSIGNED1 Process_Type= Risk_Reporting.ProcessType.Internal
																				) := FUNCTION
	// If a company opt's out of logging this will be set to TRUE
	BOOLEAN TurnOffLogging := FALSE : STORED('DisableBocaShellLogging');
	
	Risk_Reporting.Layout_Boca_Shell slimShell(Risk_Indicators.Layout_Boca_Shell le) := TRANSFORM
		// To start with the two shells are the same, and in general will always remain the same.
		// Adding the transform just in case the two diverge slightly in the future.
		SELF.iid.watchlist_fname := (string)le.iid.watchlist_fname;
		SELF.iid.watchlist_lname := (string)le.iid.watchlist_lname;
		SELF.iid.watchlist_entity_name := (string)le.iid.watchlist_entity_name;
    SELF := le;
	END;

	slimmedBocaShell := PROJECT(IF(TurnOffLogging, DATASET([], Risk_Indicators.Layout_Boca_Shell), UNGROUP(Boca_Shell)), slimShell(LEFT));
	
	// In order to TOXML and FROMXML to work correctly for child datasets they must be placed in a wrapper.
	XMLWrapper := RECORD
		DATASET(Risk_Reporting.Layout_Boca_Shell) wrapper;
	END;
	
	slimmedWrapped := ROW({slimmedBocaShell}, XMLWrapper);
	
	cleanedXML := '<Row>' + (STRING)TOXML(slimmedWrapped) + '</Row>';
	
	Risk_Reporting.Layouts.LOG_Boca_Shell_Record FormatIntermediate() := TRANSFORM
		SELF.transaction_id := ''; // Set by the ESP
		SELF.product_id := Product_ID;
		SELF.date_added := (STRING8)Std.Date.Today() + ut.getTime(); // Current date
		SELF.process_type := (STRING4)Process_Type; //0 = Undetermined, 1 = Request, 2 for Response, 3 = Context, 4 = Internal
		SELF.processing_time := '000.000'; // Set by the ESP
		SELF.source_code := '';
		SELF.content_Type := '';    
		SELF.version := (STRING20)Version;
		SELF.reference_number := '';

		SELF.content_data := IF(LENGTH(cleanedXML) > 162000, cleanedXML[1..162000], cleanedXML);
		
		SELF := [];
	END;
	
	logResult := IF(TurnOffLogging, DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell_Record), DATASET([FormatIntermediate ()]));
	
	RETURN DATASET([{logResult}], Risk_Reporting.Layouts.LOG_Boca_Shell);
END;