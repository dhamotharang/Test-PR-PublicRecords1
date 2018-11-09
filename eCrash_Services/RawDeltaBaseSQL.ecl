IMPORT ut, FLAccidents_Ecrash, eCrash_Services;

EXPORT RawDeltaBaseSQL(eCrash_Services.IParam.searchrecords in_mod) := MODULE

		EXPORT boolean	hasReportNumberParm 	:= in_mod.reportnumber <> '';
		EXPORT boolean	hasRequestHashKey 		:= in_mod.RequestHashKey;
		EXPORT boolean	hasInputDOL 					:= in_mod.dateOfLoss <> '';
		
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
		EXPORT string   location_search_sql := IF (hasAccidentStreet, ' AND k.accident_location_street LIKE "%'+in_mod.AccidentLocationStreet+'%"', '') + IF (hasCrossStreet, ' AND k.accident_location_crossstreet LIKE "%'+in_mod.AccidentLocationCrossStreet+'%"','');
		EXPORT boolean 	hasDolStartdate := in_mod.DolStartdate <> '';
		EXPORT boolean 	hasDolEnddate := in_mod.DolEnddate <> '';
		EXPORT boolean 	hasVin := in_mod.VehicleVin <> '';
		EXPORT boolean 	haslicenseNbr := in_mod.driversLicenseNumber <> '';
		EXPORT boolean 	hasTag := in_mod.LicensePlate <> '';
		EXPORT boolean 	hasOfficerBadge := in_mod.OfficerBadgeNumber <> '';
		
		EXPORT boolean isDOLOnly := ((hasDolStartdate AND hasDolEnddate) OR hasInputDOL)
			AND ~hasOneNameParm 
			AND	~hasANYStreet
			AND ~hasReportNumberParm 
			AND ~hasVin
			AND ~haslicenseNbr
			AND ~hasTag
			AND ~hasOfficerBadge;
		
		vinSQL := IF(hasVin, ' AND v.vin = "' + in_mod.VehicleVin + '"', '');
		licenseSQL := IF(haslicenseNbr, ' AND p.driver_license_number = "' + in_mod.driversLicenseNumber + '"', '');
		tagSQL := IF(hasTag, ' AND v.tag_number = "' + in_mod.LicensePlate + '"', '');		
		officerBadgeSQL := IF(hasOfficerBadge, ' AND k.officer_id = "' + in_mod.OfficerBadgeNumber + '"', '');

		
	  shared dataset(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended) GetNormzd_aliasrecs(eCrash_Services.IParam.searchrecords tmod):= FUNCTION
		
			eCrash_Services.layouts.ECrashSearchAgency_alias_extended xform_normalize({tmod.Agencies} R, integer cnt) := TRANSFORM
				
					hasAgencyORI 	  := R.AgencyORI <> '';
					agencyORISQL 		:= IF(hasAgencyORI,' AND k.agency_ori="'+TRIM(R.AgencyORI)+'"','');
					imageHashNotNull := ' AND k.report_hashkey is not NULL';
					hasJurisdiction 	 		:= R.Jurisdiction<>'';
					hasJurisdictionState	:= R.JurisdictionState <> '';
					jurisNotNullSQL				:= ' AND k.jurisdiction is not NULL';
					jurisString						:= ' AND k.jurisdiction="' + TRIM(R.Jurisdiction)+'"';
					jurisIfParmSQL 				:= IF(hasJurisdiction,jurisString,'');
					jurisStateString 			:= ' AND k.jurisdiction_state="' + TRIM(R.JurisdictionState)+'"';
					jurisStateIfParmSQL 	:= IF(hasJurisdictionState,jurisStateString,'');			
					jurisNotNullIfNoParmSQL := IF(hasJurisdiction,'',jurisNotNullSQL);
					jurisAndStateIfParms 	:= jurisIfParmSQL+jurisStateIfParmSQL;
					jurisAndStateIfParmsElseNotNull := jurisNotNullIfNoParmSQL+jurisAndStateIfParms;
					fNameStateSQL           := jurisStateIfParmSQL + jurisIfParmSQL + firstNameSQL;
					
					
					vinLicenseTagOfficerBadgeSQL := vinSQL + licenseSQL + tagSQL + officerBadgeSQL;
					
					
					simplePartialReportNumberWhere := jurisAndStateIfParmsElseNotNull+ANYStreetSQLifParms;						
				
					Self.hasAgencyORI				:= hasAgencyORI; // boolean
					Self.agencyORISQL				:= agencyORISQL; // string					
					Self.imageHashNotNull := imageHashNotNull ;
					Self.requestedHashKeySQLifParms :=  IF(hasRequestHashKey,agencyORISQL+imageHashNotNull,'');
					Self.hasjurisdiction := hasJurisdiction; // boolean
					Self.hasJurisdictionState := hasJurisdictionState; //boolean
					Self.jurisNotNullSQL	:= jurisNotNullSQL; // string
					Self.jurisString			:= jurisString; // string
					Self.jurisIfParmSQL		:= jurisIfParmSQL; // string
					Self.jurisStateString	:= jurisStateString; // string
					Self.jurisStateIfParmSQL	:= jurisStateIfParmSQL; // string
					Self.jurisNotNullIfNoParmSQL := jurisNotNullIfNoParmSQL; // string
					self.jurisAndStateIfParms    := jurisAndStateIfParms; // string
					self.jurisAndStateIfParmsElseNotNull := jurisAndStateIfParmsElseNotNull;  // string
					self.fNameStateSQL		:= fNameStateSQL; // string
					self.vinLicenseTagOfficerBadgeSQL := vinLicenseTagOfficerBadgeSQL; //string
					self.simplePartialReportNumberWhere := simplePartialReportNumberWhere; //string
					self := R;						
			END;
			
			out := NORMALIZE(tmod.Agencies,1,xform_normalize(LEFT,COUNTER));			
			
			RETURN out;					
		END;
				
		EXPORT Normalized_recs := 	GetNormzd_aliasrecs(in_mod);
		
		shared STRING GetDeltabaseDateAdded() := FUNCTION
			DateAddedRaw := FLAccidents_Ecrash.Key_eCrashV2_DeltaDate(delta_text = 'DELTADATE');
			DateAdded := dateFormatted(
				ut.date_math(DateAddedRaw[1].date_added[1..8], -1)
			);
			RETURN DateAdded;
		END;

		// -------------------------------------------------------------------------------------------------
		EXPORT SQL_LIMIT := eCrash_Services.ConstantsDeltaBase.LIMITCLAUSE;
		setupSQLSTMT := eCrash_Services.ConstantsDeltaBase.JoinSetupString;

		// If the whereString was EMPTY - keep the entire SQL String empty.
		EXPORT protectedSQLSetupSTMT(STRING debugName, STRING whereString) := FUNCTION
				boolean whereNotEmpty := whereString<>''; 
				deltabaseDateAdded := ' k.date_added > "' + GetDeltabaseDateAdded() + '"'; 
				string finalSQL := IF(whereNotEmpty, setupSQLSTMT + deltabaseDateAdded + whereString + SQL_LIMIT, '');
				// IF(whereNotEmpty,OUTPUT(finalSQL,NAMED('BAPDEBUG_'+debugName)));
				RETURN finalSQL;
		END;

		//Person name lookup has to be a subquery to get incidentIDs with an outer query pulling back all persons for those incidents.
		specialPersonSetupSTMT := eCrash_Services.ConstantsDeltaBase.PersonOuterToInnerSelect;

		EXPORT protectedPersonSQLSetupSTMT(STRING debugName, STRING whereString) := FUNCTION
				boolean whereNotEmpty := whereString<>'';
				deltabaseDateAdded := ' k.date_added > "' + GetDeltabaseDateAdded() + '"';
				string finalSQL := IF(whereNotEmpty, specialPersonSetupSTMT + deltabaseDateAdded + whereString +')' + SQL_LIMIT, '');
				// IF(whereNotEmpty,OUTPUT(finalSQL,NAMED('BAPDEBUG_'+debugName)));
				RETURN finalSQL;
		END;
		// -------------------------------------------------------------------------------------------------
		
		// -------------------------------------------------------------------------------------------------
		EXPORT byReportNumberWhere(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				string exactReportNumberSQL := exactCaseIdentitySQL 
					+ Rec.requestedHashKeySQLifParms 
					+ Rec.jurisAndStateIfParmsElseNotNull 
					+ Rec.vinLicenseTagOfficerBadgeSQL;
				boolean shouldPerform := hasReportNumberParm AND NOT obviousPartial;
				// I think if we only get 4 - lets not try an exact lookup, could lead to massive response in error.
				RETURN IF(shouldPerform,exactReportNumberSQL,'');
		END;
		
		EXPORT byReportNumberSQL() := FUNCTION
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedPersonSQLSetupSTMT('byRpNum',byReportNumberWhere(R));
				END;				
				return PROJECT(Normalized_recs,XFORM_prj(left));
		END;
		// -------------------------------------------------------------------------------------------------
		//TODO - Records holds this read as higher priority than Partial RPT#/date/locations, keep an eye on testing to see if we should narrow this any
		//TODO   we could also safely add +fuzzyCaseIdentitySQL+jurisAndStateIfParms if we need this to narrow better
		//TODO   *OR* I can remove the existing ANYStreetSQLifParms ... not sure how long that's been there but it hasn't appeared to hurt anything.
		//TODO 7-9-13 ... I think I really need to add fuzzyCaseIdentitySQL here to limit rows returned.
		EXPORT byAutoRecsWhere(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				RETURN IF(
					isDOLOnly, 
					'',
					fullNameSQLifParms
					+ ANYStreetSQLifParms
					+ Rec.jurisAndStateIfParmsElseNotNull
					+ Rec.vinLicenseTagOfficerBadgeSQL
				);
		END;
		
		EXPORT byAutoRecsSQL() := FUNCTION		
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedPersonSQLSetupSTMT('byAutoRecs',byAutoRecsWhere(R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));	
				
		END;
		
		EXPORT byDOLExactWhere(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				RETURN IF(hasInputDOL,DOLEqualsSQLIfParms + Rec.simplePartialReportNumberWhere,'');
		END;
		
		EXPORT byDOLExactSQL() := FUNCTION
					
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedSQLSetupSTMT('byDOLExact',byDOLExactWhere(R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));	
				
		END;
				
		// -------------------------------------------------------------------------------------------------
		EXPORT byDOLFuzzyWhere(String8 minDate, String8 maxDate,eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				dolBetweenString := DOLBetweenOrEqSQL(minDate,maxDate);
				out := dolBetweenString + Rec.simplePartialReportNumberWhere;
				RETURN out;
		END;

		EXPORT byDOLFuzzySQL(String8 minDate, String8 maxDate) := FUNCTION
								
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedSQLSetupSTMT('byDOLFuzzy',byDOLFuzzyWhere(minDate,maxDate,R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));	
		END;
		
		
				
		// -------------------------------------------------------------------------------------------------
		EXPORT byPartialReportNumberWhere(STRING8 minDate, STRING8 maxDate,eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				// a superior stmt if DOL parm is there
				dolEnhancedPartialRptNumWhere := DOLBetweenOrEqSQL(minDate,maxDate)+ Rec.simplePartialReportNumberWhere;
				string partialReportNumReturnWhere := if(hasInputDOL, dolEnhancedPartialRptNumWhere, Rec.simplePartialReportNumberWhere);
				boolean shouldPerform := hasReportNumberParm;		
				RETURN if(shouldPerform, partialReportNumReturnWhere, '');
		END;
		
		EXPORT byPartialReportNumberSQL(STRING8 minDate, STRING8 maxDate) := FUNCTION
								
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedSQLSetupSTMT('byPrtlRptNum',byPartialReportNumberWhere(minDate, maxDate, R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));			
				
		END;
		
		// -------------------------------------------------------------------------------------------------
		SHARED STRING GetSqlByWhere(STRING Query, STRING Where) := IF(
			Where = '', '', Query + ' WHERE ' + Where
		);
		
		EXPORT STRING GetImageRetrievalSqlByReportId(STRING ReportId, STRING DateAdded) := 
			IF(
				TRIM(ReportId) != '' AND TRIM(DateAdded) != '',
				GetSqlByWhere(
					eCrash_Services.ConstantsDeltabase.ImageRetrievalSqlByReportId, 
					'k.report_id = ' + ReportId + ' AND k.date_added > ' + '"' + DateAdded + '"'
				),
				''
			);	
		
		EXPORT GetImageRetrievalSql(eCrash_Services.Layouts.eCrashRecordStructure SearchBy, STRING ReportIdWhere = '', STRING DateAddedIn = '') := FUNCTION
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

			ResultRaw := GetSqlByWhere(eCrash_Services.ConstantsDeltabase.ImageRetrievalSql, WhereClause);
			
			DateAdded := IF(DateAddedIn = '', GetDeltabaseDateAdded(), DateAddedIn);
			Result := ResultRaw + ' AND k.date_added > "' + DateAdded + '"' + eCrash_Services.ConstantsDeltaBase.LIMITCLAUSE;	
				
			RETURN Result; 
		END;
		
		
		EXPORT GetTmImageSql(SET OF STRING ReportIds) := FUNCTION
			ReportIdsString := fn_CombineWords(ReportIds, ',');
			Where := IF(
				TRIM(ReportIdsString) = '',
				'',
				'report_id IN (' + ReportIdsString + ') ORDER BY date_added DESC LIMIT 1'
			);
			
			RETURN GetSqlByWhere(eCrash_Services.ConstantsDeltabase.TmImageSql, Where);
		END;
	
		EXPORT byLocationWhere(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
				RETURN ANYStreetSQLifParms + Rec.jurisStateIfParmSQL + Rec.jurisIfParmSQL + Rec.vinLicenseTagOfficerBadgeSQL;
		END;
		
		EXPORT byLocationSQL() := FUNCTION
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedPersonSQLSetupSTMT('byLocation',byLocationWhere(R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));		
		END;		
		
		
	
		EXPORT byFirstNameAndStateWhere(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended Rec) := FUNCTION
			  RETURN IF(hasFirst, Rec.fNameStateSQL + Rec.vinLicenseTagOfficerBadgeSQL, '');
		END;
		
		EXPORT byFirstNameAndState() := FUNCTION
				eCrash_Services.Layouts.R_DeltaBaseSelectRequest xform_prj(eCrash_Services.Layouts.ECrashSearchAgency_alias_extended R) := TRANSFORM
					Self.Select := protectedPersonSQLSetupSTMT('byFnameState',byFirstNameAndStateWhere(R));
				END;
				RETURN PROJECT(Normalized_recs,XFORM_prj(left));		
		END;
	
		EXPORT associatedReportsByReportLinkID(eCrash_Services.Layouts.recs_with_penalty rec) := FUNCTION
		    sqlWhereString := ' AND k.report_link_id = "' +TRIM(rec.ReportLinkID)+ '" AND k.report_type_id <> "' +TRIM(rec.report_type_id)+ '"';
			  RETURN protectedSQLSetupSTMT('associatedReportsByReportLinkID',sqlWhereString);    
		END;
		
		
		EXPORT subscriptionWhere() := FUNCTION
				Primary_rec := Normalized_recs(PrimaryAgency = true);				
				RETURN Primary_rec[1].jurisStateIfParmSQL + Primary_rec[1].jurisIfParmSQL + ' AND k.report_type_id = "A"';	
		END;
		
		EXPORT GetSubscriptionSQL(string incidentIdList) := FUNCTION				
				RETURN protectedSQLSetupSTMT('subscription',subscriptionWhere() + ' AND k.incident_id IN (' + incidentIdList + ')');
		END;
		
		EXPORT GetSubscriptionIncidentIdSQL(INTEGER limitValue) := FUNCTION
				//return  'SELECT DISTINCT k.incident_id AS incidentId from delta_ec.delta_key k WHERE k.jurisdiction="' + TRIM(in_mod.Jurisdiction)+'"' +  ' AND k.jurisdiction_state="' + TRIM(in_mod.JurisdictionState)+'"' + ' AND k.report_type_id = "A" ORDER BY date_added desc ' + ' limit ' + limitValue;
				Primary_rec := Normalized_recs(PrimaryAgency = true);		
				return  'SELECT DISTINCT k.incident_id AS incidentId from delta_ec.delta_key k WHERE k.jurisdiction="' + TRIM(Primary_rec[1].Jurisdiction)+'"' +  ' AND k.jurisdiction_state="' + TRIM(Primary_rec[1].JurisdictionState)+'"' + ' AND k.report_type_id = "A" ORDER BY date_added desc ' + ' limit ' + limitValue;
		END;
	
		EXPORT GetDocumentsByReportIdSQL(STRING ReportId, STRING DateAdded) := FUNCTION
			  RETURN eCrash_Services.ConstantsDeltaBase.Document_Select + ' report_id IN ( ' + ReportId + ' )  AND date_added > "' + DateAdded + '"' + SQL_LIMIT;
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
					
					
			RETURN eCrash_Services.ConstantsDeltaBase.Document_Select + WhereClause + SQL_LIMIT;
		END;

END;