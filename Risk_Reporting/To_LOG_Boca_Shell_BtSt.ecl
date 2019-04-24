IMPORT Risk_Indicators, ut;

EXPORT Risk_Reporting.Layouts.LOG_Boca_Shell_BtSt To_LOG_Boca_Shell_BtSt (
																				GROUPED DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) Boca_Shell_BtSt,
																				UNSIGNED2 Product_ID,
																				UNSIGNED5 Version,
																				UNSIGNED1 Process_Type= Risk_Reporting.ProcessType.Internal
																				) := FUNCTION
	// If a company opt's out of logging this will be set to TRUE
	BOOLEAN TurnOffLogging := FALSE : STORED('DisableBocaShellLogging');
	
	Risk_Reporting.Layout_Boca_Shell_BtSt slimShell(Risk_Indicators.Layout_BocaShell_BtSt_Out le) := TRANSFORM
		// To start with the two shells are the same, and in general will always remain the same.
		// Adding the transform just in case the two diverge slightly in the future.
    SELF.bill_to_out.iid.watchlist_fname := (string)le.bill_to_out.iid.watchlist_fname;
    SELF.bill_to_out.iid.watchlist_lname := (string)le.bill_to_out.iid.watchlist_lname;
    SELF.bill_to_out.iid.watchlist_entity_name := (string)le.bill_to_out.iid.watchlist_entity_name;
    SELF.ship_to_out.iid.watchlist_fname := (string)le.ship_to_out.iid.watchlist_fname;
    SELF.ship_to_out.iid.watchlist_lname := (string)le.ship_to_out.iid.watchlist_lname;
    SELF.ship_to_out.iid.watchlist_entity_name := (string)le.ship_to_out.iid.watchlist_entity_name;
    
		SELF := le;
	END;

	slimmedBocaShell := PROJECT(IF(TurnOffLogging, DATASET([], Risk_Indicators.Layout_BocaShell_BtSt_Out), UNGROUP(Boca_Shell_BtSt)), slimShell(LEFT));
	
	// In order to TOXML and FROMXML to work correctly for child datasets they must be placed in a wrapper.
	XMLWrapper := RECORD
		DATASET(Risk_Reporting.Layout_Boca_Shell_BtSt) wrapper;
	END;
	
	slimmedWrapped := ROW({slimmedBocaShell}, XMLWrapper);
	
	cleanedXML := '<Row>' + (STRING)TOXML(slimmedWrapped) + '</Row>';
	
	Risk_Reporting.Layouts.LOG_Boca_Shell_BtSt_Record FormatIntermediate() := TRANSFORM
		SELF.transaction_id := ''; // Set by the ESP
		SELF.product_id := Product_ID;
		SELF.date_added := ut.getDate + ut.getTime(); // Current date
		SELF.process_type := (STRING4)Process_Type; //0 = Undetermined, 1 = Request, 2 for Response, 3 = Context, 4 = Internal
		SELF.processing_time := '000.000'; // Set by the ESP
		SELF.source_code := '';
		SELF.content_Type := '';    
		SELF.version := (STRING20)Version;
		SELF.reference_number := '';

		SELF.content_data := IF(LENGTH(cleanedXML) > 162000, cleanedXML[1..162000], cleanedXML);
		
		SELF := [];
	END;
	
	logResult := IF(TurnOffLogging, DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell_BtSt_Record), DATASET([FormatIntermediate ()]));
	
	RETURN DATASET([{logResult}], Risk_Reporting.Layouts.LOG_Boca_Shell_BtSt);
END;