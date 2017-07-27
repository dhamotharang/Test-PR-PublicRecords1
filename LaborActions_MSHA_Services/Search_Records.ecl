IMPORT AutoStandardI, ut, iesp, LaborActions_MSHA;

EXPORT Search_Records := MODULE

	EXPORT getContractorRecs(DATASET(Layouts.rawrec) contRecs) := FUNCTION
			
			// Project input contRecs into contractor record layout.
			contractors := PROJECT(contRecs,TRANSFORM(Layouts.contractorRec,
																			SELF.contractorName :=LEFT.contractor_name,
																			SELF.contractorId := LEFT.contractor_id,
																			SELF.mineId := LEFT.mine_id,
																			SELF.totalAccidents := 0,
																			SELF.totalViolations := 0,
																			SELF.penalt := LEFT.contractor_penalt,
																			SELF := []));
			
			// Pull the events for the contractor for each mine.														
			contractor_events := JOIN(contractors,LaborActions_MSHA.key_ContractorId_Events,
												KEYED(LEFT.contractorId = RIGHT.contractor_id) AND
												LEFT.mineId = RIGHT.mine_id,
												TRANSFORM(RIGHT),
												LIMIT(ut.limits.default,SKIP));
				
			// Only keep events that are violations; they contain a violation_no.
			contractor_events_grp := GROUP(SORT(contractor_events(violation_no != ''),contractor_id,section_of_act,mine_id,RECORD),contractor_id,section_of_act,mine_id);
			
			Layouts.violations roll_violations(recordof(contractor_events_grp) l, dataset(recordof(contractor_events_grp)) allRows) := TRANSFORM
				SELF.section := l.section_of_act;
				SELF.contractorId := l.contractor_id;
				SELF.mineId := l.mine_id;
				SELF.NumberIncidents := COUNT(allRows);
			END;
			
			contractor_viol_roll := ROLLUP(contractor_events_grp,GROUP,roll_violations(LEFT, ROWS(LEFT)));
			
			Layouts.contractorRec Denorm_Violations(Layouts.contractorRec l, DATASET(Layouts.violations) allRows) := TRANSFORM
					SELF.contractorName := l.contractorName;
					SELF.contractorId := l.contractorId;
					SELF.violation := PROJECT(allRows,TRANSFORM(layouts.violations,SELF := LEFT));
					SELF.totalViolations := SUM(allRows,allRows.NumberIncidents);
					SELF := l;
			END;
			
			// Add violation records to contractors recs.
			contractor_Viol := DENORMALIZE(contractors,contractor_viol_roll,
																			LEFT.contractorId = RIGHT.contractorId AND
																			LEFT.mineId = RIGHT.mineId,
																			GROUP,
																			Denorm_violations(LEFT,ROWS(RIGHT)));
			
			// Get accident info for the contractor at each mine									
			contractor_accidents := JOIN(contractors,LaborActions_MSHA.key_ContractorId_Accident,
												KEYED(LEFT.contractorId = RIGHT.contractor_id) AND
												LEFT.mineId = RIGHT.mine_id,
												TRANSFORM(RIGHT),
												LIMIT(ut.limits.default,SKIP));
												
			contractor_acc_grp := GROUP(SORT(contractor_accidents,contractor_id,accident_classification_description,mine_id,RECORD),contractor_id,accident_classification_description,mine_id);
			
			Layouts.accidents roll_accidents(recordof(contractor_acc_grp) l, dataset(recordof(contractor_acc_grp)) allRows) := TRANSFORM
				SELF.Description := l.accident_classification_description;
				SELF.contractorId := l.contractor_id;
				SELF.mineId := l.mine_id;
				SELF.NumberIncidents := COUNT(allRows);
			END;
			
			contractor_acc_roll := ROLLUP(contractor_acc_grp,GROUP,roll_accidents(LEFT, ROWS(LEFT)));
						
			Layouts.contractorRec Denorm_Accidents(Layouts.contractorRec l, DATASET(Layouts.accidents) allRows) := TRANSFORM
					SELF.contractorName := l.contractorName;
					SELF.contractorId := l.contractorId;
					SELF.totalViolations := l.totalViolations;
					SELF.violation := l.violation;
					SELF.totalAccidents := SUM(allRows,allRows.NumberIncidents);
					SELF.accident := PROJECT(allRows,TRANSFORM(layouts.accidents,SELF := LEFT));
					SELF := l;
			END;
			
			// Add accident records to the contractor recs.
			contractor_ViolAcc := DENORMALIZE(contractor_Viol,contractor_acc_roll,
																			LEFT.contractorId = RIGHT.contractorId AND
																			LEFT.mineId = RIGHT.mineId,
																			GROUP,
																			Denorm_accidents(LEFT,ROWS(RIGHT)));
			
			// Only keep contractors that have a violation or an accident
			contractor_WithViolAcc := contractor_ViolAcc(totalaccidents >= 1 or totalviolations >= 1);
			
			return(contractor_WithViolAcc);
			
	END;
	
	EXPORT getMineRecords(DATASET(Layouts.rawrec) recs, IParam.searchrecords in_mod) := FUNCTION
			
			Layouts.baseMineRec xform_mineRec(Layouts.rawrec l, recordof(LaborActions_MSHA.key_MineId_Mine) r) := TRANSFORM
					SELF.mineName := l.mine_name;
					SELF.mineId := l.mine_id;
					SELF.mine_penalt := l.mine_penalt;
					SELF.coalMetal := r.coal_or_metal_mine;
					SELF.mineType := r.mine_type;
					SELF.status := r.mine_status;
					SELF.statusDate := r.mine_status_date;
					SELF.county := r.county;
					SELF.state := r.mine_state;
					SELF.beginDate := r.begin_date;
					SELF.sicCode := r.sic;
					SELF.sicDescription := r.sic_description;
					SELF.controllerName := r.controller_name;
					SELF.controllerCompanyName := r.controller_name_business;
					SELF.controllerLastName := r.controller_name_cln_lname;
					SELF.controllerFirstName := r.controller_name_cln_fname;
					SELF.operatorCompanyName := r.operator_name_business;
					SELF.operatorName := r.operator_name;
					SELF.operatorLastName := r.operator_name_cln_lname;
					SELF.operatorFirstName := r.operator_name_cln_fname;
					SELF.oper_penalt := l.Operator_penalt;
					SELF.controller_penalt := l.controller_penalt;
					SELF := [];
			END;
			
			// Get the full mine information
			mine_recs := GROUP(JOIN(recs,LaborActions_MSHA.key_MineId_Mine,
												KEYED(LEFT.mine_id = RIGHT.mine_id),
												xform_mineRec(LEFT,RIGHT),
												LIMIT(ut.limits.default,SKIP)),mineId);
			
			// Filter by input date range if it was supplied
			ds_filt := mine_recs(ut.isInRange(beginDate,in_mod.InspectionStartDate,in_mod.InspectionEndDate));
			
      mine_recs_filt := if(in_mod.InspectionStartDate != '' or in_mod.InspectionEndDate != '',ds_filt,mine_recs);

			// There can be multiple operators or controllers for a mine, when this occurs there are multiple 
			// mine records from the join against key key_MineId_Mine. Create a child dataset for the unique
			// operator and controller. The dedup/sort is needed since the same operator or controller name can be repeated.
			Layouts.mineRec roll_mines(Layouts.baseMineRec l, dataset(Layouts.baseMineRec) allRows) := TRANSFORM
					SELF.controller := PROJECT(DEDUP(SORT(allRows,controllerName),controllerName),TRANSFORM(Layouts.Names,SELF.companyName := LEFT.controllerCompanyName,
																																																								SELF.lastName := LEFT.controllerLastName,
																																																								SELF.firstName := LEFT.controllerFirstName,
																																																								SELF.penalt := LEFT.controller_penalt,
																																																								SELF := LEFT));
					SELF.operator := PROJECT(DEDUP(SORT(allRows,operatorName),operatorName),TRANSFORM(Layouts.Names,SELF.companyName := LEFT.operatorCompanyName,
																																																					SELF.lastName := LEFT.operatorLastName,
																																																					SELF.firstName := LEFT.operatorFirstName,
																																																					SELF.penalt := LEFT.oper_penalt,
																																																					SELF := LEFT));
					SELF.oper_penalt := MIN(SELF.operator,penalt);
					SELF.controller_penalt := MIN(SELF.controller,penalt);
					SELF := l;
					SELF := [];
			END;

			mine_operCont := ROLLUP(mine_recs_filt,GROUP,roll_mines(LEFT, ROWS(LEFT)));

			// Only get mine violation/accident info for name matches on the mine name, operator name or
			// controller name. If a mine was for a contractor name match, we don't want the accident and 
			// violation info for the mine.
			
			mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
			unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		
			mine_slim := mine_operCont(MIN(mine_penalt,controller_penalt,oper_penalt) <= pthreshold_translated);
			
			// Get all of the mine events, which contain violations
			mine_events := JOIN(mine_slim,LaborActions_MSHA.key_MineId_Events,
												KEYED(LEFT.mineId = RIGHT.mine_id) AND
												RIGHT.violation_no != '',
												TRANSFORM(RIGHT),
												LIMIT(ut.limits.default,SKIP));
			
			mine_viol_grp := GROUP(SORT(mine_events,mine_id,section_of_act,RECORD),mine_id,section_of_act);
			
			Layouts.violations roll_violations(recordof(mine_viol_grp) l, dataset(recordof(mine_viol_grp)) allRows) := TRANSFORM
				SELF.section := l.section_of_act;
				SELF.contractorId := ''; //Not needed for mine rec
				SELF.mineId := l.mine_id;
				SELF.NumberIncidents := COUNT(allRows);
			END;

			mine_viol_roll := ROLLUP(mine_viol_grp,GROUP,roll_violations(LEFT, ROWS(LEFT)));
			
			Layouts.mineRec Denorm_Violations(Layouts.mineRec l, DATASET(Layouts.violations) allRows) := TRANSFORM
					SELF.violation := PROJECT(allRows,TRANSFORM(layouts.violations,SELF := LEFT));
					SELF.totalViolations := SUM(allRows,allRows.NumberIncidents);
					SELF := l;
			END;
			
			// Add violations as child datasets to mine records.
			mine_WithViol := DENORMALIZE(mine_operCont,mine_viol_roll,
																			LEFT.mineId = RIGHT.mineId,
																			GROUP,
																			Denorm_violations(LEFT,ROWS(RIGHT)));
			
			// Get accident records for the mine.
			mine_accidents := JOIN(mine_slim,LaborActions_MSHA.key_MineId_Accident,
												KEYED(LEFT.mineId = RIGHT.mine_id),
												TRANSFORM(RIGHT),
												LIMIT(ut.limits.default,SKIP));
			
			mine_acc_grp := GROUP(SORT(mine_accidents,accident_classification_description,RECORD),accident_classification_description);
			
			Layouts.accidents roll_accidents(recordof(mine_acc_grp) l, dataset(recordof(mine_acc_grp)) allRows) := TRANSFORM
				SELF.Description := l.accident_classification_description;
				SELF.contractorId := ''; // Not needed for mine rec
				SELF.mineId := l.mine_id;
				SELF.NumberIncidents := COUNT(allRows);
			END;
			
			mine_acc_roll := ROLLUP(mine_acc_grp,GROUP,roll_accidents(LEFT, ROWS(LEFT)));
			
			Layouts.mineRec Denorm_Accidents(Layouts.mineRec l, DATASET(Layouts.accidents) allRows) := TRANSFORM
					SELF.totalAccidents := SUM(allRows,allRows.NumberIncidents);
					SELF.accident := PROJECT(allRows,TRANSFORM(layouts.accidents,SELF := LEFT));
					SELF := l;
			END;
			
			// Add accident records as child datatest to the mine.
			mine_WithViolAcc := DENORMALIZE(mine_WithViol,mine_acc_roll,
																			LEFT.mineId = RIGHT.mineId,
																			GROUP,
																			Denorm_accidents(LEFT,ROWS(RIGHT)));

		  return(mine_WithViolAcc);
			
	END;
	
	EXPORT getFormatedRecords(DATASET(Layouts.mineRec) mines):= FUNCTION
		 
		//Sort Recs on penalty, use the lowest value from each penalty to sort on.
		
		mines_sort := SORT(mines,MIN(mine_penalt,oper_penalt,controller_penalt,contractor_penalt),mineName,RECORD);
							
		mines_iesp := PROJECT(mines_sort,TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHARecord,
																				SELF.MineName := LEFT.mineName;
																				SELF.coalOrMetal := LEFT.coalMetal;
																				SELF.MineType := LEFT.mineType;
																				SELF.MineStatus := LEFT.status;
																				SELF.StatusDate := iesp.ECL2ESP.toDatestring8(LEFT.statusDate);
																				SELF.County := LEFT.county;
																				SELF.State := LEFT.state;
																				SELF.BeginDate := iesp.ECL2ESP.toDatestring8(LEFT.beginDate);
																				SELF.SicCode := LEFT.sicCode;
																				SELF.sicDescription := LEFT.sicDescription;
																				SELF.TotalNumberOfAccidents := LEFT.totalAccidents;
																				SELF.Accidents := PROJECT(CHOOSEN(LEFT.accident,iesp.Constants.LABOR_ACTION_MSHA.MaxAccidents),TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHA_Accident,
																																													SELF.Description := LEFT.Description,
																																													SELF.NumberOfAccidents := LEFT.NumberIncidents));
																				SELF.TotalNumberOfViolations := LEFT.totalViolations;
																				SELF.Violations := PROJECT(CHOOSEN(LEFT.violation,iesp.Constants.LABOR_ACTION_MSHA.MaxViolations),TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHA_Violation,
																																														SELF.Section := LEFT.Section,
																																														SELF.NumberOfViolations := LEFT.NumberIncidents));
																				
																				SELF.TotalNumberOfOperators := COUNT(LEFT.Operator);		
																				SELF.Operators := PROJECT(CHOOSEN(LEFT.operator,iesp.Constants.LABOR_ACTION_MSHA.MaxOperators),TRANSFORM(iesp.share.t_NameAndCompany,
																																													SELF.CompanyName := LEFT.companyName,
																																													SELF.Last := LEFT.lastName,
																																													SELF.First := LEFT.firstName,
																																													SELF := []));
																				
																				SELF.TotalNumberOfControllers := COUNT(LEFT.controller);
																				SELF.Controllers := PROJECT(CHOOSEN(LEFT.controller,iesp.Constants.LABOR_ACTION_MSHA.MaxControllers),TRANSFORM(iesp.share.t_NameAndCompany,
																																													SELF.CompanyName := LEFT.companyName,
																																													SELF.Last := LEFT.lastName,
																																													SELF.First := LEFT.firstName,
																																													SELF := []));
																				
																				SELF.TotalNumberOfContractors := COUNT(LEFT.contractors);																											
																				SELF.Contractors := PROJECT(CHOOSEN(LEFT.contractors,iesp.Constants.LABOR_ACTION_MSHA.MaxContractors),TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHA_Contractor,
																																													SELF.Name := LEFT.contractorName,
																																													SELF.TotalNumberOfAccidents := LEFT.totalAccidents,
																																													SELF.Accidents := PROJECT(CHOOSEN(LEFT.accident,iesp.Constants.LABOR_ACTION_MSHA.MaxAccidents),TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHA_Accident,
																																																																			SELF.Description := LEFT.description,
																																																																			SELF.NumberOfAccidents := LEFT.numberIncidents));
																																													SELF.TotalNumberOfViolations := LEFT.totalViolations,
																																													SELF.Violations := PROJECT(CHOOSEN(LEFT.violation,iesp.Constants.LABOR_ACTION_MSHA.MaxViolations),TRANSFORM(iesp.laborAction_MSHA.t_laborAction_MSHA_Violation,
																																																																			SELF.Section := LEFT.section,
																																																																			SELF.NumberOfViolations := LEFT.numberIncidents));
																																													SELF := []));
																				SELF := []));
																							
		return(mines_iesp);
	END;
	
	/* Function to calculate the Penalty for the passed name information */
	get_penalty(string comp_name = '', string last_name = '', string first_name = '', IParam.searchrecords in_mod) := FUNCTION
	
		it := AutoStandardI.InterfaceTranslator;
		
		input_company_name := it.company_name_val.val(in_mod);
		input_last_name := it.lname_value.val(in_mod); 
		input_first_name := it.fname_value.val(in_mod);
		
		mod_input_name:= MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT name_last  := input_last_name;  
			EXPORT name_first := input_first_name;      
		END;

		mod_matched_name := MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT name_last  := last_name;
			EXPORT name_first := first_name;
		END;
		
		// Calculate company penalty, if no input company and matched company name then default to 1000
		comp_penal := IF(input_company_name != '' and comp_name != '',
											ut.mod_penalize.company_name(input_company_name,comp_name),1000);
		
		// Calculate person penalty, if not input name (first or last) and no matched name (first or last) then default to 1000
		name_penal := IF((last_name != '' or first_name != '') and (input_last_name != '' or input_first_name != ''),
											ut.mod_penalize.person_name(mod_input_name,mod_matched_name),1000);
											
	  pen_val := MIN(comp_penal,name_penal);
		
		RETURN pen_val;
	END;
	
	/* This function will calculate the penalty for the mine and contractor names. */
	assign_penalts(DATASET(Layouts.rawrec) recs, IParam.searchrecords in_mod) := FUNCTION
	  in_comp_name := AutoStandardI.InterfaceTranslator.company_name_val.val(in_mod);
		
		penal_recs := PROJECT(recs, TRANSFORM(Layouts.rawrec,
																					SELF.Mine_penalt := 			get_penalty(LEFT.Mine_Name,,,in_mod),
																					SELF.Contractor_penalt := get_penalty(LEFT.Contractor_Name,,,in_mod),
																					SELF.Controller_penalt := get_penalty(LEFT.Controller_name_business,
																																								LEFT.Controller_name_cln_lname,
																																								LEFT.Controller_name_cln_fname,
																																								in_mod),
																					SELF.Operator_penalt := 	get_penalty(LEFT.Operator_name_business,
																																								LEFT.Operator_name_cln_lname,
																																								LEFT.Operator_name_cln_fname,
																																								in_mod),
																					SELF := LEFT));
		
		RETURN penal_recs;
	END;
	
	EXPORT val(IParam.searchrecords in_mod) := FUNCTION

		// get records from input criteria.
		recs := Search_IDs.val(in_mod);
		
		penalt_recs := assign_penalts(recs, in_mod);
		
		mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		
		// Keep records from autokey lookup that past penalty test
		kept_recs := penalt_recs(Mine_penalt <= pthreshold_translated or
														 Controller_penalt <= pthreshold_translated or
														 Operator_penalt <= pthreshold_translated or
														 Contractor_penalt <= pthreshold_translated);
		
		// Get mine information 
		mine_recs := GROUP(SORT(getMineRecords(kept_recs,in_mod),mineId,RECORD),mineId);
		
		// Get contractors
		contractor_recs := GROUP(SORT(getContractorRecs(kept_recs(contractor_id != '')),mineId,RECORD),mineId);
		
		Layouts.mineRec Denorm_Contractors(Layouts.mineRec l, DATASET(Layouts.contractorRec) allRows) := TRANSFORM
			SELF.contractors := PROJECT(allRows,TRANSFORM(layouts.contractorRec,SELF := LEFT));
			SELF.contractor_penalt := IF (COUNT(allRows) > 0, MIN(SELF.contractors,penalt),1000);
			SELF := l;
		END;
			
		// Add contractor records as child datatest to the mine.
		mineAndContRecs := DENORMALIZE(mine_recs,contractor_recs,
																		LEFT.mineId = RIGHT.mineId,
																		GROUP,
																		Denorm_Contractors(LEFT,ROWS(RIGHT)));
		
		// Only keep mines that have violations, or contractors with violations.
		mineWithViol := mineAndContRecs(MAX(totalaccidents,totalviolations) >= 1 or COUNT(contractors) >= 1);												
		
		finalresults := getFormatedRecords(mineWithViol);

		return(finalresults);

	END;
END;