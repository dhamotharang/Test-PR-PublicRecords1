// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- return Midex Report information.*/
/* HELP Midex Nonpublic is bit16, Freddie Mac is 17 in the DataRestrictionMask */
// <message name="DataPermissionMask: 8 = Midex Nonpublic 9 = Midex Freddie Mac">
// NOTE: the data Permission mask was implemented instead of the restriction mask due
// to a request from Jiafu and Joe Gayda (engineering lead). Per Jiafu, using the
// data restriction mask, we didn't have to do a database sweep.

IMPORT AutoStandardI, AutoheaderV2, BIPV2, iesp, MIDEX_Services, STD;

EXPORT MidexReportService :=
  MACRO
    #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    #ONWARNING(4207, ignore);
    // Get XML input
    rec_in := iesp.midexcompreport.t_MIDEXCompReportRequest;
    ds_in := DATASET ([], rec_in) : STORED ('MIDEXCompReportRequest', FEW);
    first_row := ds_in[1] : INDEPENDENT;
    
    iesp.ECL2ESP.SetInputBaseRequest (first_row);

    // Store main search criteria:
    ReportBy := GLOBAL (first_row.ReportBy);
    ReportOptions := GLOBAL (first_row.Options);
    AlertInput := GLOBAL (first_row.AlertInput);
    AlertOptions := GLOBAL (first_row.AlertInput.Options);
    AlertHashes := GLOBAL (first_row.AlertInput.Hashes);
    
    // Get input to search by // Running which portion of the comp report
    #STORED( 'MIDEXReportNumber', ReportBy.MIDEXReportNumber);
    #STORED( 'searchType', ReportBy.searchType);
    #STORED( 'BDID', ReportBy.BusinessId );
    #STORED( 'DID', ReportBy.UniqueId);
    #STORED( 'StartLoadDate', iesp.ECL2ESP.t_DateToString8(ReportBy.StartLoadDate));
    #STORED('DotID', ReportBy.BusinessIds.DotID);
    #STORED('EmpID', ReportBy.BusinessIds.EmpID);
    #STORED('POWID', ReportBy.BusinessIds.POWID);
    #STORED('SeleID', ReportBy.BusinessIds.SeleID);
    #STORED('ProxID', ReportBy.BusinessIds.ProxID);
    #STORED('OrgID', ReportBy.BusinessIds.OrgID);
    #STORED('UltID', ReportBy.BusinessIds.UltID);
  
    UNSIGNED6 s_DotID := 0 : STORED('DotID');
    UNSIGNED6 s_EmpID := 0 : STORED('EmpID');
    UNSIGNED6 s_PowID := 0 : STORED('PowID');
    UNSIGNED6 s_ProxID := 0 : STORED('ProxID');
    UNSIGNED6 s_SeleID := 0 : STORED('SeleID');
    UNSIGNED6 s_OrgID := 0 : STORED('OrgID');
    UNSIGNED6 s_UltID := 0 : STORED('UltID');
    STRING1 BusinessReportFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BusinessReportFetchLevel');
    
    // Added back into the Service level because the defaults when the service is run are not
    // correct for what is needed to run the Business SmartLinx Report
    STRING BDL := '' : STORED('BDL');

    #CONSTANT('TwoPartySearch', FALSE);
    #CONSTANT( 'Include_AssociatedPeople', TRUE );
    #CONSTANT( 'IncludeBankruptciesV2', FALSE );
    #CONSTANT( 'IncludeBestInfo', TRUE );
    #CONSTANT( 'IncludePropertiesV2', FALSE );
    #CONSTANT( 'Include_SourceCounts', TRUE );
    #CONSTANT( 'Include_SourceFlags', TRUE );
    #CONSTANT( 'IncludeMultipleSecured', TRUE );
    #CONSTANT( 'Include_NameVariations', TRUE );
    #CONSTANT( 'IncludeHRI', TRUE );
    #CONSTANT( 'Include_HRI', TRUE );
    #CONSTANT( 'IncludeZeroDidRefs', FALSE );
    #CONSTANT( 'IsCrs', TRUE );
    #CONSTANT( 'IsDayBr', TRUE );
    #CONSTANT( 'ReturnRolledDebtors', TRUE );
    #CONSTANT( 'UseLevels', TRUE );
    #CONSTANT( 'UseSuperGroup', TRUE );
    
    #CONSTANT( 'UseSupergroup',(UNSIGNED)bdl = 0);

    #CONSTANT( 'PropertyVersion', 0 );
    #CONSTANT( 'MaxAddressVariations', 100 );
    #CONSTANT( 'MaxBankruptciesV2', 50 );
    #CONSTANT( 'MaxBusinessAssociates', 50 );
    #CONSTANT( 'MaxAssociatedPeople', 150 );
    #CONSTANT( 'Max_LiensJudgmentsUCC_val', 10 );
    #CONSTANT( 'MaxPhoneVariations', 100 );
    #CONSTANT( 'MaxProperties', 100 );
    #CONSTANT( 'MaxNameVariations', 100 );
    #CONSTANT( 'MaxCompanyIdNumbers', 100 );
    #CONSTANT( 'MaxIndustryInformation', 100 );
    #CONSTANT( 'MaxLiensJudgmentsUcc', 100 );
    #CONSTANT( 'MaxMotorVehicles', 100 );
    #CONSTANT( 'MaxUccFilings', 100 );
    #CONSTANT( 'MaxWatercrafts', 100 );
    #CONSTANT( 'ZipRadius', 0 );
    
    STRING MIDEXReportNumber := '' : STORED( 'midexReportNumber' );
    in_midexReportNum_inDataset := DATASET([{TRIM(STD.STR.ToUpperCase(MIDEXReportNumber), LEFT, RIGHT),'','',''}],MIDEX_Services.Layouts.rec_midex_payloadKeyField);
    
    MIDEX_Services.Macros.MAC_getIncidentNumFromMidexReportNum( in_midexReportNum_inDataset, ds_MidexRptNbrDatasetWithBatchIncidentAndPartyNbrs);
    
    ds_MidexReportNumber := IF( MIDEXReportNumber = '',
                                DATASET([],MIDEX_Services.Layouts.rec_midex_payloadKeyField),
                                ds_MidexRptNbrDatasetWithBatchIncidentAndPartyNbrs );
    
    // Create BIP dataset
    BIPV2.IDlayouts.l_xlink_ids initialize() := TRANSFORM
      SELF.DotID := s_dotid;
      SELF.EmpID := s_empid;
      SELF.PowID := s_powid;
      SELF.ProxID := s_proxid;
      SELF.SeleID := s_seleid;
      SELF.OrgID := s_orgid;
      SELF.UltID := s_ultid;
    END;
    
    bip_ds := DATASET([initialize()]);
    
    UNSIGNED1 vAlertVersion := IF(AlertInput.AlertVersion = Midex_Services.Constants.AlertVersion.None,
                                  Midex_Services.Constants.AlertVersion.Current,
                                  AlertInput.AlertVersion);
    
    input_params := AutoStandardI.GlobalModule();
    tempmod := MODULE(PROJECT(input_params,MIDEX_Services.Iparam.reportrecords,OPT));
      // SearchBy fields not handled by AutoStandardI.GlobalModule
      EXPORT DATASET MidexReportNumbers := ds_MidexReportNumber;
      EXPORT STRING1 searchType := '' : STORED('searchType');
      EXPORT STRING8 StartLoadDate := '' : STORED('StartLoadDate');
      EXPORT BOOLEAN EnableAlert := AlertInput.enableAlert;
      EXPORT UNSIGNED1 AlertVersion := IF(AlertInput.EnableAlert,vAlertVersion,Midex_Services.Constants.AlertVersion.None);
      EXPORT BOOLEAN includeSourceDocs := ReportOptions.IncludeSourceDocs;
      EXPORT BOOLEAN IncludeRelatives := ReportOptions.IncludeRelatives;
      EXPORT BOOLEAN IncludeSexualOffenses := ReportOptions.IncludeSexualOffenses;
      EXPORT BOOLEAN IncludePersonBusinessAssociates := ReportOptions.IncludePersonBusinessAssociates;
      EXPORT BOOLEAN IncludeCorporateAffiliations := ReportOptions.IncludeCorporateAffiliations;
      EXPORT BOOLEAN IncludeNoticeOfDefault := ReportOptions.IncludeNoticeOfDefault;
      EXPORT BOOLEAN IncludeForeclosures := ReportOptions.IncludeForeclosures;
      EXPORT BOOLEAN TrackAddress := AlertOptions.TrackAddress;
      EXPORT BOOLEAN TrackBankruptcy := AlertOptions.TrackBankruptcy;
      EXPORT BOOLEAN TrackCriminal := AlertOptions.TrackCriminal;
      EXPORT BOOLEAN TrackDisciplinary := AlertOptions.TrackNMLSDisciplinary;
      EXPORT BOOLEAN TrackIncident := AlertOptions.TrackIncident;
      EXPORT BOOLEAN TrackLicenseStatus := AlertOptions.TrackLicenseStatus;
      EXPORT BOOLEAN TrackLienJudgment := AlertOptions.TrackLienJudgment;
      EXPORT BOOLEAN TrackName := AlertOptions.TrackName;
      EXPORT BOOLEAN TrackNMLSId := AlertOptions.TrackNMLSId;
      EXPORT BOOLEAN TrackPhone := AlertOptions.TrackPhone;
      EXPORT BOOLEAN TrackRepresent := AlertOptions.TrackNMLSRepresents;
      EXPORT BOOLEAN TrackRegistration := AlertOptions.TrackNMLSRegistration;
      EXPORT BOOLEAN TrackEmail := AlertOptions.TrackEmail;
      EXPORT BOOLEAN TrackProperty := AlertOptions.TrackProperty;
      EXPORT BOOLEAN TrackBusinessAssociate := AlertOptions.TrackBusinessAssociate;
      EXPORT BOOLEAN TrackRelative := AlertOptions.TrackRelative;
      EXPORT BOOLEAN TrackEmployer := AlertOptions.TrackEmployer;
      EXPORT BOOLEAN TrackNameVariation := AlertOptions.TrackNameVariation;
      EXPORT BOOLEAN TrackExecutive := AlertOptions.TrackExecutive;
      EXPORT BOOLEAN TrackSecretaryOfStateFiling := AlertOptions.TrackSecretaryOfStateFiling;
      EXPORT STRING25 addressHash := AlertHashes.Address.HashValue;
      EXPORT STRING25 BankruptcyHash := AlertHashes.Bankruptcy.HashValue;
      EXPORT STRING25 CriminalHash := AlertHashes.Criminal.HashValue;
      EXPORT STRING25 DisciplinaryHash := AlertHashes.NMLSDisciplinary.HashValue;
      EXPORT STRING25 incidentHash := AlertHashes.Incident.HashValue;
      EXPORT STRING25 licenseStatHash := AlertHashes.LicenseStatus.HashValue;
      EXPORT STRING25 LienJudgmentHash := AlertHashes.LienJudgment.HashValue;
      EXPORT STRING25 nameHash := AlertHashes.Name.HashValue;
      EXPORT STRING25 NMLSIdHash := AlertHashes.NMLSId.HashValue;
      EXPORT STRING25 phoneHash := AlertHashes.Phone.HashValue;
      EXPORT STRING25 RepresentHash := AlertHashes.NMLSRepresents.HashValue;
      EXPORT STRING25 RegistrationHash := AlertHashes.NMLSRegistration.HashValue;
      EXPORT STRING25 EmailHash := AlertHashes.Email.HashValue;
      EXPORT STRING25 PropertyHash := AlertHashes.Property.HashValue;
      EXPORT STRING25 RelativeHash := AlertHashes.Relative.HashValue;
      EXPORT STRING25 BusAssociateHash := AlertHashes.BusinessAssociate.HashValue;
      EXPORT STRING25 EmployerHash := AlertHashes.Employer.HashValue;
      EXPORT STRING25 NameVariationHash := AlertHashes.NameVariation.HashValue;
      EXPORT STRING25 ExecutiveHash := AlertHashes.Executive.HashValue;
      EXPORT STRING25 SOSHash := AlertHashes.SecretaryOfStateFiling.HashValue;
      EXPORT DATASET LinkIds := bip_ds;
      EXPORT STRING1 BusinessReportFetchLevel := TRIM(STD.STR.ToUpperCase(BusinessReportFetchLevel),LEFT,RIGHT);
      EXPORT BOOLEAN includeVendorSourceB := ReportOptions.IncludeVendorSourceB;
      EXPORT BOOLEAN IncludeAssignmentsAndReleases := ReportOptions.IncludeAssignmentsAndReleases;
    END;
  
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
  
  // *** call service records
  ds_results := Midex_Services.MidexReport_Records(tempmod, mod_access);
  
  OUTPUT(ds_results, NAMED('Results'));

ENDMACRO;
/*
For testing/debugging:
1. In the "MidexReportRequest" xml text area, use the sample xml input below
   filling in:
   a. the appropriate input/report options,
   b. the appropriate input/ReportBy data field(s),
   b. the ??? option (if needed/desired)
*/
  
