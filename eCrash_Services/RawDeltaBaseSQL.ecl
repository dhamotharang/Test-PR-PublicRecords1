IMPORT ut, FLAccidents_Ecrash;

EXPORT RawDeltaBaseSQL(IParam.searchrecords in_mod) := MODULE

		EXPORT boolean	hasReportNumberParm 	:= in_mod.reportnumber <> '';
		EXPORT boolean	hasRequestHashKey 		:= in_mod.RequestHashKey;
		EXPORT boolean	hasInputDOL 					:= in_mod.dateOfLoss <> '';
		EXPORT boolean	hasAgencyORI 					:= in_mod.AgencyORI<>'';
		EXPORT string		agencyORISQL 					:= IF(hasAgencyORI,' AND k.agency_ori="'+TRIM(in_mod.AgencyORI)+'"','');
		EXPORT string		imageHashNotNull 			:= ' AND k.report_hashkey is not NULL';
		EXPORT string 	requestedHashKeySQLifParms := IF(hasRequestHashKey,agencyORISQL+imageHashNotNull,'');
		
		EXPORT boolean 	hasFirst 				:= in_mod.firstname<>'';
		EXPORT boolean 	hasLast					:= in_mod.lastname<>'';
		EXPORT boolean	hasOneNameParm 	:= hasFirst OR hasLast;
		EXPORT string 	firstNameSQL 				:= IF(hasFirst,' AND p.name_first="'+TRIM(in_mod.firstname)+'"','');
		EXPORT string 	lastNameSQL 				:= IF(hasLast,' AND p.name_last="'+TRIM(in_mod.lastname)+'"','');
		EXPORT string		fullNameSQLifParms	:= lastNameSQL + firstNameSQL;
		
		// Originally thought isPartial == length(in_mod.reportnumber) = 4, but thinking that isn't right, they can send any size partial match
		EXPORT boolean	obviousPartial				:= length(in_mod.reportnumber) = 4;
		EXPORT string 	caseIdentityExactOrPartialSQL(STRING fpSymbol, STRING fpValue, STRING sqlPCT) := ' AND k.case_identifier'+fpSymbol+'"'+sqlPCT+fpValue+sqlPCT+'"';
		EXPORT string		reportNumberTrimmed 	:= TRIM(in_mod.reportnumber);
		EXPORT string		fuzzyCaseIdentitySQL	:= IF(reportNumberTrimmed <> '',caseIdentityExactOrPartialSQL(' LIKE ',reportNumberTrimmed,'%'),'');
		EXPORT string		exactCaseIdentitySQL	:= caseIdentityExactOrPartialSQL('=',reportNumberTrimmed,'');
															
		EXPORT boolean 	hasJurisdiction 			:= in_mod.Jurisdiction<>'';
		EXPORT boolean 	hasJurisdictionState	:= in_mod.JurisdictionState <> '';
		EXPORT string 	jurisNotNullSQL 			:= ' AND k.jurisdiction is not NULL';
		EXPORT string 	jurisString 					:= ' AND k.jurisdiction="' + TRIM(in_mod.Jurisdiction)+'"';
		EXPORT string 	jurisIfParmSQL 				:= IF(hasJurisdiction,jurisString,'');
		EXPORT string 	jurisStateString 			:= ' AND k.jurisdiction_state="' + TRIM(in_mod.JurisdictionState)+'"';
		EXPORT string 	jurisStateIfParmSQL 	:= IF(hasJurisdictionState,jurisStateString,'');
		EXPORT string 	jurisNotNullIfNoParmSQL := IF(hasJurisdiction,'',jurisNotNullSQL);
		EXPORT string 	jurisAndStateIfParms 	:= jurisIfParmSQL+jurisStateIfParmSQL;
		EXPORT string 	jurisAndStateIfParmsElseNotNull := jurisNotNullIfNoParmSQL+jurisAndStateIfParms;

		EXPORT boolean 	DatesNotEqual(STRING d1, STRING d2) := d1 <> d2;
		EXPORT string 	dateFormatted(STRING dateIn) := dateIn[1..4]+'-'+dateIn[5..6]+'-'+dateIn[7..8];
		EXPORT string 	DOLFormatted := dateFormatted(in_mod.dateofloss);
		EXPORT string 	DOLEqualsSQL(STRING d1) := ' AND date_of_loss="'+d1+'"';
		EXPORT string 	DOLEqualsSQLIfParms := IF(hasInputDOL,DOLEqualsSQL(dateFormatted(in_mod.dateofloss)),'');
		EXPORT string 	DOLBetweenSQL(STRING d1, STRING d2) := ' AND date_of_loss between "'+d1+'" AND "'+d2+'"';
		EXPORT string 	DOLBetweenOrEq2SQL(STRING d1, STRING d2) := DOLBetweenSQL(dateFormatted(d1),dateFormatted(d2));
		EXPORT string 	DOLBetweenOrEqSQL(STRING d1, STRING d2) := 
											IF(DatesNotEqual(d1,d2), DOLBetweenOrEq2SQL(d1,d2), DOLEqualsSQL(dateFormatted(d1)));
		
		EXPORT boolean 	hasCrossStreet 					:= in_mod.AccidentLocationCrossStreet<>'';
		EXPORT boolean 	hasAccidentStreet 			:= in_mod.AccidentLocationStreet<>'';
		EXPORT boolean 	hasOnlyAccidentStreet 	:= hasAccidentStreet and NOT hasCrossStreet;
		EXPORT boolean 	hasOnlyCrossStreet 			:= hasCrossStreet and NOT hasAccidentStreet;
		EXPORT boolean	hasBothStreets					:= hasCrossStreet and hasAccidentStreet;
		EXPORT boolean	hasANYStreet						:= hasCrossStreet OR hasAccidentStreet;
		EXPORT string		regexBothString 				:= ' REGEXP "'+in_mod.AccidentLocationCrossStreet+'|'+in_mod.AccidentLocationStreet+'"';
		EXPORT string		accidentStreet1SQL			:= IF(hasOnlyAccidentStreet,'k.accident_location_street LIKE "%'+in_mod.AccidentLocationStreet+'%"','');
		EXPORT string		accidentStreet2SQL			:= IF(hasOnlyCrossStreet,'k.accident_location_street LIKE "%'+in_mod.AccidentLocationCrossStreet+'%"','');
		EXPORT string		accidentStreet3SQL			:= IF(hasBothStreets,'k.accident_location_street'+regexBothString,'');
		EXPORT string		accidentStreetSQL				:= accidentStreet1SQL+accidentStreet2SQL+accidentStreet3SQL;		
		EXPORT string		crossStreet1SQL					:= IF(hasOnlyAccidentStreet,' OR k.accident_location_crossstreet LIKE "%'+in_mod.AccidentLocationStreet+'%"','');
		EXPORT string		crossStreet2SQL					:= IF(hasOnlyCrossStreet,' OR k.accident_location_crossstreet LIKE "%'+in_mod.AccidentLocationCrossStreet+'%"','');
		EXPORT string		crossStreet3SQL					:= IF(hasBothStreets,' OR k.accident_location_crossstreet'+regexBothString,'');
		EXPORT string		crossStreetSQL					:= crossStreet1SQL+crossStreet2SQL+crossStreet3SQL;		
		EXPORT string		nextStreet1SQL					:= IF(hasOnlyAccidentStreet,' OR k.accident_location_nextstreet LIKE "%'+in_mod.AccidentLocationStreet+'%"','');
		EXPORT string		nextStreet2SQL					:= IF(hasOnlyCrossStreet,' OR k.accident_location_nextstreet LIKE "%'+in_mod.AccidentLocationCrossStreet+'%"','');
		EXPORT string		nextStreet3SQL					:= IF(hasBothStreets,' OR k.accident_location_nextstreet'+regexBothString,'');
		EXPORT string		nextStreetSQL						:= nextStreet1SQL+nextStreet2SQL+nextStreet3SQL;
		EXPORT string		ALLStreetSQL						:= accidentStreetSQL+crossStreetSQL+nextStreetSQL;
		EXPORT string		ANYStreetSQLifParms			:= IF(hasANYStreet,' AND ('+ALLStreetSQL+')','');
		EXPORT string   fNameStateSQL           := jurisStateIfParmSQL + jurisIfParmSQL + firstNameSQL;
		
		EXPORT string   location_search_sql := IF (hasAccidentStreet, ' AND k.accident_location_street LIKE "%'+in_mod.AccidentLocationStreet+'%"', '') + IF (hasCrossStreet, ' AND k.accident_location_crossstreet LIKE "%'+in_mod.AccidentLocationCrossStreet+'%"','');

		//I think the HPCC isPartial filter imitated here with fuzzyCaseIdentitySQL
		EXPORT simplePartialReportNumberWhere := fuzzyCaseIdentitySQL + jurisAndStateIfParmsElseNotNull+ANYStreetSQLifParms;						
		
		shared STRING GetDeltabaseDateAdded() := FUNCTION
			DateAddedRaw := FLAccidents_Ecrash.Key_eCrashV2_DeltaDate(delta_text = 'DELTADATE');
			DateAdded := dateFormatted(
				ut.date_math(DateAddedRaw[1].date_added[1..8], -1)
			);
			RETURN DateAdded;
		END;

		// -------------------------------------------------------------------------------------------------
		EXPORT SQL_LIMIT := ConstantsDeltaBase.LIMITCLAUSE;
		setupSQLSTMT := ConstantsDeltaBase.JoinSetupString;

		// If the whereString was EMPTY - keep the entire SQL String empty.
		EXPORT protectedSQLSetupSTMT(STRING debugName, STRING whereString) := FUNCTION
				boolean whereNotEmpty := whereString<>''; 
				deltabaseDateAdded := ' AND k.date_added > "' + GetDeltabaseDateAdded() + '"'; 
				string finalSQL := IF(whereNotEmpty, setupSQLSTMT + whereString + deltabaseDateAdded + SQL_LIMIT, '');
				// IF(whereNotEmpty,OUTPUT(finalSQL,NAMED('BAPDEBUG_'+debugName)));
				RETURN finalSQL;
		END;

		//Person name lookup has to be a subquery to get incidentIDs with an outer query pulling back all persons for those incidents.
		specialPersonSetupSTMT := ConstantsDeltaBase.PersonOuterToInnerSelect;

		EXPORT protectedPersonSQLSetupSTMT(STRING debugName, STRING whereString) := FUNCTION
				boolean whereNotEmpty := whereString<>'';
				deltabaseDateAdded := ' AND k.date_added > "' + GetDeltabaseDateAdded() + '"';
				string finalSQL := IF(whereNotEmpty, specialPersonSetupSTMT + deltabaseDateAdded + whereString +')' + SQL_LIMIT, '');
				// IF(whereNotEmpty,OUTPUT(finalSQL,NAMED('BAPDEBUG_'+debugName)));
				RETURN finalSQL;
		END;
		// -------------------------------------------------------------------------------------------------
		
		// -------------------------------------------------------------------------------------------------
		EXPORT byReportNumberWhere() := FUNCTION
				string exactReportNumberSQL := exactCaseIdentitySQL + requestedHashKeySQLifParms + jurisAndStateIfParmsElseNotNull;
				boolean shouldPerform := hasReportNumberParm AND NOT obviousPartial;
				// I think if we only get 4 - lets not try an exact lookup, could lead to massive response in error.
				RETURN IF(shouldPerform,exactReportNumberSQL,'');
		END;
		
		EXPORT byReportNumberSQL() := FUNCTION
				RETURN protectedSQLSetupSTMT('byRpNum',byReportNumberWhere());
		END;
		// -------------------------------------------------------------------------------------------------
		//TODO - Records holds this read as higher priority than Partial RPT#/date/locations, keep an eye on testing to see if we should narrow this any
		//TODO   we could also safely add +fuzzyCaseIdentitySQL+jurisAndStateIfParms if we need this to narrow better
		//TODO   *OR* I can remove the existing ANYStreetSQLifParms ... not sure how long that's been there but it hasn't appeared to hurt anything.
		//TODO 7-9-13 ... I think I really need to add fuzzyCaseIdentitySQL here to limit rows returned.
		EXPORT byAutoRecsWhere() := FUNCTION
				RETURN IF(hasOneNameParm, fuzzyCaseIdentitySQL+fullNameSQLifParms+ANYStreetSQLifParms+jurisAndStateIfParmsElseNotNull,'');
		END;
		
		EXPORT byAutoRecsSQL() := FUNCTION
				RETURN protectedPersonSQLSetupSTMT('byAutoRecs',byAutoRecsWhere());
		END;

		// -------------------------------------------------------------------------------------------------
		// Only do DOL exact if they sent in a DOL date
		EXPORT byDOLExactWhere() := FUNCTION
				RETURN IF(hasInputDOL,DOLEqualsSQLIfParms + simplePartialReportNumberWhere,'');
		END;
		
		EXPORT byDOLExactSQL() := FUNCTION
				RETURN protectedSQLSetupSTMT('byDOLExact',byDOLExactWhere());
		END;
		// -------------------------------------------------------------------------------------------------
		
		// -------------------------------------------------------------------------------------------------
		EXPORT byDOLFuzzyWhere(String8 minDate, String8 maxDate) := FUNCTION
				dolBetweenString := DOLBetweenOrEqSQL(minDate,maxDate);
				out := dolBetweenString + simplePartialReportNumberWhere;
				RETURN out;
		END;

		EXPORT byDOLFuzzySQL(String8 minDate, String8 maxDate) := FUNCTION
				RETURN protectedSQLSetupSTMT('byDOLFuzzy',byDOLFuzzyWhere(minDate, maxDate));
		END;
		// -------------------------------------------------------------------------------------------------
		EXPORT byPartialReportNumberWhere(STRING8 minDate, STRING8 maxDate) := FUNCTION
				// a superior stmt if DOL parm is there
				dolEnhancedPartialRptNumWhere := DOLBetweenOrEqSQL(minDate,maxDate)+simplePartialReportNumberWhere;
				string partialReportNumReturnWhere := if(hasInputDOL, dolEnhancedPartialRptNumWhere, simplePartialReportNumberWhere);
				boolean shouldPerform := hasReportNumberParm;		
				RETURN if(shouldPerform, partialReportNumReturnWhere, '');
		END;
		
		EXPORT byPartialReportNumberSQL(STRING8 minDate, STRING8 maxDate) := FUNCTION
				RETURN protectedSQLSetupSTMT('byPrtlRptNum',byPartialReportNumberWhere(minDate, maxDate));
		END;
		// -------------------------------------------------------------------------------------------------
		SHARED STRING GetSqlByWhere(STRING Query, STRING Where) := IF(
			Where = '', '', Query + ' WHERE ' + Where
		);
		
		EXPORT STRING GetImageRetrievalSqlByReportId(STRING ReportId, STRING DateAdded) := 
			GetSqlByWhere(
				ConstantsDeltabase.ImageRetrievalSqlByReportId, 
				'k.report_id = ' + ReportId + ' AND k.date_added > ' + '"' + DateAdded + '"'
			);
		
		EXPORT GetImageRetrievalSql(Layouts.eCrashRecordStructure SearchBy, STRING ReportIdWhere = '', STRING DateAddedIn = '') := FUNCTION
			STRING ReportIdWhereSql := IF(
				ReportIdWhere = '',
				'',
				' AND k.report_id NOT IN (' + ReportIdWhere + ')'
			);
			
			CaseIdentifier := IF(
				TRIM(SearchBy.l_accnbr) = '', 
				'(k.case_identifier IS NULL OR k.case_identifier = "")',
				'k.case_identifier = "' + TRIM(SearchBy.l_accnbr) + '"'
			);	
			
			StateReportNumber := IF(
				TRIM(SearchBy.addl_report_number) = '', 
				'(k.original_st_rpt_num IS NULL OR k.original_st_rpt_num = "")',
				'k.original_st_rpt_num = "' + TRIM(SearchBy.addl_report_number) + '"'
			);	
			
			
			STRING WhereClause := CaseIdentifier + 
					' AND ' + StateReportNumber + 
					' AND k.agency_id = "' + TRIM(SearchBy.jurisdiction_nbr) + 
					'" AND k.jurisdiction_state = "' + TRIM(SearchBy.jurisdiction_state) +
					'" AND k.date_of_loss = "' + dateFormatted(TRIM(SearchBy.accident_date)) + 
     			'" AND k.report_type_id = "' + TRIM(SearchBy.report_type_id) + '"'+ ReportIdWhereSql;

			ResultRaw := GetSqlByWhere(ConstantsDeltabase.ImageRetrievalSql, WhereClause);
			
			DateAdded := IF(DateAddedIn = '', GetDeltabaseDateAdded(), DateAddedIn);
			Result := ResultRaw + ' AND k.date_added > "' + DateAdded + '"' + ConstantsDeltaBase.LIMITCLAUSE;	
			
			RETURN Result; 
		END;
		
		EXPORT GetTmImageSql(SET OF STRING ReportIds) := FUNCTION
			ReportIdsString := fn_CombineWords(ReportIds, ',');
			Where := 'report_id IN (' + ReportIdsString + ') ORDER BY date_added DESC LIMIT 1';
			
			RETURN GetSqlByWhere(ConstantsDeltabase.TmImageSql, Where);
		END;
		
		EXPORT byLocationWhere() := FUNCTION
				RETURN ANYStreetSQLifParms + jurisStateIfParmSQL + jurisIfParmSQL;
		END;
		
		EXPORT byLocationSQL() := FUNCTION
				RETURN protectedSQLSetupSTMT('byLocation',byLocationWhere());
		END;
	
		EXPORT byFirstNameAndStateWhere() := FUNCTION
			  RETURN IF(hasFirst, fNameStateSQL, '');
		END;
		
		EXPORT byFirstNameAndState() := FUNCTION
			  RETURN protectedPersonSQLSetupSTMT('byFnameState',byFirstNameAndStateWhere());    
		END;
		
		EXPORT associatedReportsByReportLinkID(Layouts.recs_with_penalty rec) := FUNCTION
		    sqlWhereString := ' AND k.report_link_id = "' +TRIM(rec.ReportLinkID)+ '" AND k.report_type_id <> "' +TRIM(rec.report_type_id)+ '"';
			  RETURN protectedSQLSetupSTMT('associatedReportsByReportLinkID',sqlWhereString);    
		END;
		
		EXPORT subscriptionWhere() := FUNCTION
				RETURN jurisStateIfParmSQL + jurisIfParmSQL + ' AND k.report_type_id = "A"';
		END;
		
		EXPORT GetSubscriptionSQL(string incidentIdList) := FUNCTION
				RETURN protectedSQLSetupSTMT('subscription',subscriptionWhere() + ' AND k.incident_id IN (' + incidentIdList + ')');
		END;
		
		EXPORT GetSubscriptionIncidentIdSQL(INTEGER limitValue) := FUNCTION
			  return  'SELECT DISTINCT k.incident_id AS incidentId from delta_ec.delta_key k WHERE k.jurisdiction="' + TRIM(in_mod.Jurisdiction)+'"' +  ' AND k.jurisdiction_state="' + TRIM(in_mod.JurisdictionState)+'"' + ' AND k.report_type_id = "A" ORDER BY date_added desc ' + ' limit ' + limitValue;
		END;
		
		EXPORT GetDocumentsByReportIdSQL(STRING ReportId, STRING DateAdded) := FUNCTION
			  RETURN ConstantsDeltaBase.Document_Select + ' report_id IN ( ' + ReportId + ' )  AND date_added > "' + DateAdded + '"' + SQL_LIMIT;
    END;
		
		EXPORT GetDocumentsSQL(FLAccidents_Ecrash.Key_eCrashv2_Supplemental SearchBy, STRING DateAdded) := FUNCTION
		  CaseIdentifier := IF(
				TRIM(SearchBy.accident_nbr) = '', 
				'(case_identifier IS NULL OR case_identifier = "")',
				'case_identifier = "' + TRIM(SearchBy.accident_nbr) + '"'
			);	
			
			StateReportNumber := IF(
				TRIM(SearchBy.addl_report_number) = '', 
				'(state_report_number IS NULL OR state_report_number = "")',
				'state_report_number = "' + TRIM(SearchBy.addl_report_number) + '"'
			);	
			
			
			STRING WhereClause := CaseIdentifier + 
					' AND ' + StateReportNumber + 
					' AND jurisdiction = "' + TRIM(SearchBy.jurisdiction) + 
					'" AND jurisdiction_state = "' + TRIM(SearchBy.jurisdiction_state) +
					'" AND date_of_loss = "' + dateFormatted(TRIM(SearchBy.accident_date)) + '"' +
					' AND date_added > "' + DateAdded + '"';
					
					
			RETURN ConstantsDeltaBase.Document_Select + WhereClause + SQL_LIMIT;
		END;

END;