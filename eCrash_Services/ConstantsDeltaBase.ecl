IMPORT FLAccidents_Ecrash, ut, doxie, lib_stringlib;

//** late fix for bug 128352 highlighted with lines below, two sections ************************************
//** Added the fix for bug 138974

EXPORT ConstantsDeltaBase := MODULE

		EXPORT SELECTSTMT				:=	'SELECT ';
		EXPORT LIMITCLAUSE			:=	' LIMIT 1000 ';
		
		
// ***** Pulling date_added from deltabase for resolving defect 138974		
		EXPORT Join_Columns 		:= 	' k.delta_key_id,k.date_added,k.report_code,k.jurisdiction_state,k.jurisdiction,k.case_identifier,k.state_report_number,' + 
																'k.original_case_ident,k.original_st_rpt_num,k.date_of_loss,k.accident_location_street,k.accident_location_crossstreet,'+ 
																'k.accident_location_nextstreet,k.agency_id,k.agency_ori,k.report_hashkey,k.has_coversheet,k.is_ready_for_public,k.vendor_code,'+
																'k.report_link_id,k.report_type_id,k.contrib_source,k.officer_id,k.vendor_report_id,k.date_report_submitted, p.delta_key_id as pdelta_key_id,p.person_type,p.name_first,p.name_middle,p.name_last,' + 
																// 'p.name_suffix,p.dob,p.driver_license_number,p.address,p.city,p.state,p.zip_code,k.report_id,k.incident_id,k.is_deleted ';
																'p.name_suffix,p.dob,p.driver_license_number,p.address,p.city,p.state,p.zip_code,p.vehicle_unit_number,k.report_id,k.incident_id,k.is_deleted,' +
																// 'v.vin,v.tag_number,v.tag_state'; 
																'v.vin,v.tag_number,v.unit_number'; 
		// EXPORT Join_FROM				:=	' FROM delta_ec.delta_key k, delta_ec.delta_person p';
		// EXPORT Join_WHERE				:=	' WHERE k.delta_key_id = p.delta_key_id ';

		//This is used when we only filter by report fields
		EXPORT Join_FROM :=	' FROM delta_ec.delta_key k ' +
																'LEFT JOIN delta_ec.delta_person AS p use index(p_delta_key_id_idx) ON p.delta_key_id = k.delta_key_id ' + 
																'LEFT JOIN delta_ec.delta_vehicle AS v use index(v_delta_key_id_idx) ON v.delta_key_id = k.delta_key_id ' + 
																//we don't want to join by p.vehicle_unit_number if person record doesn't exist because we still want to return a record with the vehicle data
																//we need "OR v.unit_number IS NULL" because according to the logic that builds payload data if vehicle has empty unit_number - we
																//want to assign that vehicle to ALL of the person records
																'AND (IF (p.delta_key_id IS NULL, TRUE, p.vehicle_unit_number = v.unit_number) OR v.unit_number IS NULL)';

		//This is used when we filter by person and/or vehicle fields and want to also return the non-matching rest of the parties from the reports that
		//have at least one party/vehicle that satisfies that filtering condition
		EXPORT Join_FROM_With_Subqueries :=	' FROM delta_ec.delta_key k :PERSON_SUB :VEHICLE_SUB ';															
		EXPORT Join_FROM_Person_Sub := 'INNER JOIN (SELECT p.* FROM delta_ec.delta_person AS p WHERE :PERSON_WHERE) AS p ON p.delta_key_id = k.delta_key_id ';
		EXPORT Join_FROM_Vehicle_Sub := 'INNER JOIN (SELECT v.* FROM delta_ec.delta_vehicle AS v WHERE :VEHICLE_WHERE) AS v ON v.delta_key_id = k.delta_key_id ';
		EXPORT Join_WHERE				:=	' WHERE ';
		
		SHARED ImageRetrievalSqlSelectFrom :=	'SELECT k.date_added,k.state_report_number,k.original_st_rpt_num,k.case_identifier,k.original_case_ident,' + 
																'k.report_code,k.date_of_loss,k.agency_ori,k.agency_id,k.jurisdiction,k.jurisdiction_state,k.report_id,k.delta_key_id,' + 
																'k.report_hashkey,k.accident_location_street,k.vendor_report_id,k.report_type_id,k.vendor_code,k.page_count, ' + 
																' k.accident_location_crossstreet,p.name_first,p.vehicle_unit_number,p.address,p.person_type,' + 
																' p.name_middle,p.name_last,p.driver_license_number,p.city,p.state,p.zip_code,p.date_added as person_creation_date,' + 
																'v.vin,v.vehicle_year,' + 
																' v.make_description,v.model_description,v.tag_number,k.is_deleted,k.incident_id' +
																' FROM delta_ec.delta_key AS k ';
		SHARED ImageRetrievalSqlJoin := 'LEFT JOIN delta_ec.delta_person AS p use index(p_delta_key_id_idx) ON p.delta_key_id = k.delta_key_id' + 
																' LEFT JOIN delta_ec.delta_vehicle AS v	use index(v_delta_key_id_idx) ON v.delta_key_id = k.delta_key_id AND p.vehicle_unit_number = v.unit_number';														
		
		EXPORT ImageRetrievalSqlByReportId := ImageRetrievalSqlSelectFrom + ' USE INDEX(ix_rid_dadded) ' + ImageRetrievalSqlJoin;
		EXPORT ImageRetrievalSql := ImageRetrievalSqlSelectFrom + ' USE INDEX(ix_caseid_aid_jstate_rcode_dadded_rid) ' + ImageRetrievalSqlJoin;	
		
		EXPORT JoinSetupString	:=	SELECTSTMT + Join_Columns + Join_FROM + Join_WHERE;
		PersonInnerSelect := ' k.delta_key_id IN (SELECT k.delta_key_id ' + Join_FROM_With_Subqueries + 'WHERE ' ;
		EXPORT PersonOuterToInnerSelect := JoinSetupString + PersonInnerSelect;
		
		EXPORT TmImageSql := 'SELECT report_data FROM delta_ec.delta_report_data';
		
		EXPORT Document_Select := 'SELECT document_id AS documentId,jurisdiction AS jurisdiction,jurisdiction_state AS jurisdictionState,' + 
															'case_identifier AS caseIdentifier,state_report_number AS stateReportNumber,date_of_loss AS dateOfLoss,' +
															' hashkey AS hashKey,report_type_id AS reportTypeId,is_deleted AS isDeleted,extension AS extenstion,' + 
															' page_count AS pageCount, date_added AS dateAdded ' +
                              'FROM delta_ec.delta_document WHERE ';		

END;