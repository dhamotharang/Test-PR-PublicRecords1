IMPORT Workers_Compensation,Insurance_Certification,ut, iesp;
/* Attribute to return insurance information for the passed bdids */
  
doxie_cbrs.mac_Selection_Declare()
  
EXPORT risk_metrics_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE
  
  riskmet_slim_rec := RECORD
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
    STRING2 insured_status;
    // Work Comp end fields
    // Begin Insur Cert fields
    UNSIGNED8 LNInsCertRecordID;
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
  
  // Get insurance cert (ic) data by bdid key file join.
  ic_by_BDID :=
        JOIN(
          bdids,
          Insurance_Certification.Key_BDID,
          KEYED(LEFT.bdid = RIGHT.bdid),
          TRANSFORM(RIGHT),
          INNER,
          LIMIT(ut.limits.default, SKIP)
        );


  // Sort and to keep one lninscertrecordid per bdid
  ic_by_BDID_sort := DEDUP(SORT(ic_by_BDID,bdid,LNInsCertRecordID,-date_firstseen,-dateadded,RECORD),
                          bdid,lninscertrecordid);
  
  // Transform to convert to batch output with policy info.
  riskmet_slim_rec xfm_attach_ins_policy(RECORDOF(ic_by_BDID_sort) l, RECORDOF(Insurance_Certification.Key_UniquePol) r) := TRANSFORM
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
    SELF := l;
    SELF := [];
  END;
    
  // Get the policy info and tranform results into layout to be returned
  ic_bus_policy := JOIN(ic_by_BDID_sort,Insurance_Certification.Key_UniquePol,
                        LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID,
                        xfm_attach_ins_policy(LEFT,RIGHT)
                        ,LEFT OUTER);
    
  // Keep only the most recent policy record, active policys contain "non blank" values and secondarily on policy start date.
  ic_bus_policy_dedup := DEDUP(SORT(ic_bus_policy,LNInsCertRecordID,IF(Policy_PolicyStatus != '', 0,1),Policy_PolicyStatus,-Policy_CoverageStartDate,RECORD),
                              LNInsCertRecordID);
    
  // Get workers comp insurance (wc) data by bdid key file join.
  wc_by_BDID :=
      JOIN(
        bdids,
        Workers_Compensation.Key_BDID,
        KEYED(LEFT.bdid = RIGHT.bdid),
        TRANSFORM(riskmet_slim_rec,SELF := RIGHT, SELF := []),
        INNER,
        LIMIT(ut.limits.default, SKIP)
      );

  // Combine wc and ic results
  riskMet_all := SORT(ic_bus_policy_dedup + wc_by_BDID,RECORD);
  
  // Transform into IESP output layout
  
  iesp.riskmetrics.t_RiskMetricsRecord format_iesp(RECORDOF(riskMet_all) l) := TRANSFORM
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
      SELF.SelfInsurace.Group := l.SelfInsuranceGroup;
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
  
  riskMet_out := PROJECT(riskMet_all,format_iesp(LEFT));
  riskMetDedup := DEDUP(SORT(riskMet_out,RECORD),RECORD);
  SHARED riskMet_final := CHOOSEN(riskMetDedup(Include_RiskMetrics_val),iesp.constants.RISK_METRIC.MaxRiskMetrics);
  
  EXPORT records := CHOOSEN(riskMet_final,Max_RiskMetrics_val);
  EXPORT records_count := COUNT(riskMet_final);
  
END;
