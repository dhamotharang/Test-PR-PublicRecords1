IMPORT dx_common, dx_OSHAIR, OSHAIR, BIPV2, iesp, MDR, TopBusiness_Services;

EXPORT OSHASection := MODULE

  // *********** Main function to return OSHA section of the report.
 EXPORT fn_FullView(
   DATASET(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids,
   SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
  ):= FUNCTION

  FETCH_LEVEL := in_options.ReportFetchLevel;

  violations_clean_layout := RECORD
    dx_OSHAIR.layouts.Layout_Violations - dx_common.layout_metadata
  END;

  osha_work_layout := RECORD
    BIPV2.IDlayouts.l_header_ids;
    INTEGER activity_number;
    INTEGER inspection_opening_date;
    INTEGER inspection_close_date;
    STRING5 inspection_type;
    STRING30 insp_type_desc;
    STRING5 inspection_scope;
    STRING25 insp_scope_desc;
    INTEGER total_violations;
    STRING5 safety_health_flag;
    DATASET(violations_clean_layout) violations{MAXCOUNT(iesp.constants.OSHAIR.MaxCountViolationRecords)};
  END;

  // Strip off the input acctno from each record, will re-attach them later.
  ds_in_unique_ids_only := PROJECT(ds_in_ids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
    SELF := LEFT, SELF := []));

  oshair_recs_link := dx_OSHAIR.Key_LinkIds.KFetch2(ds_in_unique_ids_only, FETCH_LEVEL);
  oshair_act_recs := PROJECT(oshair_recs_link, TRANSFORM(osha_work_layout, SELF := LEFT; SELF := []));
  oshair_act_recs_dedup := DEDUP(SORT(oshair_act_recs,activity_number),activity_number);

  Violations_key := dx_OSHAIR.key_payload_violations;

  oshair_viol_recs := JOIN(oshair_act_recs_dedup, Violations_key,
    KEYED(LEFT.activity_number = RIGHT.activity_number),
    TRANSFORM(osha_work_layout,
      SELF.violations := ROW(RIGHT, violations_clean_layout);
      SELF := LEFT;
    ), LEFT OUTER,
    LIMIT(0), KEEP(iesp.constants.OSHAIR.MaxCountViolationRecords));

  oshair_grp := GROUP(SORT(oshair_viol_recs,activity_number,RECORD),activity_number);

  osha_work_layout roll_violations(osha_work_layout L, DATASET(osha_work_layout) allRows) := TRANSFORM
    SELF.violations := DEDUP(SORT(allRows.violations, issuance_date, citation_number, item_number, item_group),activity_number, issuance_date, citation_number, item_number, item_group);
    SELF := L;
  END;

  oshair_recs := ROLLUP(oshair_grp, GROUP, roll_violations(LEFT,ROWS(LEFT)));

  iesp.osha.t_OshaSectionViolation xfm_violationRecs(violations_clean_layout l, STRING safety_health) := TRANSFORM
    SELF.ViolationType := l.Violation_Type;
    SELF.HealthSafetyIssue := safety_health;
    SELF.ViolationTypeDesc := l.Violation_Desc;
    SELF.CitationNumber := l.Citation_Number;
    SELF.CurrentPenalty := l.Current_Penalty;
    SELF.AbatementComplete := l.Abatement_Complete;
    SELF := [];
  END;

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
  END;

  SupplierRisk_Services.SupplierRisk_layouts.oshair_layout format() := TRANSFORM
    SELF.OshaSectionRecords := PROJECT(CHOOSEN(oshair_recs,iesp.constants.OSHAIR.MaxCountSuppRiskRecords),xfm_oshairRecs(LEFT));
    SELF.OshaSectionCount := COUNT(CHOOSEN(oshair_recs,iesp.constants.OSHAIR.MaxCountSuppRiskRecords));
    SELF.TotalOshaSectionCount := COUNT(oshair_recs);

    iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
      TopBusiness_Services.IDMacros.mac_IespTransferLinkids(FALSE)
      SELF.source := MDR.sourceTools.src_OSHAIR;
      SELF := [];
    END;

    sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
    SELF.sourcedocs := IF(EXISTS(oshair_recs),sourceDoc);
    SELF.acctno := ds_in_ids[1].acctno;
    SELF := [];
  END;

  oshair_final_results := DATASET([format()]);

  RETURN oshair_final_results;

 END;

END;
