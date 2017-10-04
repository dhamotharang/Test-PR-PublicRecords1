import iesp, instantid_archiving, Doxie, Gateway, ut, Data_Services;

EXPORT Raw := MODULE
	// ==============================[ Single Search ]==============================	
	// Via DeltaBase
	EXPORT singleSearchViaDeltaBase(InstantID_Archiving_Services.IParam.search_params in_mod, STRING search_type = Constants.InstantId, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := InstantID_Archiving_Services.Functions.DefineSQLParamsValues(in_mod, search_type);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;
		SelectStmt := 'select DISTINCT i.first_name, i.last_name, ' + 
		              if(search_type = InstantID_Archiving_Services.Constants.InputInstantIdIntrnatl, 
										'i.street_number, i.street_name, i.street_type,i.postal_code as postalcode, ', 'i.street,i.zip,') +
										'i.city, i.state,'+
										' i.unique_id as uniqueid, i.query_id as queryid, i.transaction_id, i.date_added '; 		
		FromStmt :=  map(
					//fraudpoint - iid and flexid
					search_type = InstantID_Archiving_Services.Constants.FraudPoint => ' from delta_iid.delta_key i join delta_iid.delta_key_model m '+
									' on i.transaction_id = m.transaction_id ',	
					//redflags						
					search_type = InstantID_Archiving_Services.Constants.RedFlags => ' from delta_iid.delta_key i join delta_iid.delta_key_redflags r ' + 
									' on i.transaction_id = r.transaction_id ',					
					//iidi	- all
					search_type = InstantID_Archiving_Services.Constants.InputInstantIdIntrnatl => ' from delta_iidi.delta_key i ',
					//flexid	- all
					search_type = InstantID_Archiving_Services.Constants.Flexid => ' from delta_flexid.delta_key i ',
					//iid	- all
					' from delta_iid.delta_key i ');		
	
		WhereStmt := ' where ' + SQLFieldList;	
		SQLStmt := SelectStmt + FromStmt + WhereStmt;		
		extraFdPtSQLStmt := if(search_type = InstantID_Archiving_Services.Constants.FraudPoint, SelectStmt + 
								' from delta_flexid.delta_key i join delta_flexid.delta_key_model m '+
								' on i.transaction_id = m.transaction_id '+ WhereStmt,'');
		//as have to add the fraud point results together for both flexid and instantid
		ds_deltabase_recs := InstantID_Archiving_Services.Macros.mac_build_GetAndMassageSoapCall(SQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.single_DB_Response, 
					InstantID_Archiving_Services.Layouts.Single_DeNormed_Records, dGateways);
		ds_extra_deltabase_recs := if(search_type = InstantID_Archiving_Services.Constants.FraudPoint, 
					InstantID_Archiving_Services.Macros.mac_build_GetAndMassageSoapCall(extraFdPtSQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.single_DB_Response, 
					InstantID_Archiving_Services.Layouts.Single_DeNormed_Records, dGateways));

		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs + ds_extra_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs;
	END;
	
	EXPORT singleIIDI2SearchViaDeltaBase(InstantID_Archiving_Services.IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := InstantID_Archiving_Services.Functions.DefineSQLParamsValues2(in_mod);
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

		ds_deltabase_recs := InstantID_Archiving_Services.Macros.mac_build_GetAndMassageIIDI2SoapCall(SQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.single_IIDI2_DB_Response, 
					InstantID_Archiving_Services.Layouts.Single_IIDI2_DeNormed_Records, dGateways); 

		ds_db_recs := DEDUP( SORT( ds_deltabase_recs , transactionid, -(INTEGER)date_added ), transactionid );
		
		RETURN ds_db_recs;
	END;

	// Via Autokeys
	EXPORT singleSearchViaAutokeys(InstantID_Archiving_Services.IParam.search_params in_mod, STRING search_type = InstantID_Archiving_Services.Constants.InstantId) := FUNCTION
		mod_AKIds := AutoKey_IDs(in_mod);	
		ds_single_trans_rec := map(
			search_type = InstantID_Archiving_Services.Constants.FraudPoint => 
				JOIN(mod_AKIds.outpl, InstantID_Archiving.Key_Model,
					KEYED(LEFT.transaction_id = RIGHT.transaction_id)
					and (RIGHT.PRODUCT IN [InstantID_Archiving_Services.CONSTANTS.FLEXID, InstantID_Archiving_Services.CONSTANTS.INSTANTID]),
				TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),
			search_type = InstantID_Archiving_Services.Constants.RedFlags => 
				JOIN(mod_AKIds.outpl,	InstantID_Archiving.Key_RedFlags,
						KEYED(LEFT.transaction_id = RIGHT.transaction_id),
					TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),		
				mod_AKIds.outpl);		
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;

	EXPORT singleSearchViaQueryIdkeys(InstantID_Archiving_Services.IParam.search_params in_mod, STRING search_type = InstantID_Archiving_Services.Constants.InstantId) := FUNCTION
	//This only searches via by QueryId, CompanyId and Product as the hope is all other searches uses fname and lname, which
	//uses autokeys.
	//Citibank wanted to only search via QueryId.
	QryId := trim(in_mod.Queryid, left, right);
	CompId := trim(trim(in_mod.companyId, all), left);
	search_name_type := InstantID_Archiving_Services.Functions.RetrieveProductType(search_type);
	Qry_id_keys := 
	TOPN(InstantID_Archiving.key_queryID(KEYED(query_id = QryId and company_id = CompId and product in search_name_type)), 	
		InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS, Transaction_id,  -(INTEGER)date_added);

	 Qry_payload_all :=
			JOIN(
				Qry_id_keys, InstantID_Archiving.Key_Payload,
				KEYED( LEFT.transaction_id = RIGHT.transaction_id) and
				right.product in search_name_type,
				TRANSFORM(RIGHT),
				INNER,
				ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)
			);
			
		//add on more info if needed
		ds_Qrysingle_trans_rec := map(
			search_type = InstantID_Archiving_Services.Constants.FraudPoint => 
				JOIN(Qry_payload_all, InstantID_Archiving.Key_Model,
					KEYED(LEFT.transaction_id = RIGHT.transaction_id)
					and (RIGHT.PRODUCT IN [InstantID_Archiving_Services.CONSTANTS.FLEXID, 
								InstantID_Archiving_Services.CONSTANTS.INSTANTID]),
				TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),
			search_type = InstantID_Archiving_Services.Constants.RedFlags => 
				JOIN(Qry_payload_all,	InstantID_Archiving.Key_RedFlags,
						KEYED(LEFT.transaction_id = RIGHT.transaction_id),
					TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),		
				Qry_payload_all);		
		ds_single_recs_dpd := DEDUP( SORT( ds_Qrysingle_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		ds_single_recs := project(ds_single_recs_dpd, TRANSFORM(InstantID_Archiving.Layout_Base, SELF := LEFT));
	RETURN ds_single_recs;
	END;
	
		// Via IIDI2 Keys
	EXPORT singleSearchViaIIDI2keys(InstantID_Archiving_Services.IParam.IIDI2_search_params in_mod) := FUNCTION
		//transaction id, company, product, country, first, last,
		// key :=InstantID_Archiving_v2.keys().build_payload.qa;
		
		//need to add limit or choosen
		ds_single_trans_rec := InstantID_Archiving.Key_Payload(
					transaction_id != '' and 
					trim(UnicodeLib.UnicodeToUpperCase(company_id)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CompanyId)) and
					trim(UnicodeLib.UnicodeToUpperCase(country)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.CountryId)) and 
					trim(UnicodeLib.UnicodeToUpperCase(orig_fname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newfirstname)) and 
					trim(UnicodeLib.UnicodeToUpperCase(orig_lname)) = trim(UnicodeLib.UnicodeToUpperCase(in_mod.newlastname)) and 
					product IN [InstantID_Archiving_Services.CONSTANTS.InstantIdIntrnatl]);	
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
 END;

	// ==============================[ Single Report ]==============================
	// Via DeltaBase
	EXPORT singleReportViaDeltaBase(InstantID_Archiving_Services.IParam.search_params in_mod, STRING search_type = InstantID_Archiving_Services.Constants.InstantId, 
					DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams := InstantID_Archiving_Services.Functions.DefineSQLParamsValues(in_mod, search_type);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;		

		ds_input     := InstantID_Archiving_Services.Functions.GetInputDS(in_mod);
		SelectStmt := 'select DISTINCT i.transaction_id as transactionid, i.date_added as date_added, ' + 
			'i.company_id as companyid, i.company_id_source as companyidsource, i.version as espversion, ' + 
			'i.source, trim(substring(trim(r.request_data), 1, 35000)) as requestdata, ' +
			' trim(substring(trim(r.response_data), 1, 161000)) as responsedata, query_id as queryid ';		
		FromStmt :=  map(
				//fraudpoint - iid and flexid
				search_type = InstantID_Archiving_Services.Constants.FraudPoint => ' from delta_iid.delta_key i left join delta_iid.delta_report r  '+
									' on i.transaction_id = R.transaction_id join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id ',					
				//redflags						
				search_type = InstantID_Archiving_Services.Constants.RedFlags => ' from delta_iid.delta_key i left join delta_iid.delta_report R ' + 
									' on i.transaction_id = R.transaction_id join delta_iid.delta_key_redflags P on I.transaction_id = P.transaction_id ',		
				//iidi				
				search_type = InstantID_Archiving_Services.Constants.InputInstantIdIntrnatl => ' from delta_iidi.delta_key i join delta_iidi.delta_report r on i.transaction_id = r.transaction_id ',
				//flexid
				search_type = InstantID_Archiving_Services.Constants.Flexid => ' from delta_flexid.delta_key i join delta_flexid.delta_report r on i.transaction_id = r.transaction_id ',
				//iid
				' from delta_iid.delta_key i join delta_iid.delta_report r on i.transaction_id = r.transaction_id ');
		WhereStmt := ' where ' + SQLFieldList;			
		SQLStmt := SelectStmt + FromStmt + WhereStmt;
		extraFdPtSQLStmt := if(search_type = InstantID_Archiving_Services.Constants.FraudPoint, SelectStmt + 
								' from delta_flexid.delta_key i left join delta_flexid.delta_report r '+
									' on i.transaction_id = r.transaction_id join delta_flexid.delta_key_model m on i.transaction_id = m.transaction_id  '+ WhereStmt,'');
		ds_deltabase_recs := InstantID_Archiving_Services.Macros.mac_build_GetAndMassageSoapCall(SQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.Report_DB_Response, InstantID_Archiving_Services.Layouts.Report_DeNormed_Records, dGateways)	;			
		ds_extra_deltabase_recs := if(search_type = InstantID_Archiving_Services.Constants.FraudPoint, 
					InstantID_Archiving_Services.Macros.mac_build_GetAndMassageSoapCall(extraFdPtSQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.Report_DB_Response, InstantID_Archiving_Services.Layouts.Report_DeNormed_Records, dGateways));
		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs + ds_extra_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs; 
	END;	
	
	// Via IIDI2 DeltaBase
	EXPORT singleIIDI2ReportViaDeltaBase(InstantID_Archiving_Services.IParam.IIDI2_search_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLWhereParams :=InstantID_Archiving_Services.Functions.DefineSQLParamsValues2(in_mod);
		SQLFieldList := SQLWhereParams.SQLWhereCriteria;
		SQLValueList := SQLWhereParams.SQLValues;		

		SelectStmt := 'select DISTINCT i.transaction_id as transactionid, i.date_added as date_added, ' + 
			'i.company_id as companyid, i.company_id_source as companyidsource, i.version as espversion, ' + 
			'i.source, trim(substring(trim(r.request_data), 1, 35000)) as requestdata, ' +
			' trim(substring(trim(r.response_data), 1, 161000)) as responsedata, query_id as queryid ';
			
		FromStmt := ' from delta_iidi.delta_key i join delta_iidi.delta_report r on i.transaction_id = r.transaction_id ';

		WhereStmt := ' where ' + SQLFieldList;			
		SQLStmt := SelectStmt + FromStmt + WhereStmt;
		
		ds_deltabase_recs := InstantID_Archiving_Services.Macros.mac_build_GetAndMassageIIDI2SoapCall(SQLStmt, SQLValueList, 
					InstantID_Archiving_Services.Layouts.Report_DB_Response, 
					InstantID_Archiving_Services.Layouts.Report_DeNormed_Records, dGateways)	;			
		
		ds_db_recs := DEDUP( SORT( (ds_deltabase_recs), transactionid, -(INTEGER)date_added ), transactionid );		
		RETURN ds_db_recs; 
	END;

	// Via Autokeys
	EXPORT singleReportViaAutokeys(InstantID_Archiving_Services.IParam.search_params in_mod, STRING search_type = InstantID_Archiving_Services.Constants.InstantId) := FUNCTION
		mod_AKIds := InstantID_Archiving_Services.AutoKey_IDs(in_mod);			
		ds_single_trans_rec := map(
			search_type = InstantID_Archiving_Services.Constants.FraudPoint => 
				JOIN(mod_AKIds.outpl, InstantID_Archiving.Key_Model,
					KEYED(LEFT.transaction_id = RIGHT.transaction_id)
					and (RIGHT.PRODUCT IN [InstantID_Archiving_Services.CONSTANTS.FLEXID, 
						InstantID_Archiving_Services.CONSTANTS.INSTANTID]),
				TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),
			search_type = InstantID_Archiving_Services.Constants.RedFlags => 
				JOIN(mod_AKIds.outpl,	InstantID_Archiving.Key_RedFlags,
						KEYED(LEFT.transaction_id = RIGHT.transaction_id),
					TRANSFORM(LEFT), ATMOST(InstantID_Archiving_Services.Constants.MAX_COUNT_RECORDS)),		
				mod_AKIds.outpl);		
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;	
	
	EXPORT singleReportSearchViaIIDI2keys(InstantID_Archiving_Services.IParam.IIDI2_search_params in_mod) := FUNCTION
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
					product IN [InstantID_Archiving_Services.CONSTANTS.InstantIdIntrnatl]);	
		ds_single_recs := DEDUP( SORT( ds_single_trans_rec, transaction_id, -(INTEGER)date_added ), transaction_id );
		RETURN ds_single_recs;
	END;
	
	// ==============================[ Summary Reports ]==============================
	EXPORT summaryRedflagsViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION		
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect := 'select i.transaction_id, i.cvi, r.risk_code ' +
									' from delta_iid.delta_key i ' +
									' join delta_iid.delta_key_redflags r ' + 
											' on i.transaction_id = r.transaction_id' +
											' WHERE '+ SQLFieldList;		
		ds_db_results := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
					InstantID_Archiving_Services.Layouts.Redflags_Response, InstantID_Archiving_Services.Layouts.RedFlags_Records, dGateways);	

		RETURN ds_db_results;
	END;

	EXPORT summaryRedflagsViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod ) := FUNCTION	
		//join on slimmed down key to match the input criteria	
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		ds_filtered_recs := CHOOSEN(JOIN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = InstantID_Archiving_Services.Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate))), InstantID_Archiving.Key_RedFlags,
				keyed(LEFT.transaction_id = RIGHT.transaction_id),
				TRANSFORM( InstantID_Archiving_Services.Layouts.RedFlags_Records,
					SELF.Transaction_id := LEFT.Transaction_id,
					//SELF := RIGHT,
					SELF.RISK_CODE := RIGHT.RISK_CODE, 
					SELF := [] //exceptions
				),
				INNER, ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT)),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
				KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product = InstantID_Archiving_Services.Constants.InstantId,
				TRANSFORM(InstantID_Archiving_Services.Layouts.RedFlags_Records, 
						SELF.Transaction_id := LEFT.Transaction_id,
						SELF.CVI := RIGHT.CVI,
						SELF.RISK_CODE := LEFT.RISK_CODE,
						SELF := []),
				ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));		
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);	
		ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.RedFlags_Records);	
		//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_recs);
		RETURN keyresults;
	END;


	EXPORT summaryNASNAPViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
					DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION	
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect := 'select i.transaction_id, i.nas, i.nap ' + 
		           'from delta_iid.delta_key i ' + 
									 	' WHERE ' + SQLFieldList;
		ds_db_results := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
					InstantID_Archiving_Services.Layouts.NASNAP_Response, InstantID_Archiving_Services.Layouts.NASNAP_Records, dGateways);	
		RETURN ds_db_results;
	END;

	EXPORT summaryNASNAPViaAutokeys(InstantID_Archiving_Services.IParam.summary_params in_mod) := FUNCTION	
			StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
			EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = InstantID_Archiving_Services.Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate)));	
		//join with payload to get the rest of the information	
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND 
			RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
			TRANSFORM(InstantID_Archiving_Services.Layouts.NASNAP_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		RETURN ds_payload_recs;
	END;
	
	EXPORT summaryFraudPtCVIViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, string ProductType = InstantID_Archiving_Services.Constants.Both
					, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION			
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
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
		ds_db_iid := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect_iid, SQLValueList, 
					InstantID_Archiving_Services.Layouts.FraudPt_Response, InstantID_Archiving_Services.Layouts.FraudPt_Records, dGateways);	
		ds_db_results_iid := IF(ProductType = InstantID_Archiving_Services.Constants.InstantId OR ProductType = InstantID_Archiving_Services.Constants.Both, 
														ds_db_iid, 
														DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));
		ds_db_flexid := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect_flexid, SQLValueList, 
					InstantID_Archiving_Services.Layouts.FraudPt_Response, InstantID_Archiving_Services.Layouts.FraudPt_Records, dGateways);		
		ds_db_results_flexid:= IF(ProductType = InstantID_Archiving_Services.Constants.Flexid OR ProductType = InstantID_Archiving_Services.Constants.Both, 
														ds_db_flexid, 
														DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));
		ds_db_results := ds_db_results_iid + ds_db_results_flexid ;
		RETURN ds_db_results;
	END;
				
	EXPORT summaryFraudPtCVISummaryViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod, string Product = InstantID_Archiving_Services.Constants.Both) := FUNCTION	
		//determine which product to run for
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		ProductType := MAP(Product = InstantID_Archiving_Services.Constants.InstantId => [InstantID_Archiving_Services.Constants.InstantId],
										Product = InstantID_Archiving_Services.Constants.Flexid => [InstantID_Archiving_Services.Constants.Flexid],
										[InstantID_Archiving_Services.Constants.InstantId, InstantID_Archiving_Services.Constants.Flexid]); //BOTH is default
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product in ProductType AND
				(date_added >= StartDate AND date_added <= EndDate))),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);
		//join with payload to get the rest of the information	
		ds_payload_recs := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);	
		ds_model_recs := JOIN(ds_payload_recs, InstantID_Archiving.Key_Model,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id),
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records, 
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score := RIGHT.score,
				SELF.score_id := RIGHT.Score_id,
				SELF.Score_Type := RIGHT.Score_Type,
			SELF := LEFT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_model_recs, InstantID_Archiving.Key_ModelRisk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.score_id) 
			AND RIGHT.Product IN ProductType,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.Description,
				SELF := LEFT, 
				SELF := []),
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));//name, score			
	ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.FraudPt_Records);	
		//put error in and format it to be same layout
	keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
	RETURN keyresults;
	END;	
	
	EXPORT summaryFraudPtRptViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, string ProductType = InstantID_Archiving_Services.Constants.Both,
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
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
		ds_db_iid := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect_iid, SQLValueList, 
				InstantID_Archiving_Services.Layouts.FraudPt_Response, InstantID_Archiving_Services.Layouts.FraudPt_Records, dGateways);	
		//only run against Instantid, if fraudpoint ran stand alone or if instantid is running fraud point option
		ds_db_results_iid := IF(ProductType = InstantID_Archiving_Services.Constants.InstantId  OR ProductType = InstantID_Archiving_Services.Constants.Both, 
													ds_db_iid, 
													DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));	
		ds_db_Flexid := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect_flexid, SQLValueList, 
			InstantID_Archiving_Services.Layouts.FraudPt_Response, InstantID_Archiving_Services.Layouts.FraudPt_Records, dGateways);			
	//only run against Flexid, if fraudpoint ran stand alone or if instantid is running fraud point option	
		ds_db_results_flexid := IF(ProductType = InstantID_Archiving_Services.Constants.Flexid OR ProductType = InstantID_Archiving_Services.Constants.Both, 
													ds_db_Flexid, 
													DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));				
		ds_db_results := ds_db_results_iid + ds_db_results_flexid;
		
		return ds_db_results;
	END;
	
	EXPORT summaryFraudPtReportViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod, string Product = InstantID_Archiving_Services.Constants.Both) := FUNCTION	
		//determine wich product to run for
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		ProductType := MAP(Product = InstantID_Archiving_Services.Constants.InstantId => [InstantID_Archiving_Services.Constants.InstantId],
										Product = InstantID_Archiving_Services.Constants.Flexid => [InstantID_Archiving_Services.Constants.Flexid],
										[InstantID_Archiving_Services.Constants.InstantId,InstantID_Archiving_Services.Constants.Flexid]); //BOTH is default
		//join on slimmed down key to match the input criteria									
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product in ProductType AND
				(date_added >= StartDate AND date_added <= EndDate))),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information		
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),//risk_code, name, score
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);
	//join those records with the Model to get the score info
		ds_model_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Model,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.Product IN ProductType,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score := RIGHT.score,
				SELF.score_id := RIGHT.Score_id,
				SELF.Score_Type := RIGHT.Score_Type,
				SELF := LEFT, 
				SELF := []),//risk_code, name
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);//name, risk_code				
	//join those records with the Model to get the score info
	ds_payload_risk_recs := JOIN(ds_model_recs, InstantID_Archiving.Key_ModelRisk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.score_id)
				AND RIGHT.Product IN ProductType ,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT, 
				SELF := []),//name
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));
		ErrorMe := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.FraudPt_Records);	
		//put error in and format it to be same layout
		resultsMe := if(showError, ErrorMe ,ds_payload_risk_recs);
		RETURN ds_payload_risk_recs;
	END;		
	//revisit below as once we get Value populated in keys and DB.
	EXPORT summaryFraudRiskIndexViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, string ProductType = InstantID_Archiving_Services.Constants.Both, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, mri.value as score, mri.name ' +
			' from delta_iid.delta_key i '+
			' left join delta_iid.delta_key_model m on i.transaction_id = m.transaction_id '+
			'  join delta_iid.delta_key_modelriskindex mri ' +
			' on m.transaction_id = mri.transaction_id and m.score_id = mri.score_id WHERE ' + SQLFieldList;
		ds_db_output := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
						InstantID_Archiving_Services.Layouts.FraudPt_Response, 
						InstantID_Archiving_Services.Layouts.FraudPt_Records, dGateways);	
		//we only run against Instantid so when instantid has fraud point on as an option or when fraud point stand alone				
		ds_db_results := IF(ProductType = InstantID_Archiving_Services.Constants.InstantId OR ProductType = InstantID_Archiving_Services.Constants.Both, 
															ds_db_output, 
															DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));			
		RETURN ds_db_results;
	END;		
	
	EXPORT summaryFraudPtRiskIndexViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod, string ProductType = InstantID_Archiving_Services.Constants.Both) := FUNCTION	
			//join on slimmed down key to match the input criteria
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = InstantID_Archiving_Services.Constants.InstantId AND
				(date_added >= StartDate AND date_added <= EndDate))),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id)  AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));	
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);
	//join those records with the Model to get the score info
		ds_payload_model_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Model,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.score_id := RIGHT.score_id,
				SELF := LEFT, 
				SELF := []),//name
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);		
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_model_recs, InstantID_Archiving.Key_RiskIndex,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id and LEFT.Score_id = RIGHT.Score_id) 
				AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FraudPt_Records ,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.Name := RIGHT.Name,
				SELF.Score := RIGHT.ivalue,
				SELF := LEFT, 
				SELF := []),//name, score	
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));		
		ds_key_results := if(ProductType = InstantID_Archiving_Services.Constants.InstantId OR 
		ProductType = InstantID_Archiving_Services.Constants.Both, ds_payload_risk_recs, 
			DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));	
		ErrorToShow := Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.FraudPt_Records);	
		//put error in and format it to be same layout	
		keyresults := if(ProductType = InstantID_Archiving_Services.Constants.InstantId OR ProductType = InstantID_Archiving_Services.Constants.Both, 
				if(showError, ErrorToShow ,ds_payload_risk_recs),
				DATASET([], InstantID_Archiving_Services.Layouts.FraudPt_Records));	
	RETURN keyresults;
	END;			
	
	EXPORT summaryIIDIiviViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION	
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.ivi, r.risk_code, r.description '+
			' from delta_iidi.delta_key i left join delta_iidi.delta_key_riskindicator r '+
			' on i.transaction_id = r.transaction_id where ' + SQLFieldList;	
		//parse out DB data into format we need
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Response, InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records, dGateways);
		RETURN ds_db_results;
	END;

	EXPORT summaryIIDI2iviViaDeltaBase(InstantID_Archiving_Services.IParam.IIDI2_summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION	
		SQLCriteria := InstantID_Archiving_Services.Functions.GetIIDI2SummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.ivi, r.risk_code, r.description '+
			' from delta_iidi.delta_key i left join delta_iidi.delta_key_riskindicator r '+
			' on i.transaction_id = r.transaction_id where ' + SQLFieldList;	
		//parse out DB data into format we need
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Response, InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records, dGateways);
		RETURN ds_db_results;
	END;
	
	EXPORT summaryInstantIdInterntlIVIViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod) := FUNCTION
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate))),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));	
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT, 
				SELF := []),//name, score
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);		
		ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;
	
	EXPORT summaryIIDI2IVIViakeys(InstantID_Archiving_Services.IParam.IIDI2_summary_params in_mod) := FUNCTION
		StartDate := InstantID_Archiving_Services.Functions.GetIIDI2StartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetIIDI2EndDate(in_mod);
		//join on slimmed down key to match the input criteria	
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate) AND
				country = in_mod.CountryId)),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);	
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records, self.ivi := (string)right.ivi, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);
	//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT,
				SELF := []),//name, score
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);
		ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.IIDI_RiskInd_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;
	
	EXPORT summaryIIDIVerifiedViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select distinct i.transaction_id, f.name, f.source_Count from delta_iidi.delta_key i ' +
							' join delta_iidi.delta_key_fieldverification f on i.transaction_id = f.transaction_id ' +
							'where ' + SQLFieldList +' and f.source_Count >= 0 ' ;	
		ds_db_results := Macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				InstantID_Archiving_Services.Layouts.IIDI_Verified_Response, InstantID_Archiving_Services.Layouts.IIDI_Verified_Records, dGateways);		
		RETURN ds_db_results;		
	END;	
	
	EXPORT summaryIIDI2VerifiedViaDeltaBase(InstantID_Archiving_Services.IParam.IIDI2_summary_params in_mod,
						DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION		
		SQLCriteria := InstantID_Archiving_Services.Functions.GetIIDI2SummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select distinct i.transaction_id, f.name, f.source_Count from delta_iidi.delta_key i ' +
							' join delta_iidi.delta_key_fieldverification f on i.transaction_id = f.transaction_id ' +
							'where ' + SQLFieldList +' and f.source_Count >= 0 ' ;	
		ds_db_results := Macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
				InstantID_Archiving_Services.Layouts.IIDI_Verified_Response, InstantID_Archiving_Services.Layouts.IIDI_Verified_Records, dGateways);		
		RETURN ds_db_results;		
	END;
	
	EXPORT summaryIIDIVerifiedViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod) := FUNCTION	
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl AND
				(date_added >= StartDate AND date_added <= EndDate)));
		//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_Verified_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
	//join those records with source count
		ds_payload_verified_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Verification,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.source_count >= 0,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_Verified_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.source_count := (string3) RIGHT.source_count,
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));
		RETURN ds_payload_verified_recs;
	END;
	
	EXPORT summaryIIDI2VerifiedViakeys(InstantID_Archiving_Services.IParam.IIDI2_summary_params in_mod) := FUNCTION	
		StartDate := InstantID_Archiving_Services.Functions.GetIIDI2StartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetIIDI2EndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := InstantID_Archiving.Key_DateAdded( 
				KEYED(company_id = in_mod.CompanyId AND
							product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl AND
						 (date_added >= StartDate AND date_added <= EndDate) AND
							country = in_mod.CountryId));
		//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantIdIntrnatl,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_Verified_Records, SELF := RIGHT, SELF := []),
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
	//join those records with source count
		ds_payload_verified_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Verification,
			KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.source_count >= 0,
			TRANSFORM(InstantID_Archiving_Services.Layouts.IIDI_Verified_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.source_count := (string3) RIGHT.source_count,
				SELF := RIGHT,
				SELF := LEFT,
				SELF := []),
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));
		RETURN ds_payload_verified_recs;
	END;
	
	EXPORT summaryFlexidViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
					DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		SQLCriteria := InstantID_Archiving_Services.Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;
		
		SQLSelect :=	'select i.transaction_id, i.cvi, i.nas, i.nap, r.risk_code,' +
				' i.first_name_verified, i.last_name_verified, i.state_verified, i.ssn_verified,i.zip_verified, '+
				' i.street_address_verified, i.city_verified, i.dob_verified, i.home_phone_verified, i.dl_verified, r.description ' +
				' from delta_flexid.delta_key i ' +
				' left join delta_flexid.delta_key_riskindicator r on i.transaction_id = r.transaction_id '+
				' where ' + SQLFieldList;
		ds_db_results := macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
			InstantID_Archiving_Services.Layouts.FlexID_Response, InstantID_Archiving_Services.Layouts.FlexID_cvi_Records, dGateways);	

		RETURN ds_db_results;		
	
	END;
	
	EXPORT summaryFlexIdViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod) := FUNCTION	
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
	//join on slimmed down key to match the input criteria		
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
				KEYED((company_id = in_mod.CompanyId) AND
				Product = InstantID_Archiving_Services.Constants.Flexid AND
				(date_added >= StartDate AND date_added <= EndDate))),
				InstantID_Archiving_Services.Constants.Max_Error_COUNT);
		//join with payload to get the rest of the information
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
			KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.Flexid,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FlexID_cvi_Records, 
				SELF.first_name_verified := RIGHT.fname_verified,
				SELF.last_name_verified := RIGHT.lname_verified,
				SELF.street_address_verified := RIGHT.address_verified,
				SELF.dl_verified := RIGHT.dl_verified,
				SELF := RIGHT,
				SELF := []), //risk_code, exceptions
			ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);
		//join those records with the Risk key to get the risk_score info
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
				KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.Flexid,
			TRANSFORM(InstantID_Archiving_Services.Layouts.FlexID_cvi_Records,
				SELF.Transaction_id := LEFT.Transaction_id,
				SELF.risk_code := RIGHT.risk_code,
				SELF.description := RIGHT.description,
				SELF := LEFT),//name, score	
				ATMOST(InstantID_Archiving_Services.Constants.Max_RISK_COUNT), LEFT OUTER);	
		ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.FlexID_cvi_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;	

	EXPORT summaryInstantIdViaDeltaBase(InstantID_Archiving_Services.IParam.summary_params in_mod, 
						DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION			
		SQLCriteria := Functions.GetSummarySQLFields(in_mod);
		SQLFieldList := SQLCriteria.SQLSummaryFields;
		SQLValueList := SQLCriteria.SQLSummaryValues;

		SQLSelect :=	'select i.transaction_id, i.cvi, i.nas, i.nap, r.risk_code, i.dob_verified, r.description' + 
			' from delta_iid.delta_key i '+
			' left join delta_iid.delta_key_riskindicator r on '+
			' i.transaction_id = r.transaction_id where ' + SQLFieldList;
	
		ds_db_results := InstantID_Archiving_Services.macros.mac_build_GetAndMassageSoapCall(SQLSelect, SQLValueList, 
			InstantID_Archiving_Services.Layouts.IID_Response, InstantID_Archiving_Services.Layouts.IID_Records, dGateways);
		RETURN ds_db_results;		
	
	END;	
	
	EXPORT summaryInstantIdViakeys(InstantID_Archiving_Services.IParam.summary_params in_mod) := FUNCTION	
		StartDate := InstantID_Archiving_Services.Functions.GetStartDate(in_mod);
		EndDate := InstantID_Archiving_Services.Functions.GetEndDate(in_mod);
		//join on slimmed down key to match the input criteria		
		ds_filtered_recs := CHOOSEN(InstantID_Archiving.Key_DateAdded( 
					KEYED((company_id = in_mod.CompanyId) AND
					Product = InstantID_Archiving_Services.Constants.InstantId AND
					(date_added >= StartDate AND date_added <= EndDate))),
					InstantID_Archiving_Services.Constants.Max_Error_COUNT);
			//join with payload to get the rest of the information	
		ds_payload_slimmed := JOIN(ds_filtered_recs, InstantID_Archiving.Key_Payload,
				KEYED(LEFT.transaction_id = RIGHT.transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
				TRANSFORM(InstantID_Archiving_Services.Layouts.IID_Records, SELF := RIGHT, SELF := []),
					ATMOST(InstantID_Archiving_Services.Constants.Max_RECORD_COUNT));
		//join those records with the Risk key to get the risk_score info
		RecCnt := COUNT(ds_filtered_recs);
		showError := if(RecCnt >= InstantID_Archiving_Services.Constants.Max_Error_COUNT, true, false);	
		ds_payload_risk_recs := JOIN(ds_payload_slimmed, InstantID_Archiving.Key_Risk,
				KEYED(LEFT.Transaction_id = RIGHT.Transaction_id) AND RIGHT.product = InstantID_Archiving_Services.Constants.InstantId,
				TRANSFORM(InstantID_Archiving_Services.Layouts.IID_Records,
					SELF.Transaction_id := LEFT.Transaction_id,
					SELF.risk_code := RIGHT.risk_code,
					SELF.description := RIGHT.description,
					SELF := LEFT), //name, score	
					LEFT OUTER, atmost(InstantID_Archiving_Services.Constants.Max_RISK_COUNT));
		ErrorToShow := InstantID_Archiving_Services.Macros.mac_GetDisplayRowErrorsExceptions( Doxie.ErrorCodes(11), InstantID_Archiving_Services.Layouts.IID_Records);	
			//put error in and format it to be same layout
		keyresults := if(showError, ErrorToShow ,ds_payload_risk_recs);
		RETURN keyresults;
	END;

END;
