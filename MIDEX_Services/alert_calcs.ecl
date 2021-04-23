IMPORT MIDEX_Services, iesp;
EXPORT alert_calcs := MODULE
  // --------------------------------------------------------------------------------------------------------------
  //              Common Alert Hashes 
  // -------------------------------------------------------------------------------------------------------------- 
  EXPORT UNSIGNED8 calcNameHash(STRING fname, STRING mname, STRING lname, STRING cname) := FUNCTION
    RETURN(HASH64(fname,mname,lname,cname));
  END;
  
  EXPORT UNSIGNED8 calcAddrHash(STRING prim_range, STRING predir, STRING prim_name, STRING addr_suffix,
                                STRING postdir, STRING sec_range, STRING city, STRING state, STRING zip) := FUNCTION
    RETURN(HASH64(prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,state,zip));
  END;
  
  EXPORT UNSIGNED8 calcAddr2Hash(STRING address1, STRING address2, STRING city, STRING state, STRING zip) := 
    FUNCTION
      RETURN(HASH64(address1,address2,city,state,zip));
    END;
  
  EXPORT UNSIGNED8 calcSanctnHash(STRING MIDEXFileNumber,STRING dbcode,STRING dataSource, 
                                  STRING incidentDate,STRING sourceDocument,STRING jurisdiction, 
                                  STRING caseNumber,STRING additionalInfo,STRING incidentReportedOnDate,
                                  STRING entryDate,STRING	modifiedDate,STRING action,
                                  STRING incidentVerification,STRING otherInfo, STRING Restitution,
                                  STRING FINES_LEVIED,STRING Alleged_amount, STRING Estimated_loss) := 
    FUNCTION
                    
      RETURN(HASH64(MIDEXFileNumber, dbcode, dataSource, incidentDate, sourceDocument, jurisdiction, 
                    caseNumber, additionalInfo, incidentReportedOnDate, entryDate, modifiedDate, 
                    action, incidentVerification, otherInfo, Restitution,
                    FINES_LEVIED, Alleged_amount, Estimated_loss));
  END;
  
  EXPORT UNSIGNED8 calcNameDescHash(STRING uniqueId,STRING businessId,STRING ssn,STRING dob,STRING personAKA,
                                    STRING jobTitle,STRING companyName,STRING companyAka,STRING tin,
                                    STRING PartyPosition,STRING PartyFirm,STRING PartyEmployer,STRING ename) := 
    FUNCTION
      RETURN(HASH64(uniqueId,businessId,ssn,dob,personAKA,jobTitle,companyName,companyAka,tin));
    END;
   
  EXPORT UNSIGNED8 calcTextLayoutSlimmedHash( iesp.midexcompreport.t_MIDEXCompComment l ) := 
    FUNCTION
      RETURN(SUM(l.Text,HASH64(value)) + HASH64((STRING)l.Date.Year, (STRING)l.Date.Month, (STRING)l.Date.Day));
    END;
   

  EXPORT UNSIGNED8 calcStringArrayHash( DATASET(iesp.share.t_StringArrayItem) l ) := 
    FUNCTION
      RETURN SUM(l,HASH64(value));
    END;
   
  EXPORT UNSIGNED8 calcLicenseHash( DATASET(MIDEX_Services.Layouts.LicenseInfo_Layout) l ) := 
    FUNCTION
      RETURN SUM(l,HASH64(lic_number,lic_type, lic_status, lic_state, lic_issue_date, lic_expir_date));
    END;
   
  EXPORT UNSIGNED8 calcIespLicenseHash( DATASET(iesp.midex_share.t_MIDEXLicenseInfo) l ) := 
    FUNCTION
      RETURN SUM(l,HASH64(_Type, Number, Status, IssueState));
    END;
  
  EXPORT UNSIGNED8 fn_calcBankStatusHistoryHash ( DATASET(iesp.bankruptcy.t_BankruptcyStatus) l) :=
    FUNCTION  
      RETURN SUM(l,HASH64(_Type,Date.year,Date.month,Date.day));
    END;
    
  
  EXPORT UNSIGNED8 fn_calcBankruptcyCommentHash ( DATASET(iesp.bankruptcy.t_BankruptcyComment) l) :=
    FUNCTION
      RETURN SUM(l, HASH64(Description,FilingDate.year,FilingDate.month,FilingDate.day));
    END;
     
  
  EXPORT UNSIGNED8 calcIespT_BankruptcyPerson2Hash ( DATASET(iesp.bankruptcy.t_BankruptcyPerson2) l ) :=
    FUNCTION
      hashCalc := SUM(l,HASH64(	hasCriminalConviction,isSexualOffender,IdValue,UniqueId,BusinessId )); 
      RETURN hashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcSmartlinxLiensJudgmentsHash ( iesp.smartlinxreport.t_SLRLienJudgment l  ) := 
  
    FUNCTION
      LienJudgmentHashCalc :=  HASH64(l.Eviction,l.JudgeVacatedDate.year,l.JudgeVacatedDate.month,l.JudgeVacatedDate.day,
                                      l.ReleaseDate.year,l.ReleaseDate.month,l.ReleaseDate.day,l.ActiveClosed ) +
                               SUM(l.Debtors,
                                   HASH64(HasCriminalConviction,IsSexualOffender,OriginName,TaxId,SSN) +
                                   calcAddrHash(Address.StreetNumber,Address.StreetPreDirection,Address.StreetName,Address.StreetSuffix,
                                                Address.StreetPostDirection,Address.UnitDesignation,Address.City,Address.State,Address.Zip5) 
                                  ) +
                               SUM(l.Creditors,
                                   HASH64(HasCriminalConviction,IsSexualOffender,Name) +
                                   calcAddrHash(Address.StreetNumber,Address.StreetPreDirection,Address.StreetName,Address.StreetSuffix,
                                                Address.StreetPostDirection,Address.UnitDesignation,Address.City,Address.State,Address.Zip5) 
                                 ) +
                              SUM(l.Filings,
                                  HASH64(FilingStatus));
      RETURN LienJudgmentHashCalc;
    END;

  // --------------------------------------------------------------------------------------------------------------
  //              Smartlinx Person Alert Hashes 
  // --------------------------------------------------------------------------------------------------------------
  EXPORT UNSIGNED8 fn_calcPersonBankruptcyHash (DATASET(iesp.smartlinxreport.t_SLRBankruptcy ) l ) := 
    FUNCTION
      personBankruptcyHash := SUM(l,
                                  HASH64(ReopenDate.year,ReopenDate.month,ReopenDate.day,
                                         ConvertedDate.year,ConvertedDate.month,
                                         ConvertedDate.day,Chapter,FilingStatus,ActiveClosed) + 
                                  fn_calcBankStatusHistoryHash(StatusHistory) +
                                  fn_calcBankruptcyCommentHash(Comments) +
                                  calcIespT_BankruptcyPerson2Hash(Debtors)
                          );
      RETURN personBankruptcyHash;
    END;
  
  EXPORT UNSIGNED8 fn_calcSmartlinxPersonBankruptcyHash (DATASET(iesp.smartlinxreport.t_SLRBankruptcies) l) :=
    FUNCTION
      personBankHashCalc := SUM(l, fn_calcPersonBankruptcyHash(l.ActiveBankruptcies) +
                                   fn_calcPersonBankruptcyHash(l.ClosedBankruptcies));
                                    
      RETURN personBankHashCalc;
    END;
    
  EXPORT UNSIGNED8 fn_calcSmartlinxPersonCriminalHash ( DATASET(iesp.criminal.t_CrimReportRecord) l) :=
    FUNCTION
      // the only fields missing from the has are count and length. These are key words and
      // generate an error when used.
      personCrimHashCalc := SUM(l,HASH64(Status,CaseTypeDescription) +
                                  calcNameHash(Name.First,Name.Middle,Name.Last,'') +
                                  SUM(AKAs,calcNameHash(First,Middle,Last,'')) +
                                  SUM(Offenses,
                                      HASH64(AdjudicationWithheld,CaseNumber,CaseType,CaseTypeDescription,
                                             SentenceDate.year,
                                             SentenceDate.month,SentenceDate.day,IncarcerationDate.year,
                                             IncarcerationDate.month,IncarcerationDate.day,Appeal.Date.year,
                                             Appeal.Date.month,Appeal.Date.day,Appeal.Disposition,
                                             Appeal.FinalDisposition,Arrest.Agency,Arrest.CaseNumber,
                                             Court.Disposition,Court.DispositionDate.year,
                                             Court.DispositionDate.month,Court.DispositionDate.day,Court.Fine,
                                             Court.Level,Court.Offense,Court.Plea,Court.Statute,Court.SuspendedFine,
                                             CourtSentence.Jail,CourtSentence.Probation,CourtSentence.Suspended)) +
                                  SUM( ParoleSentences,
                                       HASH64(ActualEndDate.year,ActualEndDate.month,ActualEndDate.day,
                                              County,CurrentStatus,ScheduledEndDate.year,
                                              ScheduledEndDate.month,ScheduledEndDate.day,
                                              StartDate.year,StartDate.month,StartDate.day)) +
                                  SUM( ParoleSentencesEx,
                                       HASH64(CurrentStatusFlag,
                                              CurrentStatusEffectiveDate.year,CurrentStatusEffectiveDate.month,
                                              CurrentStatusEffectiveDate.day) +
                                       calcNameHash(Name.First,Name.Middle,Name.Last,'') +
                                       SUM(Offenses,
                                           HASH64(SentenceDate.year,SentenceDate.month,SentenceDate.day,
                                                  OffenseCounty,OffenseCount,OffenseDate.year,
                                                  OffenseDate.month,OffenseDate.day))
                                     ) +
                                  SUM(Activities,
                                      HASH64(Date.year,Date.month,Date.day,Description))
                              );

      RETURN personCrimHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcPersonSexOffensesHash ( DATASET(iesp.sexualoffender.t_SexOffReportRecord) L) :=
    FUNCTION
      personSexOffHashCalc := SUM(L, HASH64(PrimaryKey) +
                                     calcNameHash(Name.First,Name.Middle,Name.Last,'') +
                                     SUM(Convictions, HASH64(CourtCaseNumber, OffenseDescription, OffenseDate.Year,
                                                             OffenseDate.Month, OffenseDate.Day)));
      RETURN personSexOffHashCalc;
    END;
    
  EXPORT UNSIGNED8 fn_calcPersonLienJudgmentHash ( DATASET(iesp.smartlinxreport.t_SLRLienJudgment) l) := 
    FUNCTION                                                            
      personLienJudgHashCalc := SUM(l, fn_calcSmartlinxLiensJudgmentsHash (l));
      RETURN personLienJudgHashCalc;
    END;

  EXPORT UNSIGNED8 fn_calcSmartlinxPersonLiensJudgmentsHash (iesp.smartlinxreport.t_SLRLiensJudgments l) :=
    FUNCTION
      personLienJudgHashCalc := fn_calcPersonLienJudgmentHash(l.ActiveLiensJudgments) +
                                fn_calcPersonLienJudgmentHash(l.ClosedLiensJudgments);
      RETURN personLienJudgHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcPersonPropertyHash ( DATASET(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord) l) := 
    FUNCTION                                                            
      personPropertyHashCalc := SUM(l, HASH64(SourcePropertyRecordId, NoticeOfDefaultFound, ForeclosureFound)
                                      + calcAddrHash(PropertyAddress.StreetNumber,PropertyAddress.StreetPreDirection,PropertyAddress.StreetName,PropertyAddress.StreetSuffix,
                                                  PropertyAddress.StreetPostDirection,PropertyAddress.UnitDesignation,PropertyAddress.City,PropertyAddress.State,PropertyAddress.Zip5) );
      RETURN personPropertyHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcSmartlinxPersonPropertyHash (iesp.smartlinxreport.t_SLRProperties l) := 
    FUNCTION
      personPropertyHashCalc := fn_calcPersonPropertyHash(l.CurrentProperties) + 
                              fn_calcPersonPropertyHash(l.PriorProperties);
      RETURN personPropertyHashCalc;
    END;

  EXPORT UNSIGNED8 fn_calcSmartlinxPersonEmployerHash (DATASET(iesp.peopleatwork.t_PeopleAtWorkRecord) L) := 
    FUNCTION
      personEmployerHashCalc := SUM(L, HASH64(BusinessIds.UltID, BusinessIds.OrgID, BusinessIds.SeleID, 
                                              BusinessIds.ProxID, BusinessIds.POWID, BusinessIds.EmpID, 
                                              BusinessIds.DotID, UniqueId, BusinessId)
                                       + calcNameHash(Name.First,Name.Middle,Name.Last,CompanyName));
      RETURN personEmployerHashCalc;
    END;
    
  EXPORT UNSIGNED8 fn_calcSmartlinxPersonBusinessAssociateHash (DATASET(iesp.smartlinxreport.t_SLROtherAssociatedBusinesses) associatedBus,
                                                                DATASET(iesp.bpsreport.t_BpsCorpAffiliation) busConnection) :=
    FUNCTION
      personBusinessAssocHashCalc := SUM(associatedBus, 
                                        HASH64(BusinessIds.UltID, BusinessIds.OrgID, BusinessIds.SeleID, 
                                               BusinessIds.ProxID, BusinessIds.POWID, BusinessIds.EmpID, 
                                               BusinessIds.DotID, UniqueId, BusinessId)
                                        + calcNameHash(Name.First,Name.Middle,Name.Last,CompanyName)) +
                                     SUM(busConnection, 
                                        HASH64(BusinessIds.UltID, BusinessIds.OrgID, BusinessIds.SeleID, 
                                               BusinessIds.ProxID, BusinessIds.POWID, BusinessIds.EmpID, 
                                               BusinessIds.DotID, BusinessId)
                                        + calcNameHash(Name.First,Name.Middle,Name.Last,CompanyName));				 
      RETURN personBusinessAssocHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcSmartlinxPersonEmailHash (DATASET(iesp.emailsearch.t_EmailSearchRecord) L) := 
    FUNCTION
      personEmailHash := SUM(L, HASH64(EmailId) +
                                SUM(Emails, HASH64(EmailAddress)));
      RETURN personEmailHash;
    END;	
    
  // --------------------------------------------------------------------------------------------------------------
  //              Smartlinx Business Alert Hashes 
  // -------------------------------------------------------------------------------------------------------------- 	
  EXPORT UNSIGNED8 fn_calcSmartlinxBizBankruptcyHash ( DATASET(iesp.bankruptcy.t_BankruptcyReport2Record) l) := 
    FUNCTION
      bizBankHashCalc := SUM(l, HASH64(ReopenDate.year,ReopenDate.month,
                                       ReopenDate.day,ConvertedDate.year,ConvertedDate.month,
                                       ConvertedDate.day,Chapter,FilingStatus) +
                                fn_calcBankStatusHistoryHash(StatusHistory) +
                                fn_calcBankruptcyCommentHash(Comments) +
                                calcIespT_BankruptcyPerson2Hash(Debtors) 
                           );     
      RETURN bizBankHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcSmartlinxBizLiensJudgmentsHash (DATASET(iesp.lienjudgement.t_LienJudgmentReportRecord) l) := 
    FUNCTION
      newLayout := PROJECT(l, TRANSFORM( iesp.smartlinxreport.t_SLRLienJudgment,
                                         SELF.ActiveClosed := '';
                                         SELF              := LEFT;
                                       ));
      bizLienJudgmentHashCalc := SUM(newLayout, fn_calcSmartlinxLiensJudgmentsHash (newLayout) );
      
      RETURN bizLienJudgmentHashCalc; 
    END;  
    
  EXPORT UNSIGNED8 fn_calcSmartlinxBizPropertiesHash (DATASET(iesp.property.t_PropertyReport2Record) L) :=
    FUNCTION
      bizPropertyHashCalc :=  SUM(L, HASH64(DataSource, FaresId, Deed.FaresForeclosure, Deed.DeedSourcePropertyRecord.Foreclosure, Assessment.PropertyAddress));
        ;
      RETURN bizPropertyHashCalc;
    END;

  EXPORT UNSIGNED8 fn_calcSmartLinxBizBusinessAssociatesHash (dataset(iesp.rollupbizreport.t_BusinessAssociate) l) := 
    FUNCTION
      bizBusinessAssocHashCalc := SUM(L, HASH64(BusinessId, CompanyName));
      RETURN bizBusinessAssocHashCalc;
    END;
    
  // --------------------------------------------------------------------------------------------------------------
  //              Top Business Alert Hashes 
  // -------------------------------------------------------------------------------------------------------------- 
  EXPORT UNSIGNED8 calcIespT_BankruptcyTopBusinessPartyHash ( DATASET(iesp.TopBusinessReport.t_TopBusinessBankruptcyParty) l ) :=
    FUNCTION
      hashCalc := SUM(l,HASH64(	CompanyName,Name.First, Name.Last, TaxID, SSN ));
                     
      RETURN hashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcTopBusinessBankruptcyHash ( DATASET(iesp.TopBusinessReport.t_TopBusinessBankruptcy) l) := 
    FUNCTION
      bizBankHashCalc := SUM(l, HASH64(StatusDate.year,StatusDate.month,
                                       StatusDate.day,OriginalCaseNumber,FilingStatus,
                                       StatusHistory, //StatusHistory Hash
                                       Comment, OriginalFilingDate.year,OriginalFilingDate.month,OriginalFilingDate.day) + //CommentHash
                                calcIespT_BankruptcyTopBusinessPartyHash(Debtors) 
                           );     
      RETURN bizBankHashCalc;
    END;
  
  EXPORT UNSIGNED8 fn_calcTopBusinessLiensJudgmentsHash (DATASET(iesp.TopBusinessReport.t_TopBusinessJudgmentLienDetail) l) := 
    FUNCTION
      LienJudgmentHashCalc :=  SUM(L, HASH64(Eviction,OrigFilingDate.year,OrigFilingDate.month,OrigFilingDate.day,
                                      FilingJurisdiction,OrigFilingNumber, OrigFilingType ) +
                               SUM(Debtors,
                                   HASH64(CompanyName,Name.First, Name.Last,TaxId,SSN) +
                                   calcAddrHash(Address.StreetNumber,Address.StreetPreDirection,Address.StreetName,Address.StreetSuffix,
                                                Address.StreetPostDirection,Address.UnitDesignation,Address.City,Address.State,Address.Zip5) 
                                  ) +
                               SUM(Creditors,
                                   HASH64(CompanyName,Name.First, Name.Last,TaxId,SSN) +
                                   calcAddrHash(Address.StreetNumber,Address.StreetPreDirection,Address.StreetName,Address.StreetSuffix,
                                                Address.StreetPostDirection,Address.UnitDesignation,Address.City,Address.State,Address.Zip5) 
                                 ) +
                               SUM(Filings,
                                  HASH64(FilingStatus)));
      RETURN LienJudgmentHashCalc;
    END;  
    
  EXPORT UNSIGNED8 fn_calcTopBusinessPropertiesHash (DATASET(iesp.topbusinessreport.t_TopBusinessProperty) L) :=
    FUNCTION
      bizPropertyHashCalc :=  SUM(L, HASH64(PropertyUniqueId, IsNoticeOfDefault, IsForeclosed)
                                   + calcAddrHash(PropertyAddress.StreetNumber,PropertyAddress.StreetPreDirection,PropertyAddress.StreetName,PropertyAddress.StreetSuffix,
                                                  PropertyAddress.StreetPostDirection,PropertyAddress.UnitDesignation,PropertyAddress.City,PropertyAddress.State,PropertyAddress.Zip5) 
                                  );
        ;
      RETURN bizPropertyHashCalc;
    END;
    
  EXPORT UNSIGNED8 fn_calcTopBusinessBusAssociatesHash (DATASET(iesp.TopBusinessReport.t_TopBusinessAssociateBusiness) associates, 
                                                        DATASET(iesp.TopBusinessReport.t_TopBusinessConnectedBusiness) connectedBus) := 
    FUNCTION
      bizBusinessAssocHashCalc := SUM(associates, HASH64(BusinessIds.UltID, BusinessIds.OrgID, BusinessIds.SeleID, 
                                                         BusinessIds.ProxID, BusinessIds.POWID, BusinessIds.EmpID, 
                                                         BusinessIds.DotID, CompanyName, Role)) +
                                  SUM(connectedBus, HASH64(BusinessIds.UltID, BusinessIds.OrgID, BusinessIds.SeleID, 
                                                           BusinessIds.ProxID, BusinessIds.POWID, BusinessIds.EmpID, 
                                                           BusinessIds.DotID, CompanyName));
      RETURN bizBusinessAssocHashCalc;
    END;
    
  EXPORT UNSIGNED8 fn_calcTopBusinessExecutivesHash (DATASET(iesp.topbusinessreport.t_TopBusinessIndividual) current, 
                                                     DATASET(iesp.topbusinessreport.t_TopBusinessIndividual) prior) := 
    FUNCTION
      bizExecutiveHash := SUM(current, HASH64(UniqueId, HasDerog, IsDeceased,
                                              ExecutiveElsewhere, BestPosition.CompanyTitle)
                                      + calcNameHash(Name.First,Name.Middle,Name.Last,''))
                        + SUM(prior, HASH64(UniqueId));
      RETURN bizExecutiveHash;
    END;
  
  EXPORT UNSIGNED8 fn_calcTopBusinessEmployeeHash (DATASET(iesp.topbusinessreport.t_TopBusinessIndividual) L) := 
    FUNCTION
      bizEmployeeHash := SUM(L, HASH64(UniqueId) + calcNameHash(Name.First,Name.Middle,Name.Last,''));
      RETURN bizEmployeeHash;
    END;
    
  EXPORT UNSIGNED8 fn_calcTopBusinessContactsHash (iesp.midexcompreport.t_MIDEXCompTopBusinessContactSection L) := 
    FUNCTION
      bizContactHash := fn_calcTopBusinessExecutivesHash(L.CurrentExecutives, L.PriorExecutives) +
                          fn_calcTopBusinessEmployeeHash(L.CurrentIndividuals);
      RETURN bizContactHash;
    END;
  
  EXPORT UNSIGNED8 fn_calcTopBusinessCorpFilingsHash (DATASET(iesp.TopBusinessReport.t_TopBusinessIncorporationInfo) L) := 
    FUNCTION
      bizCorpFilingHash := SUM(L, HASH64(CorporationName, BusinessStatus, FilingNumber, StateOfOrigin));
      RETURN bizCorpFilingHash;
    END;
    
   // --------------------------------------------------------------------------------------------------------------
  //               Alert Transforms
  // -------------------------------------------------------------------------------------------------------------- 
   
  EXPORT MIDEX_Services.Layouts.license_srch_layout calcLicenseSrchHashes (MIDEX_Services.Layouts.license_srch_layout l) := TRANSFORM
    SELF.name_hash := calcNameHash(l.licensee_FirstName,l.licensee_MidName,l.licensee_LastName,l.licensee_companyName);
                                 // Alerts were captured with a truncated license status(first 25 chars) when the
                                 // default license status was added to the keys. To avoid alerts firing when the 
                                 // status is no longer truncated, a check is made and if it matches the
                                 // default status, only the first 25 chars will be used
    vLicStatus := IF(l.lic_status = MIDEX_Services.Constants.LIC_NOT_REPORTED,l.lic_status[1..25],l.lic_status);
    SELF.prev_license_status_hash := HASH64(vLicStatus);
    SELF.license_status_hash := HASH64(vLicStatus,l.isCurrent);
    SELF.address_hash :=  calcAddrHash(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,
                                       l.city,l.st,l.zip5);
    SELF.phone_hash :=  HASH64(l.phone);
    SELF.license_hash := HASH64(l.lic_number);
    SELF.license_expir_hash := HASH64(l.lic_expir_date);
    SELF.nmls_id_hash := SUM(l.nmls_info,HASH64(nmlsId));
    SELF.incident_hash := 0;
    SELF.prev_all_hash := SELF.name_hash + SELF.prev_license_status_hash + SELF.license_hash + SELF.address_hash + SELF.incident_hash + 
                          SELF.phone_hash + SELF.nmls_id_hash + SELF.license_expir_hash;
    SELF.all_hash := SELF.name_hash + SELF.license_status_hash + SELF.license_hash + SELF.address_hash + SELF.incident_hash + 
                     SELF.phone_hash + SELF.nmls_id_hash + SELF.license_expir_hash;
    SELF := l;
  END;
  
  EXPORT MIDEX_Services.Layouts.rec_temp_layout calcMidexSrchHashes (MIDEX_Services.Layouts.rec_temp_layout l) := TRANSFORM
    SELF.name_hash := calcNameHash(l.FirstName,l.MiddleName,l.LastName,l.CompanyName);
    SELF.prev_license_status_hash  := 0;
    SELF.license_status_hash := 0;
    SELF.address_hash :=  calcAddrHash(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,
                                       l.city,l.st,l.zip5);
    SELF.phone_hash    := HASH64(l.phone);
    SELF.license_hash  := HASH64(l.licenseNumber);
    SELF.incident_hash := HASH64(l.publicIncidentNum);
    SELF.prev_all_hash := SELF.name_hash + SELF.prev_license_status_hash + SELF.license_hash + SELF.address_hash + 
                     SELF.incident_hash + SELF.phone_hash + HASH64(l.midex_rpt_nbr);
    SELF.all_hash := SELF.name_hash + SELF.license_status_hash + SELF.license_hash + SELF.address_hash + 
                     SELF.incident_hash + SELF.phone_hash + HASH64(l.midex_rpt_nbr);
    SELF := l;
  END;
  
  
  EXPORT MIDEX_Services.Layouts.LicenseReport_Layout calcLicenseReptHashes (MIDEX_Services.Layouts.LicenseReport_Layout l,UNSIGNED alertVersion) := TRANSFORM
    SELF.name_hash := calcNameHash(l.FirstName,l.MiddleName,l.LastName,l.companyName);
    // Previous version of the alert version doesn't include "isCurrent" in the calculation of license status hash
    SELF.prev_license_status_hash := SUM(l.Licenses,HASH64(lic_number,lic_status,lic_type,lic_state,lic_issue_date,lic_expir_date));
    SELF.license_status_hash := SUM(l.Licenses,HASH64(lic_number,lic_status,lic_type,lic_state,lic_issue_date,lic_expir_date,isCurrent));
    SELF.address_hash := (calcAddrHash(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,
                                       l.city,l.st,l.zip5) +
                          calcAddrHash(l.company_prim_range,l.company_predir,l.company_prim_name,l.company_addr_suffix,l.company_postdir,
                                       l.company_sec_range,l.company_city,l.company_st,l.company_zip5));
    SELF.phone_hash := HASH64(l.phone);
    SELF.license_hash := 0;
    SELF.incident_hash := 0;
    SELF.represent_hash := SUM(l.Represents,HASH64(comp_nmls_id,company_name,start_date,end_date));
    SELF.registration_hash := SUM(l.Regulators,HASH64(authorized,regulator_name,registration_name,SUM(Registrations,HASH64(comp_nmls_id,lic_number,reg_status,org_issue_date,status_date,renewed_thru))));
    SELF.disciplinary_hash := SUM(l.Disc_Actions,HASH64(regulator_name,authority_name,authority_type,action_date,
                                                        action_type,assoc_doc,action_detail)) +
                                  SUM(l.Reg_Actions,HASH64(regulator_name,authority_name,authority_type,action_date,
                                                           action_type,assoc_doc,action_detail));
    SELF.nmls_id_hash := HASH64(l.nmls_id);
    SELF.AKA_and_name_variation_hash := HASH64(l.DBAName);
    SELF.prev_all_hash := SELF.name_hash + SELF.prev_license_status_hash + SELF.address_hash + SELF.incident_hash + SELF.phone_hash +
                           SELF.represent_hash + SELF.registration_hash + SELF.disciplinary_hash + SELF.nmls_id_hash
                           + SELF.AKA_and_name_variation_hash;
    SELF.all_hash := SELF.name_hash + SELF.license_status_hash + SELF.address_hash + SELF.incident_hash + SELF.phone_hash +
                     SELF.represent_hash + SELF.registration_hash + SELF.disciplinary_hash + SELF.nmls_id_hash
                     + SELF.AKA_and_name_variation_hash;
    SELF := l;
  END;


   // --------------------------------------------------------------------------------------------------------------
  //              Incident Alert Calculations
  // -------------------------------------------------------------------------------------------------------------- 
  // product requested a single alert for Incidents and wants the alert to flag any change within
  // the output. 
  EXPORT MIDEX_Services.Layouts.CompReport_TempLayout xfm_calcMidexIncidentHashes (MIDEX_Services.Layouts.CompReport_TempLayout l) := 
    TRANSFORM
      address_hash  := (calcAddrHash(l.prim_range,l.predir,l.prim_name,l.addr_suffix,
                                     l.postdir,l.sec_range,l.city,l.st,l.zip5) +
                        calcAddr2Hash(l.propertyAddr, '', l.propertyCity, l.propertyState, 
                                      l.propertyZip));
      freddieIncidentTextSlimmed_hash := calcTextLayoutSlimmedHash(l.freddieIncidentText);
      incidentTextSlimmed_hash := calcTextLayoutSlimmedHash(l.incidentText);
      license_hash  := SUM(l.Licenses,HASH64(Number,_type, IssueState)) + HASH64(l.nmlsType) + HASH64(l.nmlsId);
      name_hash     := calcNameHash(l.FirstName,l.MiddleName,l.LastName,l.CompanyName);
      nameDescriptors_hash := calcNameDescHash(l.uniqueId,l.businessId,l.ssn,l.dob,l.personAKA,
                                               l.jobTitle,l.companyName,l.companyAka,l.tin,
                                               l.PartyPosition,l.PartyFirm,l.PartyEmployer,l.ename);                                
      // phone_hash               :=  HASH64(l.phone);
      phone_hash               :=  0;
      professionsSlimmed_hash  := calcStringArrayHash(l.Professions);
      publicActions_hash       := calcStringArrayHash(l.PublicActions);
      responseTextSlimmed_hash := calcTextLayoutSlimmedHash(l.responseText);
      sanction_hash            := calcSanctnHash(l.MIDEXFileNumber,l.dbcode,l.dataSource, 
                                                 l.incidentDate,l.sourceDocument,l.jurisdiction, 
                                                 l.caseNumber,l.additionalInfo,l.incidentReportedOnDate,
                                                 l.entryDate,l.modifiedDate,l.action,l.incidentVerification,
                                                 l.otherInfo,l.Restitution,l.FINES_LEVIED,
                                                 l.Alleged_amount,l.Estimated_loss);
      incidentParty_hash        := SUM(l.IncidentParties, 
                                       HASH64(tin,additionalInfo,ssn,partyEmployer,partyPosition,
                                              partyFirm,uniqueId,businessId,dob.year,dob.month,dob.day/*,phone*/) +
                                       calcNameHash(name.First,name.Middle,name.Last,'') +
                                       calcAddrHash(address.StreetNumber,address.StreetPreDirection,
                                                    address.StreetName,address.StreetSuffix,
                                                    address.StreetPostDirection,address.UnitNumber,
                                                    address.city,address.state,address.zip5) +
                                       calcIespLicenseHash(Licenses) +
                                       calcStringArrayHash(Professions) + 
                                       calcStringArrayHash(OtherIdentifyingReferences)
                                      );                                         
      combinedHashes            := address_hash + freddieIncidentTextSlimmed_hash + incidentTextSlimmed_hash + 
                                   license_hash + name_hash + nameDescriptors_hash + phone_hash + 
                                   professionsSlimmed_hash + publicActions_hash + responseTextSlimmed_hash + 
                                   sanction_hash + incidentParty_hash;
      SELF.name_hash            := 0;
      SELF.license_status_hash  := 0;
      SELF.address_hash         := 0;
      SELF.phone_hash           := 0;
      SELF.license_hash         := 0;
      SELF.incident_hash        := combinedHashes;
      SELF.all_hash             := combinedHashes;
      SELF := l;
  END;


   // --------------------------------------------------------------------------------------------------------------
  //              Smartlinx Business Alert Calculations
  // --------------------------------------------------------------------------------------------------------------
  
  EXPORT MIDEX_Services.Layouts.hash_layout xfm_calcMidexSmartlinxBusinessHashes( iesp.midexcompreport.t_MIDEXCompBusinessSmartLinxRecord L) := 
    TRANSFORM
      // calculated the hashes separately so that if the all_hash is needed in the future, we can use the independent 
      // option for the calculations and assign the values to the layout and add them without the system having to
      // recalculate the datasets/hashes
      BestInformation					:= L.BestInformation;
      address_hash            := calcAddrHash(BestInformation.Address.StreetNumber,BestInformation.Address.StreetPreDirection,BestInformation.Address.StreetName,
                                              BestInformation.Address.StreetSuffix,BestInformation.Address.StreetPostDirection,BestInformation.Address.UnitDesignation,
                                              BestInformation.Address.City,BestInformation.Address.State,BestInformation.Address.Zip5); // use if all_hash is calculated    :INDEPENDENT;
      name_hash               := HASH64(BestInformation.CompanyName); 
      name_variation_hash			:= SUM(L.NameVariations, HASH64(CompanyName));
      phone_hash              := HASH64(BestInformation.PhoneInfo.Phone10); 
      bankruptcy_hash         := fn_calcSmartlinxBizBankruptcyHash(L.Bankruptcies); 
      lien_judgment_hash      := fn_calcSmartlinxBizLiensJudgmentsHash(L.LiensJudgments); 
      property_hash						:= fn_calcSmartlinxBizPropertiesHash(L.Properties);
      bus_associate_hash			:= fn_calcSmartLinxBizBusinessAssociatesHash(L.BusinessAssociates);
      SELF.name_hash          := name_hash;
      SELF.name_variation_hash:= name_variation_hash;
      SELF.address_hash       := address_hash;
      SELF.phone_hash         := phone_hash;
      SELF.bankruptcy_hash    := bankruptcy_hash;
      SELF.lien_judgment_hash := lien_judgment_hash;
      SELF.property_hash			:= property_hash;
      SELF.bus_associate_hash	:= bus_associate_hash;
      SELF                    := [];
      END; // function


   // --------------------------------------------------------------------------------------------------------------
  //              TopBusiness Alert Calculations
  // --------------------------------------------------------------------------------------------------------------
  
  EXPORT MIDEX_Services.Layouts.hash_layout xfm_calcMidexTopBusinessHashes(iesp.midexcompreport.t_MIDEXCompTopBusinessRecord L) := 
    TRANSFORM
      BestInformation					:= L.BestSection;
      address_hash            := calcAddrHash(BestInformation.Address.StreetNumber,BestInformation.Address.StreetPreDirection,BestInformation.Address.StreetName,
                                              BestInformation.Address.StreetSuffix,BestInformation.Address.StreetPostDirection,BestInformation.Address.UnitDesignation,
                                              BestInformation.Address.City,BestInformation.Address.State,BestInformation.Address.Zip5);
      name_hash               := HASH64(BestInformation.CompanyName); 
      name_variation_hash			:= SUM(BestInformation.OtherCompanyNames, HASH64(CompanyName));
      phone_hash              := HASH64(BestInformation.PhoneInfo.Phone10); 
      bankruptcy_hash         := fn_calcTopBusinessBankruptcyHash(L.BankruptcySection.AsDebtors); 
      lien_judgment_hash      := fn_calcTopBusinessLiensJudgmentsHash(L.LienSection.JudgmentsLiens); 
      property_hash						:= fn_calcTopBusinessPropertiesHash(L.PropertySection.PropertyRecords.Properties);
      bus_associate_hash			:= fn_calcTopBusinessBusAssociatesHash(L.AssociateSection.BusinessAssociates, L.ConnectedBusinessSection.ConnectedBusinessRecords);
      executive_hash					:= fn_calcTopBusinessContactsHash(L.ContactSection);
      sos_hash								:= fn_calcTopBusinessCorpFilingsHash(L.IncorporationSection.CorpFilings);
      SELF.name_hash          := name_hash;
      SELF.name_variation_hash:= name_variation_hash;
      SELF.address_hash       := address_hash;
      SELF.phone_hash         := phone_hash;
      SELF.bankruptcy_hash    := bankruptcy_hash;
      SELF.lien_judgment_hash := lien_judgment_hash;
      SELF.bus_associate_hash	:= bus_associate_hash;
      SELF.executive_hash			:= executive_hash;
      SELF.sos_hash						:= sos_hash;
      SELF                    := [];
    END; // function


   // --------------------------------------------------------------------------------------------------------------
  //              Smartlinx Person Alert Calculations
  // --------------------------------------------------------------------------------------------------------------
  
  EXPORT MIDEX_Services.Layouts.hash_layout xfm_calcMidexSmartlinxPersonHashes( iesp.midexcompreport.t_MIDEXCompPersonSmartlinxRecord L) := 
    TRANSFORM
      BestInformation						:= L.BestInformation;
      address_hash              := calcAddrHash( BestInformation.Address.StreetNumber,BestInformation.Address.StreetPreDirection,BestInformation.Address.StreetName,
                                                 BestInformation.Address.StreetSuffix,BestInformation.Address.StreetPostDirection,BestInformation.Address.UnitDesignation,
                                                 BestInformation.Address.City,BestInformation.Address.State,BestInformation.Address.Zip5);
      name_hash                 := calcNameHash(BestInformation.Name.First,BestInformation.Name.Middle,BestInformation.Name.Last,'');
      phone_hash                := HASH64(BestInformation.PhonesV2[1].Phone10);
      bankruptcy_hash           := fn_calcSmartlinxPersonBankruptcyHash(L.Bankruptcies);
      criminal_hash							:= fn_calcSmartlinxPersonCriminalHash(L.Criminals) + fn_calcPersonSexOffensesHash(L.SexualOffenses);
      lien_judgment_hash        := fn_calcSmartlinxPersonLiensJudgmentsHash(L.LiensJudgments);
      property_hash							:= fn_calcSmartlinxPersonPropertyHash(L.Properties);
      bus_associate_hash				:= fn_calcSmartlinxPersonBusinessAssociateHash(L.OtherAssociatedBusinesses, L.CorporateAffiliations);
      employer_hash							:= fn_calcSmartlinxPersonEmployerHash(L.PeopleAtWorks);
      email_hash								:= fn_calcSmartlinxPersonEmailHash(L.EmailAddresses);
      relative_hash							:= SUM(L.Relatives, HASH64(UniqueId));
      SELF.address_hash         := address_hash;
      SELF.name_hash            := name_hash;
      SELF.phone_hash           := phone_hash;
      SELF.bankruptcy_hash      := bankruptcy_hash;
      SELF.criminal_hash        := criminal_hash;
      SELF.lien_judgment_hash   := lien_judgment_hash;
      SELF.property_hash				:= property_hash;
      SELF.bus_associate_hash		:= bus_associate_hash;
      SELF.employer_hash				:= employer_hash;
      SELF.email_hash						:= email_hash;
      SELF.relative_hash				:= relative_hash;
      SELF                      := [];
    END;
 

   // --------------------------------------------------------------------------------------------------------------
  //              Calculate Alert Changes
  // --------------------------------------------------------------------------------------------------------------
  
  EXPORT calcChanges(DATASET(MIDEX_Services.Layouts.Monitor_layout) l, MIDEX_Services.IParam.reportrecords in_mod) := FUNCTION
    alertResults := PROJECT(l,TRANSFORM(MIDEX_Services.Layouts.Monitor_layout,
                            license_status_hash := IF(in_mod.AlertVersion = Midex_Services.Constants.AlertVersion.Current,
                                                      (STRING) LEFT.license_status_hash,
                                                      (STRING) LEFT.prev_license_status_hash);
                            SELF.nameChanged := IF(in_mod.trackname,
                                                    (LEFT.passed_name_hash != (STRING) LEFT.name_hash)
                                                    ,FALSE);
                            SELF.addressChanged := IF(in_mod.trackaddress,
                                                      (LEFT.passed_address_hash != (STRING) LEFT.address_hash)
                                                      ,FALSE);
                            SELF.phoneChanged   := IF(in_mod.trackphone,
                                                      (LEFT.passed_phone_hash != (STRING) LEFT.phone_hash)
                                                      ,FALSE);
                            SELF.BankruptcyChanged := IF(in_mod.trackBankruptcy,
                                                          (LEFT.passed_bankruptcy_hash != (STRING) LEFT.bankruptcy_hash)
                                                          ,FALSE);
                            SELF.CriminalChanged := IF(in_mod.trackCriminal,
                                                        (LEFT.passed_criminal_hash != (STRING) LEFT.criminal_hash)
                                                        ,FALSE);
                            SELF.incidentChanged := IF(in_mod.TrackIncident,
                                                        (LEFT.passed_incident_hash != (STRING) LEFT.incident_hash)
                                                        ,FALSE);
                            SELF.licenseStatusChanged := IF(in_mod.tracklicensestatus,
                                                            (LEFT.passed_license_status_hash != license_status_hash)
                                                            ,FALSE);
                            SELF.LienJudgmentChanged := IF(in_mod.trackLienJudgment,
                                                            (LEFT.passed_lien_judgment_hash != (STRING) LEFT.lien_judgment_hash)
                                                            ,FALSE);
                            SELF.NMLSIdChanged := IF(in_mod.TrackNMLSId,
                                                      (LEFT.passed_NMLS_Id_hash != (STRING) LEFT.NMLS_Id_hash)
                                                      ,FALSE);
                            SELF.RepresentChanged := IF(in_mod.trackRepresent,
                                                        (LEFT.passed_Represent_hash != (STRING) LEFT.Represent_hash)
                                                        ,FALSE);
                            SELF.RegistrationChanged := IF(in_mod.trackRegistration,
                                                            (LEFT.passed_Registration_hash != (STRING) LEFT.Registration_hash)
                                                            ,FALSE);
                            SELF.DisciplinaryChanged := IF(in_mod.trackDisciplinary,
                                                            (LEFT.passed_Disciplinary_hash != (STRING) LEFT.Disciplinary_hash)
                                                            ,FALSE);
                            SELF.EmailChanged := IF(in_mod.trackEmail,
                                                      (LEFT.passed_email_hash != (STRING) LEFT.email_hash)
                                                      ,FALSE);
                            SELF.PropertyChanged := IF(in_mod.trackProperty,
                                                      (LEFT.passed_property_hash != (STRING) LEFT.Property_hash)
                                                      ,FALSE);
                            SELF.BusinessAssociateChanged := IF(in_mod.trackBusinessAssociate,
                                                      (LEFT.passed_bus_associate_hash != (STRING) LEFT.bus_associate_hash)
                                                      ,FALSE);
                            SELF.RelativeChanged := IF(in_mod.trackRelative,
                                                      (LEFT.passed_relative_hash != (STRING) LEFT.relative_hash)
                                                      ,FALSE);	
                            SELF.EmployerChanged := IF(in_mod.trackEmployer,
                                                      (LEFT.passed_employer_hash != (STRING) LEFT.Employer_hash)
                                                      ,FALSE);																												
                            SELF.NameVariationChanged := IF(in_mod.trackNameVariation,
                                                      (LEFT.passed_name_variation_hash != (STRING) LEFT.name_variation_hash)
                                                      ,FALSE);	
                            SELF.ExecutiveChanged := IF(in_mod.trackExecutive,
                                                      (LEFT.passed_executive_hash != (STRING) LEFT.executive_hash)
                                                      ,FALSE);
                            SELF.SecretaryOfStateFilingChanged := IF(in_mod.trackSecretaryOfStateFiling,
                                                      (LEFT.passed_sos_hash != (STRING) LEFT.sos_hash)
                                                      ,FALSE);				
                            SELF.AKAAndNameVariationChanged := IF(in_mod.trackAKAAndNameVariation,
                                                      (LEFT.passed_AKA_and_name_variation_hash != (STRING) LEFT.AKA_and_name_variation_hash)
                                                      ,FALSE);																													
                            SELF.anyChanged := LEFT.passed_all_hash != (STRING) LEFT.all_hash;
                            SELF := LEFT;
                            SELF := [];));
    RETURN(alertResults);
  END;
 
END;
