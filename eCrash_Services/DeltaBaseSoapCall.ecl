IMPORT ut, iesp, Gateway;


//TODO eCrash team is a bit concerned that failures will simply act as though no delta records are found.
// This silent fail could lead to customers simply not trusting the system because they don't get answers.
EXPORT DeltaBaseSoapCall(IParam.searchrecords in_mod) := MODULE

		EXPORT EspServiceName := in_mod.SqlSearchEspNAME;
		EXPORT EspServiceUrl := in_mod.SqlSearchEspURL;
		EXPORT IsSafeToPerformSoap := EspServiceUrl <> '' AND EspServiceName <> '';
		EXPORT eCrashRecordStructure := Layouts.eCrashRecordStructure;

		EXPORT LookupDeltabase(SQLString, Transformer, ResponseLayout) := FUNCTIONMACRO		
			SqlDataset := DATASET([{SQLString}], Layouts.R_DeltaBaseSelectRequest);
			ShouldPerform := SQLString <> '' AND IsSafeToPerformSoap;			
			Incidents := IF(ShouldPerform, 
				Gateway.SoapCall_Deltabase(
					SqlDataset, 
					eCrash_Services.Layouts.R_DeltaBaseSelectRequest, 
					eCrash_Services.Layouts.ResponseLayout
				)
			);
						
			EspRecords := PROJECT(Incidents, ConstantsDeltaBase.Transformer(LEFT));
			
			RETURN EspRecords;
		ENDMACRO;
				
		EXPORT LookupDeltabase_ALias(SQLString_DS, Transformer, ResponseLayout) := FUNCTIONMACRO		
			ShouldPerform := count(SQLString_DS(TRIM(Select) <> '')) > 0 AND IsSafeToPerformSoap;
			Incidents := IF(ShouldPerform, 
			Gateway.SoapCall_Deltabase(
					SQLString_DS, 
					eCrash_Services.Layouts.R_DeltaBaseSelectRequest, 
					eCrash_Services.Layouts.ResponseLayout
				)
			);
						
			EspRecords := PROJECT(Incidents, ConstantsDeltaBase.Transformer(LEFT));

			RETURN EspRecords;
			
		ENDMACRO;
		
		EXPORT LookupIncidentPersons_Alias(Dataset(Layouts.R_DeltaBaseSelectRequest) SQLString_DS) := FUNCTION
			RETURN LookupDeltabase_alias(SQLString_DS, transformDeltaJoinedRecs, DeltaBaseReportResponse);
		END;
		
		EXPORT LookupIncidentPersons(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, transformDeltaJoinedRecs, DeltaBaseReportResponse);
		END;
		
		EXPORT GetImageData(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateImageDataResult, DeltaBaseImageDataResponse);
		END;
		
		EXPORT GetReportData(STRING DeltabaseReportSelectSql) := FUNCTION
			ReportDeltabaseRowRaw := LookupIncidentPersons(DeltabaseReportSelectSql);
			//each report in deltabase has a duplicative report with the case_identifier and state_report_number swapped
			//so here we need to get only one report and that's why we need to filter by l_accnbr here
			AccNbr := ReportDeltabaseRowRaw[1].l_accnbr;
			
			RETURN ReportDeltabaseRowRaw(l_accnbr = AccNbr);
		END;
		
		EXPORT GetAgencyLastReportDate(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateLastUploadDate, DeltaBaseAgencyDataResponse);
		END;
		
		EXPORT GetAgencySubscriptionIncidentIds(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateSubsIncidentData, DeltaBaseSubsIncidentResponse);
		END;
	
		EXPORT GetDocumentData(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateDocumentData, DeltaBaseDocumentResponse);
		END;
		
	END;