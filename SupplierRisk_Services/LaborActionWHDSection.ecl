IMPORT LaborActions_WHD, BIPV2, std, iesp, MDR, TopBusiness_Services;

EXPORT LaborActionWHDSection := MODULE


 // *********** Main function to return Diversity Certification section of the report.
 EXPORT fn_FullView(
   DATASET(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids,
   SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
  ):= FUNCTION
  
  caseid_rec := RECORD
    STRING10 caseid;
    STRING15 TotalViolations;
    STRING15 BW_TotalAgreedAmount;
    STRING15 CMP_TotalAssessments;
    STRING15 EE_TotalViolations;
    STRING15 EE_TotalAgreedCount;
    STRING3500 Violations_Summary;
  END;

  laborActions_summ_rec := RECORD
    BIPV2.IDlayouts.l_header_ids;
    UNSIGNED4 Summary_TotalViolations := 0;
    UNSIGNED4 Summary_BW_TotalAgreedAmount := 0;
    UNSIGNED4 Summary_CMP_TotalAssessments := 0;
    UNSIGNED4 Summary_EE_TotalViolations := 0;
    UNSIGNED4 Summary_EE_TotalAgreedCount := 0;
    DATASET(caseid_rec) caseid_recs;
  END;
  
  FETCH_LEVEL := in_options.ReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
  ds_in_unique_ids_only := PROJECT(ds_in_ids, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
    SELF := LEFT, SELF := []));

  ds_labor_recs := LaborActions_WHD.Key_LinkIDS.KFetch(ds_in_unique_ids_only, FETCH_LEVEL); 
                          
  labor_recs_level := SupplierRisk_Services.Functions.setLinkidFetchLev(ds_labor_recs, RECORDOF(ds_labor_recs), FETCH_LEVEL);
  
  laborAct_layout := RECORDOF(ds_labor_recs);
  laborRecs_dedup := DEDUP(SORT(labor_recs_level,#expand(BIPV2.IDmacros.mac_ListAllLinkids()), caseid,-dateupdated),#expand(BIPV2.IDmacros.mac_ListAllLinkids()), caseid);
  laborRecs_grouped := GROUP(laborRecs_dedup,#expand(BIPV2.IDmacros.mac_ListAllLinkids()));
  
  /* Transform that will convert each violation into a string for display, along with the violation the
     number of violations per the type is concatenated before the violation desc. */
  caseid_rec xfm_caserec (laborAct_layout l) := TRANSFORM
      
    // layout_desc := { STRING desc };
    ds_violation_descriptions :=
          IF((INTEGER)l.CA_CountViolations > 0, l.CA_CountViolations + ' for CA (Copeland Anti-kickback Act); ','') +
          IF((INTEGER)l.CCPA_CountViolations > 0, l.CCPA_CountViolations + ' for CCPA (Consumer Credit Protection Act - Wage Garnishment); ','') +
          IF((INTEGER)l.CREW_CountViolations > 0, l.CREW_CountViolations + ' for CREW (Longshoremen (D1)); ','') +
          IF((INTEGER)l.CWHSSA_CountViolations > 0, l.CWHSSA_CountViolations + ' for CWHSSA (Contract Work Hours AND Safety Standards Act); ','') +
          IF((INTEGER)l.DBRA_CL_CountViolations > 0, l.DBRA_CL_CountViolations + ' for DBRA (Davis-Bacon AND Related Act); ','') +
          IF((INTEGER)l.EEV_CountViolations > 0, l.EEV_CountViolations + ' for EEV (ESA 91); ','') +
          IF((INTEGER)l.EPPA_CountViolations > 0, l.EPPA_CountViolations + ' for EPPA (Employee Polygraph Protection Act); ','') +
          IF((INTEGER)l.FLSA_CountViolations > 0, l.FLSA_CountViolations + ' for FLSA (Fair Labor Standards Act); ','') +
          IF((INTEGER)l.FLSA_CL_CountViolations > 0, l.FLSA_CL_CountViolations + ' for FLSA - CL (Fair Labor Standards Act - Child Labor); ','') +
          IF((INTEGER)l.FLSA_HMWKR_CountViolations > 0, l.FLSA_HMWKR_CountViolations + ' for FLSA - HMWKR (Fair Labor Standards Act - industrial homework); ','') +
          IF((INTEGER)l.FLSA_SMW14_CountViolations > 0, l.FLSA_SMW14_CountViolations + ' for FLSA - SMW14 (Fair Labor Standards Act - Special Minimum Wages under Section 14(c)); ','') +
          IF((INTEGER)l.FLSA_SMWAP_CountViolations > 0, l.FLSA_SMWAP_CountViolations + ' for FLSA - SMWAP (Fair Labor Standards Act - Special Minimum Wages - Apprentices); ', '') +
          IF((INTEGER)l.FLSA_SMWFT_CountViolations > 0, l.FLSA_SMWFT_CountViolations + ' for FLSA - SMWFT (Fair Labor Standards Act - Special Minimum Wages - Full Time); ','') +
          IF((INTEGER)l.FLSA_SMWL_CountViolations > 0, l.FLSA_SMWL_CountViolations + ' for FLSA - SMWL (Fair Labor Standards Act - Special Minimum Wages - Learners); ','') +
          IF((INTEGER)l.FLSA_SMWMG_CountViolations > 0, l.FLSA_SMWMG_CountViolations + ' for FLSA - SMWMG (Fair Labor Standards Act - Special Minimum Wages - Messengers); ','') +
          IF((INTEGER)l.FLSA_SMWPW_CountViolations > 0, l.FLSA_SMWPW_CountViolations + ' for FLSA - SMWPW (Fair Labor Standards Act - Special Minimum Wages - Patient worker); ','') +
          IF((INTEGER)l.FLSA_SMWSL_CountViolations > 0, l.FLSA_SMWSL_CountViolations + ' for FLSA - SMWSL (Fair Labor Standards Act - Special Minimum Wages - Student Learners); ','') +
          IF((INTEGER)l.FMLA_CountViolations > 0, l.FMLA_CountViolations + ' for FMLA (Family AND Medical Leave Act); ','') +
          IF((INTEGER)l.H1A_CountViolations > 0, l.H1A_CountViolations + ' for H1A (Work Visa - Registered nurses for temporary employment); ','') +
          IF((INTEGER)l.H1B_CountViolations > 0, l.H1B_CountViolations + ' for H1B (Work Visa - Speciality Occupations); ','') +
          IF((INTEGER)l.H2A_CountViolations > 0, l.H2A_CountViolations + ' for H2A (Work Visa - Seasonal Agricultural Workers); ','') +
          IF((INTEGER)l.H2B_CountViolations > 0, l.H2B_CountViolations + ' for H2B (Work Visa - Temporary Non-Agricultural Work); ','') +
          IF((INTEGER)l.MPSA_CountViolations > 0, l.MPSA_CountViolations + ' for MSPA (Migrant AND Seasonal Agricultural Worker Protection Act); ','') +
          IF((INTEGER)l.OSHA_CountViolations > 0, l.OSHA_CountViolations + ' for OSHA (Occupational Safety AND Health Standards); ','') +
          IF((INTEGER)l.PCA_CountViolations > 0, l.PCA_CountViolations + ' for PCA (Public Contracts Act); ','') +
          IF((INTEGER)l.SCA_CountViolations > 0, l.SCA_CountViolations + ' for SCA (Service Contract Act); ','') +
          IF((INTEGER)l.SRAW_CountViolations > 0, l.SRAW_CountViolations + ' for SRAW (Spec. Agri. Workers/Replenishment Agri. Workers)','');
          
    SELF.Violations_Summary := STD.str.removesuffix(ds_violation_descriptions,';'); // Remove last semicolon
    SELF := l;
    SELF := [];
  END;
  
  // Create a summary record out of the individual case records and roll the case records into a child
  // dataset of the summary record.
  laborActions_summ_rec roll_CaseRecs(laborAct_layout l, DATASET(laborAct_layout) allrows) := TRANSFORM
    SELF.Summary_TotalViolations := SUM(allrows,(INTEGER)TotalViolations);
    SELF.Summary_BW_TotalAgreedAmount := SUM(allrows,(INTEGER)BW_totalagreedamount);
    SELF.Summary_CMP_TotalAssessments := SUM(allrows,(INTEGER)CMP_TotalAssessments);
    SELF.Summary_EE_TotalViolations := SUM(allrows,(INTEGER)EE_TotalViolations);
    SELF.Summary_EE_TotalAgreedCount := SUM(allrows,(INTEGER)EE_TotalAgreedCount);
    SELF.caseid_recs := PROJECT(allrows,xfm_caserec(LEFT));
    SELF := l;
  END;
    
  laborRecs_rolled := ROLLUP(laborRecs_grouped,GROUP,roll_CaseRecs(LEFT,ROWS(LEFT)));
    
  iesp.laboraction_whd.t_LaborActionWHDRecord xfm_laborRecs(laborActions_summ_rec l) := TRANSFORM
    SELF.Summary.TotalViolations := l.Summary_TotalViolations;
    SELF.Summary.BackWagesTotalAgreedAmount := l.Summary_BW_TotalAgreedAmount;
    SELF.Summary.CivilMoneyPenaltiesTotalAssessments := l.Summary_CMP_TotalAssessments;
    SELF.Summary.EmployeeEarnings.TotalViolations := l.Summary_EE_TotalViolations;
    SELF.Summary.EmployeeEarnings.TotalAgreedCount := l.Summary_EE_TotalAgreedCount;
    SELF.CaseIDs := PROJECT(CHOOSEN(l.caseid_recs,iesp.Constants.LABORACTIONWHD.MaxCaseIDs),
      TRANSFORM(iesp.laboraction_whd.t_LaborActionCaseID,
        SELF.Identifier := LEFT.caseid;
        SELF.TotalViolations := (INTEGER) LEFT.TotalViolations;
        SELF.BackWagesTotalAgreedAmount := (INTEGER) LEFT.BW_TotalAgreedAmount;
        SELF.CivilMoneyPenaltiesTotalAssessments := (INTEGER) LEFT.CMP_TotalAssessments;
        SELF.EmployeeEarnings.TotalViolations := (INTEGER) LEFT.EE_TotalViolations;
        SELF.EmployeeEarnings.TotalAgreedCount := (INTEGER) LEFT.EE_TotalAgreedCount;
        SELF.ViolationsSummary := LEFT.Violations_Summary)
      );
    SELF := [];
  END;
  
  SupplierRisk_Services.SupplierRisk_layouts.laborActionWHD_layout format() := TRANSFORM
    SELF.LaborActionWHDRecords := PROJECT(CHOOSEN(laborRecs_rolled,iesp.constants.LABORACTIONWHD.MaxCountSuppRiskRecords),xfm_laborRecs(LEFT));
    SELF.LaborActionWHDCount := COUNT(CHOOSEN(laborRecs_rolled,iesp.constants.LABORACTIONWHD.MaxCountSuppRiskRecords));
    SELF.TotalLaborActionWHDCount := COUNT(laborRecs_rolled);
    
    iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
      TopBusiness_Services.IDMacros.mac_IespTransferLinkids(FALSE)
      SELF.source := MDR.sourceTools.src_LaborActions_WHD;
      SELF := [];
    END;
    
    sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
    SELF.sourcedocs := IF(EXISTS(laborRecs_rolled),sourceDoc);
    SELF.acctno := ds_in_ids[1].acctno;
    SELF := [];
  END;
  
  labor_final_results := DATASET([format()]);
  RETURN labor_final_results;
   
 END; // end of the fn_FullView FUNCTION
  
END; //end of the module
