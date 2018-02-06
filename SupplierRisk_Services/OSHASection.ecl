IMPORT AutoStandardI, Oshair, BIPV2, iesp, MDR, TopBusiness_Services, ut;

EXPORT OSHASection := MODULE

  // *********** Main function to return OSHA section of the report.
 EXPORT fn_FullView(
   dataset(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids
	 ,SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
                   ):= FUNCTION 
  	
	FETCH_LEVEL := in_options.ReportFetchLevel;
	
	osha_work_layout := RECORD
			BIPV2.IDlayouts.l_header_ids;
			integer			activity_number;
			integer			inspection_opening_date;
			integer			inspection_close_date;
			string5			inspection_type;
			string30		insp_type_desc;
			string5			inspection_scope;
			string25		insp_scope_desc;
			integer			total_violations;
			string5			safety_health_flag;
			dataset(OSHAIR.layout_OSHAIR_violations_clean) violations{MAXCOUNT(iesp.constants.OSHAIR.MaxCountViolationRecords)};	
	END;
	
  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));

  //
  // *** Key fetch to get osha linking data from BIP2 linkids key file.
  oshair_recs_link := OSHAIR.Key_OSHAIR_LinkIds.KFetch(
	                         ds_in_unique_ids_only, // input file to join key with
													 FETCH_LEVEL); // level of ids to join with
							  					 // 3rd parm is ScoreThreshold, take default of 0

	oshair_act_recs := PROJECT(oshair_recs_link,TRANSFORM(osha_work_layout,SELF := LEFT,SELF := []));
	
	oshair_act_recs_dedup := DEDUP(SORT(oshair_act_recs,activity_number),activity_number);
	
	Violations_key := OSHAIR.Key_OSHAIR_violations;
		
	oshair_viol_recs := JOIN(oshair_act_recs_dedup, Violations_key,
														KEYED(LEFT.activity_number = RIGHT.activity_number),
														TRANSFORM(osha_work_layout,
																			SELF.violations := ROW(RIGHT, OSHAIR.layout_OSHAIR_violations_clean),
																			SELF := LEFT),
														LEFT OUTER,
														LIMIT(0),
														KEEP(iesp.constants.OSHAIR.MaxCountViolationRecords));
	
	oshair_grp := GROUP(SORT(oshair_viol_recs,activity_number,RECORD),activity_number);
	
	osha_work_layout roll_violations(osha_work_layout L, DATASET(osha_work_layout) allRows) := TRANSFORM
			SELF.violations := DEDUP(SORT(allRows.violations, issuance_date, citation_number, item_number, item_group),activity_number, issuance_date, citation_number, item_number, item_group);
			SELF := L;
	END;
	
	oshair_recs := ROLLUP(oshair_grp, GROUP, roll_violations(LEFT,ROWS(LEFT)));

	iesp.osha.t_OshaSectionViolation xfm_violationRecs(OSHAIR.layout_OSHAIR_violations_clean l, string safety_health) := TRANSFORM
			SELF.ViolationType := l.Violation_Type;
			SELF.HealthSafetyIssue := safety_health;
			SELF.ViolationTypeDesc := l.Violation_Desc;
			SELF.CitationNumber := l.Citation_Number;
			SELF.CurrentPenalty := l.Current_Penalty;
			SELF.AbatementComplete := l.Abatement_Complete;
			SELF := [];
	end;
	
	iesp.osha.t_OshaSectionRecord xfm_oshairRecs(osha_work_layout l) := TRANSFORM
			SELF.ActivityNumber := l.activity_number;
			SELF.InspectionOpeningDate := iesp.ECL2ESP.toDate(l.inspection_opening_date);
			SELF.InspectionCloseDate := iesp.ECL2ESP.toDate(l.inspection_close_date);
			SELF.InspectionType := l.inspection_type;
			SELF.InspectionTypeDesc := l.insp_type_desc;
			SELF.InspectionScope := l.inspection_scope;
			SELF.InspectionScopeDesc := l.insp_scope_desc;
			SELF.TotalNumberViolations := l.total_violations;
			HealthSafetyValue := MAP (l.Safety_Health_Flag = 'S' => 'SAFETY',
                                l.Safety_Health_Flag = 'H' => 'HEALTH', '');
			// Output violation records (records with an activity num of 0 are empty and excluded).													
			SELF.Violations := PROJECT(CHOOSEN(l.violations(activity_number != 0),iesp.constants.OSHAIR.MaxCountViolationRecords),xfm_violationRecs(LEFT,HealthSafetyValue));
			SELF := [];
	end;
	
	SupplierRisk_Services.SupplierRisk_layouts.oshair_layout format() := TRANSFORM
				self.OshaSectionRecords := PROJECT(CHOOSEN(oshair_recs,iesp.constants.OSHAIR.MaxCountSuppRiskRecords),xfm_oshairRecs(LEFT));
				self.OshaSectionCount := COUNT(CHOOSEN(oshair_recs,iesp.constants.OSHAIR.MaxCountSuppRiskRecords));
				self.TotalOshaSectionCount := COUNT(oshair_recs);
				
				iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
						TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false)
						self.source := MDR.sourceTools.src_OSHAIR;
						self := [];
				END;
				
				sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
				self.sourcedocs := IF(EXISTS(oshair_recs),sourceDoc);
				self.acctno := ds_in_ids[1].acctno;
				self := [];
	end;

	oshair_final_results := DATASET([format()]);
	
	return oshair_final_results;

 END; // end of the fn_FullView function
	
END; //end of the module