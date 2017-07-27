import iesp, instantid_archiving, Doxie, Gateway, ut, Data_Services;

EXPORT Raw := MODULE
	// ==============================[ Single Search ]==============================	
	// Via DeltaBase
	EXPORT singleSearchViaDeltaBase(IParam.search_params in_mod, STRING search_type = Constants.InstantId, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := Functions.DefineSQLParamsValues(in_mod, search_type);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;
		SelectStmt := 'select DISTINCT i.first_name, i.last_name, ' + 
		              if(search_type = Constants.InputInstantIdIntrnatl, 
										'i.street_number, i.street_name, i.street_type,i.postal_code as postalcode, ', 'i.street,i.zip,') +
										'i.city, i.state,'+
										' i.unique_id as uniqueid, i.query_id as queryid, i.transaction_id, i.date_added '; 		
		FromStmt :=  map(
					//fraudpoint - iid and flexid
					search_type = Constants.FraudPoint => ' from delta_iid.delta_key i join delta_iid.delta_key_model m '+
									' on i.transaction_id = m.transaction_id ',	
					//redflags						
					search_type = Constants.RedFlags => ' from delta_iid.delta_key i join delta_iid.delta_key_redflags r ' + 
									' on i.transaction_id = r.transaction_id ',					
					//iidi	- all
					search_type = Constants.InputInstantIdIntrnatl => ' from delta_iidi.delta_key i ',
					//flexid	- all
					search_type = Constants.Flexid => ' from delta_flexid.delta_key i ',
					//iid	- all
					' from delta_iid.delta_key i ');		
	
		WhereStmt := ' where ' + SQLFieldList;	
		SQLStmt := SelectStmt + FromStmt + WhereStmt;		
		extraFdPtSQLStmt := if(search_type = Constants.FraudPoint, SelectStmt + 
								' from delta_flexid.delta_key i join delta_flexid.delta_key_model m '+
								' on i.transaction_id = m.transaction_id '+ WhereStmt,'');
		//as have to add the fraud point results together for both flexid and instantid
		ds_deltabase_recs := Macros.mac_build_GetAndMassageSoapCall(SQLStmt, SQLValueList, 
					Layouts.single_DB_Response, Layouts.Single_DeNormed_Records, dGateways);
		ds_extra_deltabase_recs := if(search_type = Constants.FraudPoint, Macros.mac_build_GetAndMassageSoapCall(extraFdPtSQLStmt, SQLValueList, 
					Layouts.single_DB_Response, Layouts.Single_DeNormed_Records, dGateways));

		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs + ds_extra_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs;
	END;
	
	EXPORT singleIIDI2SearchViaDeltaBase(IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := Functions.DefineSQLParamsValues2(in_mod);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;
		SelectStmt := 'select DISTINCT i.first_name, i.middle_name, i.last_name, i.full_name, i.maiden_name, i.gender, ' + 
									'i.street_address1, i.street_address2, i.unit_number, i.building_number, i.building_name, i.floor_number, ' +
									'i.street_number, i.street_name, i.street_type, i.suburb, i.district, i.city, i.county, i.state, i.postal_code, ' +
									'i.country, i.phone, i.mobile_phone, i.work_phone, i.dob, i.national_id, i.national_id_city_issued, ' +
									'i.national_id_district_issued, i.national_id_county_issued, i.national_id_province_issued, ' +
									'i.dl_number, i.dl_version_number, i.dl_state, i.dl_expire_date, ' +
									'i.passport_number, i.passport_expire_date, i.passport_place_birth, i.passport_country_birth, i.passport_family_name_birth, ' +
									'i.company_id, i.unique_id as uniqueid, i.query_id as queryid, i.transaction_id, i.date_added ';		
		
		FromStmt :=  'from delta_iidi.delta_key i ';		
	
		WhereStmt := 'where ' + SQLFieldList;	
		SQLStmt := SelectStmt + FromStmt + WhereStmt;	

		ds_deltabase_recs := Macros.mac_build_GetAndMassageIIDI2SoapCall(SQLStmt, SQLValueList, 
					Layouts.single_IIDI2_DB_Response, Layouts.Single_IIDI2_DeNormed_Records, dGateways); 

		ds_db_recs := DEDUP( SORT( ds_deltabase_recs , transactionid, -(INTEGER)date_added ), transactionid );
		
		RETURN ds_db_recs;
	END;

	// Via Autokeys
	EXPORT singleSearchViaAutokeys(IParam.search_params in_mod, STRING search_type = Constants.InstantId) := FUNCTION
		mod_AKIds := AutoKey_IDs(in_mod);	
		ds_single_trans_rec := map(
			search_type = Constants.FraudPoint => 
				JOIN(mod_AKIds.outpl, InstantID_Archiving.Key_Model,
					KEYED(LEFT.transaction_id = RIGHT.transaction_id)
					and (RIGHT.PRODUCT IN [CONSTANTS.FLEXID, CONSTANTS.INSTANTID]),
				TRANSFORM(LEFT), ATMOST(Constants.MAX_COUNT_RECORDS)),
			search_type = Constants.RedFlags => 
				JOIN(mod_AKIds.outpl,	InstantID_Archiving.Key_RedFlags,
						KEYED(LEFT.transaction_id = RIGHT.transaction_id),
					TRANSFORM(LEFT), ATMOST(Constants.MAX_COUNT_RECORDS)),		
				mod_AKIds.outpl);		
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;
	
		// Via IIDI2 Keys
	EXPORT singleSearchViaIIDI2keys(IParam.IIDI2_search_params in_mod) := FUNCTION
		//transaction id, company, product, country, first, last,
		// key :=InstantID_Archiving_v2.keys().build_payload.qa;
		
		//need to add limit or choosen
		ds_single_trans_rec := InstantID_Archiving.Key_Payload(
					transaction_id != '' and 
					trim(UnicodeLib.UnicodeToUpperCase(company_id)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CompanyId)) and
					trim(UnicodeLib.UnicodeToUpperCase(country)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CountryId)) and 
					trim(UnicodeLib.UnicodeToUpperCase(orig_fname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newfirstname)) and 
					trim(UnicodeLib.UnicodeToUpperCase(orig_lname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newlastname)) and 
					product IN [CONSTANTS.InstantIdIntrnatl]);	
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
		// RETURN ds_single_trans_rec;
	END;

	// ==============================[ Single Report ]==============================
	// Via DeltaBase
	EXPORT singleReportViaDeltaBase(IParam.search_params in_mod, STRING search_type = Constants.InstantId, 
					DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := Functions.DefineSQLParamsValues(in_mod, search_type);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;		

		ds_input     := Functions.GetInputDS(in_mod);
		SelectStmt := 'select DISTINCT i.transaction_id as transactionid, i.date_added as date_added, ' + 
			'i.company_id as companyid, i.company_id_source as companyidsource, i.version as espversion, ' + 
			'i.source, trim(substring(trim(r.request_data), 1, 35000)) as requestdata, ' +
			' trim(substring(trim(r.response_data), 1, 161000)) as responsedata, query_id as queryid ';		
		FromStmt :=  map(
				//fraudpoint - iid and flexid
				search_type = Constants.FraudPoint => ' from delta_iid.delta_key i left join delta_iid.delta_report r  '+
									' on i.transaction_id = R.transaction_id join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id ',					
				//redflags						
				search_type = Constants.RedFlags => ' from delta_iid.delta_key i left join delta_iid.delta_report R ' + 
									' on i.transaction_id = R.transaction_id join delta_iid.delta_key_redflags P on I.transaction_id = P.transaction_id ',		
				//iidi				
				search_type = Constants.InputInstantIdIntrnatl => ' from delta_iidi.delta_key i join delta_iidi.delta_report r on i.transaction_id = r.transaction_id ',
				//flexid
				search_type = Constants.Flexid => ' from delta_flexid.delta_key i join delta_flexid.delta_report r on i.transaction_id = r.transaction_id ',
				//iid
				' from delta_iid.delta_key i join delta_iid.delta_report r on i.transaction_id = r.transaction_id ');
		WhereStmt := ' where ' + SQLFieldList;			
		SQLStmt := SelectStmt + FromStmt + WhereStmt;
		extraFdPtSQLStmt := if(search_type = Constants.FraudPoint, SelectStmt + 
								' from delta_flexid.delta_key i left join delta_flexid.delta_report r '+
									' on i.transaction_id = r.transaction_id join delta_flexid.delta_key_model m on i.transaction_id = m.transaction_id  '+ WhereStmt,'');
		ds_deltabase_recs := Macros.mac_build_GetAndMassageSoapCall(SQLStmt, SQLValueList, 
					Layouts.Report_DB_Response, Layouts.Report_DeNormed_Records, dGateways)	;			
		ds_extra_deltabase_recs := if(search_type = Constants.FraudPoint, Macros.mac_build_GetAndMassageSoapCall(extraFdPtSQLStmt, SQLValueList, 
					Layouts.Report_DB_Response, Layouts.Report_DeNormed_Records, dGateways));
		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs + ds_extra_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs; 
	END;	
	
	// Via IIDI2 DeltaBase
	EXPORT singleIIDI2ReportViaDeltaBase(IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := Functions.DefineSQLParamsValues2(in_mod);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;		

		SelectStmt := 'select DISTINCT i.transaction_id as transactionid, i.date_added as date_added, ' + 
			'i.company_id as companyid, i.company_id_source as companyidsource, i.version as espversion, ' + 
			'i.source, trim(substring(trim(r.request_data), 1, 35000)) as requestdata, ' +
			' trim(substring(trim(r.response_data), 1, 161000)) as responsedata, query_id as queryid ';
			
		FromStmt := ' from delta_iidi.delta_key i join delta_iidi.delta_report r on i.transaction_id = r.transaction_id ';

		WhereStmt := ' where ' + SQLFieldList;			
		SQLStmt := SelectStmt + FromStmt + WhereStmt;
		
		ds_deltabase_recs := Macros.mac_build_GetAndMassageIIDI2SoapCall(SQLStmt, SQLValueList, 
					Layouts.Report_DB_Response, Layouts.Report_DeNormed_Records, dGateways)	;			
		
		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs; 
	END;

	// Via Autokeys
	EXPORT singleReportViaAutokeys(IParam.search_params in_mod, STRING search_type = Constants.InstantId) := FUNCTION
		mod_AKIds := AutoKey_IDs(in_mod);			
		ds_single_trans_rec := map(
			search_type = Constants.FraudPoint => 
				JOIN(mod_AKIds.outpl, InstantID_Archiving.Key_Model,
					KEYED(LEFT.transaction_id = RIGHT.transaction_id)
					and (RIGHT.PRODUCT IN [CONSTANTS.FLEXID, CONSTANTS.INSTANTID]),
				TRANSFORM(LEFT), ATMOST(Constants.MAX_COUNT_RECORDS)),
			search_type = Constants.RedFlags => 
				JOIN(mod_AKIds.outpl,	InstantID_Archiving.Key_RedFlags,
						KEYED(LEFT.transaction_id = RIGHT.transaction_id),
					TRANSFORM(LEFT), ATMOST(Constants.MAX_COUNT_RECORDS)),		
				mod_AKIds.outpl);		
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;	
	
	EXPORT singleReportSearchViaIIDI2keys(IParam.IIDI2_search_params in_mod) := FUNCTION
		//transaction id, company, product, country, first, last,
		
		//need to add limit or choosen
		ds_single_trans_rec := InstantID_Archiving.Key_Payload(
					transaction_id != '' and 
					trim(UnicodeLib.UnicodeToUpperCase(company_id)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CompanyId)) and
					trim(UnicodeLib.UnicodeToUpperCase(country)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CountryId))
					and 
					((trim(UnicodeLib.UnicodeToUpperCase(orig_fname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newfirstname)) and 
					trim(UnicodeLib.UnicodeToUpperCase(orig_lname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newlastname)))
					or
					transaction_id = in_mod.transactionid)
					and 
					product IN [CONSTANTS.InstantIdIntrnatl]);	
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;
	
	// ==============================[ Summary Reports ]==============================
	EXPORT summaryRedflagsViaDeltaBase(IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION		
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect := 'select i.transaction_id, i.cvi, r.risk_code ' +
									' from delta_iid.delta_key i ' +
									' join delta_iid.delta_key_redflags r ' + 
											' on i.transaction_id = r.transaction_id' +
											' WHERE '+ SQLFieldList;		
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
					Layouts.Redflags_Response, Layouts.RedFlags_Records, dGateways);	

		RETURN ds_db_results;
	END;

	EXPORT summaryRedflagsViakeys(IParam.summary_params in_mod ) := FUNCTION	
		//join on slimmed down key to match the input criteria	
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		ds_filtered_recs := CHOOSEN(JOIN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate))), InstantID_Archiving.Key_RedFlags,
				keyed(LEFT.transaction_id = RIGHT.transaction_id),
				TRANSFORM( Layouts.RedFlags_Records,
					SELF.Transaction_id := LEFT.Transaction_id,
					//SELF := RIGHT,
					SELF.RISK_CODE := RIGHT.RISK_CODE, 
					SELF := [] //exceptions
				),
				INNER, ATMOST(Constants.Max_RISK_COUNT)),
				Constants.Max_Error_COUNT);
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
				KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product = Constants.InstantId,
				TRANSFORM(Layouts.RedFlags_Records, 
						SELF.Transaction_id := LEFT.Transaction_id,
						SELF.CVI := RIGHT.CVI,
						SELF.RISK_CODE := LEFT.RISK_CODE,
						SELF := []),
				ATMOST(Constants.Max_RECORD_COUNT));		
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);	
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.RedFlags_Records);	
		//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_recs);
		RETURN keyresults;
	END;


	EXPORT summaryNASNAPViaDeltaBase(IParam.summary_params in_mod, 
					DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION	
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect := 'select i.transaction_id, i.nas, i.nap ' + 
		           'from delta_iid.delta_key i ' + 
									 	' WHERE ' + SQLFieldList;
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
					Layouts.NASNAP_Response, Layouts.NASNAP_Records, dGateways);	
		RETURN ds_db_results;
	END;

	EXPORT summaryNASNAPViaAutokeys(IParam.summary_params in_mod) := FUNCTION	
			StartDate := Functions.GetStartDate(in_mod);
			EndDate := Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate)));	
		//join with payload to get the rest of the information	
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantId,
			TRANSFORM(Layouts.NASNAP_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));
		RETURN ds_payload_recs;
	END;
	
	EXPORT summaryFraudPtCVIViaDeltaBase(IParam.summary_params in_mod, string ProductType = Constants.Both
					, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION			
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect_iid := 'select i.transaction_id, i.cvi, mri.risk_code, m.score, m.Score_Type, mri.description ' + 
			' from delta_iid.delta_key i '+
			' left join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id ' + 
			' join delta_iid.delta_key_modelriskindicator mri on i.transaction_id = mri.transaction_id ' +
			' and m.score_id = mri.score_id WHERE ' + SQLFieldList;
		SQLSelect_flexid :=	'select i.transaction_id, i.cvi, mri.risk_code, m.score, m.Score_Type, mri.description ' + 
			' from delta_flexid.delta_key i '+
			' left join delta_flexid.delta_key_model m on i.transaction_id = m.transaction_id ' + 
			' join delta_flexid.delta_key_modelriskindicator mri on i.transaction_id = mri.transaction_id ' +
			' and m.score_id = mri.score_id WHERE ' + SQLFieldList;	
		ds_db_iid := macros.mac_build_GetAndMassageSoapCall(SQLSelect_iid, SQLValueList, 
					Layouts.FraudPt_Response, Layouts.FraudPt_Records, dGateways);	
		ds_db_results_iid := IF(ProductType = Constants.InstantId OR ProductType = Constants.Both, 
														ds_db_iid, 
														DATASET([], Layouts.FraudPt_Records));
		ds_db_flexid := macros.mac_build_GetAndMassageSoapCall(SQLSelect_flexid, SQLValueList, 
					Layouts.FraudPt_Response, Layouts.FraudPt_Records, dGateways);		
		ds_db_results_flexid:= IF(ProductType = Constants.Flexid OR ProductType = Constants.Both, 
														ds_db_flexid, 
														DATASET([], Layouts.FraudPt_Records));
		ds_db_results := ds_db_results_iid + ds_db_results_flexid ;
		RETURN ds_db_results;
	END;
				
	EXPORT summaryFraudPtCVISummaryViakeys(IParam.summary_params in_mod, string Product = Constants.Both) := FUNCTION	
		//determine which product to run for
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		ProductType := MAP(Product = Constants.InstantId => [Constants.InstantId],
										Product = Constants.Flexid => [Constants.Flexid],
										[Constants.InstantId, Constants.Flexid]); //BOTH is default
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product in ProductType AND
				(date_added >= StartDate AND date_added <= EndDate))),
				Constants.Max_Error_COUNT);
		//join with payload to get the rest of the information	
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);	
		ds_model_recs := JOIN(ds_payload_recs, InstantID_Archiving.Key_Model,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id),
			TRANSFORM(Layouts.FraudPt_Records, 
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score := RIGHT.score,
				SELF.score_id := RIGHT.Score_id,
				SELF.Score_Type := RIGHT.Score_Type,
			SELF := LEFT, SELF := []),
			ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_model_recs, InstantID_Archiving.Key_ModelRisk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.score_id) 
			AND RIGHT.Product IN ProductType,
			TRANSFORM(Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.Description,
				SELF := LEFT, 
				SELF := []),
				ATMOST(Constants.Max_RISK_COUNT));//name, score			
	ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.FraudPt_Records);	
		//put error in and format it to be same layout
	keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
	RETURN keyresults;
	END;	
	
	EXPORT summaryFraudPtRptViaDeltaBase(IParam.summary_params in_mod, string ProductType = Constants.Both,
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;	
		
		SQLSelect_iid :=	'select i.transaction_id, mri.risk_code, m.score, m.Score_Type, mri.description '+
			' from delta_iid.delta_key i ' +
			' LEFT join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id '+
			' join delta_iid.delta_key_modelriskindicator mri on m.transaction_id = mri.transaction_id '+
			' and m.score_id = mri.score_id WHERE ' + SQLFieldList;
		SQLSelect_flexid :=	'select i.transaction_id, mri.risk_code, m.score, m.Score_Type, mri.description   '+
			' from delta_flexid.delta_key i ' +
			' LEFT join delta_flexid.delta_key_model m on i.transaction_id = m.transaction_id '+
			' join delta_flexid.delta_key_modelriskindicator mri on m.transaction_id = mri.transaction_id '+
			' and m.score_id = mri.score_id WHERE ' + SQLFieldList;	
		ds_db_iid := macros.mac_build_GetAndMassageSoapCall(SQLSelect_iid, SQLValueList, 
				Layouts.FraudPt_Response, Layouts.FraudPt_Records, dGateways);	
		//only run against Instantid, if fraudpoint ran stand alone or if instantid is running fraud point option
		ds_db_results_iid := IF(ProductType = Constants.InstantId  OR ProductType = Constants.Both, 
													ds_db_iid, 
													DATASET([], Layouts.FraudPt_Records));	
		ds_db_Flexid := macros.mac_build_GetAndMassageSoapCall(SQLSelect_flexid, SQLValueList, 
			Layouts.FraudPt_Response, Layouts.FraudPt_Records, dGateways);			
	//only run against Flexid, if fraudpoint ran stand alone or if instantid is running fraud point option	
		ds_db_results_flexid := IF(ProductType = Constants.Flexid OR ProductType = Constants.Both, 
													ds_db_Flexid, 
													DATASET([], Layouts.FraudPt_Records));				
		ds_db_results := ds_db_results_iid + ds_db_results_flexid;
		
		return ds_db_results;
	END;
	
	EXPORT summaryFraudPtReportViakeys(IParam.summary_params in_mod, string Product = Constants.Both) := FUNCTION	
		//determine wich product to run for
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		ProductType := MAP(Product = Constants.InstantId => [Constants.InstantId],
										Product = Constants.Flexid => [Constants.Flexid],
										[Constants.InstantId,Constants.Flexid]); //BOTH is default
		//join on slimmed down key to match the input criteria									
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product in ProductType AND
				(date_added >= StartDate AND date_added <= EndDate))),
				Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information		
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),//risk_code, name, score
			ATMOST(Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);
	//join those records with the Model to get the score info
		ds_model_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Model,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score := RIGHT.score,
				SELF.score_id := RIGHT.Score_id,
				SELF.Score_Type := RIGHT.Score_Type,
				SELF := LEFT, 
				SELF := []),//risk_code, name
				ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);//name, risk_code				
	//join those records with the Model to get the score info
	ds_payload_risk_recs := JOIN(ds_model_recs, InstantID_Archiving.Key_ModelRisk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.score_id)
				AND RIGHT.Product IN ProductType ,
			TRANSFORM(Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT, 
				SELF := []),//name
				ATMOST(Constants.Max_RISK_COUNT));
		ErrorMe := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.FraudPt_Records);	
		//put error in and format it to be same layout
		resultsMe := if(showError, ErrorMe ,ds_payload_risk_recs);
		RETURN ds_payload_risk_recs;
	END;		
	//revisit below as once we get Value populated in keys and DB.
	EXPORT summaryFraudRiskIndexViaDeltaBase(IParam.summary_params in_mod, string ProductType = Constants.Both, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, mri.value as score, mri.name ' +
			' from delta_iid.delta_key i '+
			' left join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id '+
			'  join delta_iid.delta_key_modelriskindex mri ' +
			' on m.transaction_id = mri.transaction_id and m.score_id = mri.score_id WHERE ' + SQLFieldList;
		ds_db_output := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
						Layouts.FraudPt_Response, Layouts.FraudPt_Records, dGateways);	
		//we only run against Instantid so when instantid has fraud point on as an option or when fraud point stand alone				
		ds_db_results := IF(ProductType = Constants.InstantId OR ProductType = Constants.Both, 
															ds_db_output, 
															DATASET([], Layouts.FraudPt_Records));			
		RETURN ds_db_results;
	END;		
	
	EXPORT summaryFraudPtRiskIndexViakeys(IParam.summary_params in_mod, string ProductType = Constants.Both) := FUNCTION	
			//join on slimmed down key to match the input criteria
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate))),
				Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id)  AND RIGHT.product = Constants.InstantId,
			TRANSFORM(Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));	
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);
	//join those records with the Model to get the score info
		ds_payload_model_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Model,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = Constants.InstantId,
			TRANSFORM(Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score_id := RIGHT.score_id,
				SELF := LEFT, 
				SELF := []),//name
				ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);		
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_model_recs, InstantID_Archiving.Key_RiskIndex,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.Score_id) 
				AND RIGHT.product = Constants.InstantId,
			TRANSFORM(Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.Name := RIGHT.Name,
				SELF.Score := RIGHT.ivalue,
				SELF := LEFT, 
				SELF := []),//name, score	
				ATMOST(Constants.Max_RISK_COUNT));		
		ds_key_results := if(ProductType = Constants.InstantId OR ProductType = Constants.Both, ds_payload_risk_recs, DATASET([], Layouts.FraudPt_Records));	
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.FraudPt_Records);	
		//put error in and format it to be same layout	
		keyresults := if(ProductType = Constants.InstantId OR ProductType = Constants.Both, 
				if(showError, ErrorToShow ,ds_payload_risk_recs),
				DATASET([], Layouts.FraudPt_Records));	
	RETURN keyresults;
	END;			
	
	EXPORT summaryIIDIiviViaDeltaBase(IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION	
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.ivi, r.risk_code, r.description '+
			' from delta_iidi.delta_key i left join delta_iidi.delta_key_riskindicator r '+
			' on i.transaction_id = r.transaction_id where ' + SQLFieldList;	
		//parse out DB data into format we need
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				Layouts.IIDI_RiskInd_Response, Layouts.IIDI_RiskInd_Records, dGateways);
		RETURN ds_db_results;
	END;

	EXPORT summaryIIDI2iviViaDeltaBase(IParam.IIDI2_summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION	
		SQLCriteria := Functions.GetIIDI2SummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.ivi, r.risk_code, r.description '+
			' from delta_iidi.delta_key i left join delta_iidi.delta_key_riskindicator r '+
			' on i.transaction_id = r.transaction_id where ' + SQLFieldList;	
		//parse out DB data into format we need
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				Layouts.IIDI_RiskInd_Response, Layouts.IIDI_RiskInd_Records, dGateways);
		RETURN ds_db_results;
	END;
	
	EXPORT summaryInstantIdInterntlIVIViakeys(IParam.summary_params in_mod) := FUNCTION
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate))),
				Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_RiskInd_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));	
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_RiskInd_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT, 
				SELF := []),//name, score
				ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);		
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.IIDI_RiskInd_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;
	
	EXPORT summaryIIDI2IVIViakeys(IParam.IIDI2_summary_params in_mod) := FUNCTION
		StartDate := Functions.GetIIDI2StartDate(in_mod);
		EndDate := Functions.GetIIDI2EndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate) AND
				country = in_mod.CountryId)),
				Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_RiskInd_Records, self.ivi := (string)right.ivi, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_RiskInd_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT,
				SELF := []),//name, score
				ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.IIDI_RiskInd_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;
	
	EXPORT summaryIIDIVerifiedViaDeltaBase(IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select distinct i.transaction_id, f.name, f.source_Count from delta_iidi.delta_key i ' +
							' join delta_iidi.delta_key_fieldverification f on i.transaction_id = f.transaction_id ' +
							'where ' + SQLFieldList +' and f.source_Count >= 0 ' ;	
		ds_db_results := Macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				Layouts.IIDI_Verified_Response, Layouts.IIDI_Verified_Records, dGateways);		
		RETURN ds_db_results;		
	END;	
	
	EXPORT summaryIIDI2VerifiedViaDeltaBase(IParam.IIDI2_summary_params in_mod,
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := Functions.GetIIDI2SummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select distinct i.transaction_id, f.name, f.source_Count from delta_iidi.delta_key i ' +
							' join delta_iidi.delta_key_fieldverification f on i.transaction_id = f.transaction_id ' +
							'where ' + SQLFieldList +' and f.source_Count >= 0 ' ;	
		ds_db_results := Macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				Layouts.IIDI_Verified_Response, Layouts.IIDI_Verified_Records, dGateways);		
		RETURN ds_db_results;		
	END;
	
	EXPORT summaryIIDIVerifiedViakeys(IParam.summary_params in_mod) := FUNCTION	
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate)));
		//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_Verified_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));
	//join those records with source count
		ds_payload_verified_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Verification,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.source_count >= 0,
			TRANSFORM(Layouts.IIDI_Verified_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.source_count := (string3) RIGHT.source_count,
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
				ATMOST(Constants.Max_RISK_COUNT));
		RETURN ds_payload_verified_recs;
	END;
	
	EXPORT summaryIIDI2VerifiedViakeys(IParam.IIDI2_summary_params in_mod) := FUNCTION	
		StartDate := Functions.GetIIDI2StartDate(in_mod);
		EndDate := Functions.GetIIDI2EndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED(company_id = in_mod.CompanyId AND
							product = Constants.InstantIdIntrnatl AND
						 (date_added >= StartDate AND date_added <= EndDate) AND
							country = in_mod.CountryId));
		//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantIdIntrnatl,
			TRANSFORM(Layouts.IIDI_Verified_Records, SELF := RIGHT, SELF := []),
			ATMOST(Constants.Max_RECORD_COUNT));
	//join those records with source count
		ds_payload_verified_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Verification,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.source_count >= 0,
			TRANSFORM(Layouts.IIDI_Verified_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.source_count := (string3) RIGHT.source_count,
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
				ATMOST(Constants.Max_RISK_COUNT));
		RETURN ds_payload_verified_recs;
	END;
	
	EXPORT summaryFlexidViaDeltaBase(IParam.summary_params in_mod, 
					DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.cvi, i.nas, i.nap, r.risk_code,' +
				' i.first_name_verified, i.last_name_verified, i.state_verified, i.ssn_verified,i.zip_verified, '+
				' i.street_address_verified, i.city_verified, i.dob_verified, i.home_phone_verified, i.dl_verified, r.description ' +
				' from delta_flexid.delta_key i ' +
				' left join delta_flexid.delta_key_riskindicator r on i.transaction_id = r.transaction_id '+
				' where ' + SQLFieldList;
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
			Layouts.FlexID_Response, Layouts.FlexID_cvi_Records, dGateways);	

		RETURN ds_db_results;		
	
	END;
	
	EXPORT summaryFlexIdViakeys(IParam.summary_params in_mod) := FUNCTION	
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
	//join on slimmed down key to match the input criteria		
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = Constants.Flexid AND
				(date_added >= StartDate AND date_added <= EndDate))),
				Constants.Max_Error_COUNT);
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.Flexid,
			TRANSFORM(Layouts.FlexID_cvi_Records, 
				SELF.first_name_verified := RIGHT.fname_verified,
				SELF.last_name_verified := RIGHT.lname_verified,
				SELF.street_address_verified := RIGHT.address_verified,
				SELF.dl_verified := RIGHT.dl_verified,
				SELF := RIGHT,
				SELF := []), //risk_code, exceptions
			ATMOST(Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);
		//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
				KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = Constants.Flexid,
			TRANSFORM(Layouts.FlexID_cvi_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT),//name, score	
				ATMOST(Constants.Max_RISK_COUNT), LEFT OUTER);	
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.FlexID_cvi_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;	

	EXPORT summaryInstantIdViaDeltaBase(IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION			
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;

		SQLSelect :=	'select i.transaction_id, i.cvi, i.nas, i.nap, r.risk_code, i.dob_verified, r.description' + 
			' from delta_iid.delta_key i '+
			' left join delta_iid.delta_key_riskindicator r on '+
			' i.transaction_id = r.transaction_id where ' + SQLFieldList;
	
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
			Layouts.IID_Response, Layouts.IID_Records, dGateways);
		RETURN ds_db_results;		
	
	END;	
	
	EXPORT summaryInstantIdViakeys(IParam.summary_params in_mod) := FUNCTION	
		StartDate := Functions.GetStartDate(in_mod);
		EndDate := Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
					KEYED((company_id = in_mod.CompanyId) AND
					Product = Constants.InstantId AND
					(date_added >= StartDate AND date_added <= EndDate))),
					Constants.Max_Error_COUNT);
			//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
				KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = Constants.InstantId,
				TRANSFORM(Layouts.IID_Records, SELF := RIGHT, SELF := []),
					ATMOST(Constants.Max_RECORD_COUNT));
		//join those records with the Risk key to get the risk_score info
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= Constants.Max_Error_COUNT, true, false);	
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
				KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = Constants.InstantId,
				TRANSFORM(Layouts.IID_Records,
					SELF.Transaction_id := LEFT.Transaction_id,
					SELF.risk_code := RIGHT.risk_code,
					SELF.description := RIGHT.description,
					SELF := LEFT), //name, score	
					LEFT OUTER, atmost(Constants.Max_RISK_COUNT));
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), Layouts.IID_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;

END;
