/*--SOAP--
<message name="SupplierRiskReport_Service" wuTimeout="300000">
  <!-- COMPLIANCE/USER SETTINGS -->
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>

  <part name="UltID" type="xsd:string"/>
  <part name="OrgID" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
  <part name="ProxID" type="xsd:string"/>
  <part name="PowID" type="xsd:string"/>
  <part name="EmpID" type="xsd:string"/>
  <part name="DotID" type="xsd:string"/>

  <part name="IncludeAircrafts" type="xsd:boolean"/>
  <part name="IncludeAssociatedBusinesses" type="xsd:boolean"/>
  <part name="IncludeBankruptcies" type="xsd:boolean"/>
  <part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
  <part name="IncludeCompanyVerification" type="xsd:boolean"/>
  <part name="IncludeConnectedBusinesses" type="xsd:boolean"/>
  <part name="IncludeContacts" type="xsd:boolean"/>
  <part name="IncludeDunBradStreet" type="xsd:boolean"/>
  <part name="IncludeExperianBusinessReports" type="xsd:boolean"/>
  <part name="IncludeFinances" type="xsd:boolean"/>
  <part name="IncludeIncorporation" type="xsd:boolean"/>
  <part name="IncludeIndustries" type="xsd:boolean"/>
  <part name="IncludeInternetDomains" type="xsd:boolean"/>
  <part name="IncludeIRS5500" type="xsd:boolean"/>
  <part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
  <part name="IncludeLiensJudgments" type="xsd:boolean"/>
  <part name="IncludeMotorVehicles" type="xsd:boolean"/>
  <part name="IncludeNameVariations" type="xsd:boolean"/>
  <part name="IncludeOpsSites" type="xsd:boolean"/>
  <part name="IncludeParents" type="xsd:boolean"/>
  <part name="IncludeProperties" type="xsd:boolean"/>
  <part name="IncludeUCCFilings" type="xsd:boolean"/>
  <part name="IncludeUCCFilingsSecureds" type = "xsd:boolean"/>
  <part name="IncludeRegisteredAgents" type="xsd:boolean"/>
  <part name="IncludeSanctions" type="xsd:boolean"/>
  <part name="IncludeWatercrafts" type="xsd:boolean"/>
  <part name="IncludeDiversityCert" type="xsd:boolean"/>
  <part name="IncludeRiskMetrics" type="xsd:boolean"/>
  <part name="IncludeLaborActWHD" type="xsd:boolean"/>
  <part name="IncludeNatDisReady" type="xsd:boolean"/>
  <part name="IncludeLNCA" type="xsd:boolean"/>
  <part name="IncludeOSHAIR" type="xsd:boolean"/>
  <part name="IncludeBusinessCreditRisk" type="xsd:boolean"/>
  <part name="IncludeBusinessFailureRiskLevel" type="xsd:boolean"/>
  <part name="IncludeCustomBCIR" type="xsd:boolean"/>
  <part name="IncludeSourceCounts" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="ReportFetchLevel" type="xsd:string"/>

  <part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>

  <part name="SupplierRiskReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>

</message>
*/
/*--INFO-- This service produces a full business report.*/
IMPORT iesp, autostandardi,risk_indicators, doxie;
EXPORT SupplierRiskReport_Service() := MACRO

  #CONSTANT('NoDeepDive', TRUE);
  rec_in := iesp.SupplierRiskReport.t_SupplierRiskReportRequest;
  ds_in := DATASET([],rec_in) : STORED('SupplierRiskReportRequest',few);
  first_row := ds_in[1] : INDEPENDENT;

  s_gateway := DATASET([],risk_indicators.Layout_Gateways_In) : STORED('gateways');
  iesp.ECL2ESP.SetInputBaseRequest (first_row);

  report_by := GLOBAL(first_row.ReportBy.BusinessId);

  report_options := GLOBAL(first_row.Options);
  user_options := GLOBAL(first_row.User);

  #STORED('DotID',report_by.DotID);
  #STORED('EmpID',report_by.EmpID);
  #STORED('POWID',report_by.POWID);
  #STORED('SeleID',report_by.SeleID);
  #STORED('ProxID',report_by.ProxID);
  #STORED('OrgID',report_by.OrgID);
  #STORED('UltID',report_by.UltID);

  STRING12 s_DotID := '' : STORED('DotID');
  STRING12 s_EmpID := '' : STORED('EmpID');
  STRING12 s_PowID := '' : STORED('PowID');
  STRING12 s_ProxID := '' : STORED('ProxID');
  STRING12 s_SeleID := '' : STORED('SeleID');
  STRING12 s_OrgID := '' : STORED('OrgID');
  STRING12 s_UltID := '' : STORED('UltID');

  //#stored('SelectAll',report_options.SelectAll);
  #STORED('IncludeAircrafts',report_options.IncludeAircrafts);
  #STORED('IncludeAssociatedBusinesses',report_options.IncludeAssociatedBusinesses);
  #STORED('IncludeBankruptcies',report_options.IncludeBankruptcies);
  #STORED('IncludeBusinessRegistrations', report_options.IncludeBusinessRegistrations);
  #STORED('IncludeCompanyVerification', report_options.IncludeCompanyVerification);
  #STORED('IncludeConnectedBusinesses', report_options.IncludeConnectedBusinesses);
  #STORED('IncludeContacts',report_options.IncludeContacts);
  #STORED('IncludeFinances',report_options.IncludeFinances);
  #STORED('IncludeIncorporation',report_options.IncludeIncorporation);
  #STORED('IncludeIndustries',report_options.IncludeIndustries);
  #STORED('IncludeInternetDomains',report_options.IncludeInternetDomains);
  #STORED('IncludeIRS5500',report_options.IncludeIRS5500);
  #STORED('IncludeProfessionalLicenses',report_options.IncludeProfessionalLicenses);
  #STORED('IncludeLiensJudgments',report_options.IncludeLiensJudgments);
  #STORED('IncludeMotorVehicles',report_options.IncludeMotorVehicles);
  #STORED('IncludeOpsSites',report_options.IncludeOpsSites);
  #STORED('IncludeNameVariations',report_options.IncludeNameVariations);
  #STORED('IncludeParents',report_options.IncludeParents);
  #STORED('IncludeProperties',report_options.IncludeProperties);
  #STORED('IncludeUCCFilings',report_options.IncludeUCCFilings);
  #STORED('IncludeUCCFilingsSecureds',report_options.IncludeUCCFilingsSecureds);
  #STORED('IncludeRegisteredAgents',report_options.IncludeRegisteredAgents);
  #STORED('IncludeSanctions',report_options.IncludeSanctions);
  #STORED('IncludeWatercrafts',report_options.IncludeWatercrafts);
  #STORED('IncludeSourceCounts',report_options.IncludeSourceCounts);
  #STORED('IncludeDunBradStreet',report_options.IncludeDunBradStreet);
  #STORED('IncludeExperianBusinessReports',report_options.IncludeExperianBusinessReports);
  #STORED('IncludeDiversityCert',report_options.IncludeDiversityCert);
  #STORED('IncludeRiskMetrics',report_options.IncludeRiskMetrics);
  #STORED('IncludeLaborActWHD',report_options.IncludeLaborActWHD);
  #STORED('IncludeNatDisReady',report_options.IncludeNatDisReady);
  #STORED('IncludeLNCA',report_options.IncludeLNCA);
  #STORED('IncludeOSHAIR',report_options.IncludeOSHAIR);
  #STORED('IncludeBusinessCreditRisk',report_options.IncludeBusinessCreditRisk);
  #STORED('IncludeBusinessFailureRiskLevel',report_options.IncludeBusinessFailureRiskLevel);
  #STORED('IncludeCustomBCIR',report_options.IncludeCustomBCIR);
  #STORED('LnBranded',user_options.LnBranded);
  #STORED('ReportFetchLevel','S'); //report_options.ReportFetchLevel);

  BOOLEAN AssociateBus := FALSE : STORED('IncludeAssociatedBusinesses');
  BOOLEAN Parent := FALSE : STORED('IncludeParents');
  BOOLEAN Con := FALSE : STORED('IncludeContacts');
  BOOLEAN Finance := FALSE : STORED('IncludeFinances');
  BOOLEAN OpsSites := FALSE : STORED('IncludeOpsSites');
  BOOLEAN InCorp := FALSE : STORED('IncludeIncorporation');
  BOOLEAN Indust := FALSE : STORED('IncludeIndustries');
  BOOLEAN URL := FALSE : STORED('IncludeInternetDomains');
  BOOLEAN UCCSect := FALSE : STORED('IncludeUCCFilings');
  BOOLEAN UCCSecureds := FALSE : STORED('IncludeUCCFilingsSecureds');
  BOOLEAN Liens := FALSE : STORED('IncludeLiensJudgments');
  BOOLEAN MVR := FALSE : STORED('IncludeMotorVehicles');
  BOOLEAN Aircraft := FALSE : STORED('IncludeAircrafts');
  BOOLEAN Wc := FALSE : STORED('IncludeWatercrafts');
  BOOLEAN Bk := FALSE : STORED('IncludeBankruptcies');
  BOOLEAN Prop := FALSE : STORED('IncludeProperties');
  BOOLEAN Source := FALSE : STORED('IncludeSourceCounts');
  BOOLEAN License := FALSE : STORED('IncludeProfessionalLicenses');
  BOOLEAN RA := FALSE : STORED('IncludeRegisteredAgents');
  BOOLEAN Connectedbusinesses := FALSE : STORED('IncludeConnectedBusinesses');
  BOOLEAN nameVariations := FALSE : STORED('IncludeNameVariations');
  BOOLEAN businessRegistrations := FALSE : STORED('IncludeBusinessRegistrations');
  BOOLEAN companyVerification := FALSE : STORED('IncludeCompanyVerification');
  BOOLEAN IRSFiftyFive := FALSE : STORED('IncludeIRS5500');
  BOOLEAN sanctions := FALSE : STORED('IncludeSanctions');
  BOOLEAN DNBSect := FALSE : STORED('IncludeDunBradStreet');
  BOOLEAN ExperianBusReport := FALSE : STORED('IncludeExperianBusinessReports');
  BOOLEAN DiversityCert := FALSE : STORED('IncludeDiversityCert');
  BOOLEAN RiskMetrics := FALSE : STORED('IncludeRiskMetrics');
  BOOLEAN LaborActWHD := FALSE : STORED('IncludeLaborActWHD');
  BOOLEAN NatDisReady := FALSE : STORED('IncludeNatDisReady');
  BOOLEAN LNCA := FALSE : STORED('IncludeLNCA');
  BOOLEAN OSHAIRx := FALSE : STORED('IncludeOSHAIR');
  BOOLEAN BusinessCreditRisk := FALSE : STORED('IncludeBusinessCreditRisk');
  BOOLEAN BusinessFailureRiskLevel := FALSE : STORED('IncludeBusinessFailureRiskLevel');
  BOOLEAN CustomBCIR := FALSE : STORED('IncludeCustomBCIR');
  BOOLEAN lnbranded := FALSE : STORED('LnBranded');
  // set DEFAULT for query level report fetches to be at the SELEID = S level.
  STRING1 ReportFetchLevel := 'S' : STORED('ReportFetchLevel');
  //boolean SelectAll := false;// : stored('SelectAll');
  //boolean internal_testing := false : stored('InternalTesting');


  SupplierRisk_Services.SupplierRisk_Layouts.Report_options init_options() := TRANSFORM
    SELF.ApplicationType := AutoStandardI.GlobalModule().ApplicationType;
    SELF.IncludeAssociatedBusinesses := AssociateBus;
    SELF.IncludeParents := Parent;
    SELF.IncludeContacts := Con;
    SELF.IncludeFinances := Finance;
    SELF.IncludeOpsSites := OpsSites;
    SELF.IncludeIncorporation := InCorp;
    SELF.IncludeIndustries := Indust;
    SELF.IncludeInternetDomains := URL;
    SELF.IncludeUCCFilings := UCCSect;
    SELF.IncludeUCCFilingsSecureds := (UCCsect AND UCCSecureds);
    SELF.IncludeLiensJudgments := Liens;
    SELF.IncludeAircrafts := Aircraft;
    SELF.IncludeMotorVehicles := MVR;
    SELF.IncludeWatercrafts := Wc;
    SELF.IncludeBankruptcies := Bk;
    SELF.IncludeProperties := Prop;
    SELF.IncludeRegisteredAgents := RA;
    SELF.IncludeConnectedBusinesses := ConnectedBusinesses;
    SELF.IncludeSourceCounts := Source;
    SELF.IncludeProfessionalLicenses := License;
    SELF.IncludeNameVariations := namevariations;
    SELF.IncludeBusinessRegistrations := businessRegistrations;
    SELF.IncludeIRS5500 := IRSFiftyFive;
    SELF.IncludeCompanyVerification := companyVerification;
    SELF.IncludeSanctions := sanctions;
    SELF.IncludeDunBradStreet := DNBSect;
    SELF.IncludeExperianBusinessReports := ExperianBusReport;
    SELF.IncludeDiversityCert := DiversityCert;
    SELF.IncludeRiskMetrics := RiskMetrics;
    SELF.IncludeNatDisReady := NatDisReady;
    SELF.IncludeLaborActWHD := LaborActWHD;
    SELF.IncludeLNCA := LNCA;
    SELF.IncludeOSHAIR := OSHAIRx;
    SELF.IncludeBusinessCreditRisk := BusinessCreditRisk;
    SELF.IncludeBusinessFailureRiskLevel := BusinessFailureRiskLevel;
    SELF.IncludeCustomBCIR := CustomBCIR;
    SELF.lnbranded := lnbranded;
    SELF.internal_testing := FALSE ; //internal_testing;
    SELF.ReportFetchLevel := topbusiness_services.functions.fn_fetchLevel(TRIM(STD.STR.ToUpperCase(ReportFetchLevel),LEFT,RIGHT)[1]);
    SELF := [];
  END;

  options := ROW(init_options()); // can uncomment later

  // Create dataset
  SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids initialize() := TRANSFORM
     SELF.acctno := 'SINGLE';
     SELF.DotID := (UNSIGNED6) s_dotid,
     SELF.EmpID := (UNSIGNED6) s_empid,
     SELF.PowID := (UNSIGNED6) s_powid,
     SELF.ProxID := (UNSIGNED6) s_proxid,
     SELF.SeleID := (UNSIGNED6) s_seleid,
     SELF.OrgID := (UNSIGNED6) s_orgid,
     SELF.UltID := (UNSIGNED6) s_ultid,
  END;

  ds := DATASET([initialize()]);

  tempmod := MODULE(AutoStandardI.DataRestrictionI.params)
    EXPORT BOOLEAN AllowAll := FALSE;
    EXPORT BOOLEAN AllowDPPA := FALSE;
    EXPORT BOOLEAN AllowGLB := FALSE;
    EXPORT STRING DataRestrictionMask := '' : STORED('DataRestrictionMask');
    EXPORT UNSIGNED1 DPPAPurpose := 0 : STORED('DPPAPurpose');
    EXPORT UNSIGNED1 GLBPurpose := 0 : STORED('GLBPurpose');
    EXPORT BOOLEAN ignoreFares := FALSE;
    EXPORT BOOLEAN ignoreFidelity := FALSE;
    EXPORT BOOLEAN includeMinors := FALSE;
  END;

  // Get report
  tmpresults := SupplierRisk_Services.SupplierRisk_records(ds,options,tempmod);

  tmp := PROJECT(tmpresults, TRANSFORM(iesp.SupplierRiskReport.t_SupplierRiskReportRecord,
    SELF := LEFT, SELF := []));
  validRpt := IF(tmp[1].Bestsection.CompanyName !='',TRUE,FALSE);

  iesp.SupplierRiskReport.t_SupplierRiskReportResponse format() := TRANSFORM
    SELF._Header := iesp.ECL2ESP.GetHeaderRow(),
    // Only output report if best company name exists.
    SELF.Businesses := IF(validRpt,tmp[1]),
    SELF.RecordCount := IF(validRpt,1,0),
    SELF := []
  END;
  results := DATASET([format()]);

  // dataset(iesp.gateway_inviewreport.t_InviewReportResponse) rpt.EquifaxBusinessReport
  efx_table := DATASET(ROW(tmp[1].EQFXGatewaySection,iesp.gateway_inviewreport.t_InviewReportResponse));
  inv_royalties := Royalty.RoyaltyInview.GetOnlineRoyalties(efx_table,BusinessCreditRisk,BusinessFailureRiskLevel,CustomBCIR);

  royalties := DATASET([], Royalty.Layouts.Royalty) +
    IF(BusinessCreditRisk OR BusinessFailureRiskLevel OR CustomBCIR, inv_royalties);

  OUTPUT(Results,NAMED('Results'));
  OUTPUT(royalties, NAMED('RoyaltySet'));

ENDMACRO;
