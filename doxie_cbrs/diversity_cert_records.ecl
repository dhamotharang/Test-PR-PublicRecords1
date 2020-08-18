IMPORT Diversity_Certification,ut,iesp;
/* Attribute that will return any diversity certification information for the passed bdids */

doxie_cbrs.mac_Selection_Declare()

EXPORT diversity_cert_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  div_recs :=
      JOIN(
        bdids,
        Diversity_Certification.Key_DiversityCert_BDID,
        KEYED(LEFT.bdid = RIGHT.bdid),
        TRANSFORM(RIGHT),
        LIMIT(ut.limits.default, SKIP)
      );

  // Formating for IESP layout
  
  iesp.diversitycertification.t_DiversityCertificationRecord format_iesp(RECORDOF(div_recs) l) := TRANSFORM
    SELF.FederallyCertified := l.certfed;
    SELF.StateCertified := l.certstate;
    SELF.AcceptsFederalContracts := l.contractsfederal;
    SELF.AcceptsVAContacts := l.contractsva;
    SELF.AcceptsCommercialContracts := l.contractscommercial;
    SELF.IsGovernmentPrimeContractor := l.ContractorGovernmentPrime;
    SELF.IsGovernmentSubContractor := l.ContractorGovernmentSub;
    SELF.IsNonGovernmentContractor := l.ContractorNonGovernment;
    SELF.IsGovernmentRegisteredBusiness := l.registeredgovernmentbus;
    SELF.IsNonGovernmentRegisteredBusiness := l.registerednongovernmentbus;
    SELF.Minority.Affiliation := l.minorityaffiliation;
    SELF.Minority.OwnershipDate := iesp.ECL2ESP.toDatestring8(l.minorityownershipdate);
    SELF.PrequalifiedForBidding := l.prequalify;
    SELF.Vendor.key := l.vendorkey;
    SELF.Vendor.number := l.vendornumber;
    SELF.IssuingAuthority := l.issuingauthority;
    
    certTrans(STRING DateTo, STRING DateFrom, STRING Status, STRING Number, STRING _Type) :=
          TRANSFORM(iesp.diversitycertification.t_DivCertCertification,
                        SELF.Date.StartDate := iesp.ECL2ESP.toDatestring8(DateFrom);
                        SELF.Date.EndDate := iesp.ECL2ESP.toDatestring8(DateTo);
                        SELF.Status := Status,
                        SELF.Number := Number,
                        SELF._Type := _Type);
    
    certRecs := DATASET([ CertTrans(l.certificatedateto1,l.certificatedatefrom1,l.certificatestatus1,l.certificationnumber1,l.certificationtype1),
                          CertTrans(l.certificatedateto2,l.certificatedatefrom2,l.certificatestatus2,l.certificationnumber2,l.certificationtype2),
                          CertTrans(l.certificatedateto3,l.certificatedatefrom3,l.certificatestatus3,l.certificationnumber3,l.certificationtype3),
                          CertTrans(l.certificatedateto4,l.certificatedatefrom4,l.certificatestatus4,l.certificationnumber4,l.certificationtype4),
                          CertTrans(l.certificatedateto5,l.certificatedatefrom5,l.certificatestatus5,l.certificationnumber5,l.certificationtype5),
                          CertTrans(l.certificatedateto6,l.certificatedatefrom6,l.certificatestatus6,l.certificationnumber6,l.certificationtype6)]);
    SELF.Certifications := CHOOSEN(certRecs(Date.StartDate.Year != 0 OR Date.EndDate.Year !=0 OR Status!='' OR Number != '' OR _Type != ''),iesp.constants.DiversityCert.MaxCertifications);
    
    exportRecs := DATASET([{l.exporter,l.exportbusinessactivities,l.exportto,l.exportbusinessrelationships,l.exportobjectives}],iesp.diversitycertification.t_DivCertExporter);
    SELF.Exporters := CHOOSEN(exportRecs,iesp.constants.DiversityCert.MaxExports);
    
    refRecs := DATASET([{l.reference1},{l.reference2},{l.reference3}],iesp.share.t_StringArrayItem);
    SELF.BusinessReferences := CHOOSEN(refRecs(value!= ''),iesp.constants.DiversityCert.MaxBusinessReferences);
    
    procRecs := DATASET([{l.procurementcategory1,l.subprocurementcategory1},
                          {l.procurementcategory2,l.subprocurementcategory2},
                         {l.procurementcategory3,l.subprocurementcategory3},
                         {l.procurementcategory4,l.subprocurementcategory4},
                         {l.procurementcategory5,l.subprocurementcategory5}],iesp.diversitycertification.t_DivCertProcurement);
    SELF.Procurements := CHOOSEN(procRecs(Category!= '' OR SubCategory!= ''),iesp.constants.DiversityCert.MaxProcurements);
    
    workRecs := DATASET([{l.workcode1},{l.workcode2},{l.workcode3},{l.workcode4},
                         {l.workcode5},{l.workcode6},{l.workcode7},{l.workcode8}],iesp.share.t_StringArrayItem);
    SELF.WorkCodes := CHOOSEN(workRecs(value!=''),iesp.constants.DiversityCert.MaxWorkCodes);
    SELF := [];
  END;
  
  div_out := PROJECT(div_recs,format_iesp(LEFT));
  divDedup := DEDUP(SORT(div_out,RECORD),RECORD);
    
  SHARED div_final := CHOOSEN(divDedup(Include_DiversityCert_val),iesp.constants.DiversityCert.MaxDiversityCert);

  EXPORT records := CHOOSEN(div_final,Max_DiversityCert_val);
  EXPORT records_count := COUNT(div_final);

END;
