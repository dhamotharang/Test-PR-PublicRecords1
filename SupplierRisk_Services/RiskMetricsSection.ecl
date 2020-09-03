IMPORT Workers_Compensation,Insurance_Certification, BIPV2, iesp, MDR, ut, TopBusiness_Services;

EXPORT RiskMetricsSection := MODULE

  // *********** Main function to return Risk Metrics section of the report.
 EXPORT fn_FullView(
   DATASET(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids,
   SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
  ):= FUNCTION
    
  riskmet_slim_rec := RECORD
    BIPV2.IDlayouts.l_header_ids;
    STRING2 itype;
    // Work Comp begin fields
    STRING15 classCode;
    STRING5 Effective_Month_Day;
    STRING2 EffectiveMonth;
    STRING8 Effective_Date;
    STRING100 NAICCarrierName;
    STRING15 NAICCarrierNumber;
    STRING100 NAICGroupName;
    STRING15 NAICGroupNumber;
    STRING30 FEIN;
    STRING30 PolicySelf;
    STRING20 insured_status;
    // Work Comp end fields
    // Begin Insur Cert fields
    UNSIGNED8 LNInsCertRecordID;
    STRING15 dartid;
    STRING20 PolicyHolderNameFirst;
    STRING30 PolicyHolderNameLast;
    STRING30 StatePolicyFileNumber;
    STRING8 CoverageInjuryIllnessDate;
    STRING80 SelfInsuranceGroup;
    STRING15 SelfInsuranceGroupPhone;
    STRING25 SelfInsuranceGroupID;
    STRING60 NumberofEmployees;
    STRING10 LicensedContractor;
    STRING50 MCOName;
    STRING10 MCONumber;
    STRING8 LicenseNumber;
    STRING8 Class;
    STRING8 ClassificationDescription;
    STRING8 LicenseStatus;
    STRING8 LicenseAdditionalInfo;
    STRING8 LicenseIssueDate;
    STRING8 LicenseExpirationDate;
    STRING8 NAICSCode;
    STRING8 OfficerExemptFirstName1;
    STRING8 OfficerExemptLastName1;
    STRING8 OfficerExemptEffectiveDate1;
    STRING8 OfficerExemptTerminationDate1;
    STRING8 OfficerExemptType1;
    STRING8 OfficerExemptBusinessActivities1;
    STRING50 SubsidiaryName1;
    STRING8 SubsidiaryStartDate1;
    STRING50 SubsidiaryName2;
    STRING8 SubsidiaryStartDate2;
    STRING60 Policy_InsuranceProvider;
    STRING35 Policy_PolicyNumber;
    STRING8 Policy_CoverageStartDate;
    STRING8 Policy_CoverageExpirationDate;
    STRING8 Policy_CoverageWrapUP;
    STRING90 Policy_PolicyStatus;
    STRING25 Policy_InsuranceProviderPhone;
    STRING25 Policy_InsuranceProviderFax;
    STRING8 Policy_CoverageReinstateDate;
    STRING8 Policy_CoverageCancellationDate;
    STRING Policy_InsuranceProviderContactDept;
    STRING Policy_InsuranceType;
    STRING Policy_CoveragePostedDate;
    STRING Policy_CoverageAmountFrom;
    STRING Policy_CoverageAmountTo;
    STRING10 Policy_addr_prim_range;
    STRING2 Policy_addr_predir;
    STRING28 Policy_addr_prim_name;
    STRING4 Policy_addr_addr_suffix;
    STRING2 Policy_addr_postdir;
    STRING10 Policy_addr_unit_desig;
    STRING8 Policy_addr_sec_range;
    STRING25 Policy_addr_p_city_name;
    STRING25 Policy_addr_v_city_name;
    STRING2 Policy_addr_st;
    STRING5 Policy_addr_zip;
  END;
  
  FETCH_LEVEL := in_options.ReportFetchLevel;
  
   // Strip off the input acctno from each record, will re-attach them later.
  ds_in_unique_ids_only := PROJECT(ds_in_ids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids, 
    SELF := LEFT, SELF := []));
                                                         
  ds_ic_recs := Insurance_Certification.Key_LinkIds.KFetch(ds_in_unique_ids_only, FETCH_LEVEL);
  ic_recs_level := SupplierRisk_Services.Functions.setLinkidFetchLev(ds_ic_recs,RECORDOF(ds_ic_recs),FETCH_LEVEL);
  
  // Sort and to keep one lninscertrecordid per linkid set, also drop ids of 0, there is a
  // data issue with this id value.
  ic_sort := DEDUP(SORT(ic_recs_level(LNInsCertRecordID != 0), LNInsCertRecordID, -date_firstseen, -dateadded, RECORD),
    lninscertrecordid);
  
  // Transform to convert with policy info.
  riskmet_slim_rec xfm_attach_ins_policy(RECORDOF(ic_sort) l, RECORDOF(Insurance_Certification.Key_UniquePol) r) := TRANSFORM
    SELF.Policy_InsuranceProvider := r.InsuranceProvider;
    SELF.Policy_PolicyNumber := r.PolicyNumber;
    SELF.Policy_CoverageStartDate := r.CoverageStartDate;
    SELF.Policy_CoverageExpirationDate := r.CoverageExpirationDate;
    SELF.Policy_CoverageWrapUP := r.CoverageWrapUP;
    SELF.Policy_PolicyStatus := r.PolicyStatus;
    SELF.Policy_InsuranceProviderPhone := r.InsuranceProviderPhone;
    SELF.Policy_InsuranceProviderFax := r.InsuranceProviderFax;
    SELF.Policy_CoverageReinstateDate := r.CoverageReinstateDate;
    SELF.Policy_CoverageCancellationDate := r.CoverageCancellationDate;
    SELF.Policy_InsuranceProviderContactDept := r.InsuranceProviderContactDept;
    SELF.Policy_InsuranceType := r.InsuranceType;
    SELF.Policy_CoveragePostedDate := r.CoveragePostedDate;
    SELF.Policy_CoverageAmountFrom := r.CoverageAmountFrom;
    SELF.Policy_CoverageAmountTo := r.CoverageAmountTo;
    SELF.Policy_addr_prim_range := r.m_prim_range;
    SELF.Policy_addr_predir := r.m_predir;
    SELF.Policy_addr_prim_name := r.m_prim_name;
    SELF.Policy_addr_addr_suffix := r.m_addr_suffix;
    SELF.Policy_addr_postdir := r.m_postdir;
    SELF.Policy_addr_unit_desig := r.m_unit_desig;
    SELF.Policy_addr_sec_range := r.m_sec_range;
    SELF.Policy_addr_p_city_name := r.m_p_city_name;
    SELF.Policy_addr_v_city_name := r.m_v_city_name;
    SELF.Policy_addr_st := r.m_st;
    SELF.Policy_addr_zip := r.m_zip;
    SELF.itype := SupplierRisk_Services.Constants.risk_insureCert;
    SELF := l;
    SELF := [];
  END;
    
  // Get the policy info and tranform results into layout to be returned
  ic_bus_policy := JOIN(ic_sort,Insurance_Certification.Key_UniquePol,
    KEYED(LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID) AND
    LEFT.dartid = RIGHT.dartid,
    xfm_attach_ins_policy(LEFT,RIGHT),
    LEFT OUTER,
    LIMIT(ut.limits.default, SKIP));
  
  // Keep only the most recent policy record, active policys contain "non blank" values and secondarily on policy start date.
  ic_bus_policy_dedup := DEDUP(SORT(ic_bus_policy,LNInsCertRecordID,IF(Policy_PolicyStatus != '', 0,1), 
    Policy_PolicyStatus, -Policy_CoverageStartDate, RECORD),
      RECORD, EXCEPT LNInsCertRecordID, ALL);
    
  // Get workers comp insurance (wc) data by bdid key file join.
  ds_wc_recs := Workers_Compensation.Key_LinkIds.KFetch(ds_in_unique_ids_only, FETCH_LEVEL);
  
  ds_wc_rfmt := PROJECT(ds_wc_recs,TRANSFORM(riskmet_slim_rec,
    SELF.itype := SupplierRisk_Services.Constants.risk_workersComp,
    SELF.insured_status := REGEXREPLACE('([^ -~]+)',LEFT.insured_status,''), //Remove special chars for deduping purposes.
    SELF := LEFT;
    SELF := [];
  ));

  wc_recs_level := Functions.setLinkidFetchLev(ds_wc_rfmt,RECORDOF(ds_wc_rfmt),FETCH_LEVEL);
  
  // Sort and to keep one lninscertrecordid per linkid set
  wc_dedup := DEDUP(wc_recs_level,RECORD,ALL);
  
  // Combine wc and ic results
  riskMet_all := GROUP(SORT(ic_bus_policy_dedup + wc_dedup,itype,RECORD),itype);
    
  // Transform into IESP output layout
  
  iesp.riskmetrics.t_RskMetSelfInsurance format_iesp_selfIns(riskmet_slim_rec l) := TRANSFORM
    SELF.LNInsCertRecordID := (STRING) l.LNInsCertRecordID;
    SELF.StatePolicyFileNumber := l.StatePolicyFileNumber;
    SELF.CoverageInjuryIllnessDate := iesp.ECL2ESP.toDatestring8(l.CoverageInjuryIllnessDate);
    SELF.NumberOfEmployees := (INTEGER) l.NumberofEmployees;
    SELF.LicensedContractor := l.LicensedContractor;
    SELF.ManagedCareOrganization.Name := l.MCOName;
    SELF.ManagedCareOrganization.Number := l.MCONumber;
    SELF.License.Number := l.LicenseNumber;
    SELF.License.Class := l.Class;
    SELF.License.ClassDescription := l.ClassificationDescription;
    SELF.License.Status := l.LicenseStatus;
    SELF.License.AdditionalInfo := l.LicenseAdditionalInfo;
    SELF.License.IssueDate := iesp.ECL2ESP.toDatestring8(l.LicenseIssueDate);
    SELF.License.ExpirationDate := iesp.ECL2ESP.toDatestring8(l.LicenseExpirationDate);
    SELF.NAIC.Code := l.NAICSCode;
    SELF.OfficerExemption.Name.First := l.OfficerExemptFirstName1;
    SELF.OfficerExemption.Name.Last := l.OfficerExemptLastName1;
    SELF.OfficerExemption.EffectiveDate := iesp.ECL2ESP.toDatestring8(l.OfficerExemptEffectiveDate1);
    SELF.OfficerExemption.TerminationDate := iesp.ECL2ESP.toDatestring8(l.OfficerExemptTerminationDate1);
    SELF.OfficerExemption._Type := l.OfficerExemptType1;
    SELF.OfficerExemption.BusinessActivities := l.OfficerExemptBusinessActivities1;
    SELF.Policy.PolicyNumber := l.Policy_PolicyNumber;
    SELF.Policy.PolicyHolderName.First := l.PolicyHolderNameFirst;
    SELF.Policy.PolicyHolderName.Last := l.PolicyHolderNameLast;
    SELF.Policy.InsuranceProvider := l.Policy_InsuranceProvider;
    SELF.Policy.CoverageDateRange.StartDate := iesp.ECL2ESP.toDatestring8(l.Policy_CoverageStartDate);
    SELF.Policy.CoverageDateRange.EndDate := iesp.ECL2ESP.toDatestring8(l.Policy_CoverageExpirationDate);
    SELF.Policy.CoverageWrapUp := l.Policy_CoverageWrapUP;
    SELF.Policy.PolicyStatus := l.Policy_PolicyStatus;
    SELF.Policy.InsuranceProviderPhone := l.Policy_InsuranceProviderPhone;
    SELF.Policy.InsuranceProviderFax := l.Policy_InsuranceProviderFax;
    SELF.Policy.CoveragereInstateDate := iesp.ECL2ESP.toDatestring8(l.Policy_CoverageReinstateDate);
    SELF.Policy.CoverageCancellationDate := iesp.ECL2ESP.toDatestring8(l.Policy_CoverageCancellationDate);
    SELF.Policy.InsuranceProviderContactDept := l.Policy_InsuranceProviderContactDept;
    SELF.Policy.InsuranceType := l.Policy_InsuranceType;
    SELF.Policy.CoveragePostedDate := iesp.ECL2ESP.toDatestring8(l.Policy_CoveragePostedDate);
    SELF.Policy.CoverageAmountFrom := l.Policy_CoverageAmountFrom;
    SELF.Policy.CoverageAmountTo := l.Policy_CoverageAmountTo;
    SELF.SelfInsurace.GROUP := l.SelfInsuranceGroup;
    SELF.SelfInsurace.GroupPhone := l.SelfInsuranceGroupPhone;
    SELF.SelfInsurace.GroupID := l.SelfInsuranceGroupID;
    SELF.Policy.Address := iesp.ECL2ESP.SetAddress(l.Policy_addr_prim_name,l.Policy_addr_prim_range,l.Policy_addr_predir,
      l.Policy_addr_postdir,l.Policy_addr_addr_suffix,l.Policy_addr_unit_desig,
      l.Policy_addr_sec_range,l.Policy_addr_p_city_name,l.Policy_addr_st,
      l.Policy_addr_zip,'','');
    
    subTrans(STRING CompanyName, STRING StartDate) :=
        TRANSFORM(iesp.riskmetrics.t_RskMetSubsidiary,
          SELF.Name := CompanyName;
          SELF.StartDate := iesp.ECL2ESP.toDatestring8(StartDate));
    
    subRecs := DATASET([ SubTrans(l.SubsidiaryName1,l.SubsidiaryStartDate1),
                        SubTrans(l.SubsidiaryName2,l.SubsidiaryStartDate2)]);
    SELF.Subsidiaries := CHOOSEN(subRecs,iesp.constants.RISK_METRIC.MaxSubsidiaries);
    SELF := [];
  END;
  
  iesp.riskmetrics.t_RskMetWorkersComp format_iesp_workComp(riskmet_slim_rec l) := TRANSFORM
    SELF.ClassCode := l.classCode;
    SELF.EffectiveDate := iesp.ECL2ESP.toDatestring8(l.Effective_Date);
    SELF.NAIC.Code := l.NAICSCode;
    SELF.NAIC.CarrierName := l.NAICCarrierName;
    SELF.NAIC.CarrierNumber := (INTEGER) l.NAICCarrierNumber;
    SELF.NAIC.GroupName := l.NAICGroupName;
    SELF.NAIC.GroupNumber := (INTEGER) l.NAICGroupNumber;
    SELF.FEIN := l.fein;
    SELF.PolicySelf := l.PolicySelf;
    SELF.InsuredStatus := l.insured_status;
    SELF := [];
  END;
  
  iesp.riskmetrics.t_RiskMetricsRecord format_iesp(riskmet_slim_rec l, DATASET(riskmet_slim_rec) allrows) := TRANSFORM
    SELF.SelfInsurances := PROJECT(
      CHOOSEN(DEDUP(allrows(itype=SupplierRisk_Services.Constants.risk_insureCert),ALL), iesp.constants.RISK_METRIC.MaxSelfInsurance),
      format_iesp_selfIns(LEFT));
    workers_recs := PROJECT(allrows(itype=SupplierRisk_Services.Constants.risk_workersComp),format_iesp_workComp(LEFT));
    SELF.WorkersInsComps := CHOOSEN(
      DEDUP(SORT(workers_recs,-EffectiveDate.year,-EffectiveDate.month,-EffectiveDate.day,RECORD),RECORD),
      iesp.constants.RISK_METRIC.MaxWorkersComp);
    SELF.WorkersInsCompCount := COUNT(allrows(itype=SupplierRisk_Services.Constants.risk_workersComp));
    SELF.SelfInsuranceCount := COUNT(allrows(itype=SupplierRisk_Services.Constants.risk_insureCert));
    SELF := [];
  END;
  
  riskMet_iesp := ROLLUP(riskMet_all,GROUP,format_iesp(LEFT,ROWS(LEFT)));

  SupplierRisk_Services.SupplierRisk_layouts.risk_metrics_layout format() := TRANSFORM
    SELF.RiskMetricsRecords := CHOOSEN(riskMet_iesp,iesp.constants.RISK_METRIC.MaxCountSuppRiskRecords);
    SELF.RiskMetricsCount := COUNT(CHOOSEN(riskMet_iesp,iesp.constants.RISK_METRIC.MaxCountSuppRiskRecords));
    SELF.TotalRiskMetricsCount := COUNT(riskMet_iesp);
    
    iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedocWC(riskmet_slim_rec l) := TRANSFORM
      TopBusiness_Services.IDMacros.mac_IespTransferLinkids(FALSE)
      SELF.source := MDR.sourceTools.src_Workers_Compensation;
      SELF := [];
    END;
    
    iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedocIC(riskmet_slim_rec l) := TRANSFORM
      TopBusiness_Services.IDMacros.mac_IespTransferLinkids(FALSE)
      SELF.IDValue := (STRING) l.LNInsCertRecordID + '//' + TRIM(l.dartid);
      SELF.IDType := TopBusiness_Services.Constants.sourcedocid;
      SELF.source := MDR.sourceTools.src_Insurance_Certification;
      SELF := [];
    END;
        
    sourceDocWC := DEDUP(PROJECT(riskMet_all(itype=SupplierRisk_Services.Constants.risk_workersComp),xfm_sourcedocWC(LEFT)),ALL);
    sourceDocIC := DEDUP(PROJECT(riskMet_all(itype=SupplierRisk_Services.Constants.risk_insureCert),xfm_sourcedocIC(LEFT)),ALL);
    
    SELF.sourcedocs := IF(EXISTS(riskMet_iesp),UNGROUP(sourceDocWC+sourceDocIC));
    SELF.acctno := ds_in_ids[1].acctno;
    SELF := [];
  END;
  
  riskmetric_final_results := DATASET([format()]);
  RETURN riskmetric_final_results;
   
 END; 
  
END;
